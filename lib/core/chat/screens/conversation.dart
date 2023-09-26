import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/screens/profile.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/conversation.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/screens/chat.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/conversation.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/dialog/subsciption.dart';

import '../models/message.dart';
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
        title: Text('Chat', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: LikedMeListView(onTap: ([UserInfo? u]) {
              if (ref.read(myProfileProvider)!.isMember) {
                if (u == null) return;
                Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfileScreen(user: u!, relation: Relation.likeMe)));
              } else {
                showSubscription();
              }
            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 20),
              child: Text('Messages', style: Theme.of(context).textTheme.titleMedium),
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
            child: SizedBox(height: kBottomNavigationBarHeight),
          )
        ],
      )
    );
  }

  Future _showConversationActions(ImConversation conversation) async {
    final choice = await showRadioFieldDialog<String>(context: context, options: {'Delete': 'delete'});
    if (choice == 'delete') {
      deleteChat(id: conversation.otherSide.id);
    }
  }

  Future _chat(ChatEntry entry, UserInfo u) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(entry: entry, otherSide: u)));
  }

  Future _onHookTap(int userId) async {
    return callSona(
        userId: userId,
        type: CallSonaType.HOOK
    );
  }

  @override
  bool get wantKeepAlive => true;
}