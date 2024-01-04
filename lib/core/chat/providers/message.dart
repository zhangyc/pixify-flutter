import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/models/message_type.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/inputbar/mode_provider.dart';

import '../../../account/providers/profile.dart';
import '../../../utils/global/global.dart';
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

  factory MessageSendingParams.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString);
    return MessageSendingParams(
        id: json['id'],
        userId: json['userId'],
        mode: InputMode.values[json['mode']],
        content: json['content'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime'])
    );
  }

  String toJsonString() {
    return jsonEncode({
      'id': id,
      'userId': userId,
      'mode': mode.index,
      'content': content,
      'dateTime': dateTime.millisecondsSinceEpoch
    });
  }

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
  final dynamic data;
  final MessageSendingError? error;
}

enum MessageSendingError {
  maximumLimit,
  contentFilter,
  other
}

class AsyncMessageSendingNotifier extends AutoDisposeFamilyAsyncNotifier<MessageSendingResult, String> {
  Future<MessageSendingResult> _send() async {
    final params = MessageSendingParams.fromJsonString(arg);
    MessageSendingResult result;
    Response<dynamic> response;
    // ref.keepAlive();
    // ref.onCancel(() {ref.invalidateSelf();});
    // ref.onDispose(() {ref.invalidateSelf();});
    try {
      if (params.mode == InputMode.manual) {
        response = await sendMessage(
          userId: params.userId,
          type: ImMessageType.manual,
          content: params.content,
        );
      } else {
        response = await callSona(
          userId: params.userId,
          type: CallSonaType.INPUT,
          input: params.content
        );
      }
      result = switch (response.statusCode) {
        0 => MessageSendingResult(success: true, data: response.data),
        10150 => const MessageSendingResult(success: false, error: MessageSendingError.maximumLimit),
        20020 => const MessageSendingResult(success: false, error: MessageSendingError.contentFilter),
        _ => const MessageSendingResult(success: false, error: MessageSendingError.other)
      };

      if (result.success) {
        ref.read(localPendingMessagesProvider(params.userId).notifier).update((state) => List.from(state..removeWhere((msg) => msg.id == params.id)));
        SonaAnalytics.log(params.mode == InputMode.sona ? 'chat_sona' : 'chat_manual');
      } else {
        switch (result.error) {
          case MessageSendingError.maximumLimit:
            if (ref.read(myProfileProvider)!.isMember) {
              SonaAnalytics.log('sona_message_hit_maximum_limit:plus');
            } else {
              SonaAnalytics.log('sona_message_hit_maximum_limit:non-plus');
            }
            break;
          case MessageSendingError.contentFilter:
            SonaAnalytics.log('sona_message_hit_content_filter');
            break;
          default:
            break;
        }
      }
    } catch(e) {
      if (kDebugMode) print(e);
      result = const MessageSendingResult(
        success: false,
        error: MessageSendingError.other
      );
    }
    return result;
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

final asyncMessageSendingProvider = AsyncNotifierProvider.family.autoDispose<
    AsyncMessageSendingNotifier,
    MessageSendingResult,
    String
>(() => AsyncMessageSendingNotifier());