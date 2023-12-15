import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/screens/profile.dart';
import 'package:sona/core/chat/models/conversation.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/screens/chat.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/conversation.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/dialog/subsciption.dart';
import 'package:sona/utils/global/global.dart';

import '../../../generated/l10n.dart';
import '../../subscribe/subscribe_page.dart';
import '../models/message.dart';
import '../../like_me/widgets/liked_me.dart';

class ConversationScreen extends StatefulHookConsumerWidget {
  const ConversationScreen({
    super.key,
    required this.onShowLikeMe
  });
  final void Function() onShowLikeMe;
  static const routeName="/conversations";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ref.read(asyncChatStylesProvider);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(S.of(context).chat, style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w900
        )),
        centerTitle: false,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: LikedMeListView(
              onShowAll: widget.onShowLikeMe,
              onTap: ([UserInfo? u]) {
                if (ref.read(myProfileProvider)!.isMember) {
                  if (u == null) {
                    // SonaAnalytics.log('chatlist_golikedme');
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => LikeMeScreen(data: ref.watch(asyncLikedMeProvider).value!)));
                  } else {
                    SonaAnalytics.log('chatlist_member_card');
                    Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfileScreen(userId: u.id, relation: Relation.likeMe,)));
                  }
                } else {
                  SonaAnalytics.log('chatlist_tapblur');
                  showSubscription(SubscribeShowType.secretSonamate(),FromTag.pay_chatlist_blur);
                }
              }
              ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          ref.watch(conversationStreamProvider).when(
            data: (conversations) => conversations.isEmpty ? _noChats() : SliverList.separated(
              itemBuilder: (BuildContext context, int index) {
                final conversation = conversations[index];
                return ConversationItemWidget(
                  key: ValueKey(conversation.otherSide.id),
                  conversation: conversation,
                  onTap: () => _chat(ChatEntry.conversation, conversation),
                  onLongPress: () => _showConversationActions(conversation),
                  onHookTap: () => _onHookTap(conversation.convoId)
                );
              },
              itemCount: conversations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 20),
            ),
            error: (_, __) => SliverToBoxAdapter(child: Container()),
            loading: () => SliverToBoxAdapter(child: Container(
              alignment: Alignment.center,
              child: const SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(),
              ),
            ))
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.bottom),
          )
        ],
      )
    );
  }

  Future _showConversationActions(ImConversation conversation) async {
    final choice = await showActionButtons<String>(context: context, options: {S.of(context).buttonDelete: 'delete'});
    if (choice == 'delete') {
      deleteChat(id: conversation.otherSide.id);
    }
  }

  Future _chat(ChatEntry entry, ImConversation convo) {
    if (convo.hasUnreadMessage) SonaAnalytics.log('chatlist_unread');
    return Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(entry: entry, otherSide: convo.otherSide)));
  }

  Future _onHookTap(int userId) async {
    SonaAnalytics.log('chatlist_quickreply');
    return callSona(
        userId: userId,
        type: CallSonaType.HOOK
    );
  }

  Widget _noChats() {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/data_empty.png', width: 272),
            const SizedBox(height: 20),
            Text(S.of(context).noMessageTips)
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}