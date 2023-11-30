import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/env.dart';
import 'package:sona/common/services/user.dart';

import '../models/user.dart';

class AsyncProfileNotifier
    extends AutoDisposeFamilyAsyncNotifier<UserInfo, int> {
  FutureOr<UserInfo> _fetchProfile() {
    return fetchUserInfo(id: arg)
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


class AsyncAdditionalUserInfoNotifier extends FamilyAsyncNotifier<UserInfo, int> {
  FutureOr<UserInfo> _fetchProfile() {
    return FirebaseFirestore.instance
      .collection('${env.firestorePrefix}_users')
      .doc(arg.toString())
      .get()
      .then((snapshot) => UserInfo.fromFirestore(snapshot.data()!))
      .catchError((e) {
        if (kDebugMode) print('get-fire-user-info error: $e');
        throw e;
      });
  }

  @override
  FutureOr<UserInfo> build(int arg) {
    return _fetchProfile();
  }
}

final asyncAdditionalUserInfoProvider = AsyncNotifierProvider.family<
    AsyncAdditionalUserInfoNotifier,
    UserInfo,
    int
>(() => AsyncAdditionalUserInfoNotifier());