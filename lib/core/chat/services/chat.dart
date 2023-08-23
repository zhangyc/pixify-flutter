import 'package:dio/dio.dart';
import 'package:sona/core/chat/models/message.dart';

Future<Response> fetchChatList({
  required Dio httpClient
}) async {
  return httpClient.post(
      '/user/friend/find-chat'
  );
}

Future<Response> fetchMessageList({
  required Dio httpClient,
  required int userId,
  required int page,
  int pageSize = 20
}) async {
  return httpClient.post(
    '/message/find',
    data: {
      'userId': userId,
      'page': page,
      'pageSize': pageSize
    }
  );
}

Future<Response> callSona({
  required Dio httpClient,
  required int userId,
  required CallSonaType type,
  String? input,
}) async {
  return httpClient.post(
      '/prompt/common',
      data: {
        'userId': userId,
        'type': type.name,
        'input': input,
      }
  );
}

Future<Response> sendMessage({
  required Dio httpClient,
  required int userId,
  required String content,
}) async {
  return httpClient.post(
      '/message/send',
      data: {
        'userId': userId,
        'message': content,
        'type': CallSonaType.SUGGEST
      }
  );
}

