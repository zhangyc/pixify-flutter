import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/utils/global/global.dart';

import '../chat/models/conversation.dart';

final chatNoticeProvider = StateProvider<bool>((ref) {
  final convos = ref.watch(conversationStreamProvider).unwrapPrevious().valueOrNull;
  final lastCheckTime = ref.watch(convosLastCheckTimeProvider);
  if (convos == null || convos.isEmpty) return false;
  if (lastCheckTime == null) return true;
  return convos.any((convo) => (convo.hasUnreadMessage || convo.lastMessageId == null) && convo.dateTime.isAfter(lastCheckTime));
}, dependencies: [conversationStreamProvider, convosLastCheckTimeProvider]);

const _lastCheckTimeKey = 'convos_last_check_time';
final convosLastCheckTimeProvider = StateProvider<DateTime?>((ref) {
  final millisecondsSinceEpoch = kvStore.getInt(_lastCheckTimeKey);
  ref.listenSelf((previous, next) {
    if (next != null) {
      kvStore.setInt(_lastCheckTimeKey, next.millisecondsSinceEpoch);
    } else {
      kvStore.remove(_lastCheckTimeKey);
    }
  });
  return millisecondsSinceEpoch != null ? DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch) : null;
});

enum ChatNoticeMode {
  message,
  like,
  none
}