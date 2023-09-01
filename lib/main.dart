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


