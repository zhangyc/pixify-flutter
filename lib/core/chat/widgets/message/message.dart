import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/widgets/message/message_from_me.dart';
import 'package:sona/core/chat/widgets/message/message_from_other.dart';
import 'package:sona/core/chat/widgets/message/time.dart';

import '../../../../utils/dialog/input.dart';
import 'local_pending_message_from_me.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.prevMessage,
    required this.message,
    required this.fromMe,
    required this.onPendingMessageSucceed
  });
  final ImMessage? prevMessage;
  final ImMessage message;
  final bool fromMe;
  final Function(ImMessage message) onPendingMessageSucceed;

  @override
  Widget build(BuildContext context) {
    Widget _message;
    if (fromMe) {
      if (message.pending != null) {
        _message = LocalPendingMessageFromMe(message: message, onSucceed: () => onPendingMessageSucceed(message));
      } else {
        _message = MessageFromMe(message: message);
      }
    } else {
      _message = MessageFromOther(message: message);
    }

    return GestureDetector(
      onLongPress: () async {
        final action = await showRadioFieldDialog(context: context, options: {'Copy': 'copy', 'Delete': 'delete'}, dismissible: true);
        if (action == 'copy') {
          Clipboard.setData(ClipboardData(text: message.content));
          Fluttertoast.showToast(msg: 'Message has been copied to Clipboard');
        } else if (action == 'delete') {
          Fluttertoast.showToast(msg: 'todo');
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: prevMessage == null || prevMessage!.time.add(const Duration(minutes: 5)).isBefore(message.time),
              child: MessageTime(time: message.time)
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75
              ),
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: fromMe ? Theme.of(context).primaryColor : Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(24)
              ),
              child: _message
            )
          ],
        ),
      ),
    );
  }
}