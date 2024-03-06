import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
          ref.invalidate(conversationStreamProvider);
          ref.invalidate(asyncMyTravelWishesProvider);
          ref.invalidate(travelWishParamsProvider);
        });
        FirebaseAnalytics.instance.setUserId(id: null);
        FirebaseMessaging.instance.deleteToken();
      }
    });
    return global.token;
  }
);