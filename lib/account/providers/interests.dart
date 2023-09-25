import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/services/common.dart';

class AsyncInterestsNotifier extends AsyncNotifier<List<String>> {

  FutureOr<List<String>> _fetchInterests() async {
    final interests = await fetchAvailableInterests();
    if (interests.statusCode == 0) {
      return (interests.data as List).map<String>((i) => i['code']).toList();
    } else {
      // todo: error handling
      return [];
    }
  }

  @override
  FutureOr<List<String>> build() {
    return _fetchInterests();
  }
}

final asyncInterestsProvider = AsyncNotifierProvider<AsyncInterestsNotifier, List<String>>(
  () => AsyncInterestsNotifier()
);