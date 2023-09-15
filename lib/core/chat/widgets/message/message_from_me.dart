import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sona/core/chat/models/message.dart';

import '../../../../utils/dialog/input.dart';

class MessageFromMe extends StatefulWidget {
  const MessageFromMe({super.key, required this.message});
  final ImMessage message;

  @override
  State<StatefulWidget> createState() => _MessageFromMeState();
}

class _MessageFromMeState extends State<MessageFromMe> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _onLongPress,
      child: Text(widget.message.content, style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.white
      )),
    );
  }


  void _onLongPress() async {
    final action = await showRadioFieldDialog(context: context, options: {'Copy': 'copy', 'Delete': 'delete'}, dismissible: true);
    if (action == 'copy') {
      Clipboard.setData(ClipboardData(text: widget.message.content));
      Fluttertoast.showToast(msg: 'Message has been copied to Clipboard');
    } else if (action == 'delete') {
      Fluttertoast.showToast(msg: 'todo');
    }
  }
}