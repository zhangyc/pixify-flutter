import 'package:flutter/material.dart';
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

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Visibility(
            visible: prevMessage == null || prevMessage!.time.add(const Duration(minutes: 5)).isBefore(message.time),
            child: MessageTime(time: message.time)
          ),
          Container(
              margin: EdgeInsets.only(left: fromMe ? 70 : 16, bottom: 12, right: fromMe ? 16 : 70),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: fromMe ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1) : Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.1),
                border: Border(
                  left: fromMe ? BorderSide.none : BorderSide(color: Theme.of(context).colorScheme.tertiaryContainer, width: 2),
                  right: fromMe ? BorderSide(color: Theme.of(context).colorScheme.secondaryContainer, width: 2) : BorderSide.none
                )
              ),
              child: _message
          )
        ],
  );
  }
}