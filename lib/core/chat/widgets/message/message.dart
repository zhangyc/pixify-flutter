import 'package:flutter/material.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/widgets/message/message_from_me.dart';
import 'package:sona/core/chat/widgets/message/message_from_other.dart';

import 'local_pending_message_from_me.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.message,
    required this.fromMe
  });
  final ImMessage message;
  final bool fromMe;

  @override
  Widget build(BuildContext context) {
    if (fromMe) {
      if (message.pending != null) {
        return LocalPendingMessageFromMe(message: message);
      }
      return MessageFromMe(message: message);
    } else {
      return MessageFromOther(message: message);
    }
  }
}