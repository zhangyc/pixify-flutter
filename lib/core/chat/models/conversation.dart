import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sona/common/models/user.dart';

class ImConversation {
  ImConversation._({
    required this.otherSide,
    required this.dateTime,
    required this.lastMessageId,
    required this.lastMessageContent,
  });

  final UserInfo otherSide;
  final DateTime dateTime;
  final int? lastMessageId;
  final String? lastMessageContent;

  factory ImConversation.fromJson(Map<String, dynamic> json) {
    return ImConversation._(
      otherSide: UserInfo.fromJson({
        'id': json['userId'],
        'nickname': json['nickname'],
        'avatar': json['avatar']
      }),
      dateTime: (json['createDate'] as Timestamp).toDate(),
      lastMessageId: json['id'],
      lastMessageContent: json['message']
    );
  }
}