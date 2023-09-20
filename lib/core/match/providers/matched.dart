import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    final resp= await matchAction(
        httpClient: ref.read(dioProvider),
        userId: id,
        action: action
    );
    if (resp.statusCode == 10150) {
      Navigator.push(ref.read(navigatorKeyProvider).currentContext!, MaterialPageRoute(builder:(c){
        return SubscribePage();
      }));
    }
  }
}

final asyncMatchRecommendedProvider = AsyncNotifierProvider<AsyncMatchRecommendedNotifier, List<UserInfo>>(
  () => AsyncMatchRecommendedNotifier(),
);

///过滤条件
final filterProvider = StateNotifierProvider<FilterNotifier, Filter>((ref) {
  return FilterNotifier()..loadFilter();
});

class Filter {
  int? minAge;
  int? maxAge;
  String? gender;

  Filter copyWith({
    int? minAge,
    int? maxAge,
    String? gender,
  }) {
    return Filter(
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      gender: gender ?? this.gender,
    );
  }
  Filter({this.minAge, this.maxAge, this.gender});
}

class FilterNotifier extends StateNotifier<Filter> {
  FilterNotifier() : super(Filter());

  void updateAge({int? min, int? max}) {
    state = state.copyWith(minAge: min, maxAge: max);
    _saveToCache();
  }

  void updateGender(String? gender) {
    state = state.copyWith(gender: gender);
    _saveToCache();
  }

  Future<void> _saveToCache() async {
    final prefs = await SharedPreferences.getInstance();
    if (state.minAge != null) {
      prefs.setInt('minAge', state.minAge!);
    }
    if (state.maxAge != null) {
      prefs.setInt('maxAge', state.maxAge!);
    }
    if (state.gender != null) {
      prefs.setString('gender', state.gender!);
    }
  }

  Future<void> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final minAge = prefs.getInt('minAge',);
    final maxAge = prefs.getInt('maxAge');
    final gender = prefs.getString('gender');
    if (minAge != null && maxAge != null && gender != null) {
      state = Filter(
        minAge: minAge,
        maxAge: maxAge,
        gender: gender,
      );
    }
  }

  Future<void> loadFilter() async {
    await _loadFromCache();
  }
}