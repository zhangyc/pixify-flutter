import 'package:sona/common/models/user.dart';

import 'message.dart';

class ImConversation {
  ImConversation._({
    required this.otherSide,
  });

  final UserInfo otherSide;
  ImMessage? lastMessage;

  factory ImConversation.fromJson(Map<String, dynamic> json) {
    return ImConversation._(
      otherSide: UserInfo.fromJson({
        'id': json['id'],
        'nickname': json['nickname'],
        'avatar': json['avatar']
      }),
    );
  }
}