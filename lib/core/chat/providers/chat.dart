import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';

import '../models/conversation.dart';
import '../models/message.dart';

final conversationStreamProvider = StreamProvider<List<ImConversation>>((ref) async* {
  final userId = ref.read(asyncMyProfileProvider).value!.id;
  final stream = FirebaseFirestore.instance
      .collection('users').doc('$userId')
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

final messageStreamProvider = StreamProvider.family.autoDispose<List<ImMessage>, int>(
  (ref, roomId) async* {
    List<ImMessage> messages = [];
    final userId = ref.read(asyncMyProfileProvider).value!.id;
    final stream = FirebaseFirestore.instance
        .collection('users').doc('$userId')
        .collection('rooms').doc('$roomId')
        .collection('msgs').orderBy('id', descending: true)
        .snapshots();
    ref.listen(messagePaginationProvider(roomId), (previous, next) async {
      if (next != null) {
        final historyMessages = await FirebaseFirestore.instance
            .collection('users').doc('$userId')
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

// final localMessageStreamControllerProvider = Provider.autoDispose.family<StreamController<ImMessage>, int>(
//   (ref, roomId) {
//     return StreamController.broadcast();
//   }
// );
//
// final localMessageStreamProvider = StreamProvider.autoDispose.family<List<ImMessage>, int>(
//     (ref, roomId) async* {
//       List<ImMessage> messages = [];
//       final userId = ref.read(asyncMyProfileProvider).value!.id;
//       final stream = ref.read(localMessageStreamControllerProvider(roomId)).stream;
//       ref.listen(messageStreamProvider(roomId), (previous, next) async {
//         if (next.value != null && next.value!.isNotEmpty && messages.isNotEmpty) {
//           for (var msg in next.value!) {
//             messages.removeWhere((message) => message.sender.id == userId && message.time == msg.time && msg.content == message.content);
//           }
//         }
//       });
//       await for (var msg in stream) {
//         messages = [...messages, msg];
//         yield messages;
//       }
//     },
//     dependencies: [messageStreamProvider]
// );
//
// final firestoreMessageStreamProvider = StreamProvider.family.autoDispose<List<ImMessage>, int>(
//     (ref, roomId) async* {
//       List<ImMessage> messages = [];
//       final userId = ref.read(asyncMyProfileProvider).value!.id;
//       final stream = FirebaseFirestore.instance
//           .collection('users').doc('$userId')
//           .collection('rooms').doc('$roomId')
//           .collection('msgs').orderBy('id', descending: true)
//           .snapshots();
//       await for (var snapshot in stream) {
//         messages = snapshot.docs.map<ImMessage>((doc) => ImMessage.fromJson(doc.data())).toList();
//         yield messages;
//       }
//     }
// );
//
// class AsyncHistoryMessageNotifier extends AutoDisposeFamilyAsyncNotifier<List<ImMessage>, int> {
//   List<ImMessage> _messages = [];
//
//   Future<List<ImMessage>> _fetchHistoryMessages(int id) async {
//     var messages = await FirebaseFirestore.instance
//         .collection('users').doc('${ref.read(asyncMyProfileProvider).value!.id}')
//         .collection('rooms').doc('$id')
//         .collection('msgs').orderBy('id', descending: true).limit(20)
//         .get()
//         .then<List<QueryDocumentSnapshot<Map<String, dynamic>>>>((snapshot) => snapshot.docs)
//         .then<Iterable<ImMessage>>((docs) => docs.map<ImMessage>((doc) => ImMessage.fromJson(doc.data())));
//     return [..._messages, ...messages];
//   }
//
//   @override
//   FutureOr build(int id) {
//     return _fetchHistoryMessages(id);
//   }
// }
//
// final historyMessageStreamProvider = AsyncNotifierProvider.family.autoDispose<List<ImMessage>, int>(
//   (ref, roomId) async {
//     List<ImMessage> messages = [];
//     final userId = ref.read(asyncMyProfileProvider).value!.id;
//     ref.listen(messagePaginationProvider(roomId), (previous, next) async {
//       if (next != null) {
//         final historyMessages = await FirebaseFirestore.instance
//             .collection('users').doc('$userId')
//             .collection('rooms').doc('$roomId')
//             .collection('msgs').orderBy('id', descending: true).startAfterDocument(next)
//             .get()
//             .then<List<QueryDocumentSnapshot<Map<String, dynamic>>>>((snapshot) => snapshot.docs)
//             .then<Iterable<ImMessage>>((docs) => docs.map<ImMessage>((doc) => ImMessage.fromJson(doc.data())));
//         messages = [...messages, ...historyMessages];
//       }
//     });
//     return messages;
//   },
//   dependencies: [messagePaginationProvider]
// );
