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

class ConversationScreen extends StatefulHookConsumerWidget {
  const ConversationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> with AutomaticKeepAliveClientMixin, RouteAware {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didPushNext() {
    super.didPushNext();
  }

  @override
  void didPopNext() {
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
          ref.watch(conversationStreamProvider).when(
            data: (conversations) => SliverList.separated(
              itemBuilder: (BuildContext context, int index) {
                final conversation = conversations[index];
                return GestureDetector(
                  key: ValueKey(conversation.otherSide.id),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatFunctionScreen(otherSide: conversation.otherSide))),
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
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatFunctionScreen(otherSide: u)));
  }

  @override
  bool get wantKeepAlive => true;
}