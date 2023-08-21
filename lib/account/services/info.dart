import 'package:dio/dio.dart';
import 'package:sona/account/models/user_info.dart';

Future<Response> updateMyInfo({
  required Dio httpClient,
  required MyInfo info
}) async {
  return httpClient.post(
      '/user/update',
      data: info.toJson()
  );
}

Future<MyInfo> getMyInfo({
  required Dio httpClient,
}) async {
  final resp = await httpClient.post(
      '/user/find-myself'
  );
  return MyInfo.fromJson(resp.data);
}