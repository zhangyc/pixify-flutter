import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/utils/providers/dio.dart';
import 'package:sona/utils/providers/kv_store.dart';

import '../models/gender.dart';
import '../models/user_info.dart';


@immutable
class AsyncMyProfileNotifier extends AsyncNotifier<MyInfo> {

  Future<MyInfo> _fetchProfile() async {
    final profile = await getMyInfo(httpClient: ref.read(dioProvider));
    ref.read(kvStoreProvider).setString('profile', jsonEncode(profile.toJson()));
    return profile;
  }

  @override
  FutureOr<MyInfo> build() {
    try {
      final localCachedProfileString = ref.read(kvStoreProvider).getString('profile1');
      return MyInfo.fromJson(jsonDecode(localCachedProfileString!));
    } catch(e) {
      return _fetchProfile();
    }
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
    String? avatar,
    Position? position,
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
        avatar: avatar,
        position: position
      );
      return _fetchProfile();
    });
  }
}

final asyncMyProfileProvider = AsyncNotifierProvider<AsyncMyProfileNotifier, MyInfo>(
  () => AsyncMyProfileNotifier()
);