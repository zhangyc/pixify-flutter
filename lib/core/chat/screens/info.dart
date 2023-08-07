import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/screens/function.dart';
import 'package:sona/core/persona/models/persona.dart';

import '../../../utils/providers/dio.dart';
import '../../persona/models/user.dart';

class ChatInfoScreen extends StatefulHookConsumerWidget {
  const ChatInfoScreen({
    super.key,
    required this.user,
  });
  final User user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatInfoScreenState();
}

class _ChatInfoScreenState extends ConsumerState<ChatInfoScreen> {

  Persona? _persona;

  @override
  void initState() {
    _fetchPersona();
    super.initState();
  }

  Future _fetchPersona() async {
    final dio = ref.read(dioProvider);
    final resp = await dio.get('/persona/${widget.user.phone}');
    final data = resp.data;
    if (data['code'] == 1) {
      if (mounted) {
        setState(() {
          _persona = Persona.fromJson(data['data']);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.user.name),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(_persona?.intro ?? ''),
      )
    );
  }
}