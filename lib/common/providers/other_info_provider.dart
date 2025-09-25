import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/match/util/http_util.dart';

final getProfileByIdProvider = FutureProvider.family<HttpResult, int>((ref, userId) async {
  HttpResult result = await post('/user/find-detail', data: {"id": userId});
  if (result.isSuccess && result.data != null) {
    MatchUserInfo userInfo = MatchUserInfo.fromJson(result.data);
    result.data = userInfo;
  }
  return result;
});