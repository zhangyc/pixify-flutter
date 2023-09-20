import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/conversation.dart';
import 'package:sona/utils/providers/kv_store.dart';

import '../../../common/widgets/image/user_avatar.dart';

class ConversationItemWidget extends ConsumerStatefulWidget {
  final ImConversation conversation;
  final Future Function() onTap;
  final Future Function() onLongPress;

  const ConversationItemWidget({
    super.key,
    required this.conversation,
    required this.onTap,
    required this.onLongPress
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConversationItemWidgetState();
}

class _ConversationItemWidgetState extends ConsumerState<ConversationItemWidget> {
  void _computeUnread() {
    final t = ref.read(kvStoreProvider).getInt('convo_${widget.conversation.convoId}_check_time');
    widget.conversation.checkTime = t == null ? null : DateTime.fromMillisecondsSinceEpoch(t);
  }

  @override
  void initState() {
    _computeUnread();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onTap().then((value) {
            _computeUnread();
            if (mounted) setState(() {});
          });
          ref.read(kvStoreProvider).setInt('convo_${widget.conversation.convoId}_check_time', DateTime.now().millisecondsSinceEpoch);
        },
        onLongPress: widget.onLongPress,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: ListTile(
              leading: UserAvatar(url: widget.conversation.otherSide.avatar!, size: 52),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.conversation.otherSide.name ?? '',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    widget.conversation.lastMessageContent ?? 'New matched',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall,
                  )
                ],
              ),
              trailing: widget.conversation.hasUnreadMessage ? Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(4)
                ),
              ) : null
            )
        )
    );
  }
}