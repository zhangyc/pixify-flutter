import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../bean/match_user.dart';
import '../util/http_util.dart';

final updateProfileBioProvider = FutureProvider<HttpResult>((ref) async {
  return updateProfileBio();
});

Future<HttpResult> updateProfileBio() async {
  HttpResult result = await post('/prompt/common', data: {
    "type": "BIO",
  });
  if (result.isSuccess && result.data != null) {
    result.data = result.data['txt'] ?? '';
    return result;
  }

  return result;
}
