import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/required_info_form.dart';
import 'package:sona/account/login.dart';
import 'package:sona/account/providers/info.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/core/providers/navigator_key.dart';
import 'package:sona/setting/screens/setting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sona/test/test_chat.dart';

import 'core/home.dart';


const primaryColor =  Color(0xFFFF00D4);
const scaffoldBackgroundColor = Colors.white;
const fontColour = Color(0xFF4D4D4D);

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
          child: Builder(
            builder: (context) {
              final asyncMyInfo = ref.watch(myInfoProvider);
              return Stack(
                children: [
                  Positioned.fill(child: child!),
                  Positioned.fill(child: asyncMyInfo.when(
                    data: (myInfo) {
                      if (myInfo.completed) {
                        return const Opacity(
                          opacity: 0,
                        );
                      } else {
                        final pages = [
                          const MaterialPage(
                              child: RequiredInfoFormScreen()
                          )
                        ];
                        return HeroControllerScope.none(
                          child: Navigator(
                            pages: pages,
                            onPopPage: (Route<dynamic> route, dynamic result) {
                              pages.remove(route.settings);
                              return route.didPop(result);
                            },
                          )
                        );
                      }
                    },
                    loading: () => Container(
                      color: Colors.white54,
                      alignment: Alignment.center,
                      child: const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator()
                      ),
                    ),
                    error: (err, stack) => token == null ? const Opacity(opacity: 0) : GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => ref.watch(myInfoProvider.notifier).refresh(),
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: const Text(
                          'Load info error\nclick the screen to try again.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, decoration: TextDecoration.none)
                        ),
                      ),
                    ),
                  ))
                ],
              );
            }
          ),
        );
      }),
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          titleTextStyle: GoogleFonts.inder(
            textStyle: const TextStyle(
              color: fontColour,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1
            )
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: fontColour
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark
          )
        ),
        textTheme: TextTheme(
          bodySmall: GoogleFonts.inder(
            textStyle: const TextStyle(
              color: fontColour,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 1
            )
          )
        )
      ),
      initialRoute: token == null ? 'login' : '/',
      // routes: _routes,
      onGenerateRoute: _onGenerateRoute,
      // home: TestChat(),
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