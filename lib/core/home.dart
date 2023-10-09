import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/chat/screens/chat.dart';
import 'package:sona/core/chat/screens/conversation.dart';
import 'package:sona/core/persona/screens/persona.dart';
import 'package:sona/core/providers/home_provider.dart';
import 'package:sona/core/providers/notice.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/location/location.dart';

import 'match/screens/match.dart';
import 'match/widgets/filter_dialog.dart';

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
    SonaAnalytics.init();
    _determinePosition();
    _setUpFcmListener();
    super.initState();
  }

  void _determinePosition() async {
    final position = await determinePosition();
    longitude=position.longitude;
    latitude=position.latitude;
    ref.read(myProfileProvider.notifier).updateField(position: position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final bottomItem = ref.watch(backgroundColorProvider);
          return Container(
            decoration: (bottomItem.index==0||bottomItem.index==2)?BoxDecoration(
              color: bottomItem.color
            ):BoxDecoration(
                gradient: LinearGradient(colors: [

                  Colors.black.withOpacity(0.2),
                  bottomItem.color,
                  ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter

                )
            ),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconSize: 48,
              currentIndex: _currentIndex,
              onTap: _onPageChange,
              selectedItemColor: (bottomItem.index==0||bottomItem.index==2)?Colors.black:  Colors.white,
              unselectedItemColor: Color(0xff9f9f9f),
              items: [
                BottomNavigationBarItem(
                    icon: SonaIcon(icon: SonaIcons.navicon_chat, size: 24,color: Color(0xff9f9f9f), activeProvider: bottomChatNoticeProvider),
                    activeIcon: SonaIcon(icon: SonaIcons.navicon_chat, size: 24,color: Colors.black,),
                    label: 'Chat'
                ),
                BottomNavigationBarItem(
                    icon: SonaIcon(icon: SonaIcons.navicon_match, size: 24,color: Color(0xff9f9f9f),),
                    activeIcon: SonaIcon(icon: SonaIcons.navicon_match, size: 24,color: Colors.white,),
                    label: 'Match'
                ),
                BottomNavigationBarItem(
                    icon: SonaIcon(icon: SonaIcons.navicon_sona, size: 24,color: Color(0xff9f9f9f),),
                    activeIcon: SonaIcon(icon: SonaIcons.navicon_sona, size: 24,color: Colors.black,),
                    label: 'Profile'
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onPageChange(int index) {
    if (index == 0) {
      ref.read(backgroundColorProvider.notifier).updateColor(BottomColor(Colors.white, 0));
    } else if (index == 1) {
      ref.read(backgroundColorProvider.notifier).updateColor(BottomColor(Colors.black, 1));
      // 更新其他颜色
    }else if(index == 2){
      ref.read(backgroundColorProvider.notifier).updateColor(BottomColor(Colors.white, 2));

    }
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
        _pageController.jumpToPage(_currentIndex);
      });
      final tabName = switch(index) {
        0 => 'chat',
        1 => 'match',
        2 => 'profile',
        _ => 'none'
      };
      SonaAnalytics.log('home_tab_$tabName');
    }
  }

  void _setUpFcmListener() async{
    ///kill
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage==null){
      return;
    }
    if(initialMessage.data.containsKey('route')&&initialMessage.data['route']=='lib/core/chat/screens/conversation_list'){
      String ext= initialMessage.data['ext'];
      UserInfo info =UserInfo.fromJson(jsonDecode(ext));
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (c){
          return ChatScreen(entry: ChatEntry.push, otherSide: info);
        }));
      }
    }
    ///background start
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if(initialMessage.data.containsKey('route')&&initialMessage.data['route']=='lib/core/chat/screens/conversation_list'){
        String ext= initialMessage.data['ext'];
        UserInfo info =UserInfo.fromJson(jsonDecode(ext));
        Navigator.push(context, MaterialPageRoute(builder: (c){
          return ChatScreen(entry: ChatEntry.push, otherSide: info);
        }));
      }
    });
  }
}
