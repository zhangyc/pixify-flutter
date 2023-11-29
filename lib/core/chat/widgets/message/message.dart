import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/services/chat.dart';
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
    Widget? localPendingMessage;
    String? upperMessage;
    String? lowerMessage;

    if (fromMe) {
      if (message.pending != null) {
        localPendingMessage = LocalPendingMessageFromMe(message: message, onSucceed: () => onPendingMessageSucceed(message));
      } else {
        upperMessage = message.origin;
        lowerMessage = message.content;
      }
    } else {
      upperMessage = message.content;
      lowerMessage = message.origin;
    }

    final actions = <Widget>[];
    actions.add(CupertinoContextMenuAction(
      child: const Text('Copy'),
      onPressed: () {
        Navigator.pop(context);
        Clipboard.setData(ClipboardData(text: message.content));
        Fluttertoast.showToast(msg: 'Message has been copied to Clipboard');
      },
    ));
    if (fromMe) {
      actions.add(CupertinoContextMenuAction(
        child: const Text('Delete'),
        onPressed: () {
          Navigator.pop(context);
          onDelete(message);
        },
      ));

      // AI消息
      if ([1, 2, 3, 4, 7, 11].contains(message.type)) {
        if (message.content.isNotEmpty) {
          actions.add(CupertinoContextMenuAction(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RawMaterialButton(
                  child: Row(
                    children: [
                      Icon(
                        message.feedback == MessageFeedbackType.like
                            ? CupertinoIcons.hand_thumbsup_fill
                            : CupertinoIcons.hand_thumbsup,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 12),
                          Text('Good'),
                        ],
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    if (message.feedback == MessageFeedbackType.like) {
                      feedback(messageId: message.id, type: MessageFeedbackType.none);
                    } else {
                      feedback(messageId: message.id, type: MessageFeedbackType.like);
                    }
                  },
                ),
                RawMaterialButton(
                  child: Row(
                    children: [
                      Icon(
                        message.feedback == MessageFeedbackType.dislike
                            ? CupertinoIcons.hand_thumbsdown_fill
                            : CupertinoIcons.hand_thumbsdown,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: 12),
                      Text('Subpar')
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    if (message.feedback == MessageFeedbackType.dislike) {
                      feedback(messageId: message.id, type: MessageFeedbackType.none);
                    } else {
                      feedback(messageId: message.id, type: MessageFeedbackType.dislike);
                    }
                  },
                )
              ],
            ),
          ));
        }
      }
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
            actions: actions,
            builder:(BuildContext context, Animation<double> animation) {
              return Container(
                // decoration:
                //   animation.value < CupertinoContextMenu.animationOpensAt ? boxDecorationAnimation.value : null,
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.82
                ),
                // padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                // decoration: BoxDecoration(
                //     color: fromMe ? Theme.of(context).primaryColor : Color(0xFFF9F9F9),
                //     borderRadius: BorderRadius.circular(24),
                // ),
                child: localPendingMessage == null ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24)
                    ),
                    foregroundDecoration: fromMe ? null : BoxDecoration(
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(24)
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (upperMessage != null && upperMessage.isNotEmpty) Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              color: fromMe ? Theme.of(context).primaryColor : Colors.transparent
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            upperMessage,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: fromMe ? Colors.white : Theme.of(context).primaryColor,
                              height: 1.5
                            ),
                          ),
                        ),
                        if (lowerMessage != null && lowerMessage.isNotEmpty) Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              color: fromMe ? Color(0xFF454545) : Color(0xFFF6F3F3)
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            lowerMessage,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Color(0xFFB7B7B7),
                                height: 1.5
                            ),
                          ),
                        )
                      ],
                    )
                ) : localPendingMessage
              );
            },
          ),
          SizedBox(height: 12),
          // Visibility(
          //   visible: message.type == 4 && fromMe && message.shortenTimes < 2,
          //   child: Align(
          //     alignment: Alignment.bottomRight,
          //     child: SIconButton(
          //       size: 28,
          //       onTap: () => onShorten(message),
          //       loadingWhenAsyncAction: true,
          //       child: Container(
          //         width: 28,
          //         height: 28,
          //         decoration: BoxDecoration(
          //           color: Color(0xFFF5F5F5),
          //           shape: BoxShape.circle
          //         ),
          //         alignment: Alignment.center,
          //         child: SonaIcon(icon: SonaIcons.sparkles, size: 16)
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 12)
        ],
      ),
    );
  }
}