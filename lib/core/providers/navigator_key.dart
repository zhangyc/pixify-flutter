import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/providers/token.dart';

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (ref) {
    ref.watch(tokenProvider);
    return GlobalKey<NavigatorState>(debugLabel: 'global-navigator-key');
  }
);