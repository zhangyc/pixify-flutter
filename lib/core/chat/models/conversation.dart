import 'message.dart';

class ImConversation {
  ImConversation({
    required this.conversationId,
    this.lastMessage
  });

  final String conversationId;
  ImMessage? lastMessage;

  factory ImConversation.fromJson(Map<String, dynamic> json) {
    return ImConversation(
      conversationId: json['targetId'],
      lastMessage: json['lastMessage']
    );
  }
}