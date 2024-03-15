import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sona/core/chat/models/message.dart';

import '../../../common/models/user.dart';
import 'package:sona/utils/uuid.dart' as u;

import '../../../utils/global/global.dart';


class AudioMessage extends ImMessage {
  AudioMessage({
    required super.chatId,
    required super.id,
    required super.uuid,
    required super.sender,
    required super.receiver,
    required super.time,
    required super.content,
    required this.url,
    required this.duration,
    required this.recognizedText,
    required this.translatedText,
    required this.sourceLocale,
    required this.targetLocale,
    required this.words
  });

  final String url;
  final double? duration;
  final String? recognizedText;
  final String? translatedText;
  final String? sourceLocale;
  final String? targetLocale;
  final List<double>? words;

  factory AudioMessage.fromJson(Map<String, dynamic> json) {
    var contentJson = json['content'];
    Map<String, dynamic> content = {};
    if (contentJson != null && contentJson.isNotEmpty) {
      try {
        content = jsonDecode(contentJson);
      } catch(e) {
        if (kDebugMode) print(e);
      }
    }
    content['type'] = json['contentType'];
    final duration = content['duration'];
    double dur = (duration is int) ? duration.toDouble() : duration;
    if (dur < 1.0) dur = 1.0;

    return AudioMessage(
      chatId: json['sendUserId'] == profile!.id ? json['receiveUserId'] : json['sendUserId'],
      id: json['id'],
      uuid: json['uuid'],
      sender: UserInfo.fromJson({'id': json['sendUserId'], 'nickname': json['senderName']}),
      receiver: UserInfo.fromJson({'id': json['receiveUserId']}),
      time: (json['createDate'] as Timestamp).toDate(),
      content: content,
      url: content['url'] ?? '',
      duration: dur,
      recognizedText: content['recognizedText'],
      translatedText: content['translatedText'],
      sourceLocale: content['sourceLocale'],
      targetLocale: content['targetLocale'],
      words: json['words']
    );
  }

  factory AudioMessage.fromContent({
    required Map<String, dynamic> content,
    required UserInfo sender,
    required UserInfo receiver,
  }) {
    return AudioMessage(
      chatId: receiver.id,
      id: null,
      uuid: u.uuid.v4(),
      sender: sender,
      receiver: receiver,
      time: DateTime.now(),
      content: content,
      url: content['url'] ?? '',
      duration: content['duration'],
      recognizedText: null,
      translatedText: null,
      sourceLocale: null,
      targetLocale: null,
      words: null
    );
  }

  Map<String, dynamic> contentMap() => <String, dynamic>{
    'url': url,
    'duration': duration,
  };

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is AudioMessage && other.uuid == uuid);
  }

  @override
  int get hashCode => super.hashCode;
}