import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/widgets/inputbar/chat_style.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/persona/providers/persona.dart';
import 'package:sona/utils/providers/kv_store.dart';

import '../chat/providers/liked_me.dart';

const tokenKey = 'token';
final tokenProvider = StateProvider<String?>(
  (ref) {
    final kvStore = ref.watch(kvStoreProvider);
    ref.listenSelf((previous, next) {
      if (next == null) {
        // 移除本地缓存
        kvStore.remove(tokenKey);
        kvStore.remove(profileKey);

        // 重置状态
        ref.invalidate(asyncMyProfileProvider);
        ref.invalidate(asyncLikedMeProvider);
        ref.invalidate(asyncPersonaProvider);
        ref.invalidate(asyncMatchRecommendedProvider);
        ref.invalidate(conversationStreamProvider);
        ref.invalidate(asyncChatStylesProvider);
      } else {
        kvStore.setString(tokenKey, next);
      }
    });
    final token = kvStore.getString(tokenKey);
    return token;
  }
);