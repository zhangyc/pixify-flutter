import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/chat/providers/message.dart';
import 'package:sona/core/chat/services/chat.dart';

import '../../../generated/l10n.dart';

class ImMessage {
  ImMessage({
    required this.id,
    required this.uuid,
    required this.type,
    required this.sender,
    required this.receiver,
    required this.originalContent,
    required this.translatedContent,
    required this.time,
    required this.contentType,
    required this.content
  });

  int? id;
  final String? uuid;
  final int? type;
  final String? originalContent;
  String? translatedContent;
  final UserInfo sender;
  final UserInfo receiver;
  final DateTime time;
  String? sendingParams;
  String? content;

  ///1
  // 纯文本
  // 2
  // 图片
  // 3
  // 声音
  // 4
  // 视频
  int? contentType;
  factory ImMessage.fromJson(Map<String, dynamic> json) {
    return ImMessage(
      id: json['id'],
      uuid: json['uuid'],
      type: json['messageType'],
      sender: UserInfo.fromJson({'id': json['sendUserId'], 'nickname': json['senderName']}),
      receiver: UserInfo.fromJson({'id': json['receiveUserId']}),
      originalContent: json['originalContent'],
      translatedContent: json['translatedContent'],
      time: (json['createDate'] as Timestamp).toDate(),
      contentType: json['contentType'],
      content: json['content'],

    );
  }

  factory ImMessage.copyWith(ImMessage message, {
    int? id,
    String? uuid,
    int? type,
    String? originalContent,
    String? translatedContent,
    UserInfo? sender,
    UserInfo? receiver,
    DateTime? time,
    int? contentType,
    String? content,

  }) {
    return ImMessage(
      id: id ?? message.id,
      uuid: uuid ?? message.uuid,
      type: type ?? message.type,
      sender: sender ?? message.sender,
      receiver: receiver ?? message.receiver,
      originalContent: originalContent ?? message.originalContent,
      translatedContent: translatedContent ?? message.translatedContent,
      time: time ?? message.time,
      contentType: message.contentType,
        content: message.content
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
  SIMPLE,
  SONA_IMPRESSION,
  SUGGEST_V2,
  SUGGEST_FUNC
}

extension DateTimeExt on DateTime {
  String toMessageTime(String languageTag) {
    final now = DateTime.now();
    if (year == now.year) {
      if (month == now.month) {
        if (day == now.day) {
          if (now.difference(this) < const Duration(hours: 1)) {
            if (now.difference(this) < const Duration(minutes: 1)) {
              return S.current.justNow;
            } else {
              return DateFormat.Hm(languageTag).format(this);
            }
          } else {
            return DateFormat.Hm(languageTag).format(this);
          }
        } else {
          return DateFormat.MMMd(languageTag).add_Hm().format(this);
        }
      } else {
        return DateFormat.yMMMd(languageTag).add_Hm().format(this);
      }
    } else {
      return DateFormat.yMMMd(languageTag).add_Hm().format(this);
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