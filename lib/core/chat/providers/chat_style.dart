import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/utils/providers/dio.dart';

import '../services/chat_style.dart';

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
    return _fetchChatStyles();
  }
}

final asyncChatStylesProvider = AsyncNotifierProvider<AsyncChatStylesNotifier, List<ChatStyle>>(
    () => AsyncChatStylesNotifier()
);


final currentChatStyleIdProvider = StateProvider<int?>(
  (ref) => ref.watch(asyncChatStylesProvider).when(
    data: (styles) => styles.first.id,
    error: (_, __) => null,
    loading: () => null
  )
);