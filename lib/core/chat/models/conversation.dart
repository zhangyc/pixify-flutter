import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/utils/global/global.dart' as global;
import 'package:sona/common/models/user.dart';

class ImConversation {
  ImConversation._( {
    required this.convoId,
    required this.otherSide,
    required this.dateTime,
    required this.lastMessageId,
    required this.lastMessageType,
    required this.lastMessageOriginalContent,
    required this.lastMessageTranslatedContent,
    required this.lastMessageSenderId,
    required this.contentType,
  });

  final int convoId;
  final UserInfo otherSide;
  final DateTime dateTime;
  final int? lastMessageId;
  final int? lastMessageType;
  final String? lastMessageOriginalContent;
  final String? lastMessageTranslatedContent;
  final int? lastMessageSenderId;
  final int? contentType;

  DateTime? _checkTime;
  DateTime? get checkTime {
    if (_checkTime == null) {
      final msse = global.kvStore.getInt('convo_${convoId}_check_time');
      if (msse != null) _checkTime = DateTime.fromMillisecondsSinceEpoch(msse);
    }
    return _checkTime;
  }
  set checkTime(DateTime? dateTime) {
    if (dateTime == null) {
      global.kvStore.remove('convo_${convoId}_check_time');
    } else {
      global.kvStore.setInt('convo_${convoId}_check_time', dateTime.millisecondsSinceEpoch);
    }
    _checkTime = dateTime;
  }

  factory ImConversation.fromJson(Map<String, dynamic> json) {
    return ImConversation._(
      convoId: json['userId'],
      otherSide: UserInfo.fromJson({
        'id': json['userId'],
        'nickname': json['nickname'],
        'avatar': json['avatar']
      }),
      dateTime: (json['createDate'] as Timestamp).toDate(),
      lastMessageId: json['id'],
      lastMessageType: json['messageType'],
      lastMessageOriginalContent: json['originalContent'],
      lastMessageTranslatedContent: json['translatedContent'],
      lastMessageSenderId: json['sendUserId'],
      contentType: json['contentType']
      // inputMode: InputMode.values[json['inputMode'] ?? 0],
      // chatStyleId: json['chatStyleId']
    );
  }

  bool get hasUnreadMessage =>
      (lastMessageId == null
        || lastMessageOriginalContent != null
        && convoId == lastMessageSenderId)
        && (checkTime == null || checkTime!.isBefore(dateTime));
}