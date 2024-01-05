import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/env.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/utils/global/global.dart';

import '../../../../account/providers/profile.dart';

final softKeyboardHeightProvider = StateProvider<double>((ref) => 300);

final inputModeProvider = StateProvider.family<InputMode, int>((ref, arg) {
  ref.listenSelf((previous, next) {
    kvStore.setBool(arg.toString(), next == InputMode.sona);
  });
  final enabled = kvStore.getBool(arg.toString()) ?? true;
  return enabled ? InputMode.sona : InputMode.manual;
}, dependencies: [conversationStreamProvider]);

final chatStylesVisibleProvider = StateProvider.family.autoDispose<bool, int>((ref, arg) {
  if (ref.watch(inputModeProvider(arg)) == InputMode.manual) {
    return false;
  }
  return false;
}, dependencies: [inputModeProvider]);

final sonaInputProvider = StateProvider.autoDispose.family<String, int>((ref, arg) => '');
final manualInputProvider = StateProvider.autoDispose.family<String, int>((ref, arg) => '');
final currentInputEmptyProvider = StateProvider.autoDispose.family<bool, int>((ref, arg) {
  final mode = ref.watch(inputModeProvider(arg));
  if (mode == InputMode.sona) {
    return ref.watch(sonaInputProvider(arg)).isEmpty;
  } else {
    return ref.watch(manualInputProvider(arg)).isEmpty;
  }
}, dependencies: [inputModeProvider, sonaInputProvider, manualInputProvider]);

enum InputMode {
  sona,
  manual
}