import 'package:dio/dio.dart';

Future<Response> fetchLikedMeList({
  required Dio httpClient
}) async {
  return httpClient.post(
    '/user/friend/find-like-me'
  );
}
