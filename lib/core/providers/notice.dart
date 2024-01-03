import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/utils/global/global.dart';

import '../chat/models/conversation.dart';

const convosStoreKey = 'convos_last_check_time';
final chatNoticeProvider = StateProvider<bool>((ref) {
  final convos = ref.watch(conversationStreamProvider).unwrapPrevious().valueOrNull;
  final convosCheckTime = kvStore.getInt(convosStoreKey) != null ? DateTime.fromMillisecondsSinceEpoch(kvStore.getInt(convosStoreKey)!) : null;
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