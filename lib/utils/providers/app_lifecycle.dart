import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppStateObserver extends StateNotifier<bool> with WidgetsBindingObserver{
  bool isInBackground = false;

  AppStateObserver():super(false);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        isInBackground = true;
        // 应用程序进入后台运行
        break;
      case AppLifecycleState.resumed:
        isInBackground = false;
        // 应用程序返回前台运行
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }
}
final appIsBackgroundProvider = StateNotifierProvider<AppStateObserver, bool>((ref) {
  return AppStateObserver();
});