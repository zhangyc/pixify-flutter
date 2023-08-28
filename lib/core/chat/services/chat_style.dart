import 'package:dio/dio.dart';

Future<Response> fetchChatStyles({
  required Dio httpClient
}) async {
  return httpClient.post(
    '/chat-style/find',
  );
}