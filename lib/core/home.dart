import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/screens/chat.dart';
import 'package:sona/core/persona/screens/persona.dart';

import 'match/screens/match.dart';

class SonaHome extends StatefulHookConsumerWidget {
  const SonaHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SonaHomeState();
}

class _SonaHomeState extends ConsumerState<SonaHome> {
  int _currentIndex = 0;
  late final _pageController = PageController(initialPage: _currentIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChange,
        children: [
          MatchScreen(),
          PersonaScreen(),
          ChatScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onPageChange,
        items: [
          BottomNavigationBarItem(icon: Text('match'), label: 'match'),
          BottomNavigationBarItem(icon: Text('persona'), label: 'persona'),
          BottomNavigationBarItem(icon: Text('chat'), label: 'chat')
        ],
      ),
    );
  }

  void _onPageChange(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
        _pageController.jumpToPage(_currentIndex);
      });
    }
  }
}