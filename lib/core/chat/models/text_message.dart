import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sona/core/chat/models/message.dart';

import '../../../common/models/user.dart';

class TextMessage extends ImMessage{
  TextMessage({
    required super.id,
    required super.uuid,
    required super.type,
    required super.sender,
    required super.receiver,
    required super.originalContent,
    required super.translatedContent,
    required super.time,
    required super.contentType,
    required super.content});

  factory TextMessage.fromJson(Map<String, dynamic> json) {
    return TextMessage(
      id: json['id'],
      uuid: json['uuid'],
      type: json['messageType'],
      sender: UserInfo.fromJson({'id': json['sendUserId'], 'nickname': json['senderName']}),
      receiver: UserInfo.fromJson({'id': json['receiveUserId']}),
      originalContent: json['originalContent'],
      translatedContent: json['translatedContent'],
      time: (json['createDate'] as Timestamp).toDate(),
      contentType: json['contentType'],
      content: jsonDecode(json['content']),

    );
  }

  factory TextMessage.copyWith(ImMessage message, {
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
    return TextMessage(
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