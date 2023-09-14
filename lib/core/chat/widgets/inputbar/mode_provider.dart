import 'package:hooks_riverpod/hooks_riverpod.dart';

final softKeyboardHeightProvider = StateProvider<double>((ref) => 300);
final inputModeProvider = StateProvider.family<InputMode, int>((ref, arg) => InputMode.sona);
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
  manual,
  sona
}