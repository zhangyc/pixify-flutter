import 'package:dio/dio.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/models/message_type.dart';
import 'package:sona/utils/global/global.dart';

Future<Response> fetchChatList() async {
  return dio.post('/user/friend/find-chat');
}

Future<Response> fetchMessageList(
    {required int userId, required int page, int pageSize = 20}) async {
  return dio.post('/message/find',
      data: {'userId': userId, 'page': page, 'pageSize': pageSize});
}

Future<Response> callSona(
    {String? uuid,
    int? userId,
    required CallSonaType type,
    int? chatStyleId,
    String? input,
    int? messageId}) async {
  return dio.post('/prompt/common',
      data: {
        'uuid': uuid,
        'userId': userId,
        'type': type.name,
        'chatStyleId': chatStyleId,
        'input': input,
        'messageId': messageId
      }..removeWhere((key, value) => value == null));
}

/// 发送文本消息
Future<Response> sendTextMessage({
  required String uuid,
  required int userId,
  required String text,
}) async {
  return dio.post('/message/send', data: {
    'uuid': uuid,
    'userId': userId,
    'messageType': ImMessageType.manual.name,
    'contentType': ImMessageContentType.text,
    'message': text,
  });
}

/// 发送图片消息
Future<Response> sendImageMessage({
  required String uuid,
  required int userId,
  ImMessageType? type,
  required Map<String, dynamic> content,
}) async {
  return dio.post('/message/send',
      data: {
        'uuid': uuid,
        'userId': userId,
        'messageType': type?.name,
        'contentType': content['type'],
        'message': content['url'],
        ...content
      }..removeWhere((key, value) => value == null || key == 'localExtension'));
}

Future<Response> sendMessage({
  required String uuid,
  required int userId,
  ImMessageType? type,
  required Map<String, dynamic> content,
}) async {
  return dio.post('/message/send',
      data: {
        'uuid': uuid,
        'userId': userId,
        'messageType': type?.name,
        'contentType': content['type'],
        'message': content['url'],
        ...content
      }..removeWhere((key, value) => value == null || key == 'localExtension'));
}

Future<Response> deleteChat({required int id}) async {
  return dio.post('/message/delete-chat', data: {
    'id': id,
  });
}

Future<Response> deleteMessage({required int messageId}) async {
  return dio.post('/message/delete', data: {
    'id': messageId,
  });
}

Future<Response> deleteAllMessages({required int chatId}) async {
  return dio.post('/message/delete-all', data: {
    'id': chatId,
  });
}

Future<Response> feedback({
  required int messageId,
  required MessageFeedbackType type,
}) async {
  return dio.post('/message/feedback',
      data: {'messageId': messageId, 'feedbackStatus': type.status});
}

enum MessageFeedbackType {
  none(0),
  like(1),
  dislike(2);

  const MessageFeedbackType(this.status);

  factory MessageFeedbackType.fromStatus(int status) {
    return switch (status) {
      0 => MessageFeedbackType.none,
      1 => MessageFeedbackType.like,
      2 => MessageFeedbackType.dislike,
      _ => MessageFeedbackType.none
    };
  }

  final int status;
}
