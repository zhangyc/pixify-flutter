import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sona/common/models/user.dart';

class ImMessage {
  ImMessage({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.time,
    required this.shortenTimes
  });

  final int id;
  final String content;
  final UserInfo sender;
  final UserInfo receiver;
  final DateTime time;
  final int shortenTimes;
  Future? pending;
  Future Function()? func;

  factory ImMessage.fromJson(Map<String, dynamic> json) {
    return ImMessage(
      id: json['id'],
      sender: UserInfo.fromJson({'id': json['sendUserId'], 'nickname': json['senderName']}),
      receiver: UserInfo.fromJson({'id': json['receiveUserId']}),
      content: json['message'],
      time: (json['createDate'] as Timestamp).toDate(),
      shortenTimes: json['simplifyNum'] ?? 0
    );
  }
}

enum CallSonaType {
  PROLOGUE,
  AUTO,
  SUGGEST,
  INPUT,
  MANUAL,
  BIO,
  HOOK,
  SIMPLE
}

extension DateTimeExt on DateTime {
  String toMessageTime() {
    final now = DateTime.now();
    if (year == now.year) {
      if (month == now.month) {
        if (day == now.day) {
          if (now.difference(this) < const Duration(hours: 1)) {
            if (now.difference(this) < const Duration(minutes: 1)) {
              return 'just now';
            } else {
              return 'Today ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
            }
          } else {
            return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
          }
        } else {
          return '${_getMonthShort(month)} ${day.toString().padLeft(2, '0')} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
        }
      } else {
        return '${_getMonthShort(month)} ${day.toString().padLeft(2, '0')} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
      }
    } else {
      return '${_getMonthShort(month)} ${day.toString().padLeft(2, '0')}, $year ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
  }
}

String _getMonthShort(int index) {
  return switch (index) {
    1 => 'Jan',
    2 => 'Feb',
    3 => 'Mar',
    4 => 'Apr',
    5 => 'May',
    6 => 'Jun',
    7 => 'Jul',
    8 => 'Aug',
    9 => 'Sep',
    10 => 'Oct',
    11 => 'Nov',
    12 => 'Dec',
    _ => 'Unknown'
  };
}