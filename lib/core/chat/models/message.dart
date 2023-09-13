import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sona/common/models/user.dart';

class ImMessage {
  ImMessage({
    required this.conversationId,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.time,
    this.knowledgeAdded = false
  });

  final int conversationId;
  final String content;
  final UserInfo sender;
  final UserInfo receiver;
  final DateTime time;
  bool knowledgeAdded;

  factory ImMessage.fromJson(Map<String, dynamic> json) {
    return ImMessage(
      conversationId: json['id'],
      sender: UserInfo.fromJson({'id': json['sendUserId'], 'nickname': json['senderName']}),
      receiver: UserInfo.fromJson({'id': json['receiveUserId']}),
      content: json['message'],
      time: (json['createDate'] as Timestamp).toDate(),
      knowledgeAdded: json['knowledge_added'] ?? false
    );
  }

  @override
  bool operator ==(Object other) {
    return super == other || other is ImMessage && other.sender.id == sender.id && other.time == time;
  }

  @override
  int get hashCode => identityHashCode('${sender.id}_${time.microsecondsSinceEpoch}');
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