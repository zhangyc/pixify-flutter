import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sona/common/models/user.dart';

class ImMessage {
  ImMessage({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.time,
  });

  final int id;
  final String content;
  final UserInfo sender;
  final UserInfo receiver;
  final DateTime time;
  Future? pending;
  Future Function()? func;

  factory ImMessage.fromJson(Map<String, dynamic> json) {
    return ImMessage(
      id: json['id'],
      sender: UserInfo.fromJson({'id': json['sendUserId'], 'nickname': json['senderName']}),
      receiver: UserInfo.fromJson({'id': json['receiveUserId']}),
      content: json['message'],
      time: (json['createDate'] as Timestamp).toDate(),
    );
  }
}

enum CallSonaType {
  PROLOGUE,
  AUTO,
  SUGGEST,
  INPUT,
  MANUAL
}

extension DateTimeExt on DateTime {
  String toMessageTime() {
    final now = DateTime.now();
    if (year == now.year && month == now.month && day == now.day) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
    return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}