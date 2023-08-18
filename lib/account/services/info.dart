import 'package:dio/dio.dart';
import 'package:sona/account/models/user_info.dart';

Future<Response> updateMyInfo({
  required Dio httpClient,
  required UserInfo info
}) async {
  return httpClient.post(
      '/user/update',
      data: info.toJson()
  );
}

Future<UserInfo> getMyInfo({
  required Dio httpClient,
}) async {
  final resp = await httpClient.post(
      '/user/find-my-detail'
  );
  return UserInfo.fromJson(resp.data);
}