import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/message.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/providers/dio.dart';

import '../models/conversation.dart';
import '../models/message.dart';


final chatProvider = StreamProvider.family.autoDispose<List<ImMessage>, String>((ref, conversation) async* {
  var allMessages = const <ImMessage>[];
  await for (final message in messageStream) {
    // A new message has been received. Let's add it to the list of all messages.
    allMessages = [...allMessages, message];
    yield allMessages;
  }
});


class AsyncConversationsNotifier extends AsyncNotifier<List<ImConversation>> {
  Future<List<ImConversation>> _fetchData() {
    return fetchChatList(httpClient: ref.read(dioProvider)).then((resp) {
      return (resp.data as List).map((m) => ImConversation.fromJson(m)).toList();
    });
  }

  @override
  FutureOr<List<ImConversation>> build() {
    return _fetchData();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => _fetchData());
  }
}

final asyncConversationsProvider = AsyncNotifierProvider<AsyncConversationsNotifier, List<ImConversation>>(
  () => AsyncConversationsNotifier(),
);


class AsyncMessagesNotifier extends AutoDisposeFamilyAsyncNotifier<List<ImMessage>, int> {
  Future<List<ImMessage>> _fetchData(int id) {
    return fetchMessageList(
      httpClient: ref.read(dioProvider),
      userId: id,
      page: 1,
      pageSize: 100
    ).then((resp) {
      return (resp.data['list'] as List).map((m) => ImMessage.fromJson(m)).toList();
    });
  }

  @override
  FutureOr<List<ImMessage>> build(int arg) {
    return _fetchData(arg);
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => _fetchData(arg));
  }
}

final asyncMessagesProvider = AsyncNotifierProvider.family.autoDispose<AsyncMessagesNotifier, List<ImMessage>, int>(
    () => AsyncMessagesNotifier()
);
