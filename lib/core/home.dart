import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/chat/screens/conversation.dart';
import 'package:sona/core/persona/screens/persona.dart';
import 'package:sona/core/providers/notice.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/utils/location/location.dart';

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
    Stream<RemoteMessage> stream = FirebaseMessaging.onMessageOpenedApp;
    stream.listen((event) {
       print(event);
    });
    super.initState();
  }

  void _determinePosition() async {
    final position = await determinePosition();
    ref.read(myProfileProvider.notifier).updateField(position: position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(onPressed: (){
      //       Navigator.push(context, MaterialPageRoute(builder: (context){
      //         return SubscribePage();
      //       }));
      //     }, icon: Icon(Icons.subscriptions))
      //   ],
      // ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChange,
        children: const [
          ConversationScreen(),
          MatchScreen(),
          PersonaScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconSize: 48,
        currentIndex: _currentIndex,
        onTap: _onPageChange,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: SonaIcon(icon: SonaIcons.navicon_chat, size: 24,color: Colors.grey, activeProvider: bottomChatNoticeProvider),
              activeIcon: SonaIcon(icon: SonaIcons.navicon_chat, size: 24,color: Colors.black,),
              label: 'Chat'
          ),
          BottomNavigationBarItem(
              icon: SonaIcon(icon: SonaIcons.navicon_match, size: 24,color: Colors.grey,),
              activeIcon: SonaIcon(icon: SonaIcons.navicon_match, size: 24,color: Colors.black,),
              label: 'Match'
          ),
          BottomNavigationBarItem(
              icon: SonaIcon(icon: SonaIcons.navicon_sona, size: 24,color: Colors.grey,),
              activeIcon: SonaIcon(icon: SonaIcons.navicon_sona, size: 24,color: Colors.black,),
              label: 'Profile'
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
