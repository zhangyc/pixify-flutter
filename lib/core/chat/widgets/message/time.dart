import 'package:flutter/material.dart';
import 'package:sona/core/chat/models/message.dart';

class MessageTime extends StatelessWidget {
  const MessageTime({super.key, required this.time});
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      child: Text(
          time.toMessageTime(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Color(0xFF747474),
            fontWeight: FontWeight.w400,
            fontSize: 12
          )
      )
    );
  }
}