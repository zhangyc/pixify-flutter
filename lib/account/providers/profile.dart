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
class AsyncMyProfileNotifier extends AsyncNotifier<MyProfile> {

  Future<MyProfile> _fetchProfile() async {
    final profile = await getMyInfo(httpClient: ref.read(dioProvider));
    ref.read(kvStoreProvider).setString('profile', jsonEncode(profile.toJson()));
    return profile;
  }

  @override
  FutureOr<MyProfile> build() {
    try {
      final localCachedProfileString = ref.read(kvStoreProvider).getString('profile');
      final profile = MyProfile.fromJson(jsonDecode(localCachedProfileString!));
      refresh(true);
      return profile;
    } catch(e) {
      ref.read(kvStoreProvider).remove('profile');
      return _fetchProfile();
    }
  }

  Future<void> refresh([bool silence = false]) async {
    if (!silence) state = const AsyncValue.loading();
    final profile = await _fetchProfile();
    state = AsyncValue.data(profile);
  }

  Future<void> updateInfo({
    String? name,
    Gender? gender,
    DateTime? birthday,
    Set<String>? interests,
    String? avatar,
    String? bio,
    Position? position
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final dio = ref.watch(dioProvider);
      final resp = await updateMyInfo(
        httpClient: dio,
        name: name,
        gender: gender,
        birthday: birthday,
        interests: interests,
        avatar: avatar,
        bio: bio,
        position: position
      );
      if (resp.statusCode == 0) {
        return _fetchProfile();
      } else {
        return state.value!;
      }
    });
  }
}

final asyncMyProfileProvider = AsyncNotifierProvider<AsyncMyProfileNotifier, MyProfile>(
  () => AsyncMyProfileNotifier()
);
