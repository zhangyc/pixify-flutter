import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/services/common.dart';

import '../../../common/models/user.dart';
import '../../../utils/global/global.dart';
import '../models/audio_message.dart';
import '../models/message.dart';
import '../models/message_type.dart';
import '../models/text_message.dart';
import '../providers/chat.dart';
import '../providers/message.dart';
import 'chat.dart';

class MessageController {
  MessageController({
    required this.ref,
    required this.chatId,
    required this.otherInfo
  }) : myInfo = ref.read(myProfileProvider)!.toUser();

  final WidgetRef ref;
  final int chatId;
  final UserInfo myInfo;
  final UserInfo otherInfo;

  Future send(Map<String, dynamic> content) async {
    ImMessage message;
    switch(content['type']) {
      case ImMessageContentType.text:
        message = TextMessage.fromContent(
          sender: myInfo,
          receiver: otherInfo,
          content: content,
        );
        break;
      case ImMessageContentType.audio:
        message = AudioMessage.fromContent(
          sender: myInfo,
          receiver: otherInfo,
          content: content,
        );
        break;
      default:
        throw();
    }
    ref.read(localMessagesProvider(chatId).notifier).update((state) {
      return [...state, message];
    });
    final result = await _send(message);
    ref.read(localMessagesProvider(chatId).notifier).update((state) {
      final index = state.indexWhere((m) => m.uuid == message.uuid);
      if (index == -1) return state;
      return [...state..[index].localExtension = {'result': result}];
    });
  }

  Future resend(ImMessage message) async {
    final result = await _send(message);
    ref.read(localMessagesProvider(chatId).notifier).update((state) {
      final index = state.indexWhere((m) => m.uuid == message.uuid);
      if (index == -1) return state;
      return [...state..[index].localExtension = {'result': result}];
    });
  }

  Future<MessageSendingResult> _send(ImMessage msg) async {
    Response<dynamic> response;
    MessageSendingResult result;
    try {
      switch(msg.runtimeType) {
        case TextMessage:
          if (msg.content['localExtension']['needsTranslation']) {
            response = await sendMessage(
              uuid: msg.uuid!,
              userId: msg.receiver.id,
              type: ImMessageType.manual,
              content: msg.content..['message'] = msg.content['originalText'],
            );
          } else {
            response = await callSona(
              uuid: msg.uuid,
              userId: msg.receiver.id,
              type: CallSonaType.INPUT,
              input: msg.content['originalText']
            );
          }
        case AudioMessage:
          final localFile = File(msg.content['localExtension']['path']);
          msg.content['url'] ??= await uploadFile(bytes: localFile.readAsBytesSync(), filename: localFile.path);
          response = await sendMessage(
            uuid: msg.uuid!,
            userId: msg.receiver.id,
            content: msg.content,
          );
        default:
          throw();
      }

      result = switch (response.statusCode) {
        0 => MessageSendingResult(success: true, data: response.data),
        10150 => const MessageSendingResult(success: false, error: MessageSendingError.maximumLimit),
        20020 => const MessageSendingResult(success: false, error: MessageSendingError.contentFilter),
        _ => const MessageSendingResult(success: false, error: MessageSendingError.other)
      };

      if (result.success) {
        SonaAnalytics.log(msg.content['needsTranslation'] ? 'chat_sona' : 'chat_manual');
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
}