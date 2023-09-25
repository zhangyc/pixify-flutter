import 'dart:async';
import 'dart:convert';

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
      state = MyProfile.fromJson(resp.data);
    } else {
      //
    }
  }

  Future<void> refresh() async {
    final resp = await getMyProfile();
    if (resp.statusCode == 0) {
      state = MyProfile.fromJson(resp.data);
    } else {
      //
    }
  }
}

final myProfileProvider = StateNotifierProvider<MyProfileNotifier, MyProfile?>(
  (ref) {
    final profile = kvStore.getString(profileKey);
    return MyProfileNotifier(profile != null ? MyProfile.fromJson(jsonDecode(profile)) : null);
  }
);
