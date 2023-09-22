import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sona/common/widgets/button/icon.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/widgets/message/message_from_me.dart';
import 'package:sona/core/chat/widgets/message/message_from_other.dart';
import 'package:sona/core/chat/widgets/message/time.dart';

import 'local_pending_message_from_me.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.prevMessage,
    required this.message,
    required this.fromMe,
    required this.onDelete,
    required this.onPendingMessageSucceed,
    required this.onShorten
  });
  final ImMessage? prevMessage;
  final ImMessage message;
  final bool fromMe;
  final Future Function(ImMessage) onDelete;
  final void Function(ImMessage) onPendingMessageSucceed;
  final Future Function(ImMessage) onShorten;

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

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: prevMessage == null || prevMessage!.time.add(const Duration(minutes: 5)).isBefore(message.time),
            child: MessageTime(time: message.time)
          ),
          CupertinoContextMenu.builder(
            actions: <Widget>[
              CupertinoContextMenuAction(
                child: const Text('Copy'),
                onPressed: () {
                  Navigator.pop(context);
                  Clipboard.setData(ClipboardData(text: message.content));
                  Fluttertoast.showToast(msg: 'Message has been copied to Clipboard');
                },
              ),
              CupertinoContextMenuAction(
                child: const Text('Delete'),
                onPressed: () {
                  Navigator.pop(context);
                  onDelete(message);
                },
              ),
            ],
            builder:(BuildContext context, Animation<double> animation) {
              return Container(
                // decoration:
                //   animation.value < CupertinoContextMenu.animationOpensAt ? boxDecorationAnimation.value : null,
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                    color: fromMe ? Theme.of(context).primaryColor : Color(0xFFF9F9F9),
                    borderRadius: BorderRadius.circular(24),
                ),
                child: _message
              );
            },
          ),
          SizedBox(height: 12),
          Visibility(
            visible: message.type == 4 && fromMe && message.shortenTimes < 2,
            child: Align(
              alignment: Alignment.bottomRight,
              child: SIconButton(
                size: 28,
                onTap: () => onShorten(message),
                loadingWhenAsyncAction: true,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                    shape: BoxShape.circle
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.switch_access_shortcut_add_outlined, size: 16, color: Theme.of(context).colorScheme.tertiary)
                ),
              ),
            ),
          ),
          SizedBox(height: 12)
        ],
      ),
    );
  }
}