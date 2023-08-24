import 'package:sona/common/models/user.dart';

class ImMessage {
  ImMessage({
    required this.conversationId,
    required this.sender,
    required this.receiver,
    required this.content,
    this.knowledgeAdded = false
  });

  final int conversationId;
  final String content;
  final UserInfo sender;
  final UserInfo receiver;
  bool knowledgeAdded;

  factory ImMessage.fromJson(Map<String, dynamic> json) {
    return ImMessage(
      conversationId: json['id'],
      sender: UserInfo.fromJson({'id': json['sendUserId'], 'nickname': json['senderName']}),
      receiver: UserInfo.fromJson({'id': json['receiveUserId']}),
      content: json['message'],
      knowledgeAdded: json['knowledge_added'] ?? false
    );
  }

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //   'target': conversation,
  //   'sender': sender.toJson(),
  //   'receiver': receiver.toJson(),
  //   'content': content,
  //   'knowledge_added': knowledgeAdded
  // };
}


enum CallSonaType {
  PROLOGUE,
  AUTO,
  SUGGEST,
  INPUT,
  MANUAL
}