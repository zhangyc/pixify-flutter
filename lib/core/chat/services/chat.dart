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
  int? chatStyleId,
  String? input,
}) async {
  return httpClient.post(
      '/prompt/common',
      data: {
        'userId': userId,
        'type': type.name,
        'chatStyleId': chatStyleId,
        'input': input,
      }
  );
}

Future<Response> sendMessage({
  required Dio httpClient,
  required int userId,
  required CallSonaType type,
  required String content,
}) async {
  return httpClient.post(
      '/message/send',
      data: {
        'userId': userId,
        'message': content,
        'messageType': type.name
      }
  );
}

Future<Response> deleteChat({
  required Dio httpClient,
  required int id
}) async {
  return httpClient.post(
      '/message/delete-chat',
      data: {
        'id': id,
      }
  );
}
