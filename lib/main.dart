import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/firebase/sona_firebase.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'utils/global/global.dart' as global;
import 'utils/local_notification/local_lotification_manager.dart';
import 'utils/providers/app_lifecycle.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  await global.init();
  runApp(
    ProviderScope(
      child: const SonaApp()
    )
  );
}


