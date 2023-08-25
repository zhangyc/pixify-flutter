import 'package:dio/dio.dart';

Future<Response> fetchMatchedList({
  required Dio httpClient
}) async {
  return httpClient.post(
    '/user/friend/find-like'
  );
}
