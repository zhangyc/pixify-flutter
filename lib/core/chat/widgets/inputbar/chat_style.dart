import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/widgets/inputbar/mode_provider.dart';
import 'package:sona/utils/providers/dio.dart';
import 'package:sona/utils/providers/kv_store.dart';

import '../../../../account/providers/profile.dart';
import '../../services/chat_style.dart';

class ChatStyle {
  const ChatStyle._({
    required this.id,
    required this.icon,
    required this.title
  });

  final int id;
  final String icon;
  final String title;

  factory ChatStyle.fromJson(json) {
    return ChatStyle._(
        id: json['id'],
        icon: json['icon'],
        title: json['title']
    );
  }
}


class AsyncChatStylesNotifier extends AsyncNotifier<List<ChatStyle>> {
  Future<List<ChatStyle>> _fetchChatStyles() {
    return fetchChatStyles(
        httpClient: ref.read(dioProvider)
    ).then<List<ChatStyle>>(
        (resp) => (resp.data as List).map<ChatStyle>(ChatStyle.fromJson).toList()
    );
  }

  @override
  FutureOr<List<ChatStyle>> build() {
    try {
      final jsonString = ref.read(kvStoreProvider).getString('styles');
      final styles = (jsonDecode(jsonString!) as List).map<ChatStyle>(ChatStyle.fromJson).toList();
      refresh(true);
      return styles;
    } catch (_) {
      return _fetchChatStyles();
    }
  }

  Future<void> refresh([bool silence = false]) async {
    if (!silence) state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchChatStyles());
  }
}

final asyncChatStylesProvider = AsyncNotifierProvider<AsyncChatStylesNotifier, List<ChatStyle>>(
    () => AsyncChatStylesNotifier()
);


final currentChatStyleProvider = StateProvider.family<ChatStyle?, int>(
  (ref, arg) {
    ref.listenSelf((previous, next) {
      FirebaseFirestore.instance.collection('users')
          .doc(ref.read(asyncMyProfileProvider).value!.id.toString())
          .collection('rooms').doc(arg.toString())
          .set({'chatStyleId': next?.id}, SetOptions(merge: true))
          .catchError((_) {});
    });
    try {
      final convo = ref.watch(conversationStreamProvider).value!.firstWhere((convo) => convo.convoId == arg);
      final styles = ref.watch(asyncChatStylesProvider).value!;
      return styles.firstWhere((style) => style.id == convo.chatStyleId, orElse: () => styles.first);
    } catch (_) {
      //
    }
    return null;
  },
  dependencies: [conversationStreamProvider, asyncChatStylesProvider]
);