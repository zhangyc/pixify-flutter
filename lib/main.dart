import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sona/utils/providers/firebase.dart';
import 'package:sona/utils/providers/kv_store.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'utils/providers/app_lifecycle.dart';
///如果使用的是 Flutter 3.3.0 版或更高版本，则必须紧接函数声明之前用 @pragma('vm:entry-point') 标注消息处理程序（否则，对于发布模式，可能会在摇树优化期间将其移除）。
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  var appStateObserver = AppStateObserver();
  WidgetsBinding.instance.addObserver(appStateObserver);

  final firebase = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'sona'
  );
  ///初始化firebase app。
  if(firebase.name=='sona'){

    FirebaseMessaging.instance.getToken().then((String? token) {
      print(token);
    });
    FirebaseMessaging messaging = FirebaseMessaging.instance;

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
