import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/chat/services/like.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/providers/dio.dart';


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
    return fetchMatchedList(
      httpClient: ref.read(dioProvider)
    ).then(
      (resp) => (resp.data as List).map<UserInfo>((m) => UserInfo.fromJson(m)).toList()
    );
  }

  @override
  FutureOr<List<UserInfo>> build() {
    return _fetchLikedMeData();
  }

  Future refresh() async {
    state = await AsyncValue.guard(() => _fetchLikedMeData());
  }
}

final asyncLikedMeUsers = AsyncNotifierProvider<AsyncLikedMeUsersNotifier, List<UserInfo>>(
  () => AsyncLikedMeUsersNotifier(),
  dependencies: [tokenProvider]
);