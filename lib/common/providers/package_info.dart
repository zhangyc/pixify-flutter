import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AsyncPackageInfoNotifier extends AsyncNotifier<PackageInfo> {
  @override
  FutureOr<PackageInfo> build() {
    return PackageInfo.fromPlatform();
  }
}

final asyncPackageInfoProvider = AsyncNotifierProvider<AsyncPackageInfoNotifier, PackageInfo>(
    () => AsyncPackageInfoNotifier()
);