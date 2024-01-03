import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/chat/services/like.dart';
import 'package:sona/core/like_me/models/social_user.dart';
import 'package:sona/utils/global/global.dart';

final likeMeStreamProvider = StreamProvider((ref) {
  final streamController = StreamController<List<SocialUser>>.broadcast();
  fetchData([_]) async {
    fetchLikedMeList().then((resp) => (resp.data as List).map<SocialUser>(
      (m) => SocialUser.fromJson(m)
    ).toList()).then((list) => streamController.add(list)).catchError((_) {});
  }
  Timer.periodic(const Duration(seconds: 5), fetchData);
  fetchData();

  return streamController.stream;
});

const likeMeStoreKey = 'like_me_last_check_time';
final likeMeNoticeNotifier = StateProvider<bool>((ref) {
  var state = false;
  final list = ref.watch(likeMeStreamProvider).unwrapPrevious().valueOrNull;
  if (list != null) {
    if (list.isNotEmpty) {
      final mill = kvStore.getInt(likeMeStoreKey);
      if (mill == null) {
        state = true;
      } else {
        final lastCheckTime = DateTime.fromMillisecondsSinceEpoch(mill);
        state = list.any((u) => u.updateTime!.isAfter(lastCheckTime));
      }
    } else {
      state = false;
    }
  }
  return state;
}, dependencies: [likeMeStreamProvider]);