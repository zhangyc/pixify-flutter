import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/screens/profile.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/widgets/inputbar/chat_style.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/inputbar/chat_inputbar.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/utils/global/global.dart';

import '../../../common/models/user.dart';
import '../../../utils/dialog/subsciption.dart';
import '../models/message_type.dart';
import '../widgets/inputbar/mode_provider.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_outlined),
        ),
        elevation: 4,
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
          IconButton(onPressed: _showInfo, icon: Icon(Icons.more_horiz_outlined))
        ],
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //     statusBarBrightness: Brightness.light,
        //     statusBarColor: Colors.transparent,
        //     statusBarIconBrightness: Brightness.dark
        // )
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: ref.watch(messageStreamProvider(widget.otherSide.id)).when(
                data: (messages) {
                  final localPendingMessages = ref.watch(localPendingMessagesProvider(widget.otherSide.id));
                  final msgs = [...localPendingMessages, ...messages]..sort((m1, m2) => m2.time.compareTo(m1.time));
                  if (msgs.isNotEmpty) {
                    return Container(
                      alignment: Alignment.topCenter,
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        reverse: true,
                        itemBuilder: (BuildContext context, int index) => MessageWidget(
                          prevMessage: index == msgs.length - 1 ? null : msgs[index + 1],
                          message: msgs[index],
                          fromMe: ref.read(myProfileProvider)!.id == msgs[index].sender.id,
                          onPendingMessageSucceed: _onPendingMessageSucceed,
                          onShorten: _shortenMessage,
                          onDelete: _deleteMessage,
                        ),
                        itemCount: msgs.length,
                        separatorBuilder: (_, __) => SizedBox(height: 5),
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      ),
                    );
                  } else {
                    return _startupline();
                  }
                },
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
            Container(
              padding: const EdgeInsets.only(
                left: 8,
                top: 8,
                right: 8,
                bottom: 8
              ),
              child: ChatInstructionInput(
                  chatId: widget.otherSide.id,
                  onSubmit: _onSend,
                  onSuggestionTap: _onSuggestionTap,
                  onHookTap: _onHookTap,
                  autofocus: false
              ),
            ),
          ],
        ),
      ),
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
    if (text.trim().isEmpty) return;

    await sendMessage(
      userId: widget.otherSide.id,
      type: type,
      content: text,
    );
  }

  int _lastLocalId = -9999;
  Future _onSend(String? text) async {
    if (text == null || text.trim().isEmpty) return;

    if (ref.read(inputModeProvider(widget.otherSide.id)) == InputMode.manual) {
      SonaAnalytics.log('chat_handwriting');
      return _sendMessage(text, ImMessageType.manual);
    }

    func() => callSona(
        userId: widget.otherSide.id,
        input: text,
        type: CallSonaType.INPUT,
        chatStyleId: ref.read(currentChatStyleProvider(widget.otherSide.id))?.id
    );
    final message = ImMessage(
      id: _lastLocalId++,
      type: CallSonaType.INPUT.index + 1,
      content: text,
      sender: ref.read(myProfileProvider)!.toUser(),
      receiver: widget.otherSide,
      time: DateTime.now(),
      shortenTimes: 2
    );
    final pending = func();
    message
      ..func = func
      ..pending = pending;
    ref.read(localPendingMessagesProvider(widget.otherSide.id).notifier).update((state) => [...state, message]);
    pending.then((resp) {
      if (resp.statusCode == 10015) {
        showSubscription();
      } else if (resp.statusCode == 0) {
        _onPendingMessageSucceed(message);
      }
    });
    SonaAnalytics.log('chat_sona');
  }

  void _onPendingMessageSucceed(ImMessage message) {
    if (mounted) {
      ref.read(localPendingMessagesProvider(widget.otherSide.id).notifier).update((state) => state..remove(message));
    }
  }

  Future _shortenMessage(ImMessage message) {
    SonaAnalytics.log('chat_shorten');
    return callSona(
      type: CallSonaType.SIMPLE,
      userId: widget.otherSide.id,
      messageId: message.id
    );
  }

  Future _deleteMessage(ImMessage message) {
    return deleteMessage(
      messageId: message.id
    );
  }

  void _showInfo() {
    SonaAnalytics.log('chat_card');
    Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfileScreen(user: widget.otherSide, relation: Relation.matched)));
  }

  Future _startUpLine() async {
    final resp = await callSona(
      userId: widget.otherSide.id,
      type: CallSonaType.PROLOGUE
    );
    SonaAnalytics.log('chat_starter');
    if (resp.statusCode == 10015) {
      showSubscription();
    }
  }

  void _onSonaTap() {
    // ref.read(chatModeProvider.notifier).state = ChatMode.input;
  }

  Future _onHookTap() async {
    final resp = await callSona(
      userId: widget.otherSide.id,
      type: CallSonaType.HOOK
    );
    if (resp.statusCode == 10015) {
      showSubscription();
    }
    SonaAnalytics.log('chat_hook');
  }

  Future _onSuggestionTap() async {
    final resp = await callSona(
      userId: widget.otherSide.id,
      type: CallSonaType.SUGGEST_V2
    );
    if (resp.statusCode == 10015) {
      showSubscription();
    }
    final options = resp.data['optionV2'] as List;

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
                      ...options.map((opt) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          Navigator.pop(context);
                          callSona(
                            userId: widget.otherSide.id,
                            type: CallSonaType.SUGGEST_FUNC,
                            input: opt
                          );
                          SonaAnalytics.log('chat_sendsuggest');
                        },
                        child: Container(
                            width: 130,
                            height: 155,
                            color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            child: Text(opt ?? '', style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
    SonaAnalytics.log('chat_suggest');
  }

  Future _deleteAllMessages() async {
    await deleteAllMessages(chatId: widget.otherSide.id);
    var allMsgs = await FirebaseFirestore.instance
        .collection('users')
        .doc(ref.read(myProfileProvider)!.id.toString())
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