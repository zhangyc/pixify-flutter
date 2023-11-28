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
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24)
      ),
      foregroundDecoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(24)
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.message.origin != null) Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.transparent
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.message.origin!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  // color: Colors.white,
                  height: 1.5
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
                color: Color(0xFFF6F3F3)
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.message.content ?? '',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  height: 1.5
              ),
            ),
          )
        ],
      )
    );
  }
}