import 'package:dio/dio.dart';
import 'package:sona/utils/global/global.dart';

Future<Response> fetchChatStyles() async {
  return dio.post(
    '/chat-style/find',
  );
}