import 'package:dio/dio.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/models/message_type.dart';
import 'package:sona/utils/global/global.dart';

Future<Response> fetchChatList() async {
  return dio.post(
      '/user/friend/find-chat'
  );
}

Future<Response> fetchMessageList({
  required int userId,
  required int page,
  int pageSize = 20
}) async {
  return dio.post(
    '/message/find',
    data: {
      'userId': userId,
      'page': page,
      'pageSize': pageSize
    }
  );
}

Future<Response> callSona({
  int? userId,
  required CallSonaType type,
  int? chatStyleId,
  String? input,
  int? messageId
}) async {
  return dio.post(
      '/prompt/common',
      data: {
        'userId': userId,
        'type': type.name,
        'chatStyleId': chatStyleId,
        'input': input,
        'messageId': messageId
      }
  );
}

Future<Response> sendMessage({
  required int userId,
  required ImMessageType type,
  required String content,
}) async {
  return dio.post(
      '/message/send',
      data: {
        'userId': userId,
        'message': content,
        'messageType': type.name
      }
  );
}

Future<Response> deleteChat({
  required int id
}) async {
  return dio.post(
      '/message/delete-chat',
      data: {
        'id': id,
      }
  );
}

Future<Response> deleteMessage({
  required int messageId
}) async {
  return dio.post(
      '/message/delete',
      data: {
        'id': messageId,
      }
  );
}

Future<Response> deleteAllMessages({
  required int chatId
}) async {
  return dio.post(
      '/message/delete-all',
      data: {
        'id': chatId,
      }
  );
}
