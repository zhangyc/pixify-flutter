import 'package:flutter/material.dart';
import 'package:sona/core/chat/models/message.dart';

class MessageFromMe extends StatefulWidget {
  const MessageFromMe({super.key, required this.message});
  final ImMessage message;

  @override
  State<StatefulWidget> createState() => _MessageFromMeState();
}

class _MessageFromMeState extends State<MessageFromMe> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.message.content, style: Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Colors.white
    ));
  }
}