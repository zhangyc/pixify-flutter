import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/like_me/providers/liked_me.dart';

final chatNoticeProvider = StateProvider<bool>((ref) {
  final convos = ref.watch(conversationStreamProvider).unwrapPrevious().valueOrNull;
  if (convos == null) return false;
  if (convos.any((convo) => convo.hasUnreadMessage || convo.lastMessageId == null)) {
    return true;
  } else {
    return false;
  }
}, dependencies: [conversationStreamProvider]);

final bottomChatNoticeProvider = StateProvider<ChatNoticeMode>((ref) {
  try {
    final hasNewMsg = ref.watch(chatNoticeProvider);
    final hasNewLikeMe = ref.watch(likeMeNoticeNotifier);
    if (hasNewMsg) return ChatNoticeMode.message;
    if (hasNewLikeMe) return ChatNoticeMode.like;
  } catch (e) {
    //
  }
  return ChatNoticeMode.none;
}, dependencies: [chatNoticeProvider, likeMeNoticeNotifier]);

enum ChatNoticeMode {
  message,
  like,
  none
}