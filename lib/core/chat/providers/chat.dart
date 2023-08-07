import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/message.dart';

import '../models/conversation.dart';
import '../models/message.dart';


final chatProvider = StreamProvider.family.autoDispose<ImMessage, int>((ref, conversation) {
  return messageStream.where((message) => message.conversation == conversation);
});

final conversationsProvider = Provider<List<ImConversation>>((ref) {
  var conversationList = <ImConversation>[];
  messageStream.listen((ImMessage message) {
    final index = conversationList.indexWhere(
      (ImConversation conversation)
        => conversation.conversationId == message.conversation
    );
    if (index != -1) {
      conversationList[index].lastMessage = message;
    } else {
      conversationList = [
        ImConversation(
            conversationId: message.conversation,
            lastMessage: message
        ),
        ...conversationList
      ];
    }
  });
  return conversationList;
});
