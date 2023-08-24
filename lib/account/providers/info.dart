import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/utils/providers/dio.dart';

import '../models/gender.dart';
import '../models/user_info.dart';


@immutable
class AsyncMyProfileNotifier extends AsyncNotifier<MyInfo> {

  Future<MyInfo> _fetchProfile() {
    return getMyInfo(httpClient: ref.read(dioProvider));
  }

  @override
  build() {
    return _fetchProfile();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProfile());
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
      return _fetchProfile();
    });
  }
}

final asyncMyProfileProvider = AsyncNotifierProvider<AsyncMyProfileNotifier, MyInfo>(
  () => AsyncMyProfileNotifier()
);