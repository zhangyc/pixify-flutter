import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/account/screens/login.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/setting/screens/setting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sona/theme/theme.dart';
import 'package:sona/utils/global/global.dart' as global;

import 'core/home.dart';

class SonaApp extends HookConsumerWidget {
  const SonaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.read(tokenProvider);
    MyProfile? profile;
    if (token != null) {
      profile = ref.read(myProfileProvider);
    }
    final navigatorKey = global.navigatorKey;
    final initialRoute = profile == null || !profile.completed ? 'login' : '/';

    return MaterialApp(
      key: ValueKey(token),
      navigatorKey: navigatorKey,
      builder: EasyLoading.init(builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: child
        );
      }),
      theme: themeData,
      initialRoute: initialRoute,
      // routes: _routes,
      onGenerateRoute: _onGenerateRoute,
    );
  }
}

final _routes = <String, WidgetBuilder>{
  '/': (_) => const SonaHome(),
  'login': (_) => const LoginScreen(),
  'setting': (_) => const SettingScreen()
};

Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
  final name = settings.name;
  final builder = _routes[name]!;
  return MaterialPageRoute(builder: builder, settings: settings);
}
