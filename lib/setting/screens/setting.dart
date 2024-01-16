import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/env.dart';
import 'package:sona/common/providers/package_info.dart';
import 'package:sona/common/widgets/button/forward.dart';
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
  bool openNotification=true;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ForwardButton(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AccountSettingScreen())),
                      text: S.of(context).account,
                    ),
                    ForwardButton(
                      onTap: _showNotificationSetting,
                      text: S.of(context).notifications,
                    ),
                    ForwardButton(
                      onTap: _showPrivacy,
                      text: S.of(context).privacy,
                    ),
                    ForwardButton(
                      onTap: _showAbout,
                      text: S.of(context).about,
                    ),
                    ForwardButton(
                      onTap: _logout,
                      text: S.of(context).buttonSignOut,
                      color: Color(0xFFEA4710),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/about_logo.png', height: 20),
                  SizedBox(height: 8),
                  Text(
                    ref.watch(asyncPackageInfoProvider).when(
                        data: (info) => kDebugMode ? 'Version ${info.version}  build ${info.buildNumber}' : 'Version ${info.version}',
                        error: (_, __) => '',
                        loading: () => ''
                    ),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Color(0xFFB7B7B7)
                    )
                  ),
                  SizedBox(height: 16)
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  void _showNotificationSetting() async {
    await showCommonBottomSheet(
        context: context,
        title: S.of(context).notifications,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).pushNotifications, style: Theme.of(context).textTheme.titleMedium),
              Consumer(
                builder: (_, _ref, __) => Switch(
                  value: _ref.watch(myProfileProvider)!.pushEnabled,
                  activeColor: Colors.white,
                  activeTrackColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    toggleNotification(value);
                  }
                )
              )
            ],
          )
        ]
    );
  }

  Future toggleNotification(bool value) {
    return dio.post('/user/update',data: {
      'openPush': value
    }).then((resp){
      if (resp.statusCode  == 0) {
        ref.read(myProfileProvider.notifier).updatePushEnabled(value);
      }
    });
  }

  void _logout() {
    ref.read(tokenProvider.notifier).state = null;
  }

  Future _showPrivacy() async {
    await showCommonBottomSheet(
      context: context,
      title: S.of(context).privacy,
      description: S.of(context).warningCancelDisplayCity,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.of(context).displayMyCity, style: Theme.of(context).textTheme.titleMedium),
            Consumer(
              builder: (_, _ref, __) => Switch(
                  value: _ref.watch(myProfileProvider)!.cityVisibility,
                  activeColor: Colors.white,
                  activeTrackColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    toggleCityVisibility(value);
                  }
              ),
            )
          ],
        )
      ]
    );
  }

  Future toggleCityVisibility(bool value) {
    return dio.post('/user/update',data: {
      'showCity': value
    }).then((resp){
      if (resp.statusCode  == 0) {
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
    if (result != null && mounted){
      if (result == '1') {
        Navigator.push(context, MaterialPageRoute(builder: (c){
          return WebView(url: env.privacyPolicy, title: S.of(context).privacyPolicy);
        }));
      } else if(result == '2') {
        Navigator.push(context, MaterialPageRoute(builder: (c){
          return WebView(url: env.disclaimer, title: S.of(context).disclaimer);
        }));
      } else if(result == '3') {
        Navigator.push(context, MaterialPageRoute(builder: (c){
          return WebView(url: env.termsOfService, title: S.of(context).termsOfService);
        }));
      } else if (result == 'feedback') {
        const email = 'sona@zervo.me';
        launchUrl(Uri(scheme: 'mailto', path: email), mode: LaunchMode.externalApplication);
      }
    }
  }

}