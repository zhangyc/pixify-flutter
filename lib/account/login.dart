import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pinput/pinput.dart';
import 'package:sona/account/providers/info.dart';
import 'package:sona/account/required_info_form.dart';
import 'package:sona/account/services/auth.dart';
import 'package:sona/account/signup.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/firebase/sona_firebase.dart';
import 'package:sona/utils/http/interceptors/base.dart';
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
  var _countryCode;
  var _phoneNumber;
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
                mainAxisSize: MainAxisSize.min,
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
                        onChanged: (PhoneNumber? pn) {
                          _countryCode = pn?.countryCode;
                          _phoneNumber = pn?.number;
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
                    length: 6,
                    controller: _pinController,
                    focusNode: _pinFocusNode,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    androidSmsAutofillMethod:  AndroidSmsAutofillMethod.smsUserConsentApi,
                    validator: (s) {
                      final regex = RegExp(r'^\d{6}$');
                      return s != null && regex.hasMatch(s) ? null : 'Pin is incorrect';
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
    if (_phoneKey.currentState!.validate()) {
      _phoneKey.currentState!.save();

      await _sendPin();
      await _controller.animateToPage(1,
          duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _pinFocusNode.requestFocus();
      });
    }
  }

  // final _maxRetryTime = 1;
  // var _currentRetryTime = 0;
  Future _sendPin() async {
    final dio = ref.read(dioProvider);
    try {
      await sendPin(httpClient: dio, countryCode: _countryCode, phoneNumber: _phoneNumber);
    } on CustomDioException catch (e) {
      Fluttertoast.showToast(msg: 'Sending pin message failed');
      rethrow;
    }
  }

  Future _complete() async {
    if (_pinKey.currentState!.validate()) {
      try {
        final resp = await login(
            httpClient: ref.read(dioProvider),
            countryCode: _countryCode,
            phoneNumber: _phoneNumber,
            pinCode: _pinController.text
        );
        final token = resp.data['token'];

        ref.read(tokenProvider.notifier).state = token;
        ref.read(asyncMyProfileProvider.notifier).refresh();
      } on CustomDioException catch (e) {
        if (e.code == '2') {
          if (mounted) {
            await Navigator.push(context, MaterialPageRoute(
                builder: (_) => RequiredInfoFormScreen()));
          }
        }
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
}
