import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/conversation.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/providers/liked_me.dart';
import 'package:sona/core/chat/screens/chat.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/providers/dio.dart';

import '../widgets/liked_me.dart';
///会话列表
class ConversationList extends StatefulHookConsumerWidget {
  const ConversationList({super.key});
  static const routeName="lib/core/chat/screens/conversation_list";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ConversationList> with AutomaticKeepAliveClientMixin, RouteAware {

  Timer? _timer;

  void _startRefresh() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      ref.read(asyncLikedMeProvider.notifier).refresh();
      ref.read(asyncConversationsProvider.notifier).refresh();
    });
  }

  @override
  void initState() {
    _startRefresh();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didPushNext() {
    _timer?.cancel();
    super.didPushNext();
  }

  @override
  void didPopNext() {
    _startRefresh();
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Chat'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: LikedMeListView(onMatchedTap: _startANewChat),
          ),
          ref.watch(asyncConversationsProvider).when(
            data: (conversations) => SliverList.separated(
              itemBuilder: (BuildContext context, int index) {
                final conversation = conversations[index];
                return GestureDetector(
                  key: ValueKey(conversation.otherSide.id),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(otherSide: conversation.otherSide))),
                  onLongPress: () => _showConversationActions(conversation),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ListTile(
                      leading: UserAvatar(key: ValueKey(conversation.otherSide.id), url: conversation.otherSide.avatar!),
                      title: Text(conversation.otherSide.name ?? '')
                    )
                  )
                );
              },
              itemCount: conversations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 5),
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
        ],
      )
    );
  }

  void _showConversationActions(ImConversation conversation) async {
    final choice = await showRadioFieldDialog<String>(context: context, options: ['delete'], labels: ['Delete']);
    if (choice == 'delete') {
      deleteChat(httpClient: ref.read(dioProvider), id: conversation.otherSide.id);
    }
  }

  void _startANewChat(UserInfo u) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(otherSide: u)));
  }

  @override
  bool get wantKeepAlive => true;
}