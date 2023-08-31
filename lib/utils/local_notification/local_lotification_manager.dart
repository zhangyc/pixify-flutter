import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
 'high_importance_channel', // id
 'High Importance Notifications', // ti
 description: 'ddddddddddddddddddddd',// tle
 importance: Importance.max,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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
   var initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');

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
  print(
      'notification action tapped with input: ${notificationResponse.input}');
 }
}