import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/utils/global/global.dart';

import '../models/gender.dart';
import '../models/my_profile.dart';

const profileKey = 'profile';

class MyProfileNotifier extends StateNotifier<MyProfile?> {
  MyProfileNotifier(super.state);

  void update(MyProfile? profile) {
    if (profile == null) {
      kvStore.remove(profileKey);
    } else {
      kvStore.setString(profileKey, jsonEncode(profile.toJson()));
    }
    state = profile;
  }

  Future<void> updateField({
    String? name,
    Gender? gender,
    DateTime? birthday,
    Set<String>? interests,
    String? avatar,
    String? bio,
    Position? position
  }) async {
    final resp = await updateMyProfile(
      name: name,
      gender: gender,
      birthday: birthday,
      interests: interests,
      avatar: avatar,
      bio: bio,
      position: position
    );
    if (resp.statusCode == 0) {
      await refresh();
    } else {
      //
    }
  }

  Future<void> refresh() async {
    final resp = await getMyProfile();
    if (resp.statusCode == 0) {
      update(MyProfile.fromJson(resp.data));
    } else {
      //
    }
  }
}

final myProfileProvider = StateNotifierProvider<MyProfileNotifier, MyProfile?>(
  (ref) {
    MyProfile? profile;
    try {
      final localCachedProfileString = kvStore.getString(profileKey);
      if (localCachedProfileString != null) {
        profile = MyProfile.fromJson(jsonDecode(localCachedProfileString));
      }
    } catch(e) {
      if (kDebugMode) print(e);
    }
    return MyProfileNotifier(profile);
  }
);
