import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/utils/providers/dio.dart';
import 'package:sona/common/widgets/button/colored.dart';

import '../../../utils/dialog/input.dart';

class PromptTemplateScreen extends StatefulHookConsumerWidget {
  const PromptTemplateScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PromptTemplateScreenState();
}

class _PromptTemplateScreenState extends ConsumerState<PromptTemplateScreen> {

  final _pageController = PageController();
  final _keys = ['accost_template', 'request_suggestion_template', 'free_chat_template'];

  @override
  void initState() {

    super.initState();
  }

  Future<String?> _getTemplate(String key) async {
    final dio = ref.read(dioProvider);
    final resp = await dio.get('/template/$key');
    final data = resp.data;
    if (data['code'] == 1 && data['data']['value'] != null) {
      return data['data']['value'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Prompt Templates'),
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ..._keys.map<Widget>((key) => Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ColoredButton(
                    onTap: () => _setTemplate(key),
                    text: '修改 $key'
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future _setTemplate(String key) async {
    final initialText = await _getTemplate(key);
    if (initialText == null) {
      Fluttertoast.showToast(msg: '网络错误');
      return;
    }
    var text = await showTextFieldDialog(
      context: context,
      initialText: initialText
    );
    final dio = ref.read(dioProvider);
    final resp = await dio.post('/template/$key', data: {"key": key, "value": text});
    final data = resp.data;
    if (data['code'] == 1 ) {
      Fluttertoast.showToast(msg: '成功');
    }
  }
}