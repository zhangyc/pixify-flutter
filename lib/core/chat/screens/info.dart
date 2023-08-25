import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/screens/function.dart';
import 'package:sona/core/persona/models/persona.dart';

import '../../../common/models/user.dart';
import '../../../utils/providers/dio.dart';

class ChatInfoScreen extends StatefulHookConsumerWidget {
  const ChatInfoScreen({
    super.key,
    required this.user,
  });
  final UserInfo user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatInfoScreenState();
}

class _ChatInfoScreenState extends ConsumerState<ChatInfoScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.user.name!),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(widget.user.bio ?? ''),
      )
    );
  }
}