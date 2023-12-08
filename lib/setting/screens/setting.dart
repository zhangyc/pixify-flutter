import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/widgets/button/forward.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/setting/screens/account.dart';
import 'package:sona/utils/dialog/common.dart';
import 'package:sona/utils/global/global.dart';

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
        title: Text(S.current.settings),
      ),
      body: CustomScrollView(
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
                    text: 'Account Setting',
                  ),
                  ForwardButton(
                    onTap: _showNotificationSetting,
                    text: 'Notification',
                  ),
                  ForwardButton(
                    onTap: _showPrivacy,
                    text: 'Privacy',
                  ),
                  ForwardButton(
                    onTap: _showAbout,
                    text: 'About',
                  ),
                  ForwardButton(
                    onTap: _logout,
                    text: 'Sign out',
                    color: Color(0xFFEA4710),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  void _showNotificationSetting() async {
    await showCommonBottomSheet(
        context: context,
        title: 'Notifications',
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Push notifications', style: Theme.of(context).textTheme.titleMedium),
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
      title: 'Privacy',
      description: 'When turned off, your city will not be displayed, which may prevent you from being found by other people',
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Display my city', style: Theme.of(context).textTheme.titleMedium),
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
    var result = await showRadioFieldDialog(context: context, options: {
      'Privacy Policy': '1',
      'Disclaimer': '2',
      'Terms and Conditions':'3'
    });
    if (result != null && mounted){
      if(result=='1'){
        Navigator.push(context, MaterialPageRoute(builder: (c){
          return WebView(url: 'https://h5.sona.pinpon.fun/privacy-policy.html', title: 'Privacy policy');
        }));
      }else if(result=='2'){
        Navigator.push(context, MaterialPageRoute(builder: (c){
          return WebView(url: 'https://h5.sona.pinpon.fun/disclaimer.html', title: 'Disclaimer');
        }));
      }else if(result=='3'){
        Navigator.push(context, MaterialPageRoute(builder: (c){
          return WebView(url: 'https://h5.sona.pinpon.fun/terms-and-conditions.html', title: 'Terms and conditions');
        }));
      }
    }
  }

}