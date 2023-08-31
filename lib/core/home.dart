import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/info.dart';
import 'package:sona/core/chat/screens/conversation_list.dart';
import 'package:sona/core/persona/screens/persona.dart';
import 'package:sona/common/widgets/text/gradient_colored_text.dart';
import 'package:sona/utils/location/location.dart';

import 'match/providers/setting.dart';
import 'match/screens/match.dart';

class SonaHome extends StatefulHookConsumerWidget {
  const SonaHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SonaHomeState();
}

class _SonaHomeState extends ConsumerState<SonaHome> {
  int _currentIndex = 1;
  late final _pageController = PageController(initialPage: _currentIndex);

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  void _determinePosition() async {
    final position = await determinePosition();
    ref.read(asyncMyProfileProvider.notifier).updateInfo(position: position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChange,
        children: const [
          MatchScreen(),
          PersonaScreen(),
          ConversationList(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        currentIndex: _currentIndex,
        onTap: _onPageChange,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              activeIcon: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).colorScheme.primary)
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.favorite, color: Theme.of(context).colorScheme.primaryContainer)
              ),
              label: ''
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: GradientColoredText(
                text: 'S',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 24
                )
              ),
            ),
            activeIcon: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).colorScheme.primary)
              ),
              alignment: Alignment.center,
              child: GradientColoredText(
                  text: 'S',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24
                  )
              ),
            ),
            label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).colorScheme.primary)
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                      Icons.chat_bubble_outlined,
                      color: Theme.of(context).colorScheme.primaryContainer
                  )
              ),
              label: ''
          )
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