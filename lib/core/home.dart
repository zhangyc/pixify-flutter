import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/services/global_notification_service.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/chat/screens/chat.dart';
import 'package:sona/core/chat/screens/conversation.dart';
import 'package:sona/core/discover/screens/discover.dart';
import 'package:sona/core/like_me/providers/liked_me.dart';
import 'package:sona/core/like_me/screens/like_me.dart';
import 'package:sona/core/persona/screens/persona.dart';
import 'package:sona/core/providers/home_provider.dart';
import 'package:sona/core/providers/notice.dart';
import 'package:sona/core/travel_wish/providers/my_wish.dart';
import 'package:sona/core/widgets/generate_banner.dart';
import 'package:sona/generated/assets.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/location/location.dart';

import '../common/permission/permission.dart';
import '../firebase/sona_firebase.dart';
import '../generated/l10n.dart';
import 'chat/providers/chat.dart';
import 'match/screens/match.dart';
import 'match/util/local_data.dart';
import 'package:sona/common/env.dart';

class SonaHome extends StatefulHookConsumerWidget {
  const SonaHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SonaHomeState();
}

class _SonaHomeState extends ConsumerState<SonaHome> {
  int _currentIndex = 0;
  late final _pageController = PageController(initialPage: _currentIndex);

  @override
  void initState() {
    SonaAnalytics.setUserId();
    initUserPermission();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _handlerNotification();
      ref.refresh(asyncMyTravelWishesProvider);
      ref.refresh(conversationStreamProvider);
      ref.refresh(likeMeStreamProvider);
    });
    super.initState();
  }

  void _determinePosition() async {
    await Permission.locationWhenInUse.request();
    final position = await determinePosition();
    longitude = position.longitude;
    latitude = position.latitude;
    ref.read(myProfileProvider.notifier).updateFields(position: position);
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
        children: [
          MatchScreen(),
          LikeMeScreen(),
          ConversationScreen(onShowLikeMe: () {
            _pageController.animateToPage(1,
                duration: const Duration(milliseconds: 2), curve: Curves.ease);
          }),
          PersonaScreen(),
        ],
      ),
      bottomNavigationBar: Consumer(
        builder: (_, ref, __) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              top: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            iconSize: 24,
            currentIndex: ref.watch(currentHomeTapIndexProvider),
            onTap: _onPageChange,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFFB5B6C8) // nightTheme 的次级文字色
                : Theme.of(context).hintColor,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(Assets.homeUndiscover,width: 24,),
                    // child: SonaIcon(icon: SonaIcons.navicon_match, size: 24),x
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(Assets.homeDiscover,width: 24,),
                  // activeIcon: SonaIcon(
                  //   icon: SonaIcons.navicon_match_active,
                  //   size: 24,
                  //   color: Theme.of(context).primaryColor,
                  // ),
                  ),
                  label: ''
              ),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(Assets.homeUnFavorite,width: 24,),
                    // child: SonaIcon(
                    //     icon: SonaIcons.navicon_like_me,
                    //     size: 24,
                    //     activeProvider: likeMeNoticeNotifier),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgPicture.asset(Assets.homeFavorite,width: 24,),

                  // activeIcon: SonaIcon(
                  //   icon: SonaIcons.navicon_like_me_active,
                  //   size: 24,
                  //   color: Theme.of(context).primaryColor,
                  // ),
                  ),
                  label: ''
              ),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(Assets.homeUnchat,width: 24,),
                    // child: SonaIcon(
                    //     icon: SonaIcons.navicon_chat,
                    //     size: 24,
                    //     activeProvider: chatNoticeProvider),
                  ),

                  activeIcon: Padding(padding: EdgeInsets.all(4.0),
                    child: SvgPicture.asset(Assets.homeChat,width: 24,),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SonaIcon(icon: SonaIcons.navicon_sona, size: 24),
                  ),
                  activeIcon: SonaIcon(
                    icon: SonaIcons.navicon_sona_active,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: '')
            ],
          ),
        ),
      ),
    );
  }

  void _onPageChange(int index) {
    _currentIndex = index;
    setState(() {});
    if (index == 1) {
      ref
          .read(likeMeLastCheckTimeProvider.notifier)
          .update((state) => DateTime.now());
    } else if (index == 2) {
      ref
          .read(convosLastCheckTimeProvider.notifier)
          .update((state) => DateTime.now());
    }
    if (index != ref.read(currentHomeTapIndexProvider)) {
      ref.read(currentHomeTapIndexProvider.notifier).update((_) => index);
      _pageController.jumpToPage(index);
      final tabName = switch (index) {
        0 => 'match',
        1 => 'like',
        2 => 'chat',
        3 => 'me',
        _ => 'unknown'
      };
      SonaAnalytics.log('home_tab', {'index': index, 'name': tabName});
    }
  }

  void _handlerNotification() async {
    RemoteMessage? initialMessage = await messagesService.getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage.data.containsKey('screen') &&
          initialMessage.data['screen'] ==
              'lib/core/chat/screens/conversation_list') {
        String ext = initialMessage.data['ext'];
        if (kDebugMode) print('push_data: $ext');
        UserInfo info1 = UserInfo.fromJson(jsonDecode(ext));
        Navigator.push(navigatorKey.currentState!.context,
            MaterialPageRoute(builder: (c) {
          return ChatScreen(entry: ChatEntry.push, otherSide: info1);
        }));
      }
    }
  }
}
