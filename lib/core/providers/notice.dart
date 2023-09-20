import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/providers/chat.dart';

final chatNoticeProvider = StateProvider<bool>((ref) {
  final convos = ref.watch(conversationStreamProvider).value;
  if (convos == null) return false;
  if (convos.any((convo) => convo.hasUnreadMessage)) {
    return true;
  } else {
    return false;
  }
}, dependencies: [conversationStreamProvider]);