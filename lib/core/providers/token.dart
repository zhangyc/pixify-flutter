import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/persona/providers/persona.dart';
import 'package:sona/core/providers/home_provider.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';
import 'package:sona/core/travel_wish/providers/my_wish.dart';
import 'package:sona/utils/global/global.dart' as global;

import '../like_me/providers/liked_me.dart';

final tokenProvider = StateProvider<String?>(
  (ref) {
    ref.listenSelf((previous, next) {
      global.token = next;
      if (next == null) {
        if (previous == null) return;
        global.navigatorKey.currentState?.pushNamedAndRemoveUntil('login', (route) => false);
        Future.delayed(const Duration(seconds: 1), () {
          ref.invalidate(currentHomeTapIndexProvider);
          ref.invalidate(myProfileProvider);
          ref.invalidate(likeMeStreamProvider);
          ref.invalidate(asyncPersonaProvider);
          ref.invalidate(conversationStreamProvider);
          // ref.invalidate(asyncChatStylesProvider);
          ref.invalidate(asyncMyTravelWishesProvider);
          ref.invalidate(travelWishParamsProvider);
          FirebaseMessaging.instance.deleteToken();
        });
      }
    });
    return global.token;
  }
);