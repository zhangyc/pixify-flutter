import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/env.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/utils/global/global.dart';

import '../../../../account/providers/profile.dart';
import '../../services/chat_style.dart';

class ChatStyle {
  const ChatStyle._({
    required this.id,
    required this.icon,
    required this.title,
    required this.isDefault,
    required this.memberOnly
  });

  final int id;
  final String icon;
  final String title;
  final bool isDefault;
  final bool memberOnly;

  factory ChatStyle.fromJson(json) {
    return ChatStyle._(
      id: json['id'],
      icon: json['icon'],
      title: json['title'],
      isDefault: json['hasDef'],
      memberOnly: json['hasVip']
    );
  }
}


class AsyncChatStylesNotifier extends AsyncNotifier<List<ChatStyle>> {
  Future<List<ChatStyle>> _fetchChatStyles() {
    return fetchChatStyles().then<List<ChatStyle>>(
        (resp) => (resp.data as List).map<ChatStyle>(ChatStyle.fromJson).toList()
    );
  }

  @override
  FutureOr<List<ChatStyle>> build() {
    try {
      final jsonString = kvStore.getString('styles');
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
      FirebaseFirestore.instance.collection('${env.firestorePrefix}_users')
          .doc(ref.read(myProfileProvider)!.id.toString())
          .collection('rooms').doc(arg.toString())
          .set({'chatStyleId': next?.id}, SetOptions(merge: true))
          .catchError((_) {});
    });
    try {
      final convo = ref.watch(conversationStreamProvider).value!.firstWhere((convo) => convo.convoId == arg);
      final styles = ref.watch(asyncChatStylesProvider).value!;
      return styles.firstWhere((style) => style.id == convo.chatStyleId, orElse: () => styles.firstWhere((style) => style.isDefault, orElse: () => styles.first));
    } catch (_) {
      //
    }
    return null;
  },
  dependencies: [conversationStreamProvider, asyncChatStylesProvider]
);