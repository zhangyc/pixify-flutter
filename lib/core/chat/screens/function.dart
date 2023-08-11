import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/screens/info.dart';
import 'package:sona/core/chat/widgets/chat_input.dart';
import 'package:sona/core/providers/user.dart';
import 'package:sona/widgets/button/colored_button.dart';

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
  var _mode = 'docker';

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
      body: Stack(
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
      floatingActionButton: _mode == 'docker' ? _bottomTips() : Container(
        padding: EdgeInsets.only(
          top: 12,
          bottom: MediaQuery.of(context).viewPadding.bottom + 12
        ),
        color: Colors.white,
        child: ChatInput(onSubmit: _onMessage, actionText: _mode == 'manuel' ? 'Send' : 'Sona'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final message = _messages[index];
    final me = ref.read(userProvider);
    if (message.sender.phone == me.phone) {
      return Container(
        margin: EdgeInsets.only(left: 50, bottom: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Text(message.content),
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
                      child: Text('S', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w700)),
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
        margin: EdgeInsets.only(right: 50, bottom: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
                title: Text(message.content),
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

  Widget _bottomTips() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => _getMessageSuggestion(),
              icon: Text('💡')
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  _mode = 'sona';
                });
              },
              onLongPress: () async {
                HapticFeedback.mediumImpact();
                final dio = ref.read(dioProvider);
                EasyLoading.show();
                try {
                  await dio.post('/chat/free', data: {
                    'receiver_id': widget.to.phone,
                  });
                } catch(e) {
                  //
                } finally {
                  EasyLoading.dismiss();
                }
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.pinkAccent.shade100,
                      Colors.blueAccent.shade100
                    ]
                  ),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text('S', style: TextStyle(fontSize: 28)),
              )
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  _mode = 'manuel';
                });
              },
              icon: Text('\u{270D}', style: _blueStyle)
          ),
        ],
      ),
    );
  }

  void _onMessage({String? text}) async {
    print(text);
    if (text == null || text.trim().isEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        _mode = 'docker';
      });
      return;
    }
    final dio = ref.read(dioProvider);
    final me = ref.read(userProvider);
    EasyLoading.show();
    if (_mode == 'manuel') {
      final message = ImMessage(conversation: widget.to.phone, sender: me, receiver: widget.to, content: text);
      try {
        final resp = await dio.post('/chat/message', data: message.toJson());
        final data = resp.data;
        if (data['code'] == 1) {
          // 成功
          setState(() {
            _mode = 'docker';
          });
        }
      } catch(e) {
        //
      } finally {
        EasyLoading.dismiss();
      }
    } else if (_mode == 'sona') {
      try {
        final resp = await dio.post('/chat/free', data: {
          'receiver_id': widget.to.phone,
          'purpose': text
        });
        final data = resp.data;
        if (data['code'] == 1) {
          // 成功
          setState(() {
            _mode = 'docker';
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

  Future _getMessageSuggestion() async {
    final dio = ref.read(dioProvider);
    EasyLoading.show();
    var resp;
    try {
      resp = await dio.post('/chat/suggestion', data: {
        'receiver_id': widget.to.phone,
      });
    } catch(e) {
      //
    } finally {
      EasyLoading.dismiss();
    }
    final sugg_map = resp.data['data']['suggestion'] as Map;
    showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),
      builder: (_) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...sugg_map.entries.map((e) => Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
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