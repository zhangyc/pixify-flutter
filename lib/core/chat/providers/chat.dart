import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/env.dart';

import '../../../common/models/user.dart';
import '../models/conversation.dart';
import '../models/message.dart';

final conversationStreamProvider =
    StreamProvider<List<ImConversation>>((ref) async* {
  final userId = ref.read(myProfileProvider)?.id;
  if (userId != null) {
    final stream = FirebaseFirestore.instance
        .collection('${env.firestorePrefix}_users')
        .doc('$userId')
        .collection('rooms')
        .orderBy('createDate', descending: true)
        .limit(100)
        .snapshots();
    await for (var snapshot in stream) {
      var conversations = snapshot.docs
          .map<ImConversation>((doc) => ImConversation.fromJson(doc.data()))
          .toList();
      yield conversations;
    }
  } else {
    yield [];
  }
});

final localMessagesProvider = StateProvider.autoDispose
    .family<List<ImMessage>, int>((ref, arg) => <ImMessage>[]);

final remoteMessageStreamProvider =
    StreamProvider.family.autoDispose<List<ImMessage>, int>(
  (ref, roomId) async* {
    List<ImMessage> messages = [];
    final userId = ref.read(myProfileProvider)!.id;
    final stream = FirebaseFirestore.instance
        .collection('${env.firestorePrefix}_users')
        .doc('$userId')
        .collection('rooms')
        .doc('$roomId')
        .collection('msgs')
        .orderBy('id', descending: true)
        .snapshots();
    await for (var snapshot in stream) {
      messages = snapshot.docs
          .map<ImMessage>((doc) => ImMessage.fromJson(doc.data()))
          .toList();
      yield messages;
    }
  },
);

final messagesProvider =
    StateProvider.autoDispose.family<List<ImMessage>, int>((ref, roomId) {
  final localMessages = ref.watch(localMessagesProvider(roomId));
  final remoteMessages = ref
          .watch(remoteMessageStreamProvider(roomId))
          .unwrapPrevious()
          .valueOrNull ??
      [];
  for (var m in remoteMessages) {
    localMessages.removeWhere((lm) => lm.uuid == m.uuid);
  }
  return [...localMessages, ...remoteMessages]
    ..sort((m1, m2) => m2.time.compareTo(m1.time));
}, dependencies: [localMessagesProvider, remoteMessageStreamProvider]);

final futureUserProvider = FutureProvider.family<UserInfo, int>((ref, arg) {
  return FirebaseFirestore.instance
      .collection('${env.firestorePrefix}_users')
      .doc(arg.toString())
      .get()
      .then((snapshot) => UserInfo.fromFirestore(snapshot.data()!))
      .catchError((e) {
    if (kDebugMode) print('fetch firestore user data error: $e');
    throw (e);
  });
});
