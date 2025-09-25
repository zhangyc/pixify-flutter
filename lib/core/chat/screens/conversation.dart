import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/screens/profile.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/screens/other_user_profile.dart';
import 'package:sona/core/chat/models/conversation.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/screens/chat.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/conversation.dart';
import 'package:sona/core/subscribe/model/member.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/dialog/subsciption.dart';
import 'package:sona/utils/global/global.dart';

import '../../../generated/l10n.dart';
import '../../subscribe/subscribe_page.dart';
import '../models/message.dart';
import '../../like_me/widgets/liked_me.dart';

class ConversationScreen extends StatefulHookConsumerWidget {
  const ConversationScreen({super.key, required this.onShowLikeMe});
  final void Function() onShowLikeMe;
  static const routeName = "/conversations";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen>
    with AutomaticKeepAliveClientMixin {
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
          title: Text(S.of(context).chat,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontSize: 28, fontWeight: FontWeight.w900)),
          centerTitle: false,
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: LikedMeListView(
                  onShowAll: widget.onShowLikeMe,
                  onTap: ([UserInfo? u]) {
                    if (ref.read(myProfileProvider)?.memberType ==
                        MemberType.plus) {
                      if (u == null) {
                        // SonaAnalytics.log('chatlist_golikedme');
                        // Navigator.push(context, MaterialPageRoute(builder: (_) => LikeMeScreen(data: ref.watch(asyncLikedMeProvider).value!)));
                      } else {
                        SonaAnalytics.log('chatlist_member_card');
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                                builder: (_) => OtherUserProfileScreen(
                                      userId: u.id,
                                      relation: Relation.likeMe,
                                    )));
                      }
                    } else {
                      SonaAnalytics.log('chatlist_tapblur');
                      showSubscription(FromTag.pay_chatlist_blur);
                    }
                  }),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 4)),
            ref.watch(conversationStreamProvider).when(
                data: (conversations) => conversations.isEmpty
                    ? _noChats()
                    : SliverList.separated(
                        itemBuilder: (BuildContext context, int index) {
                          final conversation = conversations[index];
                          return ConversationItemWidget(
                              key: ValueKey(conversation.otherSide.id),
                              conversation: conversation,
                              onTap: () =>
                                  _chat(ChatEntry.conversation, conversation),
                              onLongPress: () =>
                                  _showConversationActions(conversation),
                              onHookTap: () =>
                                  _onHookTap(conversation.convoId));
                        },
                        itemCount: conversations.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                      ),
                error: (_, __) => SliverToBoxAdapter(child: Container()),
                loading: () => SliverToBoxAdapter(
                        child: Container(
                      alignment: Alignment.center,
                      child: const SizedBox(
                        height: 32,
                        width: 32,
                        child: CircularProgressIndicator(),
                      ),
                    ))),
            SliverToBoxAdapter(
              child: SizedBox(height: MediaQuery.of(context).padding.bottom),
            )
          ],
        ));
  }

  Future _showConversationActions(ImConversation conversation) async {
    final choice = await showActionButtons<String>(
        context: context, options: {S.of(context).buttonDelete: 'delete'});
    if (choice == 'delete') {
      deleteChat(id: conversation.otherSide.id);
    }
  }

  Future _chat(ChatEntry entry, ImConversation convo) {
    if (convo.hasUnreadMessage) SonaAnalytics.log('chatlist_unread');
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChatScreen(
                entry: entry,
                otherSide: convo.otherSide,
                hasHistoryMessage: convo.lastMessageId != null)));
  }

  Future _onHookTap(int userId) async {
    SonaAnalytics.log('chatlist_quickreply');
    return callSona(userId: userId, type: CallSonaType.MANUAL);
  }

  Widget _noChats() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 空状态图标
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                size: 60,
                color: Theme.of(context).primaryColor.withOpacity(0.6),
              ),
            ),

            const SizedBox(height: 24),

            // 主标题
            Text(
              S.of(context).fateOnTheWay,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textTheme.headlineSmall?.color,
                  ),
            ),

            const SizedBox(height: 12),

            // 副标题
            Text(
              S.of(context).emptyChatRoomMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(0.7),
                    height: 1.5,
                  ),
            ),

            const SizedBox(height: 32),

            // 运营按钮组
            Column(
              children: [
                // 去发现按钮
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      // 切换到发现页面
                      ///开通会员，获取更多推荐
                      //ref.read(currentHomeTapIndexProvider.notifier).state = 0;
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                              builder: (_) => SubscribePage(
                                    fromTag: FromTag.pay_chatlist_blur,
                                  )));
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.explore_outlined, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          S.of(context).upgradeForMoreRecommendations,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 完善资料按钮
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // 跳转到个人资料页面
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (_) => const ProfileScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      side: BorderSide(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        width: 1.5,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_outline, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          S.of(context).completeProfile,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 小贴士
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      S.of(context).profileTip,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
