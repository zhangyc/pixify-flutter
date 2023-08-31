import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sona/firebase/sona_firebase.dart';
import 'package:sona/utils/providers/kv_store.dart';

import 'app.dart';
import 'core/chat/screens/conversation_list.dart';
import 'firebase_options.dart';
import 'utils/local_notification/local_lotification_manager.dart';
import 'utils/providers/app_lifecycle.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  Stream<RemoteMessage> _stream = FirebaseMessaging.onMessageOpenedApp;
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler); ///后台消息处理

  initNotificationPlugin();
  var appStateObserver = AppStateObserver();
  WidgetsBinding.instance.addObserver(appStateObserver);  ///判断app当前在前台还是后台

  final firebase = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'sona'
  );
  ///成功初始化firebase app。
  if(firebase.name=='sona'){
    sonaFireBase=firebase;
    authService = FirebaseAuth.instanceFor(app: firebase);
    messagesService =FirebaseMessaging.instance;
    ///终止应用程序后，您需要以Main.dart的主要方法获取消息，如果您尝试将其获取其他任何地方，则会失败。我将此消息传递到第一页，然后在Initstate中采取了适当的诉讼。
    final RemoteMessage? _message = await messagesService.getInitialMessage();  ///这个方法

    NotificationSettings settings = await messagesService.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    messagesService.setForegroundNotificationPresentationOptions(
      badge: true
    );
    messagesService.getToken().then((value){
      deviceToken=value;
    });

    ///应用在前台时，
    FirebaseMessaging.onMessage.listen(foreground);
    storeService=FirebaseFirestore.instance;
  }
  final preferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        // firebaseProvider.overrideWithValue(firebase),
        kvStoreProvider.overrideWithValue(preferences)
      ],
      child: const SonaApp()
    )
  );
}
String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';
void initNotificationPlugin() async{
  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
      Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = "/";
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
    initialRoute =ConversationList.routeName;
  }

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');

  final List<DarwinNotificationCategory> darwinNotificationCategories =
  <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: darwinNotificationCategories,
  );
  final LinuxInitializationSettings initializationSettingsLinux =
  LinuxInitializationSettings(
    defaultActionName: 'Open notification',
    defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin,
    linux: initializationSettingsLinux,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
}
