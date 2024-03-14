import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sona/core/chat/models/message.dart';

import '../../../common/models/user.dart';
import '../../../utils/global/global.dart';
import 'package:sona/utils/uuid.dart' as u;

class ImageMessage extends ImMessage{
  ImageMessage({
    required super.chatId,
    required super.id,
    required super.uuid,
    required super.sender,
    required super.receiver,
    required super.time,
    required super.content,
    required this.url,
    this.width,
    this.height
  });

  final String url;
  final int? width;
  final int? height;

  factory ImageMessage.fromJson(Map<String, dynamic> json) {
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

    return ImageMessage(
      chatId: json['sendUserId'] == profile!.id ? json['receiveUserId'] : json['sendUserId'],
      id: json['id'],
      uuid: json['uuid'],
      sender: UserInfo.fromJson({'id': json['sendUserId'], 'nickname': json['senderName']}),
      receiver: UserInfo.fromJson({'id': json['receiveUserId']}),
      time: (json['createDate'] as Timestamp).toDate(),
      content: content,
      url: content['image'] ?? '',
      width: content['width'],
      height: content['height']
    );
  }

  factory ImageMessage.fromContent({
    required Map<String, dynamic> content,
    required UserInfo sender,
    required UserInfo receiver,
  }) {
    return ImageMessage(
      chatId: receiver.id,
      id: null,
      uuid: u.uuid.v4(),
      sender: sender,
      receiver: receiver,
      time: DateTime.now(),
      content: content,
      url: content['image']!,
    );
  }

  Map<String, dynamic> contentMap() => <String, dynamic>{
    'image': url,
    'width': width,
    'height': height
  };
}