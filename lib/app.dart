import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/login.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/core/providers/navigator_key.dart';
import 'package:sona/setting/screens/setting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'core/home.dart';


class SonaApp extends HookConsumerWidget {
  const SonaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(tokenProvider);
    final navigatorKey = ref.watch(navigatorKeyProvider);

    return MaterialApp(
      key: ValueKey(token),
      navigatorKey: navigatorKey,
      builder: EasyLoading.init(builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: child,
        );
      }),
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1
          ),
          iconTheme: IconThemeData(
            color: Colors.black87
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark
          )
        ),
      ),
      initialRoute: token == null ? 'login' : '/',
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
  print('on-generate-route: $name');
  final builder = _routes[name]!;
  return MaterialPageRoute(builder: builder, settings: settings);
}