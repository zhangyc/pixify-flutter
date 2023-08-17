import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/screens/info.dart';
import 'package:sona/core/chat/widgets/chat_directive_button.dart';
import 'package:sona/core/chat/widgets/chat_input.dart';
import 'package:sona/core/persona/widgets/sona_avatar.dart';
import 'package:sona/core/persona/widgets/sona_message.dart';
import 'package:sona/core/providers/user.dart';
import 'package:sona/widgets/button/colored_button.dart';
import 'package:sona/widgets/text/gradient_colored_text.dart';

import '../../../utils/dialog/input.dart';
import '../../../utils/providers/dio.dart';
import '../../persona/models/user.dart';

class ChatFunctionScreen extends StatefulHookConsumerWidget {
  const ChatFunctionScreen({super.key, required this.to});
  final User to;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatFunctionScreenState();
}

class _ChatFunctionScreenState extends ConsumerState<ChatFunctionScreen> {

  Timer? _timer;
  var _messages = <ImMessage>[];
  ChatActionMode _mode = ChatActionMode.docker;

  @override
  void initState() {
    _fetchList();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _fetchList();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future _fetchList() async {
    final dio = ref.read(dioProvider);
    final resp = await dio.get('/chat/message/${widget.to.phone}');
    final data = resp.data;
    if (data['code'] == 1) {
      final list = data['data']['list'] as List;
      if (list.length == _messages.length) return;

      if (mounted) {
        setState(() {
          _messages = list.map((e) => ImMessage.fromJson(e)).toList(growable: false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.to.name),
        elevation: 0,
        actions: [
          IconButton(onPressed: _onClearHistory, icon: Icon(Icons.cleaning_services_outlined)),
          IconButton(onPressed: _showInfo, icon: Icon(Icons.info_outline))
        ],
      ),
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
              child: _messages.isNotEmpty ? Container(
                alignment: Alignment.topCenter,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  reverse: true,
                  itemBuilder: _itemBuilder,
                  itemCount: _messages.length,
                  separatorBuilder: (_, __) => SizedBox(height: 5),
                ),
              ) : _tips()
            ),
          ],
        ),
      ),
      floatingActionButton: _mode == ChatActionMode.docker ? ChatDirectiveButton(
        onAction: _onAction
      ) : Container(
        padding: EdgeInsets.only(
          top: 12,
          bottom: MediaQuery.of(context).viewPadding.bottom + 12
        ),
        color: Colors.white,
        child: ChatInput(onSubmit: _onMessage, actionText: _mode == ChatActionMode.manuel ? 'Send' : 'Sona'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final message = _messages[index];
    final me = ref.read(userProvider);
    if (message.sender.phone == me.phone) {
      return Container(
        margin: EdgeInsets.only(left: 70, bottom: 12, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(message.content, style: Theme.of(context).textTheme.bodySmall),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => _onEditMessage(message),
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
                  visible: !message.knowledgeAdded,
                  child: GestureDetector(
                    onTap: () => _onAddKnowledge(message),
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
              child: Text(message.content, style: Theme.of(context).textTheme.bodySmall),
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
            onTap: () => _getSuggestion('有趣的开场白'),
            child: Text('有趣的开场白', style: _blueStyle)
          ),
          SizedBox(height: 10),
          GestureDetector(
              onTap: () => _getSuggestion('询问我关心的问题'),
              child: Text('我关心的问题', style: _blueStyle)
          ),
          SizedBox(height: 10),
          GestureDetector(
              onTap: () => _getSuggestion('尝试投其所好'),
              child: Text('尝试投其所好', style: _blueStyle)
          ),
          SizedBox(height: 10),
          GestureDetector(
              onTap: () => _getSuggestion('自由发挥'),
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

    final dio = ref.read(dioProvider);
    final me = ref.read(userProvider);
    EasyLoading.show();
    if (_mode == ChatActionMode.manuel) {
      final message = ImMessage(conversation: widget.to.phone, sender: me, receiver: widget.to, content: text);
      try {
        final resp = await dio.post('/chat/message', data: message.toJson());
        final data = resp.data;
        if (data['code'] == 1) {
          // 成功
          setState(() {
            _mode = ChatActionMode.docker;
          });
        }
      } catch(e) {
        //
      } finally {
        EasyLoading.dismiss();
      }
    } else if (_mode == ChatActionMode.sona) {
      try {
        final resp = await dio.post('/chat/directive', data: {
          'receiver_id': widget.to.phone,
          'purpose': text
        });
        final data = resp.data;
        if (data['code'] == 1) {
          // 成功
          setState(() {
            _mode = ChatActionMode.docker;
          });
        }
      } catch(e) {
        //
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.dismiss();
    }
  }

  Future _sendMessage(String content) async {
    EasyLoading.show();
    try {
      final dio = ref.read(dioProvider);
      final me = ref.read(userProvider);
      final message = ImMessage(conversation: widget.to.phone, sender: me, receiver: widget.to, content: content);
      try {
        final resp = await dio.post('/chat/message', data: message.toJson());
      } catch(e) {
        //
      } finally {
        EasyLoading.dismiss();
      }
    } catch(e) {
      //
    } finally {
      EasyLoading.dismiss();
    }
  }

  void _showInfo() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatInfoScreen(user: widget.to)));
  }

  void _onClearHistory() async {
    final sure = await showConfirm(
      context: context,
      content: '清空历史消息'
    );
    if (sure == true) {
      final dio = ref.read(dioProvider);
      EasyLoading.show();
      try {
        await dio.delete('/chat/${widget.to.phone}/message');
      } catch(e) {
        //
      } finally {
        EasyLoading.dismiss();
      }
    }
  }

  Future _getSuggestion(String purpose) async {
    final dio = ref.read(dioProvider);
    EasyLoading.show();
    try {
      await dio.post('/chat/free', data: {
        'receiver_id': widget.to.phone,
        'purpose': purpose
      });
    } catch(e) {
      //
    } finally {
      EasyLoading.dismiss();
    }
  }

  FutureOr _onAction(ChatActionMode mode) {
    switch(mode) {
      case ChatActionMode.docker:
      case ChatActionMode.manuel:
      case ChatActionMode.sona:
        setState(() {
          _mode = mode;
        });
        break;
      case ChatActionMode.suggestion:
        return _onSuggestion();
      case ChatActionMode.chat:
        return _freeChat();
    }
  }

  Future _freeChat() async {
    final dio = ref.read(dioProvider);
    try {
      await dio.post('/chat/free', data: {
        'receiver_id': widget.to.phone,
      });
    } catch(e) {
      //
    }
  }

  Future _onSuggestion() async {
    final dio = ref.read(dioProvider);
    var resp = await dio.post('/chat/suggestion', data: {
      'receiver_id': widget.to.phone,
    });
    final sugg_map = resp.data['data']['suggestion'] as Map;
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
                  ...sugg_map.entries.map((e) => Container(
                    margin: EdgeInsets.only(top: 5, left: 64),
                    child: ColoredButton(
                        onTap: () async {
                          Navigator.pop(context);
                          _sendMessage(e.value);
                        },
                        text: e.key
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
}

enum ChatActionMode {
  docker,
  manuel,
  sona,
  suggestion,
  chat
}