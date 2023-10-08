import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/utils/timer/debounce.dart';

import '../../../account/models/gender.dart';
import '../../../utils/global/global.dart';

final positionProvider = StateProvider<Position?>((ref) {
  return ref.watch(myProfileProvider)?.position;
}, dependencies: [myProfileProvider]);


@immutable
class MatchSetting {
  const MatchSetting({required this.gender, required this.ageRange});
  final Gender? gender;
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
  static const genderKey = 'match:gender';
  static const ageRangeKey = 'match:agerange';

  @override
  MatchSetting build() {
    Gender? gender;
    final storageGenderValue = kvStore.getInt(genderKey);
    if (storageGenderValue != null) {
      gender = Gender.fromIndex(storageGenderValue);
    }

    RangeValues ageRange;
    final ageRangeValues = kvStore.getString(ageRangeKey);
    if (ageRangeValues != null) {
      final values = ageRangeValues.split(':');
      ageRange = RangeValues(double.parse(values[0]), double.parse(values[1]));
    } else {
      ageRange = RangeValues(18, 60);
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
    debounce.run(() => ref.refresh(asyncMatchRecommendedProvider));
    kvStore.setString(ageRangeKey, [ageRange.start.toInt(), ageRange.end.toInt()].join(':'));
  }

  void setGender(Gender? gender) {
    if (gender == state.gender) return;
    state = state.copyWith(
      gender: gender
    );
    debounce.run(() => ref.refresh(asyncMatchRecommendedProvider));
    if (gender != null) {
      kvStore.setInt(genderKey, gender.index);
    } else {
      kvStore.remove(genderKey);
    }
  }
}

final matchSettingProvider = NotifierProvider<MatchSettingNotifier, MatchSetting>(
    () => MatchSettingNotifier()
);
