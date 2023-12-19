import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/models/message_type.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/inputbar/mode_provider.dart';

import 'chat.dart';

class MessageSendingParams {
  const MessageSendingParams({
    required this.id,
    required this.userId,
    required this.mode,
    required this.content,
    required this.dateTime
  });
  final int id;
  final int userId;
  final InputMode mode;
  final String content;
  final DateTime dateTime;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MessageSendingParams) return false;
    return id == other.id
      && userId == other.userId
      && mode == other.mode
      && content == other.content
      && dateTime == other.dateTime;
  }

  @override
  int get hashCode => Object.hash(id, userId, mode, content, dateTime);

  @override
  String toString() {
    return 'MessageSendingParams: $id, $userId, $mode, $content, $dateTime';
  }
}

class MessageSendingResult {
  const MessageSendingResult({
    required this.success,
    this.data,
    this.error
  });
  final bool success;
  final Map<String, dynamic>? data;
  final MessageSendingError? error;
}

enum MessageSendingError {
  maximumLimit,
  contentFilter,
  other
}

class AsyncMessageSendingNotifier extends AutoDisposeFamilyAsyncNotifier<MessageSendingResult, MessageSendingParams> {
  Future<MessageSendingResult> _send() async {
    Future<Response<dynamic>> future;
    if (arg.mode == InputMode.manual) {
      future = sendMessage(
        userId: arg.userId,
        type: ImMessageType.manual,
        content: arg.content,
      );
    } else {
      future = callSona(
        userId: arg.userId,
        type: CallSonaType.INPUT,
        input: arg.content
      );
    }
    return future.then<MessageSendingResult>((resp) {
      return switch (resp.statusCode) {
        0 => MessageSendingResult(success: true, data: resp.data),
        10150 => const MessageSendingResult(success: false, error: MessageSendingError.maximumLimit),
        20020 => const MessageSendingResult(success: false, error: MessageSendingError.contentFilter),
        _ => const MessageSendingResult(success: false, error: MessageSendingError.other)
      };
    }).catchError((_) => const MessageSendingResult(
      success: false,
      error: MessageSendingError.other
    ));
  }

  @override
  Future<MessageSendingResult> build(arg) {
    return _send();
  }

  Future resend() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _send());
  }
}

final asyncMessageSendingProvider = AsyncNotifierProvider.autoDispose.family<
    AsyncMessageSendingNotifier,
    MessageSendingResult,
    MessageSendingParams
>(() => AsyncMessageSendingNotifier());