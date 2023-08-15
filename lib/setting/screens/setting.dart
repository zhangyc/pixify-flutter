import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/providers/token.dart';

import '../../utils/dialog/input.dart';
import '../../utils/providers/env.dart';

class SettingScreen extends StatefulHookConsumerWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingScreen();
}

class _SettingScreen extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TextButton(
              onPressed: () {},
              child: Text('Notification')
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
              onPressed: () {},
              child: Text('About')
            ),
          ),
          SliverToBoxAdapter(
            child: TextButton(
                onPressed: _switchEnv,
                child: Text('Switch to local test env')
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: _logout,
                child: Text('Logout')
              ),
            ),
          )
        ],
      )
    );
  }

  Future<void> _switchEnv() async {
    final sure = await showConfirm(
        context: context,
        content: '连接到银古本地测试环境?\n(数据是同一份，不会丢失；App重启后复原)'
    );
    if (sure == true) {
      ref.read(envProvider.notifier).state = 'http://192.168.31.142:8000';
    }
  }

  void _logout() {
    ref.read(tokenProvider.notifier).state = null;
  }
}