import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/services/match.dart';

class AsyncMatchActivityNotifier extends FamilyAsyncNotifier<String?, int> {
  @override
  FutureOr<String?> build(arg) {
    return getLikeActivity(userId: arg);
  }
}

final asyncMatchActivityProvider = AsyncNotifierProvider.family<AsyncMatchActivityNotifier, String?, int>(
    () => AsyncMatchActivityNotifier()
);