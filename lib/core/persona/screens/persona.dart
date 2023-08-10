import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:sona/core/persona/providers/persona.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/core/providers/user.dart';
import 'package:sona/utils/providers/dio.dart';
import 'package:sona/utils/providers/env.dart';

import '../../../utils/dialog/input.dart';

class PersonaScreen extends StatefulHookConsumerWidget {
  const PersonaScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonaScreenState();
}

class _PersonaScreenState extends ConsumerState<PersonaScreen> {

  var _controller = TextEditingController();
  String? _currentCharacter;
  List<String> _knowledge = [];

  @override
  void initState() {
    _fetchIntro();
    _fetchKnowledge();
    super.initState();
  }

  Future _fetchIntro() async {
    final dio = ref.read(dioProvider);
    final resp = await dio.get('/persona');
    final data = resp.data;
    if (data['code'] == 1 && data['data']['intro'] != null) {
      if (mounted) {
        setState(() {
          _controller.setText(data['data']['intro']);
        });
      }
    }
    if (data['code'] == 1 && data['data']['character'] != null) {
      if (mounted) {
        setState(() {
          _currentCharacter = data['data']['character'];
        });
      }
    }
  }

  Future _fetchKnowledge() async {
    final dio = ref.read(dioProvider);
    final resp = await dio.get('/knowledge');
    final data = resp.data;
    if (data['code'] == 1) {
      if (mounted) {
        setState(() {
          _knowledge = List<String>.from(data['data']);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.settings), onPressed: () => Navigator.pushNamed(context, 'setting')),
        centerTitle: true,
        title: Text(user.name),
        actions: [
          IconButton(onPressed: _switchEnv, icon: Icon(Icons.share_outlined))
        ],
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  ...['Misaki', 'Hannah'].map((name) => Flexible(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () async {
                        final dio = ref.read(dioProvider);
                        final resp = await dio.post('/persona', data: {'character': name});
                        final data = resp.data;
                        if (data['code'] == 1) {
                          if (mounted) {
                            setState(() {
                              _currentCharacter = name;
                            });
                          }
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: _currentCharacter == name ? Colors.black : Colors.black12, width: 2)
                        ),
                        alignment: Alignment.center,
                        child: Text(name),
                      ),
                    )
                  ))
                ],
              ),
              SizedBox(height: 15,),
              Text("Bio", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
              TextField(
                controller: _controller,
                minLines: 6,
                maxLines: 6,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  hintText: '输入介绍，年龄、性别、性取向等',
                  border: OutlineInputBorder()
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    final dio = ref.read(dioProvider);
                    dio.post('/persona', data: {'intro': _controller.text});
                    FocusManager.instance.primaryFocus?.unfocus();
                    Fluttertoast.showToast(msg: '设置成功');
                  },
                  child: Text('修改', style: TextStyle(fontSize: 18),),
                ),
              ),
              SizedBox(height: 15,),
              Text("知识库", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              SizedBox(height: 10),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _onAddKnowledge,
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1)
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.add, size: 24,)
                ),
              ),
              SizedBox(height: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ..._knowledge.map((e) => Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F1F1)
                    ),
                    child: Text(e)
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _onAddKnowledge() async {
    var text = await showTextFieldDialog(context: context);
    final dio = ref.read(dioProvider);
    final resp = await dio.post('/knowledge', data: {'content': text});
    final data = resp.data;
    if (data['code'] == 1 ) {
      _fetchKnowledge();
    }
  }

  Future<void> _switchEnv() async {
    final sure = await showConfirm(
        context: context,
        content: '连接到银古本地测试环境?\n(数据是同一份，不会丢失；App重启后复原)'
    );
    if (sure == true) {
      ref.read(envProvider.notifier).state = 'http://192.168.31.142:8000';
    }
  }
}