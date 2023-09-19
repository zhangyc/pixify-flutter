import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pinput/pinput.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/screens/required_info_form.dart';
import 'package:sona/account/services/auth.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/http/interceptors/base.dart';
import 'package:sona/utils/providers/dio.dart';

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
            Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  top: 32,
                  left: 16,
                  right: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'using phone number',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 32),
                      Form(
                        key: _phoneKey,
                        child: IntlPhoneField(
                          controller: _phoneController,
                          focusNode: _phoneFocusNode,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          initialCountryCode: 'CN',
                          onChanged: (PhoneNumber? pn) {
                            _countryCode = pn?.countryCode.replaceAll('+', '');
                            _phoneNumber = pn?.number;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: ColoredButton(
                    size: ColoredButtonSize.large,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontColor: Colors.white.withAlpha(200),
                    text: 'Continue',
                    onTap: _next,
                    loadingWhenAsyncAction: true,
                  ),
                )
              ],
            ),
            Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  top: 32,
                  left: 16,
                  right: 16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter Code',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'we sent to $_countryCode $_phoneNumber',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            WidgetSpan(child: SizedBox(width: 8)),
                            TextSpan(
                              text: 'change number',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.primary
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _controller.animateToPage(0,
                                      duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
                                  _pinController.clear();
                                  _pinFocusNode.unfocus();
                                  _phoneFocusNode.requestFocus();
                                }
                            )
                          ]
                        )
                      ),
                      SizedBox(height: 32),
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
                            return s != null && regex.hasMatch(s) ? null : 'invalid pin';
                          },
                          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onCompleted: (pin) {
                            _complete();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: ColoredButton(
                    size: ColoredButtonSize.large,
                    color: Theme.of(context).colorScheme.primary,
                    fontColor: Colors.white.withAlpha(200),
                    text: 'Continue',
                    onTap: _complete,
                    loadingWhenAsyncAction: true,
                  ),
                )
              ]
            ),
          ],
        ),
      )
    );
  }

  Future _next() async {
    if (_phoneKey.currentState!.validate()) {
      _sendPin();
      if (mounted) setState(() {});
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
    final resp = await sendPin(httpClient: dio, countryCode: _countryCode, phoneNumber: _phoneNumber);
    if (resp.statusCode != 0) {
      Fluttertoast.showToast(msg: 'Sending pin message failed');
    }
  }

  Future _complete() async {
    if (_pinKey.currentState!.validate()) {
      final resp = await login(
          httpClient: ref.read(dioProvider),
          countryCode: _countryCode,
          phoneNumber: _phoneNumber,
          pinCode: _pinController.text
      );
      if (resp.statusCode == 0 || resp.statusCode == 2) {
        final token = resp.data['token'];

        ref.read(tokenProvider.notifier).state = token;
        ref.read(asyncMyProfileProvider.notifier).refresh();
      }

      if (resp.statusCode == 2) {
        if (mounted) {
          await Navigator.push(context, MaterialPageRoute(
              builder: (_) => RequiredInfoFormScreen()));
        }
      }
    }
  }
}
