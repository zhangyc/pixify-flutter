import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/providers/token.dart';

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

  void _logout() {
    ref.read(tokenProvider.notifier).state = null;
  }
}