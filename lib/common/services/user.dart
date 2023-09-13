import 'package:dio/dio.dart';

Future<Response> fetchUserInfo({
  required Dio httpClient,
  required int id
}) async {
  return httpClient.post(
      '/user/find-detail',
      data: {'id': id}
  );
}