import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/screens/profile.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/conversation.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/screens/chat.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/conversation.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/providers/dio.dart';

import '../widgets/inputbar/chat_style.dart';
import '../widgets/liked_me.dart';

class ConversationScreen extends StatefulHookConsumerWidget {
  const ConversationScreen({super.key});
  static const routeName="/conversations";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(asyncChatStylesProvider);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Chat', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: LikedMeListView(onTap: (UserInfo u) => Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfileScreen(user: u)))),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 20),
              child: Text('Messages', style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold
              )),
            ),
          ),
          ref.watch(conversationStreamProvider).when(
            data: (conversations) => SliverList.separated(
              itemBuilder: (BuildContext context, int index) {
                final conversation = conversations[index];
                return ConversationItemWidget(
                  key: ValueKey(conversation.otherSide.id),
                  conversation: conversation,
                  onTap: () => _chat(ChatEntry.conversation, conversation.otherSide),
                  onLongPress: () => _showConversationActions(conversation),
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
            child: SizedBox(height: kBottomNavigationBarHeight),
          )
        ],
      )
    );
  }

  Future _showConversationActions(ImConversation conversation) async {
    final choice = await showRadioFieldDialog<String>(context: context, options: {'Delete': 'delete'});
    if (choice == 'delete') {
      deleteChat(httpClient: ref.read(dioProvider), id: conversation.otherSide.id);
    }
  }

  Future _chat(ChatEntry entry, UserInfo u) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(entry: entry, otherSide: u)));
  }

  @override
  bool get wantKeepAlive => true;
}