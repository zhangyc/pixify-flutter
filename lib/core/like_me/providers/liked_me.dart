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
  Timer.periodic(const Duration(seconds: 30), fetchData);
  fetchData();

  return streamController.stream;
});

final likeMeNoticeNotifier = StateProvider<bool>((ref) {
  final list = ref.watch(likeMeStreamProvider).unwrapPrevious().valueOrNull;
  final lastCheckTime = ref.watch(likeMeLastCheckTimeProvider);
  if (list == null || list.isEmpty) return false;
  if (lastCheckTime == null) return true;
  return (list.any((u) => u.updateTime!.isAfter(lastCheckTime)));
}, dependencies: [likeMeStreamProvider, likeMeLastCheckTimeProvider]);

const _lastCheckTimeKey = 'like_me_last_check_time';
final likeMeLastCheckTimeProvider = StateProvider<DateTime?>((ref) {
  final millisecondsSinceEpoch = kvStore.getInt(_lastCheckTimeKey);
  ref.listenSelf((previous, next) {
    if (next != null) {
      kvStore.setInt(_lastCheckTimeKey, next.millisecondsSinceEpoch);
    } else {
      kvStore.remove(_lastCheckTimeKey);
    }
  });
  return millisecondsSinceEpoch != null ? DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch) : null;
});