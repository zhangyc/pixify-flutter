import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sona/utils/toast/flutter_toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/event/account_event.dart';
import 'package:sona/account/screens/email_pin.dart';
import 'package:sona/account/services/auth.dart';
import 'package:sona/common/env.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/utils/global/global.dart';

import '../../common/widgets/webview.dart';
import '../../generated/l10n.dart';


class SignInWithEmailScreen extends StatefulHookConsumerWidget {
  const SignInWithEmailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInWithEmailScreenState();
}

class _SignInWithEmailScreenState extends ConsumerState<SignInWithEmailScreen> {
  final _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  bool _validate = true;

  @override
  void initState() {
    super.initState();
    SonaAnalytics.log(AccountEvent.reg_click_email.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // forceMaterialTransparency: true,
      ),
      extendBody: false,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: MediaQuery.of(context).viewPadding.top + 64,
              bottom: 160
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/tender_affection.png', height: 206),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  S.current.whatsYourEmail,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Form(
                child: TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).primaryColor
                      ),
                      borderRadius: BorderRadius.circular(20),
                      gapPadding: 8
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).primaryColor
                      ),
                      borderRadius: BorderRadius.circular(20),
                      gapPadding: 8
                    ),
                    hintText: 'Email',
                  ),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    letterSpacing: 1.6
                  ),
                  onChanged: (_) {
                    setState(() {
                      _validate = true;
                    });
                  },
                  autofocus: true,
                  // onTapOutside: (_) => _phoneFocusNode.unfocus(),
                  validator: _validator,
                  autovalidateMode: _validate ? AutovalidateMode.disabled : AutovalidateMode.always,
                ),
              ),
            ],
          ),
        )
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: S.current.userPhoneNumberPageTermsPrefix
                  ),
                  TextSpan(
                    text: S.current.userPhoneNumberPageTermsText,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (c){
                        return WebView(url: env.termsOfService, title: S.of(context).termsOfService);
                      }))
                  ),
                  TextSpan(
                    text: S.current.userPhoneNumberPageTermsAnd
                  ),
                  TextSpan(
                    text: S.current.userPhoneNumberPagePrivacyText,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (c){
                        return WebView(url: env.privacyPolicy, title: S.of(context).privacyPolicy);
                      }))
                  ),
                  TextSpan(
                      text: S.current.userPhoneNumberPagePrivacySuffix
                  ),
                ]
              ),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.black54
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 12),
            ColoredButton(
              size: ColoredButtonSize.large,
              // color: Color(0xFFDD70E0),
              fontColor: Colors.white,
              text: S.current.buttonNext,
              onTap: _next,
              loadingWhenAsyncAction: true,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  String? _validator(String? value) {
    var validatorMessage = 'Invalid Email';
    if (value == null) return validatorMessage;
    const emailRegex = r"""^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*(?:\.[a-zA-Z]{2,6})$""";
    return RegExp(emailRegex).hasMatch(value)
        ? null
        : validatorMessage;
  }

  Future _next() async {
    try {
      final email = _emailController.text.trim();
      if (_validator(email) == null) {
        final result = await _sendPin(email);
        if (!result) return;
        if (mounted) setState(() {});
        Navigator.push(context, MaterialPageRoute(builder: (_) => EmailPinScreen(email: email)));
        SonaAnalytics.log(AccountEvent.reg_email_next.name);
      } else {
        setState(() {
          _validate = false;
        });
      }
    } catch(e) {
      setState(() {
        _validate = false;
      });
    }
  }

  Future<bool> _sendPin(String email) async {
    try {
      final resp = await sendEmailPin(email: email);
      if (resp.statusCode == 0) {
        return true;
      } else if (resp.statusCode == 10070) {
        Fluttertoast.showToast(msg: 'Code requests too frequent. Wait minutes before trying again.');
        return kDebugMode;
      } else {
        Fluttertoast.showToast(msg: 'Sending pin message failed');
        return kDebugMode;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Sending pin message failed');
      return false;
    }
  }
}
