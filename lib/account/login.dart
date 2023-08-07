import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:sona/account/signup.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/providers/dio.dart';
import 'package:sona/utils/providers/firebase.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final PageController _controller = PageController();
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _pinFocusNode = FocusNode();
  final _phoneKey = GlobalKey<FormState>(debugLabel: 'phone_number');
  final _pinKey = GlobalKey<FormState>(debugLabel: 'pin_number');

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  late final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
    borderRadius: BorderRadius.circular(8),
  );

  late final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration!.copyWith(
      color: Color.fromRGBO(234, 239, 243, 1),
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      key: _phoneKey,
                      child: IntlPhoneField(
                        controller: _phoneController,
                        focusNode: _phoneFocusNode,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'CN',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                  ),
                  SizedBox(height: 108),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: _next,
                      icon: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        size: 28,
                      )
                    )
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(height: 108),
                Form(
                  key: _pinKey,
                  child: Pinput(
                    controller: _pinController,
                    focusNode: _pinFocusNode,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    validator: (s) {
                      return s == '2222' ? null : 'Pin is incorrect';
                    },
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    onCompleted: (pin) {
                      _complete();
                    },
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
              ]
            ),
          ],
        ),
      )
    );
  }

  void _next() async {
    if (_phoneController.value.text.isEmpty) {
      _phoneKey.currentState!.validate();
      return;
    }
    if (_phoneKey.currentState!.validate()) {
      await _controller.animateToPage(1,
          duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _pinFocusNode.requestFocus();
      });
    }
  }

  Future _complete() async {
    if (_pinKey.currentState!.validate()) {
      final phone = _phoneController.text;
      final pin = _pinController.text;

      final dio = ref.read(dioProvider);
      try {
        final resp = await dio.post('/auth/login', data: {'phone': phone, 'pin': pin});
        final data = resp.data as Map<String, dynamic>;
        if (data['code'] == 1) {
          final token = data['data']['token'];
          ref.read(tokenProvider.notifier).state = token;
        } else if (data['code'] == 1001) {
          // 未注册
          if (mounted) {
            await Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen(phone: phone, pin: pin)));
          }
        } else {
          throw Exception(data['msg']);
        }
      } on Exception catch (e) {
        print(e);
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
}
