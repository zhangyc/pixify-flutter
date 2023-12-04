import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/match/util/http_util.dart';
part 'other_info_provider.g.dart';
@riverpod
Future<HttpResult> getProfileById(GetProfileByIdRef ref,int userId) async {
  HttpResult result=await post('/user/find-detail',data: {
    "id":userId
  });
  if(result.isSuccess){
     MatchUserInfo userInfo=MatchUserInfo.fromJson(result.data);
     result.data=userInfo;
  }
  return result;
}