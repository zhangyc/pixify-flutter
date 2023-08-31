import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../screens/chat.dart';

final joystickCenterPositionProvider = StateProvider<Offset>((ref) => Offset.zero);

final joystickHitProvider = StateProvider<ChatActionMode>((ref) => ChatActionMode.docker);

final sonaLoadingProvider = StateProvider<bool>((ref) => false);