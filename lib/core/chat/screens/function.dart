import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/screens/info.dart';
import 'package:sona/core/chat/widgets/chat_input.dart';
import 'package:sona/core/providers/user.dart';
import 'package:sona/widgets/button/colored_button.dart';

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
  bool _showSuggestion = true;

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
                padding: EdgeInsets.symmetric(horizontal: 20),
                reverse: true,
                itemBuilder: _itemBuilder,
                itemCount: _messages.length,
                separatorBuilder: (_, __) => SizedBox(height: 5),
              ),
            ) : _tips()
          ),
        ],
      ),
      bottomSheet: _showSuggestion ? _bottomTips() : Container(
        padding: EdgeInsets.only(
          top: 12,
          bottom: MediaQuery.of(context).viewPadding.bottom + 12
        ),
        color: Colors.white,
        child: ChatInput(onSubmit: _onMessage),
      )
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final message = _messages[index];
    final me = ref.read(userProvider);
    if (message.sender.phone == me.phone) {
      return Container(
        margin: EdgeInsets.only(left: 50),
        child: ListTile(
          trailing: CircleAvatar(
            child: Text(message.sender.name),
          ),
          title: Text(message.content),
          tileColor: Color(0xFFF8F8F8)
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(right: 50),
        child: ListTile(
            leading: CircleAvatar(
              child: Text(message.sender.name),
            ),
            title: Text(message.content),
            tileColor: Color(0xFFF8F8F8)
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
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: 10),
          GestureDetector(
              onTap: () => _getMessageSuggestion('给我建议'),
              child: Text('给我\n建议', style: _blueStyle)
          ),
          GestureDetector(
              onTap: () async {
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
              child: Text('自动\n问答', style: _blueStyle)
          ),
          GestureDetector(
              onTap: () {
                final dio = ref.read(dioProvider);
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
                              ...['调情', '讽刺', '萌萌', '好奇'].map((e) => Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ColoredButton(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      EasyLoading.show();
                                      try {
                                        await dio.post('/chat/free', data: {
                                          'receiver_id': widget.to.phone,
                                          'purpose': e == '调情' ? 'Flirty' : e
                                        });
                                      } catch(e) {
                                        //
                                      } finally {
                                        EasyLoading.dismiss();
                                      }
                                    },
                                    text: e
                                ),
                              )),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      );
                    }
                );
              },
              child: Text('手动\n指令', style: _blueStyle)
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  _showSuggestion = false;
                });
              },
              child: Text('手动\n输入', style: _blueStyle)
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  void _onMessage({String? text}) async {
    if (text == null) {
      FocusManager.instance.primaryFocus?.unfocus();
      return;
    }
    final dio = ref.read(dioProvider);
    final me = ref.read(userProvider);
    final message = ImMessage(conversation: widget.to.phone, sender: me, receiver: widget.to, content: text);
    final resp = await dio.post('/chat/message', data: message.toJson());
    final data = resp.data;
    if (data['code'] == 1) {
      // 成功
      setState(() {
        _showSuggestion = true;
      });
    }
  }

  void _showInfo() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatInfoScreen(user: widget.to)));
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

  Future _getMessageSuggestion(String purpose) async {
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
                  ...sugg_map.values.map((e) => Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ColoredButton(
                        onTap: () async {
                          Navigator.pop(context);
                          EasyLoading.show();
                          try {
                            await dio.post('/chat/free', data: {
                              'receiver_id': widget.to.phone,
                              'purpose': e
                            });
                          } catch(e) {
                            //
                          } finally {
                            EasyLoading.dismiss();
                          }
                        },
                        text: e
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
}