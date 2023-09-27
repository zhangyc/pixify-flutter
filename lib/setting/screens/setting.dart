import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/setting/screens/about.dart';
import 'package:sona/utils/global/global.dart';

import '../../common/widgets/webview.dart';
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
    // TODO: implement initState
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
        title: Text('Settings'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _showNotificationSetting,
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Icon(CupertinoIcons.bell),
                  SizedBox(width: 8),
                  Text('Notification', style: Theme.of(context).textTheme.bodyMedium),
                  Expanded(child: Container()),
                  // Text(openNotification ? 'on': 'off'),
                  Icon(CupertinoIcons.forward),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 24)),
          SliverToBoxAdapter(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () async {
                var result=await showRadioFieldDialog(context: context, options:
                {'Privacy Policy': '1',
                  'Disclaimer': '2',
                  'Terms and Conditions':'3'
                });
                if(result!=null){
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
              },
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Icon(CupertinoIcons.info),
                  SizedBox(width: 8),
                  Text('About', style: Theme.of(context).textTheme.bodyMedium),
                  Expanded(child: Container()),
                  // Text(openNotification ? 'on': 'off'),
                  Icon(CupertinoIcons.forward),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 180,
                    child: ColoredButton(
                        onTap: _logout,
                        text: 'Logout',
                      color: Colors.black,
                      fontColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 60),
                  TextButton(
                    onPressed: _delete,
                    child: Text('Delete Account', style: TextStyle(color: Colors.grey))
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  void _showNotificationSetting() async {
    final value = await showRadioFieldDialog(
      context: context,
      options: {
        'on': true,
        'off': false
      },
    );
    if (value != null) toggleNotification(value);
  }

  Future toggleNotification(bool value) {
    return dio.post('/user/update',data: {
      'openPush': value
    }).then((value){

    });
  }

  void _logout() {
    ref.read(tokenProvider.notifier).state = null;
  }

  Future _delete() async {
    final warningConfirm = await _showWarningConfirm();
    bool? finalConfirm;
    if (warningConfirm == true) {
      if (ref.read(myProfileProvider)!.isMember) {
        finalConfirm = await _showFinalConfirm();
      } else {
        finalConfirm = true;
      }
      if (finalConfirm == true) {
        final resp = await deleteAccount();
        if (resp.statusCode == 0) {
          if (mounted) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
          ref.read(tokenProvider.notifier).state = null;
        }
      }
    }
  }

  Future<bool?> _showWarningConfirm() {
    return showConfirm(
      context: context,
      title: 'Delete Account',
      confirmDelay: const Duration(seconds: 20),
      content: 'Deleting your account is permanent.\nAll your data will be deleted and can\'t be recovered.\nAre you sure you want to proceed?',
      confirmText: 'Delete',
    );
  }

  Future<bool?> _showFinalConfirm() {
    return showConfirm(
      context: context,
      title: 'Delete Account',
      content: 'Your account will be automatically deleted in 14 days.\n\nPlease remember to go to the store to cancel your current subscription to avoid additional charges.',
      confirmText: 'Got it',
      cancelText: 'Keep Account'
    );
  }
}