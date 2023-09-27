import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/setting/screens/about.dart';
import 'package:sona/utils/global/global.dart';

import '../../common/widgets/webview.dart';
import '../../core/match/util/http_util.dart';
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
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                UserAvatar(url: ref.read(myProfileProvider)?.avatar??'',size: 80,)
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Notification'),
                CupertinoSwitch(
                  value: openNotification,
                  onChanged: (bool value) {
                    //openNotification=value;
                    post('/user/update',data: {
                       'openPush':value
                     }).then((resp){
                       if(resp.isSuccess){
                         openNotification=value;
                         Fluttertoast.showToast(msg: 'Modification succeeded');
                       }else {
                         Fluttertoast.showToast(msg: 'Modification failed');
                       }
                     });
                     setState(() {

                     });
                  },
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: TextButton(
              onPressed: () async{

              },
              child: Text('Account')
            ),
          ),
          SliverToBoxAdapter(
            child: TextButton(
              onPressed: () async{
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
              child: Text('About')
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              alignment: Alignment.center,
              child: ColoredButton(
                  onTap: _logout,
                  borderColor: Colors.black,
                  text: 'Logout'
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: _delete,
                child: Text('Delete Account', style: TextStyle(color: Colors.grey))
              ),
            ),
          )
        ],
      )
    );
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