import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:sona/common/env.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/chat/models/text_message.dart';
import 'package:sona/utils/global/global.dart';

import '../../../generated/l10n.dart';
import 'audio_message.dart';
import 'image_message.dart';

class ImMessage {
  ImMessage({
    required this.chatId,
    required this.id,
    required this.uuid,
    required this.sender,
    required this.receiver,
    required this.time,
    required this.content,
    required this.read
  });

  final int chatId;
  int? id;
  final String? uuid;
  final UserInfo sender;
  final UserInfo receiver;
  final DateTime time;
  final Map<String, dynamic> content;
  final bool read;
  Map? localExtension;

  factory ImMessage.fromJson(Map<String, dynamic> json) {
    return switch(json['contentType']) {
      ImMessageContentType.text => TextMessage.fromJson(json),
      ImMessageContentType.image => ImageMessage.fromJson(json),
      ImMessageContentType.audio => AudioMessage.fromJson(json),
      _ => TextMessage.fromJson(json),
    };
  }

  void markAsRead() {
    FirebaseFirestore.instance
        .collection('${env.firestorePrefix}_users')
        .doc(profile!.id.toString())
        .collection('rooms')
        .doc(chatId.toString())
        .collection('msgs')
        .doc(id.toString())
        .set({'read': true}, SetOptions(merge: true));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other)
        || (other is ImMessage && uuid == other.uuid);
  }

  @override
  int get hashCode => super.hashCode;
}

enum CallSonaType {
  MANUAL,
}

extension DateTimeExt on DateTime {
  String toMessageTime(String languageTag) {
    final now = DateTime.now();
    if (year == now.year) {
      if (month == now.month) {
        if (day == now.day) {
          if (now.difference(this) < const Duration(hours: 1)) {
            if (now.difference(this) < const Duration(minutes: 1)) {
              return S.current.justNow;
            } else {
              return DateFormat.Hm(languageTag).format(this);
            }
          } else {
            return DateFormat.Hm(languageTag).format(this);
          }
        } else {
          return DateFormat.MMMd(languageTag).add_Hm().format(this);
        }
      } else {
        return DateFormat.yMMMd(languageTag).add_Hm().format(this);
      }
    } else {
      return DateFormat.yMMMd(languageTag).add_Hm().format(this);
    }
  }
}

class SendingMessage {
  SendingMessage({
    required this.target,
    required this.type,
    required this.content
  });
  final int target;
  final int type;
  final Map<String, dynamic> content;
}

class ImMessageContentType {
  static const unknown = 0;
  static const text = 1;
  static const image = 2;
  static const audio = 3;

  static const all = [text, text, image, audio];
}