import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/chat/services/like.dart';
import 'package:sona/core/like_me/models/social_user.dart';
import 'package:sona/utils/global/global.dart';

import '../../../account/providers/profile.dart';
import '../../../common/env.dart';


const _lastCheckTimeKey = 'like_me_last_check_time';

final likeMeStreamProvider = StreamProvider<List<SocialUser>>((ref) async* {
  final userId = ref.read(myProfileProvider)?.id;
  if (userId != null) {
    final stream = FirebaseFirestore.instance
        .collection('${env.firestorePrefix}_users').doc('$userId')
        .collection('like_me').limit(100)
        .snapshots();

    Future<List<SocialUser>> fetchData(Iterable<int> ids) {
      return fetchLikedMeList().then((resp) => (resp.data as List).map<SocialUser>(
              (m) => SocialUser.fromJson(m)
      ).toList());
    }

    await for (var snapshot in stream) {
      var ids = snapshot.docs.map<int>((doc) => int.parse(doc.id));
      try {
        final users = await fetchData(ids);
        yield users;
      } catch (e) {
        //
        rethrow;
      }
    }
  } else {
    yield [];
  }
});

final likeMeNoticeNotifier = StateProvider<bool>((ref) {
  final list = ref.watch(likeMeStreamProvider).unwrapPrevious().valueOrNull;
  final lastCheckTime = ref.watch(likeMeLastCheckTimeProvider);
  if (list == null || list.isEmpty) return false;
  if (lastCheckTime == null) return true;
  return (list.any((u) => u.updateTime!.isAfter(lastCheckTime)));
}, dependencies: [likeMeStreamProvider, likeMeLastCheckTimeProvider]);

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