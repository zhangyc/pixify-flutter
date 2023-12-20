import 'dart:ui';

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
    final initialRoute = profile == null || !profile.completed ? 'login' : '/';
    return MaterialApp(
      key: ValueKey(token),
      navigatorKey: navigatorKey,
      builder: EasyLoading.init(),
      theme: themeData,
      initialRoute: initialRoute,
      navigatorObservers: [routeObserver],
      // routes: _routes,
      onGenerateRoute: _onGenerateRoute,
      supportedLocales: supportedSonaLocales.map<Locale>((sl) => sl.toUILocale()),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: ref.watch(localeProvider),
      // localeListResolutionCallback: (List<Locale>? locales, Iterable<Locale> supportedLocales) {
      //
      //   // 判断当前locale是否为英语系国家，如果是直接返回Locale('en', 'US')
      // },
    );
  }
}

final _routes = <String, WidgetBuilder>{
  '/': (_) => const SonaHome(),
  'login': (_) => const LoginPhoneNumberScreen(),
  'setting': (_) => const SettingScreen(),
  'lib/core/chat/screens/conversation_list':(_) => const SettingScreen(),
};

Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
  final name = settings.name;
  final builder = _routes[name]!;
  print('${settings.arguments}');
  return MaterialPageRoute(builder: builder, settings: settings);
}
