import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/providers/dio.dart';

import '../models/gender.dart';
import '../models/user_info.dart';


@immutable
class AsyncMyInfoNotifier extends AsyncNotifier<MyInfo> {

  Future<MyInfo> _fetchInfo() {
    return getMyInfo(httpClient: ref.read(dioProvider));
  }

  @override
  build() {
    return _fetchInfo();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchInfo());
  }

  Future<void> updateInfo({
    String? name,
    Gender? gender,
    DateTime? birthday,
    Set<String>? interests,
    String? avatar
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final dio = ref.watch(dioProvider);
      await updateMyInfo(
        httpClient: dio,
        name: name,
        gender: gender,
        birthday: birthday,
        interests: interests,
        avatar: avatar
      );
      return _fetchInfo();
    });
  }
}

final myInfoProvider = AsyncNotifierProvider<AsyncMyInfoNotifier, MyInfo>(
  () => AsyncMyInfoNotifier(),
  dependencies: [tokenProvider]
);