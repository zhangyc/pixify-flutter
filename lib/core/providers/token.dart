import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/utils/providers/kv_store.dart';

const tokenKey = 'token';
final tokenProvider = StateProvider<String?>(
  (ref) {
    final kvStore = ref.watch(kvStoreProvider);
    ref.listenSelf((previous, next) {
      if (next == null) {
        kvStore.remove(tokenKey);
      } else {
        kvStore.setString(tokenKey, next);
      }
    });
    final token = kvStore.getString(tokenKey);
    return token;
  }
);