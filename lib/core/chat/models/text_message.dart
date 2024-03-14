import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/utils/global/global.dart';

import '../../../common/models/user.dart';
import 'package:sona/utils/uuid.dart' as u;


class TextMessage extends ImMessage{
  TextMessage({
    required super.chatId,
    required super.id,
    required super.uuid,
    required super.sender,
    required super.receiver,
    required super.time,
    required super.content,
    required this.originalText,
    required this.translatedText,
    required this.sourceLocale,
    required this.targetLocale
  });

  final String originalText;
  final String? translatedText;
  final String? sourceLocale;
  final String? targetLocale;

  factory TextMessage.fromJson(Map<String, dynamic> json) {
    var contentJson = json['content'];
    Map<String, dynamic>? content;
    if (contentJson != null && contentJson.isNotEmpty) {
      try {
        content = jsonDecode(contentJson);
      } catch(e) {
        if (kDebugMode) print(e);
      }
    }
    if (content == null || content.isEmpty) {
      content = {
        'type': ImMessageContentType.text,
        'originalText': json['originalContent'],
        'translatedText': json['translatedContent'],
      };
    } else {
      content['type'] = json['contentType'];
    }
    return TextMessage(
      chatId: json['sendUserId'] == profile!.id ? json['receiveUserId'] : json['sendUserId'],
      id: json['id'],
      uuid: json['uuid'],
      sender: UserInfo.fromJson({'id': json['sendUserId'], 'nickname': json['senderName']}),
      receiver: UserInfo.fromJson({'id': json['receiveUserId']}),
      time: (json['createDate'] as Timestamp).toDate(),
      content: content,
      originalText: content['originalText'],
      translatedText: content['translatedText'],
      sourceLocale: content['sourceLocale'],
      targetLocale: content['targetLocale']
    );
  }

  factory TextMessage.fromContent({
    required Map<String, dynamic> content,
    required UserInfo sender,
    required UserInfo receiver,
  }) {
    return TextMessage(
      chatId: receiver.id,
      id: null,
      uuid: u.uuid.v4(),
      sender: sender,
      receiver: receiver,
      time: DateTime.now(),
      content: content,
      originalText: content['originalText'],
      translatedText: null,
      sourceLocale: null,
      targetLocale: null
    );
  }

  static Map<String, dynamic> buildContent(String text, bool needsTranslation) {
    return {
      'type': ImMessageContentType.text,
      'originalText': text,
      'localExtension': {'needsTranslation': needsTranslation}
    };
  }

  Map<String, dynamic> contentMap() => <String, dynamic>{
    'originalText': originalText,
  };
}