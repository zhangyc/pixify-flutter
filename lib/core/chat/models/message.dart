import 'package:sona/core/persona/models/user.dart';

class ImMessage {
  ImMessage({
    required this.conversation,
    required this.sender,
    required this.receiver,
    required this.content,
    this.knowledgeAdded = false
  });

  final String conversation;
  final String content;
  final User sender;
  final User receiver;
  bool knowledgeAdded;

  factory ImMessage.fromJson(Map<String, dynamic> json) {
    return ImMessage(
      conversation: json['target'],
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']),
      content: json['content'],
      knowledgeAdded: json['knowledge_added'] ?? false
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'target': conversation,
    'sender': sender.toJson(),
    'receiver': receiver.toJson(),
    'content': content,
    'knowledge_added': knowledgeAdded
  };
}