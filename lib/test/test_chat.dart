import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

///FirebaseFirestore chatdemo
class TestChat extends StatefulWidget {
  const TestChat({super.key});

  @override
  State<TestChat> createState() => _TestChatState();
}

class _TestChatState extends State<TestChat> {
  ///发送消息
  void sendChatMessage(String content, int type, String groupChatId,
      String currentUserId, String peerId) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    ChatMessages chatMessages = ChatMessages(
        idFrom: currentUserId,
        idTo: peerId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatMessages.toJson());
    });

  }
  late FirebaseFirestore firebaseFirestore;
  ///获取消息
  Stream<QuerySnapshot> getChatMessage(String groupChatId, int limit) {
    return firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }
  ///消息stream
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection(FirestoreConstants.pathMessageCollection).snapshots();
  @override
  void initState() {
    ///store实例
   firebaseFirestore=FirebaseFirestore.instance;
    sendChatMessage('123', 1, '1001', '1-2', "2");
    sendChatMessage('12322222222222222222', 1, '1-2', '1', "2");
   ///测试建听是否通顺
   // firebaseFirestore.collection(FirestoreConstants.pathMessageCollection).doc('user-10').collection('user-10-12').listen((event) {
   //    // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
   //    print(event);
   //  });
   // final docRef = db.collection("cities").doc("SF");
   // firebaseFirestore.collection(FirestoreConstants.pathMessageCollection).doc('user-10').get().then(
   //       (DocumentSnapshot doc) {
   //     final data = doc.data() as Map<String, dynamic>;
   //     // ...
   //   },
   //   onError: (e) => print("Error getting document: $e"),
   // );

   // firebaseFirestore.collection(FirestoreConstants.pathMessageCollection).doc('user-10').get().then(
   //       (doc) {
   //     print(doc);
   //     // ...
   //   },
   //   onError: (e) => print("Error getting document: $e"),
   // );
   firebaseFirestore.collection(FirestoreConstants.pathMessageCollection).doc('user-10').collection('room-10-12').get().then(
         (doc) {
       print(doc);
       // ...
     },
     onError: (e) => print("Error getting document: $e"),
   );
   firebaseFirestore.collection(FirestoreConstants.pathMessageCollection).doc('user-10').collection('room-10-12').snapshots().listen((event) {
     print(event);
   });
    // getChatMessage('groupChatId', 2).listen((event) {
    //   for(var tmp in event.docChanges){
    //     print(tmp.doc.data());
    //   }
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Placeholder();
    ///StreamBuilder进行数据接受
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
            Map<String, dynamic> data =
            document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['full_name']),
              subtitle: Text(data['company']),
            );
          })
              .toList()
              .cast(),
        );
      },
    );
  }
}
class FirestoreConstants {
  static const pathUserCollection = "users";
  static const pathMessageCollection = "messages-test";
  static const displayName = "displayName";
  static const aboutMe = "aboutMe";
  static const photoUrl = "photoUrl";
  static const phoneNumber = "phoneNumber";
  static const id = "id";
  static const chattingWith = "chattingWith";
  static const idFrom = "idFrom";
  static const idTo = "idTo";
  static const timestamp = "timestamp";
  static const content = "content";
  static const type = "type";
  static const email = "email";
}


class ChatMessages {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;

  ChatMessages(
      {required this.idFrom,
        required this.idTo,
        required this.timestamp,
        required this.content,
        required this.type});

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type,
    };
  }

  factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
    String idFrom = documentSnapshot.get(FirestoreConstants.idFrom);
    String idTo = documentSnapshot.get(FirestoreConstants.idTo);
    String timestamp = documentSnapshot.get(FirestoreConstants.timestamp);
    String content = documentSnapshot.get(FirestoreConstants.content);
    int type = documentSnapshot.get(FirestoreConstants.type);

    return ChatMessages(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type);
  }
}