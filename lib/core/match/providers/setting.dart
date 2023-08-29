
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/utils/providers/kv_store.dart';

import '../../../account/models/gender.dart';

final positionProvider = StateProvider<Position?>((ref) => null);


@immutable
class MatchSetting {
  const MatchSetting({this.gender, this.ageRange});
  final Gender? gender;
  final RangeValues? ageRange;

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
  @override
  MatchSetting build() {
    final kvStore = ref.read(kvStoreProvider);

    Gender? gender;
    final storageGenderValue = kvStore.getInt('match:gender');
    if (storageGenderValue != null) {
      gender = Gender.values.firstWhere((g) => g.value == storageGenderValue);
    }

    RangeValues? ageRange;
    final ageRangeValues = kvStore.getString('match:agerange');
    if (ageRangeValues != null) {
      final values = ageRangeValues.split(':');
      ageRange = RangeValues(double.parse(values[0]), double.parse(values[1]));
    }
    return MatchSetting(
      gender: gender,
      ageRange: ageRange
    );
  }

  void setAgeRange(RangeValues ageRange) {
    state = state.copyWith(
      ageRange: ageRange
    );
    ref.read(kvStoreProvider).setString('match:agerange', [ageRange.start.toInt(), ageRange.end.toInt()].join(':'));
  }

  void setGender(Gender gender) {
    state = state.copyWith(
      gender: gender
    );
    ref.read(kvStoreProvider).setInt('match:gender', gender.value);
  }
}

final matchSettingProvider = NotifierProvider<MatchSettingNotifier, MatchSetting>(
    () => MatchSettingNotifier()
);
