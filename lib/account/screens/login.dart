import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:sona/account/services/info.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/match/util/http_util.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/global/global.dart';

import '../../common/widgets/webview.dart';
import '../../firebase/sona_firebase.dart';
import '../models/my_profile.dart';


class LoginScreen extends StatefulHookConsumerWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final PageController _controller = PageController();
  final _phoneController = TextEditingController();
  String? _countryCode;
  String? _phoneNumber;
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Create Account',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'using phone number',
                        textAlign: TextAlign.start,
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
                          initialCountryCode: _countryCode != null ? '+$_countryCode' : null,
                          onChanged: (PhoneNumber? pn) {
                            _countryCode = pn?.countryCode.replaceAll('+', '');
                            _phoneNumber = pn?.number;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Sign up agrees to\n'
                            ),
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (c){
                                  return WebView(url: 'https://h5.sona.pinpon.fun/terms-and-conditions.html', title: 'Terms and conditions');
                                }))
                            ),
                            TextSpan(
                                text: ' and '
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (c){
                                  return WebView(url: 'https://h5.sona.pinpon.fun/privacy-policy.html', title: 'Privacy policy');
                                }))
                            ),
                          ]
                        ),
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      )
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
                              text: 'we sent to +$_countryCode $_phoneNumber',
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
      final result = await _sendPin();
      if (!result) return;
      if (mounted) setState(() {});
      await _controller.animateToPage(1,
          duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _pinFocusNode.requestFocus();
      });
      SonaAnalytics.log('reg_phone');
    }
  }

  String? verificationId;
  Future _verifyNumber() async{
    final completer = Completer();
    authService.verifyPhoneNumber(
      phoneNumber: '+${_countryCode} ${_phoneNumber}',
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async{
        if(Platform.isAndroid){
          final  userCredential=await authService.signInWithCredential(credential);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.message != null) Fluttertoast.showToast(msg: e.message!);
        completer.completeError(e);
      },
      codeSent: (String verificationId, int? resendToken) async {
        this.verificationId=verificationId;
        completer.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // print(verificationId);
      },
    );
    return completer.future;
  }

  Future<bool> _sendPin() async {
    try {
      final resp = await sendPin(countryCode: _countryCode!, phoneNumber: _phoneNumber!);
      if (resp.statusCode == 0) {
        return true;
      } else if (resp.statusCode == 10070) {
        Fluttertoast.showToast(msg: 'Code requests too frequent. Wait minutes before trying again.');
        return false;
      } else {
        Fluttertoast.showToast(msg: 'Sending pin message failed');
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Sending pin message failed');
      return false;
    }
  }

  Future _complete() async {
    if (_pinKey.currentState!.validate()) {

    // PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId!, smsCode: _pinController.text);
    //
    // // Sign the user in (or link) with the credential
    // final  userCredential= await authService.signInWithCredential(credential);
    // final  idToken=await userCredential.user?.getIdToken();  //idToken上送给业务服务器

    // final resp = await dio.post('/auth/login-firebase',data: {
    //   "token":idToken, //
    //   "deviceToken":deviceToken, // 设备 token 可为空
    //   "timezone":'${DateTime.now().timeZoneOffset.inHours}',
    //   "phonePrefix":_countryCode, // 手机号前缀
    //   "phone":_phoneNumber, // 手机号
    //   // 用户所在时区 可为空
    // });
      final resp = await login(
          countryCode: _countryCode!,
          phoneNumber: _phoneNumber!,
          pinCode: _pinController.text
      );

      if (resp.statusCode == 0 || resp.statusCode == 2) {
        SonaAnalytics.log('reg_code');
        final token = resp.data['token'];
        ref.read(tokenProvider.notifier).state = token;
        //userToken=token;
        // 未注册
        if (resp.statusCode == 2) {
          _completeRequiredInfo();
          return;
        }

        final response = await getMyProfile();
        if (response.statusCode == 0) {
          final profile = MyProfile.fromJson(response.data);
          ref.read(myProfileProvider.notifier).update(profile);
          if (!profile.completed) {
            _completeRequiredInfo();
            return;
          }
          Fluttertoast.showToast(msg: 'Welcome back, ${profile.name}');
          if (mounted) Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        } else {
          Fluttertoast.showToast(msg: 'Failed to get profile, try again later');
        }
      } else {
        Fluttertoast.showToast(msg: 'Failed to login, try again later');
      }
    }
  }

  void _completeRequiredInfo() async {
    if (mounted) {
      await Navigator.push(context, MaterialPageRoute(
          builder: (_) => RequiredInfoFormScreen()));
    }
  }
}
