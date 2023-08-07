import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/screens/function.dart';

import '../../../utils/providers/dio.dart';
import '../../persona/models/user.dart';

class ChatScreen extends StatefulHookConsumerWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {

  var _chats = <User>[];

  @override
  void initState() {
    _loadChats();
    super.initState();
  }

  Future _loadChats() async {
    final dio = ref.read(dioProvider);
    final resp = await dio.post('/chat/list');
    final data = resp.data;
    if (data['code'] == 1) {
      final d = data['data'] as List;
      final users = d.map<User>((e) => User.fromJson(e));
      _chats = [..._chats, ...users];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Chat'),
        elevation: 0,
      ),
      body: ListView.separated(
        itemBuilder: _itemBuilder,
        itemCount: _chats.length,
        separatorBuilder: (_, __) => SizedBox(height: 5),
      )
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final user = _chats[index];
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatFunctionScreen(to: user))),
      child: ListTile(title: Text(user.name), tileColor: Colors.amberAccent,)
    );
  }
}