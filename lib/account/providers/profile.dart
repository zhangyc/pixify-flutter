import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/utils/global/global.dart' as global;
import 'package:sona/utils/locale/locale.dart';

import '../models/gender.dart';
import '../models/my_profile.dart';

const profileKey = 'profile';

class MyProfileNotifier extends StateNotifier<MyProfile?> {
  MyProfileNotifier(super.state);

  void update(MyProfile? profile) {
    if (profile == null) {
      global.profile = profile;
      global.kvStore.remove(profileKey);
    } else {
      global.kvStore.setString(profileKey, jsonEncode(profile.toJson()));
    }
    state = profile;
  }

  void updatePushEnabled(bool value) {
    state = state?.copyWith(pushEnabled: value);
  }

  Future<void> updateField({
    String? name,
    Gender? gender,
    DateTime? birthday,
    Set<String>? interests,
    String? avatar,
    String? bio,
    Position? position,
    SonaLocale? locale,
    String? country
  }) async {
    final resp = await updateMyProfile(
      name: name,
      gender: gender,
      birthday: birthday,
      interests: interests,
      avatar: avatar,
      bio: bio,
      position: position,
      locale: locale,
      country: country
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
      final localCachedProfileString = global.kvStore.getString(profileKey);
      if (localCachedProfileString != null) {
        profile = MyProfile.fromJson(jsonDecode(localCachedProfileString));
      }
    } catch(e) {
      if (kDebugMode) print('error occurred when reading profile from local: $e');
    }
    return MyProfileNotifier(profile);
  }
);
