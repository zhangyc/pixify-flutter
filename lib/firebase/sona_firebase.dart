import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sona/core/match/util/http_util.dart';
import 'package:sona/utils/global/global.dart';

import '../core/chat/screens/chat.dart';
import 'package:sona/common/models/user.dart' as user;


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
  if (kDebugMode) print("Handling a background message: ${message.toMap()}");
}
///fcm前台
void foreground(RemoteMessage message) {
  if (kDebugMode) print('Got a message whilst in the foreground!');
  if (kDebugMode) print('Message data: ${message.data}');
  //showLocalNotification(message);

  if (message.notification != null) {
    if (kDebugMode) print('Message also contained a notification: ${message.notification}');
  }
}
Future<void> initFireBaseService(FirebaseApp firebase) async {
  sonaFireBase=firebase;
  authService = FirebaseAuth.instanceFor(app: firebase);
  messagesService =FirebaseMessaging.instance;
  ///终止应用程序后，您需要以Main.dart的主要方法获取消息，
  ///如果您尝试将其获取其他任何地方，则会失败。
  ///我将此消息传递到第一页，然后在Initstate中采取了适当的诉讼。
  //final RemoteMessage? _message = await messagesService.getInitialMessage();  ///这个方法

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
    if(value!=null){
      post(
          '/user/update',
          data: {
            'deviceToken': value,
          }
      );
    }
  });
  messagesService.onTokenRefresh.listen((event) {
    if (profile == null) return;
    deviceToken=event;
    post(
        '/user/update',
        data: {
          'deviceToken': event,
        }
    );
  });

  _setUpFcmListener();

  ///应用在前台时，
  FirebaseMessaging.onMessage.listen(foreground);
  storeService=FirebaseFirestore.instance;
}
void _setUpFcmListener() async{
  await Future.delayed(Duration(seconds: 1));
  ///kill


  ///background start
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if(message.data.containsKey('screen')&&message.data['screen']=='lib/core/chat/screens/conversation_list'){
      String ext= message.data['ext'];
      if (kDebugMode) print('push_data: $ext');
      user.UserInfo info =user.UserInfo.fromJson(jsonDecode(ext));
      Navigator.push(navigatorKey.currentState!.context, MaterialPageRoute(builder: (c){
        return ChatScreen(entry: ChatEntry.push, otherSide: info);
      }));
    }
  });
}