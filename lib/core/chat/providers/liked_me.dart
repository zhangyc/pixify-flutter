import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/chat/services/like.dart';


class LikedMe {
  LikedMe({
    required this.count,
    required this.avatar
  });
  int count;
  String avatar;
}

class AsyncLikedMeUsersNotifier extends AsyncNotifier<List<UserInfo>> {

  Future<List<UserInfo>> _fetchLikedMeData() {
    return fetchLikedMeList().then(
      (resp) => (resp.data as List).map<UserInfo>(
        (m) => UserInfo.fromJson(m)
          ..likeDate = DateTime.fromMillisecondsSinceEpoch(m['likeDate'])
      ).toList()
    );
  }

  @override
  FutureOr<List<UserInfo>> build() {
    return _fetchLikedMeData();
  }

  Future refresh() async {
    final data = await _fetchLikedMeData();
    if (state.value != null && state.value!.isNotEmpty && data.isNotEmpty) {
      if (state.value!.first.id != data.first.id) {
        ref.read(likeMeNoticeNotifier.notifier).update((state) => true);
      }
    }
    state = AsyncValue.data(data);
  }
}

final asyncLikedMeProvider = AsyncNotifierProvider<AsyncLikedMeUsersNotifier, List<UserInfo>>(
  () => AsyncLikedMeUsersNotifier()
);

final likeMeNoticeNotifier = StateProvider<bool>((ref) {
  return false;
});