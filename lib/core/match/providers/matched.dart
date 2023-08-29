import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/providers/setting.dart';
import 'package:sona/core/match/services/match.dart';
import 'package:sona/utils/providers/dio.dart';


/// 可能需要把分页数据也封装进来，no more data 等
@immutable
class AsyncMatchRecommendedNotifier extends AsyncNotifier<List<UserInfo>> {
  Future<List<UserInfo>> _fetchMatched() async {
    final position = ref.read(positionProvider);
    final setting = ref.read(matchSettingProvider);

    return fetchMatchPeople(
      httpClient: ref.read(dioProvider),
      position: position!,
      gender: setting.gender,
      range: setting.ageRange
    ).then<List>(
      (resp) => resp.data as List
    ).then<List<UserInfo>>(
      (data) => data.map<UserInfo>((m) => UserInfo.fromJson(m)).toList()
    );
  }

  @override
  Future<List<UserInfo>> build() async{
    return _fetchMatched();
  }

  Future refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      return _fetchMatched();
    });
  }

  void like(int id) {
    _action(id, MatchAction.like);
  }

  void skip(int id) {
    _action(id, MatchAction.skip);
  }

  void superlike(int id) {
    _action(id, MatchAction.arrow);
  }

  void _action(int id, MatchAction action) {
    matchAction(
        httpClient: ref.read(dioProvider),
        userId: id,
        action: MatchAction.like
    );
  }
}


final asyncMatchRecommendedProvider = AsyncNotifierProvider<AsyncMatchRecommendedNotifier, List<UserInfo>>(
  () => AsyncMatchRecommendedNotifier(),
);