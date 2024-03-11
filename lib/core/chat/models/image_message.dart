import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:sona/core/chat/models/message.dart';

import '../../../common/models/user.dart';

class ImageMessage extends ImMessage{
  ImageMessage({
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

  Map<String, dynamic> contentMap() => <String, dynamic>{
    'image': url,
    'width': width,
    'height': height
  };
}