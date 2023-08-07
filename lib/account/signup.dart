import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/providers/token.dart';

import '../utils/providers/dio.dart';

class SignupScreen extends StatefulHookConsumerWidget {
  const SignupScreen({
    super.key,
    required this.phone,
    required this.pin
  });
  final String phone;
  final String pin;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final PageController _controller = PageController();

  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _nameKey = GlobalKey<FormState>(debugLabel: 'name');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: SafeArea(
        child: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: 108),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16
                    ),
                    child: Form(
                      key: _nameKey,
                      child: TextField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        decoration: const InputDecoration(
                          labelText: 'Your name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 108),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: _complete,
                          icon: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            size: 28,
                          )
                      )
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Future _complete() async {
    if (_nameKey.currentState!.validate()) {
      final name = _nameController.text;
      final dio = ref.read(dioProvider);
      try {
        final resp = await dio.post('/auth/signup', data: {'phone': widget.phone, 'pin': widget.pin, 'name': name});
        final data = resp.data as Map<String, dynamic>;
        if (data['code'] == 1) {
          final token = data['data']['token'];
          ref.read(tokenProvider.notifier).state = token;
        } else {
          throw Exception(data['msg']);
        }
      } on Exception catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
}