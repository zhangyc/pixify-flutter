import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/screens/required_info_form.dart';
import 'package:sona/account/screens/login.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/core/providers/navigator_key.dart';
import 'package:sona/setting/screens/setting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sona/theme/theme.dart';

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
          child: Builder(builder: (context) {
            final asyncMyProfile = ref.watch(asyncMyProfileProvider);
            return Stack(
              children: [
                Positioned.fill(child: child!),
                Positioned.fill(
                    child: asyncMyProfile.when(
                  data: (myProfile) {
                    if (myProfile.completed) {
                      return const Opacity(
                        opacity: 0,
                      );
                    } else {
                      final pages = [
                        const MaterialPage(child: RequiredInfoFormScreen())
                      ];
                      return HeroControllerScope.none(
                          child: Navigator(
                        pages: pages,
                        onPopPage: (Route<dynamic> route, dynamic result) {
                          pages.remove(route.settings);
                          return route.didPop(result);
                        },
                      ));
                    }
                  },
                  loading: () => Container(
                    color: Colors.white54,
                    alignment: Alignment.center,
                    child: const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator()),
                  ),
                  error: (err, stack) => token == null
                      ? const Opacity(opacity: 0)
                      : GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () => ref
                              .watch(asyncMyProfileProvider.notifier)
                              .refresh(),
                          child: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: const Text(
                                'Cannot connect to server, tap to retry',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none)),
                          ),
                        ),
                ))
              ],
            );
          }),
        );
      }),
      theme: themeData,
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
  final builder = _routes[name]!;
  return MaterialPageRoute(builder: builder, settings: settings);
}
