import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sona/utils/global/global.dart' as global;
import 'package:sona/common/models/user.dart';
import 'package:sona/core/chat/widgets/inputbar/mode_provider.dart';

class ImConversation {
  ImConversation._({
    required this.convoId,
    required this.otherSide,
    required this.dateTime,
    required this.lastMessageId,
    required this.lastMessageContent,
    required this.inputMode,
    required this.chatStyleId
  });

  final int convoId;
  final UserInfo otherSide;
  final DateTime dateTime;
  final int? lastMessageId;
  final String? lastMessageContent;
  final InputMode? inputMode;
  final int? chatStyleId;

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
      lastMessageContent: json['message'],
      inputMode: InputMode.values[json['inputMode'] ?? 0],
      chatStyleId: json['chatStyleId']
    );
  }

  bool get hasUnreadMessage => lastMessageContent != null && (checkTime == null || checkTime!.isBefore(dateTime));
}