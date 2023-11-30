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
      child: Row(
        children: [
          Flexible(child: Divider(color: Color(0xFFF6F3F3),)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              time.toMessageTime(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Color(0xFFB7B7B7),
                fontWeight: FontWeight.w400,
                fontSize: 14
              )
            ),
          ),
          Flexible(child: Divider(color: Color(0xFFF6F3F3),)),
        ],
      )
    );
  }
}