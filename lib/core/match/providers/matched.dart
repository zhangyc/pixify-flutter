import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/providers/setting.dart';
import 'package:sona/core/match/services/match.dart';
import 'package:sona/core/providers/navigator_key.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/utils/http/interceptors/base.dart';
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
    )
    .then<List>((resp) => resp.data as List)
    .then<List<UserInfo>>(
        (data) => data.map<UserInfo>((m) => UserInfo.fromJson(m)).toList()
    );
  }

  @override
  Future<List<UserInfo>> build() async {
    return _fetchMatched();
  }

  void like(int id) {
    _action(id, MatchAction.like);
  }

  void skip(int id) {
    _action(id, MatchAction.skip);
  }

  void arrow(int id) {
    _action(id, MatchAction.arrow);
  }

  void _action(int id, MatchAction action) async{
    try{
     await matchAction(
          httpClient: ref.read(dioProvider),
          userId: id,
          action: action);
    }catch(e){
      print(e);
      // if(e.code=="10150"){
      //   Navigator.push(ref.read(navigatorKeyProvider).currentContext!, MaterialPageRoute(builder:(c){
      //     return SubscribePage();
      //   }));
      // }
    }

  }
}

final asyncMatchRecommendedProvider = AsyncNotifierProvider<AsyncMatchRecommendedNotifier, List<UserInfo>>(
  () => AsyncMatchRecommendedNotifier(),
);
