import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../core/chat/screens/conversation_list.dart';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
 'high_importance_channel', // id
 'High Importance Notifications', // ti
 description: 'ddddddddddddddddddddd',// tle
 importance: Importance.max,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
var initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
StreamController<ReceivedNotification>.broadcast();
class ReceivedNotification {
 ReceivedNotification({
  required this.id,
  required this.title,
  required this.body,
  required this.payload,
 });

 final int id;
 final String? title;
 final String? body;
 final String? payload;
}
final StreamController<String?> selectNotificationStream =
StreamController<String?>.broadcast();
 void showLocalNotification(RemoteMessage message){
  // AndroidNotification? android = message.notification?.android;
  RemoteNotification? notification = message.notification;

  if (notification != null) {

   flutterLocalNotificationsPlugin.show(
       notification.hashCode,
       notification.title,
       notification.body,
       NotificationDetails(
        android: AndroidNotificationDetails(
         channel.id,
         channel.name,
         channelDescription: channel.description,
         icon: initializationSettingsAndroid.defaultIcon,
         // other properties...
        ),
       )
   );
  }
}
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
 // ignore: avoid_print
 print('notification(${notificationResponse.id}) action tapped: '
     '${notificationResponse.actionId} with'
     ' payload: ${notificationResponse.payload}');
 if (notificationResponse.input?.isNotEmpty ?? false) {
  // ignore: avoid_print
  print('notification action tapped with input: ${notificationResponse.input}');
 }
}
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
String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';