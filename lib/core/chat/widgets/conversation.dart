import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/conversation.dart';
import 'package:sona/utils/global/global.dart';

import '../../../common/widgets/image/user_avatar.dart';

class ConversationItemWidget extends ConsumerStatefulWidget {
  final ImConversation conversation;
  final Future Function() onTap;
  final Future Function() onLongPress;
  final Future Function() onHookTap;

  const ConversationItemWidget({
    super.key,
    required this.conversation,
    required this.onTap,
    required this.onLongPress,
    required this.onHookTap
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConversationItemWidgetState();
}

class _ConversationItemWidgetState extends ConsumerState<ConversationItemWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onTap().then((value) {
          widget.conversation.checkTime = DateTime.now();
          if (mounted) setState(() {});
        });
        kvStore.setInt('convo_${widget.conversation.convoId}_check_time', DateTime.now().millisecondsSinceEpoch);
      },
      onLongPress: widget.onLongPress,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              UserAvatar(url: widget.conversation.otherSide.avatar ?? ''),
              SizedBox(width: 8),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 64
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.conversation.otherSide.name ?? '',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w800
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Text(
                        widget.conversation.lastMessageContent != null && widget.conversation.lastMessageContent!.isNotEmpty
                            ? widget.conversation.lastMessageContent! : 'New matched',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: widget.conversation.hasUnreadMessage ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                      )
                    ],
                  ),
                )
              ),
              SizedBox(width: 8),
              widget.conversation.hasUnreadMessage
                  ? widget.conversation.lastMessageType == 7
                  ? InkWell(
                    onTap: widget.onHookTap,
                    child: Image.asset('assets/images/quick_reply.png', width: 40),
                  )
                  : Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(4)
                    ),
                  ) : Container()
            ],
          )
      )
    );
  }
}