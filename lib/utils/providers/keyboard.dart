import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/providers/chat_mode.dart';

final keyboardChatStyleVisibleProvider = StateProvider<bool>((ref) => false);

final keyboardHeightProvider = StateProvider<double>((ref) => 0);

final keyboardMaxHeightProvider = StateProvider<double>((ref) => 300);

final keyboardBottomPositionProvider = StateProvider<double>((ref) {
  if (ref.watch(chatModeProvider) == ChatMode.docker) return 0;

  final inputMode = ref.watch(inputModeProvider);

  if (inputMode == InputMode.manual) {
    return ref.watch(keyboardHeightProvider);
  } else if (inputMode == InputMode.sona) {
    if (ref.watch(keyboardChatStyleVisibleProvider)) {
      return 0;
    } else {
      return ref.watch(keyboardHeightProvider);
    }
  }
  return 0;
}, dependencies: [chatModeProvider, inputModeProvider, keyboardMaxHeightProvider, keyboardHeightProvider, keyboardChatStyleVisibleProvider]);