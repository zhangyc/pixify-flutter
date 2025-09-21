import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/env.dart';
import 'package:sona/common/providers/package_info.dart';
import 'package:sona/common/widgets/button/forward.dart';
import 'package:sona/common/widgets/text/neon_word_mark.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/setting/screens/account.dart';
import 'package:sona/utils/dialog/common.dart';
import 'package:sona/utils/global/global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../common/widgets/webview.dart';
import '../../generated/l10n.dart';
import '../../utils/dialog/input.dart';

class SettingScreen extends StatefulHookConsumerWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreen();
}

class _SettingScreen extends ConsumerState<SettingScreen> {
  bool openNotification = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: Navigator.of(context).pop,
          ),
          centerTitle: true,
          title: Text(S.of(context).settings),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      // Account 分组
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF1C1C1E)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white.withOpacity(0.06)
                                    : Colors.black.withOpacity(0.06),
                            width: 0.5,
                          ),
                        ),
                        child: ForwardButton(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (_) => AccountSettingScreen())),
                            text: S.of(context).account,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                      ),
                      const SizedBox(height: 12),
                      // Settings 分组
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF1C1C1E)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white.withOpacity(0.06)
                                    : Colors.black.withOpacity(0.06),
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            ForwardButton(
                              onTap: _showNotificationSetting,
                              text: S.of(context).notifications,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            Container(
                              height: 0.5,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              color: Theme.of(context)
                                  .dividerColor
                                  .withOpacity(0.25),
                            ),
                            ForwardButton(
                              onTap: _showPrivacy,
                              text: S.of(context).privacy,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            Container(
                              height: 0.5,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              color: Theme.of(context)
                                  .dividerColor
                                  .withOpacity(0.25),
                            ),
                            ForwardButton(
                              onTap: _showAbout,
                              text: S.of(context).about,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Sign Out 分组
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFF1C1C1E)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white.withOpacity(0.06)
                                    : Colors.black.withOpacity(0.06),
                            width: 0.5,
                          ),
                        ),
                        child: ForwardButton(
                          onTap: _logout,
                          text: S.of(context).buttonSignOut,
                          color: const Color(0xFFEA4710),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    NeonWordmark(text: 'Astro Pair', fontSize: 16),
                    const SizedBox(height: 8),
                    Text(
                      ref.watch(asyncPackageInfoProvider).when(
                            data: (info) => kDebugMode
                                ? 'Version ${info.version} build ${info.buildNumber}'
                                : 'Version ${info.version}',
                            error: (_, __) => '',
                            loading: () => '',
                          ),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xFF8E8E93)
                                    : const Color(0xFF8E8E93),
                          ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  void _showNotificationSetting() async {
    await showCommonBottomSheet<void>(
        context: context,
        title: S.of(context).notifications,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).pushNotifications,
                  style: Theme.of(context).textTheme.titleMedium),
              Consumer(
                  builder: (_, _ref, __) => Switch(
                      value: _ref.watch(myProfileProvider)!.pushEnabled,
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xFF34C759),
                      onChanged: (value) {
                        toggleNotification(value);
                      }))
            ],
          )
        ]);
  }

  Future<void> toggleNotification(bool value) {
    return dio.post<Map<String, dynamic>>('/user/update',
        data: {'openPush': value}).then((resp) {
      if (resp.statusCode == 0) {
        ref.read(myProfileProvider.notifier).updatePushEnabled(value);
      }
    });
  }

  void _logout() {
    ref.read(tokenProvider.notifier).state = null;
  }

  Future<void> _showPrivacy() async {
    await showCommonBottomSheet<void>(
        context: context,
        title: S.of(context).privacy,
        description: S.of(context).warningCancelDisplayCity,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).displayMyCity,
                  style: Theme.of(context).textTheme.titleMedium),
              Consumer(
                builder: (_, _ref, __) => Switch(
                    value: _ref.watch(myProfileProvider)!.cityVisibility,
                    activeColor: Colors.white,
                    activeTrackColor: const Color(0xFF34C759),
                    onChanged: (value) {
                      toggleCityVisibility(value);
                    }),
              )
            ],
          )
        ]);
  }

  Future<void> toggleCityVisibility(bool value) {
    return dio.post<Map<String, dynamic>>('/user/update',
        data: {'showCity': value}).then((resp) {
      if (resp.statusCode == 0) {
        ref.read(myProfileProvider.notifier).updateCityVisibility(value);
      }
    });
  }

  Future _showAbout() async {
    var result = await showActionButtons(context: context, options: {
      S.of(context).privacyPolicy: '1',
      S.of(context).disclaimer: '2',
      S.of(context).termsOfService: '3',
      S.of(context).feedback: 'feedback'
    });
    if (result != null && mounted) {
      if (result == '1') {
        Navigator.push(context, MaterialPageRoute<void>(builder: (c) {
          return WebView(
              url: env.privacyPolicy, title: S.of(context).privacyPolicy);
        }));
      } else if (result == '2') {
        Navigator.push(context, MaterialPageRoute<void>(builder: (c) {
          return WebView(url: env.disclaimer, title: S.of(context).disclaimer);
        }));
      } else if (result == '3') {
        Navigator.push(context, MaterialPageRoute<void>(builder: (c) {
          return WebView(
              url: env.termsOfService, title: S.of(context).termsOfService);
        }));
      } else if (result == 'feedback') {
        const email = 'sona@zervo.me';
        launchUrl(Uri(scheme: 'mailto', path: email),
            mode: LaunchMode.externalApplication);
      }
    }
  }
}
