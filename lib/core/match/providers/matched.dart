import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/services/match.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/providers/dio.dart';


/// 可能需要把分页数据也封装进来，no more data 等
@immutable
class AsyncMatchedNotifier extends AsyncNotifier<List<UserInfo>> {
  Future<List<UserInfo>> _fetchMatched() async {
    return fetchMatchPeople(
      httpClient: ref.read(dioProvider),
      page: 1,
      pageSize: 50
    ).then<List>(
      (resp) => resp.data['list'] as List
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


final matchedProvider = AsyncNotifierProvider<AsyncMatchedNotifier, List<UserInfo>>(
  () => AsyncMatchedNotifier(),
  dependencies: [tokenProvider]
);