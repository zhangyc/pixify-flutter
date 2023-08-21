import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/providers/dio.dart';

import '../models/user_info.dart';


@immutable
class AsyncMyInfoNotifier extends AsyncNotifier<MyInfo> {

  Future<MyInfo> _fetchInfo() {
    final dio = ref.read(dioProvider);
    return getMyInfo(httpClient: dio);
  }

  @override
  build() {
    return _fetchInfo();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchInfo());
  }

  Future<void> setInfo(MyInfo ui) async {
    final stt = state.value ?? MyInfo.empty;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final dio = ref.watch(dioProvider);
      await updateMyInfo(httpClient: dio, info: stt.copyWith(ui));
      return _fetchInfo();
    });
  }
}

final myInfoProvider = AsyncNotifierProvider<AsyncMyInfoNotifier, MyInfo>(
  () => AsyncMyInfoNotifier(),
  dependencies: [tokenProvider]
);