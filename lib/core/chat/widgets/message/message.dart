import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/message/time.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/locale/locale.dart';

import 'local_pending_message_from_me.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({
    super.key,
    required this.prevMessage,
    required this.message,
    required this.fromMe,
    required this.onDelete,
    required this.onPendingMessageSucceed,
    required this.onShorten,
    required this.mySide,
    required this.otherSide,
    required this.myLocale,
    required this.otherLocale
  });

  final ImMessage? prevMessage;
  final ImMessage message;
  final bool fromMe;
  final UserInfo mySide;
  final UserInfo otherSide;
  final Locale? myLocale;
  final Locale? otherLocale;
  final Future Function(ImMessage) onDelete;
  final void Function(ImMessage) onPendingMessageSucceed;
  final Future Function(ImMessage) onShorten;

  @override
  State<StatefulWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {

  bool _clicked = false;

  @override
  Widget build(BuildContext context) {
    Widget? localPendingMessage;
    String? upperMessage;
    String? lowerMessage;

    if (widget.fromMe) {
      if (widget.message.pending != null) {
        localPendingMessage = LocalPendingMessageFromMe(
            message: widget.message,
            myLocale: widget.myLocale,
            onSucceed: () => widget.onPendingMessageSucceed(widget.message)
        );
      } else {
        upperMessage = widget.message.origin;
        lowerMessage = widget.message.content;
      }
    } else {
      upperMessage = widget.message.content;
      lowerMessage = widget.message.origin;
    }
    if (upperMessage == null || upperMessage.isEmpty) {
      upperMessage = lowerMessage;
      lowerMessage = null;
    }

      // AI消息
      // if ([1, 2, 3, 4, 7, 11].contains(widget.message.type)) {
      //   if (widget.message.content.isNotEmpty) {
      //     actions.add(CupertinoContextMenuAction(
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           RawMaterialButton(
      //             child: Row(
      //               children: [
      //                 Icon(
      //                   widget.message.feedback == MessageFeedbackType.like
      //                       ? CupertinoIcons.hand_thumbsup_fill
      //                       : CupertinoIcons.hand_thumbsup,
      //                   color: Theme.of(context).primaryColor,
      //                   size: 16,
      //                 ),
      //                 Row(
      //                   children: [
      //                     SizedBox(width: 12),
      //                     Text('Good'),
      //                   ],
      //                 )
      //               ],
      //             ),
      //             onPressed: () {
      //               Navigator.pop(context);
      //               if (widget.message.feedback == MessageFeedbackType.like) {
      //                 feedback(messageId: widget.message.id, type: MessageFeedbackType.none);
      //               } else {
      //                 feedback(messageId: widget.message.id, type: MessageFeedbackType.like);
      //               }
      //             },
      //           ),
      //           RawMaterialButton(
      //             child: Row(
      //               children: [
      //                 Icon(
      //                   widget.message.feedback == MessageFeedbackType.dislike
      //                       ? CupertinoIcons.hand_thumbsdown_fill
      //                       : CupertinoIcons.hand_thumbsdown,
      //                   color: Theme.of(context).primaryColor,
      //                   size: 16,
      //                 ),
      //                 SizedBox(width: 12),
      //                 Text('Subpar')
      //               ],
      //             ),
      //             onPressed: () {
      //               Navigator.pop(context);
      //               if (widget.message.feedback == MessageFeedbackType.dislike) {
      //                 feedback(messageId: widget.message.id, type: MessageFeedbackType.none);
      //               } else {
      //                 feedback(messageId: widget.message.id, type: MessageFeedbackType.dislike);
      //               }
      //             },
      //           )
      //         ],
      //       ),
      //     ));
      //   }
      // }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          if (widget.prevMessage == null || widget.prevMessage!.time.add(const Duration(minutes: 5)).isBefore(widget.message.time)) MessageTime(time: widget.message.time),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!widget.fromMe) Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: UserAvatar(url: widget.otherSide.avatar!, size: Size.square(40)),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: widget.fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onLongPress: () async {
                        if (localPendingMessage != null) return;
                        final action = await showRadioFieldDialog(
                            context: context,
                            options: {
                              'Copy': 'copy',
                              'Delete': 'delete'
                            }
                        );
                        if (action == 'copy') {
                          Clipboard.setData(ClipboardData(text: widget.message.content));
                          Fluttertoast.showToast(msg: 'Message has been copied to Clipboard');
                        } else if (action == 'delete') {
                          widget.onDelete(widget.message);
                        }
                      },
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.64,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: widget.fromMe ? Theme.of(context).primaryColor : Colors.transparent
                        ),
                        foregroundDecoration: widget.fromMe ? null : BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.all(12),
                        clipBehavior: Clip.antiAlias,
                        child: localPendingMessage != null ? localPendingMessage : Text(
                          upperMessage!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: widget.fromMe ? Colors.white : Theme.of(context).primaryColor,
                            height: 1.5,
                            locale: widget.myLocale
                          )
                        )
                      ),
                    ),
                    // SizedBox(height: 12),
                    if (lowerMessage != null && lowerMessage.isNotEmpty) GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          _clicked = !_clicked;
                        });
                      },
                      onLongPress: () async {
                        final action = await showRadioFieldDialog(
                            context: context,
                            options: {
                              'Copy': 'copy',
                            }
                        );
                        if (action == 'delete') {
                          widget.onDelete(widget.message);
                        }
                      },
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.64,
                        ),
                        padding: EdgeInsets.all(12),
                        alignment: widget.fromMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Text(
                          lowerMessage,
                          maxLines: _clicked ? null : 1,
                          overflow: _clicked ? TextOverflow.clip : TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Color(0xFFB7B7B7),
                            height: 1.5,
                            locale: widget.otherLocale
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (widget.fromMe) Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: UserAvatar(url: widget.mySide.avatar!, size: Size.square(40)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}