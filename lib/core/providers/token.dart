import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/widgets/inputbar/chat_style.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/persona/providers/persona.dart';
import 'package:sona/core/travel_wish/providers/my_wish.dart';
import 'package:sona/utils/global/global.dart' as global;

import '../chat/providers/liked_me.dart';

final tokenProvider = StateProvider<String?>(
  (ref) {
    ref.listenSelf((previous, next) {
      global.token = next;
      if (next == null) {
        global.navigatorKey.currentState?.pushNamedAndRemoveUntil('login', (route) => false);
      }

      ref.invalidate(myProfileProvider);
      ref.invalidate(asyncLikedMeProvider);
      ref.invalidate(asyncPersonaProvider);
      ref.invalidate(asyncMatchRecommendedProvider);
      ref.invalidate(conversationStreamProvider);
      // ref.invalidate(asyncChatStylesProvider);
      ref.invalidate(asyncMyTravelWishesProvider);
    });
    return global.token;
  }
);