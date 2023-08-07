import 'package:sona/core/persona/models/user.dart';

class ImMessage {
  ImMessage({
    required this.conversation,
    required this.sender,
    required this.receiver,
    required this.content
  });

  final String conversation;
  final String content;
  final User sender;
  final User receiver;

  factory ImMessage.fromJson(Map<String, dynamic> json) {
    return ImMessage(
      conversation: json['target'],
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']),
      content: json['content']
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'target': conversation,
    'sender': sender.toJson(),
    'receiver': receiver.toJson(),
    'content': content
  };
}