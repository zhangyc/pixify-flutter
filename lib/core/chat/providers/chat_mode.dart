import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatModeProvider = StateProvider<ChatMode>((ref) => ChatMode.docker);

final inputModeProvider = StateProvider<InputMode>((ref) => InputMode.sona);

final sonaLoadingProvider = StateProvider<bool>((ref) => false);

enum ChatMode {
  docker,
  input
}

enum ChatActionMode {
  hook,
  sona,
  suggestion
}

enum InputMode {
  manual,
  sona
}