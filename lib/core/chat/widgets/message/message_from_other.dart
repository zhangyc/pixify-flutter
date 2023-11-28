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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.transparent
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.message.content,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  // color: Colors.white,
                  height: 1.5
              ),
            ),
          ),
          if (widget.message.origin != null) Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
                color: Color(0xFFF6F3F3)
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.message.origin!,
              textAlign: TextAlign.start,
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