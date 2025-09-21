import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/account/screens/auth_landing.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/services/global_notification_service.dart';
import 'package:sona/common/widgets/overlay/global_notification_overlay.dart';
import 'package:sona/core/providers/token.dart';
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
    GlobalNotifications.init(ref);
    MyProfile? profile;
    if (token != null) {
      profile = ref.read(myProfileProvider);
    }
    final navigatorKey = global.navigatorKey;
    var initialRoute = profile == null || !profile.completed ? 'login' : '/';
    return MaterialApp(
        builder: (context, child) {
          return Stack(
            children: [
              child!,
              GlobalNotificationOverlay(), // 浮动通知层
            ],
          );
        },
        debugShowCheckedModeBanner: false,
        key: ValueKey(token),
        navigatorKey: navigatorKey,
        // builder: EasyLoading.init(),
        theme: nightTheme,
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
