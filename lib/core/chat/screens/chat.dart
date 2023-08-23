import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/screens/function.dart';
import 'package:sona/core/persona/widgets/sona_avatar.dart';

import '../widgets/liked_me.dart';

class ChatScreen extends StatefulHookConsumerWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> with AutomaticKeepAliveClientMixin {
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
          const SliverToBoxAdapter(
            child: LikedMeListView(),
          ),
          ref.watch(asyncConversationsProvider).when(
            data: (conversations) => SliverList.separated(
              itemBuilder: (BuildContext context, int index) {
                final conversation = conversations[index];
                return GestureDetector(
                  key: ValueKey(conversation.otherSide.id),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatFunctionScreen(otherSide: conversation.otherSide))),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ListTile(
                      leading: SonaAvatar(),
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

  @override
  bool get wantKeepAlive => true;
}