import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sona/utils/local_notification/local_lotification_manager.dart';

import '../utils/providers/app_lifecycle.dart';
///firebase实例
late final FirebaseApp sonaFireBase;
///authentic服务
late final FirebaseAuth authService;
///fcm服务
late final FirebaseMessaging messagesService;
///cloud_firestore
late final FirebaseFirestore storeService;
///fcm devicetoken
String? deviceToken;



/// fcm后台消息
///如果使用的是 Flutter 3.3.0 版或更高版本，则必须紧接函数声明之前用 @pragma('vm:entry-point') 标注消息处理程序（否则，对于发布模式，可能会在摇树优化期间将其移除）。
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  //await Firebase.initializeApp();
  //showLocalNotification(message);
  print("Handling a background message: ${message.messageId}");
}
///fcm前台
void foreground(RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');
  //showLocalNotification(message);

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
  }
}