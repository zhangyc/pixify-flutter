import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/env.dart';

import '../models/conversation.dart';
import '../models/message.dart';

final conversationStreamProvider = StreamProvider<List<ImConversation>>((ref) async* {
  final userId = ref.read(myProfileProvider)!.id;
  final stream = FirebaseFirestore.instance
      .collection('${env.firestorePrefix}_users').doc('$userId')
      .collection('rooms').orderBy('id', descending: true).limit(100)
      .snapshots();
  await for (var snapshot in stream) {
    var conversations = snapshot.docs.map<ImConversation>((doc) => ImConversation.fromJson(doc.data())).toList();
    yield conversations;
  }
});

final messagePaginationProvider = StateProvider.family.autoDispose<DocumentSnapshot?, int>(
    (ref, roomId) => null
);

final localPendingMessagesProvider = StateProvider.autoDispose.family<List<ImMessage>, int>(
  (ref, arg) => <ImMessage>[]
);

final messageStreamProvider = StreamProvider.family.autoDispose<List<ImMessage>, int>(
  (ref, roomId) async* {
    List<ImMessage> messages = [];
    final userId = ref.read(myProfileProvider)!.id;
    final stream = FirebaseFirestore.instance
        .collection('${env.firestorePrefix}_users').doc('$userId')
        .collection('rooms').doc('$roomId')
        .collection('msgs').orderBy('id', descending: true)
        .snapshots();
    ref.listen(messagePaginationProvider(roomId), (previous, next) async {
      if (next != null) {
        final historyMessages = await FirebaseFirestore.instance
            .collection('${env.firestorePrefix}_users').doc('$userId')
            .collection('rooms').doc('$roomId')
            .collection('msgs').orderBy('id', descending: true).startAfterDocument(next)
            .get()
            .then<List<QueryDocumentSnapshot<Map<String, dynamic>>>>((snapshot) => snapshot.docs)
            .then<Iterable<ImMessage>>((docs) => docs.map<ImMessage>((doc) => ImMessage.fromJson(doc.data())));
        messages = [...messages, ...historyMessages];
      }
    });
    await for (var snapshot in stream) {
      // snapshot.docChanges.
      messages = snapshot.docs.map<ImMessage>((doc) => ImMessage.fromJson(doc.data())).toList();
      yield messages;
    }
  },
  dependencies: [messagePaginationProvider]
);
