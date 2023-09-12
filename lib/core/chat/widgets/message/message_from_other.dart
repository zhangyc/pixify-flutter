import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sona/core/chat/models/message.dart';

import '../../../../utils/dialog/input.dart';

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
      margin: EdgeInsets.only(right: 70, bottom: 12, left: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onLongPress: _onLongPress,
            child: Container(
              padding: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Theme.of(context).colorScheme.secondaryContainer, width: 2)
                )
              ),
              alignment: Alignment.centerLeft,
              child: Text(widget.message.content, style: Theme.of(context).textTheme.bodySmall),
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 18),
              GestureDetector(
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)
                  ),
                  alignment: Alignment.center,
                  child: Text('❤️'),
                ),
              ),
              SizedBox(width: 12),
              Text(widget.message.time.toMessageTime(), style: Theme.of(context).textTheme.bodySmall),
            ],
          )
        ],
      ),
    );
  }


  void _onLongPress() async {
    final action = await showRadioFieldDialog(
        context: context,
        options: {'Copy': 'copy', 'Delete': 'delete'},
        dismissible: true
    );
    if (action == 'copy') {
      Clipboard.setData(ClipboardData(text: widget.message.content));
      Fluttertoast.showToast(msg: 'Message has been copied to Clipboard');
    } else if (action == 'delete') {
      Fluttertoast.showToast(msg: 'todo');
    }
  }
}