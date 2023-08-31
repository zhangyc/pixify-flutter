import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sona/firebase/sona_firebase.dart';
import 'package:sona/utils/providers/kv_store.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'utils/providers/app_lifecycle.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler); ///后台消息处理
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
