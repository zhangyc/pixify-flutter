import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/setting/screens/about.dart';
import 'package:sona/utils/global/global.dart';

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
            child: Row(
              children: [
                Text('Notification'),
                CupertinoSwitch(
                  value: openNotification,
                  onChanged: (bool value) {
                     openNotification=value;
                     dio.post('/user/update',data: {
                       'openPush':value
                     }).then((value){

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
              onPressed: () {},
              child: Text('Account')
            ),
          ),
          SliverToBoxAdapter(
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (c){
                  return AboutPage();
                }));
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