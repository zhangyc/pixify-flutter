import 'package:flutter/material.dart';
import 'package:sona/core/chat/models/message.dart';

class MessageFromOther extends StatefulWidget {
  const MessageFromOther({super.key, required this.message});
  final ImMessage message;

  @override
  State<StatefulWidget> createState() => _MessageFromOtherState();
}

class _MessageFromOtherState extends State<MessageFromOther> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.message.content, style: Theme.of(context).textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.normal,
      height: 1.5
    ));
  }
}