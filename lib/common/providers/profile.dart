import 'dart:async';
import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/services/user.dart';
import 'package:sona/utils/providers/dio.dart';

import '../models/user.dart';

class AsyncProfileNotifier
    extends AutoDisposeFamilyAsyncNotifier<UserInfo, int> {
  FutureOr<UserInfo> _fetchProfile() {
    return fetchUserInfo(httpClient: ref.read(dioProvider), id: arg)
      .then<UserInfo>((resp) => UserInfo.fromJson(resp.data))
      .onError((error, stackTrace) {
        log(error.toString());
        throw('load user:$arg info error');
      });
  }

  @override
  FutureOr<UserInfo> build(int arg) {
    return _fetchProfile();
  }
}

final asyncOthersProfileProvider = AsyncNotifierProvider.autoDispose
    .family<AsyncProfileNotifier, UserInfo, int>(() => AsyncProfileNotifier());
