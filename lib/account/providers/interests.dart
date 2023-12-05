import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/hobby.dart';
import 'package:sona/common/services/common.dart';

class AsyncInterestsNotifier extends AsyncNotifier<List<UserHobby>> {

  FutureOr<List<UserHobby>> _fetchInterests() async {
    final interests = await fetchAvailableInterests();
    if (interests.statusCode == 0) {
      return (interests.data as List).map<UserHobby>((hb) => UserHobby.fromJson(hb)).toList();
    } else {
      // todo: error handling
      return <UserHobby>[];
    }
  }

  @override
  FutureOr<List<UserHobby>> build() {
    return _fetchInterests();
  }
}

final asyncInterestsProvider = AsyncNotifierProvider<AsyncInterestsNotifier, List<UserHobby>>(
  () => AsyncInterestsNotifier()
);