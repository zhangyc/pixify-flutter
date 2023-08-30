
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/user_info.dart';
import 'package:sona/account/providers/info.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/utils/providers/kv_store.dart';
import 'package:sona/utils/timer/debounce.dart';

import '../../../account/models/gender.dart';

final positionProvider = StateProvider<Position?>((ref) {
  Position? position = ref.read(asyncMyProfileProvider).value?.position;
  ref.listen(asyncMyProfileProvider, (AsyncValue<MyInfo>? prev, AsyncValue<MyInfo> next) {
    if (next.value?.position != null && position != next.value!.position) {
      position = next.value!.position;
    }
  });
  return position;
}, dependencies: [asyncMyProfileProvider]);


@immutable
class MatchSetting {
  const MatchSetting({required this.gender, required this.ageRange});
  final Gender gender;
  final RangeValues ageRange;

  MatchSetting copyWith({
    Gender? gender,
    RangeValues? ageRange
  }) {
    return MatchSetting(
      gender: gender ?? this.gender,
      ageRange: ageRange ?? this.ageRange
    );
  }
}

class MatchSettingNotifier extends Notifier<MatchSetting> {
  static final debounce = Debounce(duration: const Duration(milliseconds: 300));

  @override
  MatchSetting build() {
    final kvStore = ref.read(kvStoreProvider);

    Gender? gender;
    final storageGenderValue = kvStore.getInt('match:gender');
    if (storageGenderValue != null) {
      gender = Gender.fromIndex(storageGenderValue);
    } else {
      gender = ref.read(asyncMyProfileProvider).value!.gender!.opposite();
    }

    RangeValues? ageRange;
    final ageRangeValues = kvStore.getString('match:agerange');
    if (ageRangeValues != null) {
      final values = ageRangeValues.split(':');
      ageRange = RangeValues(double.parse(values[0]), double.parse(values[1]));
    } else {
      ageRange = RangeValues(16, 60);
    }
    return MatchSetting(
      gender: gender,
      ageRange: ageRange
    );
  }

  void setAgeRange(RangeValues ageRange) {
    if (ageRange == state.ageRange) return;
    state = state.copyWith(
      ageRange: ageRange
    );
    debounce.run(ref.read(asyncMatchRecommendedProvider.notifier).refresh);
    ref.read(kvStoreProvider).setString('match:agerange', [ageRange.start.toInt(), ageRange.end.toInt()].join(':'));
  }

  void setGender(Gender gender) {
    if (gender == state.gender) return;
    state = state.copyWith(
      gender: gender
    );
    debounce.run(ref.read(asyncMatchRecommendedProvider.notifier).refresh);
    ref.read(kvStoreProvider).setInt('match:gender', gender.index);
  }
}

final matchSettingProvider = NotifierProvider<MatchSettingNotifier, MatchSetting>(
    () => MatchSettingNotifier()
);
