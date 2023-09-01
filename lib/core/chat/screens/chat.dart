import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/info.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/providers/chat_action.dart';
import 'package:sona/core/chat/providers/chat_style.dart';
import 'package:sona/core/chat/screens/info.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/chat_actions.dart';
import 'package:sona/core/chat/widgets/chat_input.dart';
import 'package:sona/core/chat/widgets/chat_instruction_input.dart';
import 'package:sona/core/persona/widgets/sona_message.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/common/widgets/text/gradient_colored_text.dart';

import '../../../common/models/user.dart';
import '../../../utils/providers/dio.dart';

class ChatFunctionScreen extends StatefulHookConsumerWidget {
  const ChatFunctionScreen({super.key, required this.otherSide});
  final UserInfo otherSide;
  static const routeName="lib/core/chat/screens/chat";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatFunctionScreenState();
}

class _ChatFunctionScreenState extends ConsumerState<ChatFunctionScreen> with RouteAware {

  ChatActionMode _mode = ChatActionMode.docker;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didPushNext() {
    super.didPushNext();
  }

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherSide.name!),
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
          setState(() {
            _mode = ChatActionMode.docker;
          });
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
                    itemBuilder: (BuildContext context, int index) {
                      final msg = messages[index];
                      return _itemBuilder(msg);
                    },
                    itemCount: messages.length,
                    separatorBuilder: (_, __) => SizedBox(height: 5),
                  ),
                ) : _tips(),
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
      floatingActionButton: _mode == ChatActionMode.docker ? ChatActions(
        onAct: _onAction
      ) : Container(
        padding: EdgeInsets.only(
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 12
        ),
        color: Colors.white,
        child: _mode == ChatActionMode.sona ? ChatInstructionInput(onSubmit: _onSona, autofocus: true,) :  ChatInput(onSubmit: _onMessage, autofocus: true,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _itemBuilder(ImMessage msg) {
    final me = ref.read(asyncMyProfileProvider);
    if (msg.sender.id == me.value!.id) {
      return Container(
        margin: EdgeInsets.only(left: 70, bottom: 12, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(msg.content, style: Theme.of(context).textTheme.bodySmall),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(msg.time.toMessageTime(), style: Theme.of(context).textTheme.bodySmall),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () => _onEditMessage(msg),
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)
                    ),
                    alignment: Alignment.center,
                    child: Text('\u{270D}'),
                  ),
                ),
                Visibility(
                  visible: !msg.knowledgeAdded,
                  child: GestureDetector(
                    onTap: () => _onAddKnowledge(msg),
                    child: Container(
                      height: 28,
                      width: 28,
                      margin: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1)
                      ),
                      alignment: Alignment.center,
                      child: GradientColoredText(text: 'S', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
                SizedBox(width: 12)
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(right: 70, bottom: 12, left: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(msg.content, style: Theme.of(context).textTheme.bodySmall),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 18),
                GestureDetector(
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1)
                    ),
                    alignment: Alignment.center,
                    child: Text('❤️'),
                  ),
                ),
                SizedBox(width: 12),
                Text(msg.time.toMessageTime(), style: Theme.of(context).textTheme.bodySmall),
              ],
            )
          ],
        ),
      );
    }
  }

  final _blueStyle = TextStyle(color: Colors.blue, fontSize: 18);
  Widget _tips() {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.black, width: 2))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('| ㊙️ 这条消息仅您可见', style: TextStyle(color: Colors.grey, fontSize: 14)),
          SizedBox(height: 10),
          Text('您希望怎样开始对话呢？', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => _startUpLine('有趣的开场白'),
            child: Text('有趣的开场白', style: _blueStyle)
          ),
          SizedBox(height: 10),
          GestureDetector(
              onTap: () => _startUpLine('询问我关心的问题'),
              child: Text('我关心的问题', style: _blueStyle)
          ),
          SizedBox(height: 10),
          GestureDetector(
              onTap: () => _startUpLine('尝试投其所好'),
              child: Text('尝试投其所好', style: _blueStyle)
          ),
          SizedBox(height: 10),
          GestureDetector(
              onTap: () => _startUpLine('自由发挥'),
              child: Text('自由发挥', style: _blueStyle)
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  void _onMessage({String? text}) async {
    print(text);
    if (text == null || text.trim().isEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        _mode = ChatActionMode.docker;
      });
      return;
    }

    if (_mode == ChatActionMode.manual) {
      try {
        ref.read(sonaLoadingProvider.notifier).state = true;
        await sendMessage(
            httpClient: ref.read(dioProvider),
            userId: widget.otherSide.id,
            type: CallSonaType.MANUAL,
            content: text,
        );
        setState(() {
          _mode = ChatActionMode.docker;
        });
      } catch(e) {
        //
      } finally {
        ref.read(sonaLoadingProvider.notifier).state = false;
      }
    } else if (_mode == ChatActionMode.sona) {
      try {
        ref.read(sonaLoadingProvider.notifier).state = true;
        await callSona(
            httpClient: ref.read(dioProvider),
            userId: widget.otherSide.id,
            input: text,
            type: CallSonaType.INPUT
        );
        setState(() {
          _mode = ChatActionMode.docker;
        });
      } catch(e) {
        //
      } finally {
        ref.read(sonaLoadingProvider.notifier).state = false;
      }
    }
  }

  void _onSona(String? text) async {
    if (text == null || text.trim().isEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        _mode = ChatActionMode.docker;
      });
      return;
    }

    try {
      ref.read(sonaLoadingProvider.notifier).state = true;
      await callSona(
        httpClient: ref.read(dioProvider),
        userId: widget.otherSide.id,
        input: text,
        type: CallSonaType.INPUT,
        chatStyleId: ref.read(currentChatStyleIdProvider)
      );
      setState(() {
        _mode = ChatActionMode.docker;
      });
    } catch(e) {
      //
    } finally {
      ref.read(sonaLoadingProvider.notifier).state = false;
    }
  }

  void _showInfo() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatInfoScreen(user: widget.otherSide)));
  }

  FutureOr _onAction(ChatActionMode mode) {
    switch(mode) {
      case ChatActionMode.docker:
      case ChatActionMode.manual:
      case ChatActionMode.sona:
        setState(() {
          _mode = mode;
        });
        break;
      case ChatActionMode.suggestion:
        return _onSuggestion();
      case ChatActionMode.hook:
        return _freeChat();
    }
  }

  Future _startUpLine(String input) async {
    callSona(
        httpClient: ref.read(dioProvider),
        userId: widget.otherSide.id,
        type: CallSonaType.PROLOGUE
    );
  }

  Future _freeChat() async {
    ref.read(sonaLoadingProvider.notifier).state = true;
    callSona(
        httpClient: ref.read(dioProvider),
        userId: widget.otherSide.id,
        type: CallSonaType.AUTO
    )
    .catchError((e) {
      throw(e);
    })
    .whenComplete(() {
      ref.read(sonaLoadingProvider.notifier).state = false;
    });
  }

  Future _onSuggestion() async {
    ref.read(sonaLoadingProvider.notifier).state = true;
    final resp = await callSona(
        httpClient: ref.read(dioProvider),
        userId: widget.otherSide.id,
        type: CallSonaType.SUGGEST
    )
    .catchError((e) {
      throw(e);
    })
    .whenComplete(() {
      ref.read(sonaLoadingProvider.notifier).state = false;
    });

    final options = resp.data['options'] as List;
    await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),
      isScrollControlled: true,
      builder: (_) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SonaMessage(content: '\nI\'m the Idea Wizard'),
                  SizedBox(height: 12),
                  ...options.map((m) => Container(
                    margin: EdgeInsets.only(top: 5, left: 64),
                    child: ColoredButton(
                        onTap: () async {
                          Navigator.pop(context);
                          await sendMessage(
                            httpClient: ref.read(dioProvider),
                            userId: widget.otherSide.id,
                            type: CallSonaType.SUGGEST,
                            content: m['message'],
                          );
                        },
                        text: m['short']
                    ),
                  )),
                  SizedBox(height: 30),
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

enum ChatActionMode {
  docker,
  manual,
  sona,
  suggestion,
  hook
}