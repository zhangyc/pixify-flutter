import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../bean/match_user.dart';
import '../util/http_util.dart';

part 'update_info_provider.g.dart';

@riverpod
Future<HttpResult> updateProfileBio(UpdateProfileBioRef ref) async {
  HttpResult result=await post('/prompt/common',data: {
    "type":"BIO",
  });
  if(result.isSuccess&&result.data!=null){
    result.data=result.data['txt']??'';
    return result;
  }

  return result;
}