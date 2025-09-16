import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/account/screens/auth_landing.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/onboarding/screen/onboarding.dart';
import 'package:sona/onboarding/screen/onboarding_b.dart';
import 'package:sona/setting/screens/setting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sona/theme/theme.dart';
import 'package:sona/utils/global/global.dart' as global;
import 'package:sona/utils/global/global.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sona/utils/locale/locale.dart';

import 'core/chat/screens/chat.dart';
import 'core/home.dart';
import 'generated/l10n.dart';

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
    var initialRoute = profile == null || !profile.completed ? 'login' : '/';
    // final onboarding = kvStore.getBool('onboarding') ?? false;
    // if (profile == null && !onboarding) {
    //   switch (Random().nextInt(3) % 3) {
    //     case 0:
    //       initialRoute = 'onboarding';
    //       break;
    //     case 1:
    //       initialRoute = 'onboarding_b';
    //       break;
    //     case 2:
    //       initialRoute = 'login';
    //       kvStore.setBool('onboarding', true);
    //       SonaAnalytics.log('reg_intro_v3go');
    //       break;
    //     default:
    //       initialRoute = 'login';
    //       break;
    //   }
    // }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        key: ValueKey(token),
        navigatorKey: navigatorKey,
        builder: EasyLoading.init(),
        theme: themeData,
        initialRoute: initialRoute,
        navigatorObservers: [routeObserver],
        // routes: _routes,
        onGenerateRoute: _onGenerateRoute,
        supportedLocales: supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: ref.watch(localeProvider),
        localeResolutionCallback: (_, __) {
          if (profile?.locale == 'yue') {
            return const Locale('zh', 'TW');
          }
          return null;
        });
  }
}

final _routes = <String, WidgetBuilder>{
  'onboarding': (_) => const OnboardingScreen(),
  'onboarding_b': (_) => const OnboardingScreenB(),
  '/': (_) => const SonaHome(),
  'login': (_) => const AuthLandingScreen(),
  'setting': (_) => const SettingScreen(),
  'lib/core/chat/screens/conversation_list': (_) => const SettingScreen(),
};

Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
  final name = settings.name;
  final builder = _routes[name]!;
  return MaterialPageRoute(builder: builder, settings: settings);
}
