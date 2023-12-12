import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/chat/services/like.dart';
import 'package:sona/core/like_me/models/social_user.dart';


class AsyncLikedMeUsersNotifier extends AsyncNotifier<List<SocialUser>> {
  Future<List<SocialUser>> _fetchLikedMeData() {
    return fetchLikedMeList().then(
      (resp) => (resp.data as List).map<SocialUser>(
        (m) => SocialUser.fromJson(m)
      ).toList()
    ).catchError((e) {
      if (kDebugMode) print('async like-me data error: $e');
      throw e;
    });
  }

  @override
  FutureOr<List<SocialUser>> build() {
    return _fetchLikedMeData();
  }

  Future refresh([bool silence = true]) async {
    if (!silence) {
      state = const AsyncValue.loading();
    }
    final data = await _fetchLikedMeData();
    if (state.hasValue && state.value!.isNotEmpty && data.isNotEmpty) {
      if (state.value!.first.id != data.first.id) {
        ref.read(likeMeNoticeNotifier.notifier).update((state) => true);
      }
    }
    state = AsyncValue.data(data);
  }
}

final asyncLikedMeProvider = AsyncNotifierProvider<AsyncLikedMeUsersNotifier, List<SocialUser>>(
  () => AsyncLikedMeUsersNotifier()
);

final likeMeNoticeNotifier = StateProvider<bool>((ref) {
  return false;
});