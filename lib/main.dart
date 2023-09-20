import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
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
    initFireBaseService(firebase);
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


