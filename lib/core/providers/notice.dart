import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/like_me/providers/liked_me.dart';
import 'package:sona/utils/global/global.dart';

import '../chat/models/conversation.dart';

final chatNoticeProvider = StateProvider<bool>((ref) {
  final convos = ref.watch(conversationStreamProvider).unwrapPrevious().valueOrNull;
  ref.listenSelf((previous, next) {
    kvStore.setInt('convos_check_time', DateTime.now().millisecondsSinceEpoch);
  });
  final convosCheckTime = kvStore.getInt('convos_check_time') != null ? DateTime.fromMillisecondsSinceEpoch(kvStore.getInt('convos_check_time')!) : null;
  if (convos == null) return false;
  if (convos.any((ImConversation convo) => (convo.hasUnreadMessage || convo.lastMessageId == null) && (convosCheckTime == null || convo.dateTime.isAfter(convosCheckTime)))) {
    return true;
  } else {
    return false;
  }
}, dependencies: [conversationStreamProvider]);

enum ChatNoticeMode {
  message,
  like,
  none
}