import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/chat/models/conversation.dart';
import 'package:sona/generated/assets.dart';
import 'package:sona/utils/global/global.dart';

import '../../../common/widgets/image/user_avatar.dart';
import '../../../generated/l10n.dart';

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
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Row(
            children: [
              UserAvatar(url: widget.conversation.otherSide.avatar ?? '', size: Size.square(64)),
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
                        widget.conversation.otherSide.originNickname ?? '',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      _buildConversationTip(widget.conversation.contentType??1)
                    ],
                  ),
                )
              ),
              SizedBox(width: 8),
              if (widget.conversation.hasUnreadMessage) Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Color(0xFFBEFF06),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white.withOpacity(0.2), width: 1)
                ),
              )
            ],
          )
      )
    );
  }

  _buildConversationTip(int contentType) {
    if(contentType==1){
      String? displayMessage;

      if (widget.conversation.lastMessageSenderId == ref.read(myProfileProvider)!.id) {
        displayMessage = widget.conversation.lastMessageOriginalContent;
      } else {
        displayMessage = widget.conversation.lastMessageTranslatedContent;
        if (displayMessage == null || displayMessage.isEmpty) {
          displayMessage = widget.conversation.lastMessageOriginalContent;
        }
      }
      return Text(
        displayMessage != null && displayMessage.isNotEmpty ? displayMessage : S.of(context).newMatch,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: widget.conversation.hasUnreadMessage ? Theme.of(context).primaryColor : Colors.grey,
        ),
      );
    }else if(contentType==2){
      return Row(
        children: [
          SvgPicture.asset(Assets.svgConverationDuo,width: 14,height: 14,),
          SizedBox(
            width: 4,
          ),
          Text('${S.current.duoSnap}!')
        ],
      );
    } else if (contentType == 3) {
      return Row(
        children: [
          Icon(CupertinoIcons.mic, size: 14),
          SizedBox(
            width: 4,
          ),
          Text('Voice Message')
        ],
      );
    } else {
      return Container();
    }
  }
}