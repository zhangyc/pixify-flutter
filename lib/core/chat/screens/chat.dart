import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/providers/chat_mode.dart';
import 'package:sona/core/chat/providers/chat_style.dart';
import 'package:sona/core/chat/screens/info.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/chat_actions.dart';
import 'package:sona/core/chat/widgets/chat_input.dart';
import 'package:sona/core/chat/widgets/chat_instruction_input.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/common/widgets/text/gradient_colored_text.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../../common/models/user.dart';
import '../../../utils/providers/dio.dart';
import '../models/message_type.dart';
import '../widgets/message/message.dart';

class ChatScreen extends StatefulHookConsumerWidget {
  const ChatScreen({super.key, required this.entry, required this.otherSide});
  final ChatEntry entry;
  final UserInfo otherSide;

  static const routeName = "/chat";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_outlined),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            UserAvatar(url: widget.otherSide.avatar!, size: 32),
            SizedBox(width: 12),
            Text(widget.otherSide.name!),
          ],
        ),
        centerTitle: false,
        actions: [
          IconButton(onPressed: _deleteAllMessages, icon: Icon(Icons.cleaning_services_outlined)),
          IconButton(onPressed: _showInfo, icon: Icon(Icons.info_outline))
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          ref.read(chatModeProvider.notifier).state = ChatMode.docker;
        },
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 100,
              child: ref.watch(messageStreamProvider(widget.otherSide.id)).when(
                data: (messages) => messages.isNotEmpty ? Container(
                  alignment: Alignment.topCenter,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) => MessageWidget(
                      message: messages[index],
                      fromMe: ref.read(asyncMyProfileProvider).value!.id == messages[index].sender.id
                    ),
                    itemCount: messages.length,
                    separatorBuilder: (_, __) => SizedBox(height: 5),
                  ),
                ) : _startupline(),
                error: (error, __) => Container(child: Text(error.toString()),),
                loading: () => Container(
                  alignment: Alignment.center,
                  child: const SizedBox(
                    height: 32,
                    width: 32,
                    child: CircularProgressIndicator(),
                  ),
                )
              )
            ),
          ],
        ),
      ),
      floatingActionButton: ref.watch(chatModeProvider) == ChatMode.docker ? ChatActions(
        onHookTap: _onHookTap,
        onSuggestionTap: _onSuggestionTap,
        onSonaTap: _onSonaTap
      ) : Container(
        padding: EdgeInsets.only(
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 12
        ),
        color: Colors.white,
        child: ref.watch(inputModeProvider) == InputMode.sona ? ChatInstructionInput(onSubmit: _onSona, autofocus: true,) :  ChatInput(onSubmit: (String content) => _sendMessage(content, ImMessageType.manual), autofocus: true,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _startupline() {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.black, width: 2))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('You matched!', style: TextStyle(color: Colors.grey, fontSize: 14)),
          SizedBox(height: 10),
          UserAvatar(url: widget.otherSide.avatar!, size: 200,),
          SizedBox(height: 10),
          Text('Not sure how to start?', style: TextStyle(color: Colors.grey, fontSize: 14)),
          SizedBox(height: 10),
          ColoredButton(
            size: ColoredButtonSize.large,
            loadingWhenAsyncAction: true,
            onTap: _startUpLine,
            text: '👋Have Sona say "Hi" for you',
            borderColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  void _sendMessage(String text, ImMessageType type) async {
    if (text.trim().isEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      ref.read(chatModeProvider.notifier).state = ChatMode.docker;
      return;
    }
    await sendMessage(
      httpClient: ref.read(dioProvider),
      userId: widget.otherSide.id,
      type: type,
      content: text,
    );
    FocusManager.instance.primaryFocus?.unfocus();
    ref.read(chatModeProvider.notifier).state = ChatMode.docker;
  }

  Future _onSona(String? text) async {
    if (text == null || text.trim().isEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      ref.read(chatModeProvider.notifier).state = ChatMode.docker;
      return;
    }

    return callSona(
      httpClient: ref.read(dioProvider),
      userId: widget.otherSide.id,
      input: text,
      type: CallSonaType.INPUT,
      chatStyleId: ref.read(currentChatStyleIdProvider)
    );
  }

  void _showInfo() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatInfoScreen(user: widget.otherSide)));
  }

  Future _startUpLine() {
    return callSona(
      httpClient: ref.read(dioProvider),
      userId: widget.otherSide.id,
      type: CallSonaType.PROLOGUE
    );
  }

  void _onSonaTap() {
    ref.read(chatModeProvider.notifier).state = ChatMode.input;
  }

  Future _onHookTap() async {
    return callSona(
      httpClient: ref.read(dioProvider),
      userId: widget.otherSide.id,
      type: CallSonaType.AUTO
    );
  }

  Future _onSuggestionTap() async {
    final resp = await callSona(
      httpClient: ref.read(dioProvider),
      userId: widget.otherSide.id,
      type: CallSonaType.SUGGEST
    );
    final options = resp.data['options'] as List;

    if (!mounted) return;
    await showDialog(
      context: context,
      barrierColor: Colors.black54,
      barrierDismissible: true,
      builder: (_) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('✌️Got some ideas', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white
                  )),
                  SizedBox(height: 12),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 155 / 130
                    ),
                    children: [
                      ...options.map((m) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          Navigator.pop(context);
                          _sendMessage(
                            m['message'],
                            ImMessageType.suggestion
                          );
                        },
                        child: Container(
                            width: 130,
                            height: 155,
                            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            child: Text(m['summary'], style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.black
                            ))
                        )
                      ))
                    ],
                  ),
                  SizedBox(height: 20),
                ],
            ),
          ),
        );
      }
    );
  }

  Future _onEditMessage(ImMessage message) async {
    Fluttertoast.showToast(msg: 'todo');
  }

  Future _onAddKnowledge(ImMessage message) async {
    final dio = ref.read(dioProvider);
    final resp = await dio.post('/knowledge', data: {'content': message.content});
    final data = resp.data;
    if (data['code'] == 1 ) {
      message.knowledgeAdded = true;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future _deleteAllMessages() async {
    await deleteAllMessages(httpClient: ref.read(dioProvider), id: widget.otherSide.id);
    var allMsgs = await FirebaseFirestore.instance
        .collection('users')
        .doc(ref.read(asyncMyProfileProvider).value!.id.toString())
        .collection('rooms')
        .doc(widget.otherSide.id.toString())
        .collection('msgs')
        .get();
    allMsgs.docs.forEach((doc) {
      doc.reference.delete();
    });
  }
}

enum ChatEntry {
  match,
  arrow,
  conversation
}