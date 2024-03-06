import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pinput/pinput.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/screens/base_info.dart';
import 'package:sona/account/services/auth.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/utils/global/global.dart';

import '../../generated/l10n.dart';
import '../models/my_profile.dart';


class EmailPinScreen extends StatefulHookConsumerWidget {
  const EmailPinScreen({super.key, required this.email});
  final String email;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmailPinScreenState();
}

class _EmailPinScreenState extends ConsumerState<EmailPinScreen> {
  final _pinController = TextEditingController();
  final _pinFocusNode = FocusNode();
  final _pinKey = GlobalKey<FormState>(debugLabel: 'pin_number');
  var _buttonKey = UniqueKey();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFF6F3F3)
    ),
  );

  late final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(width: 2, color: Theme.of(context).primaryColor)
  );

  late final submittedPinTheme = defaultPinTheme.copyWith(
    textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
    ),
    decoration: defaultPinTheme.decoration?.copyWith(
      border: Border.all(width: 2, color: Color(0xFFE8E6E6))
    )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: MediaQuery.of(context).viewPadding.top + 64,
            bottom: 120
          ),
          reverse: true,
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/tender_affection.png', height: 179,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text.rich(
                    TextSpan(
                      text: '${S.of(context).verifyCodePageTitle}\n\n',
                      children: [
                        TextSpan(
                          text: widget.email,
                          style: Theme.of(context).textTheme.titleMedium
                        )
                      ]
                    ),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 4),
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
                    autofocus: true,
                    onCompleted: (pin) {
                      _complete();
                    },
                  ),
                ),
              ],
          )
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Flexible(
              child: ColoredButton(
                key: _buttonKey,
                size: ColoredButtonSize.large,
                color: Colors.transparent,
                fontColor: Theme.of(context).primaryColor,
                borderColor: Colors.transparent,
                text: S.of(context).buttonResend,
                onTap: () async {
                  final result = await _sendPin();
                  if (result) {
                    setState(() {
                      _buttonKey = UniqueKey();
                    });
                  }
                },
                confirmDelay: Duration(seconds: 60),
                loadingWhenAsyncAction: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<bool> _sendPin() async {
    try {
      final resp = await sendEmailPin(email: widget.email);
      if (resp.statusCode == 0) {
        setState(() {});
        return true;
      } else if (resp.statusCode == 10070) {
        Fluttertoast.showToast(msg: 'Code requests too frequent. Wait minutes before trying again.');
        return true;
      } else {
        Fluttertoast.showToast(msg: 'Sending pin message failed');
        return true;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Sending pin message failed');
      return false;
    }
  }

  Future _complete() async {
    if (_pinKey.currentState!.validate()) {
      try {
        EasyLoading.show();
        final resp = await signInWithEmail(
            email: widget.email,
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
            await Future.delayed(const Duration(milliseconds: 200));
            if (mounted) Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          } else {
            Fluttertoast.showToast(msg: 'Failed to get profile, try again later');
          }
        } else {
          Fluttertoast.showToast(msg: 'Failed to login, try again later');
        }
      } catch (e) {
        Fluttertoast.showToast(msg: 'Failed to login, try again later');
      } finally {
        EasyLoading.dismiss();
      }
    }
  }

  void _completeRequiredInfo() async {
    if (mounted) {
      await Navigator.push(context, MaterialPageRoute(
          builder: (_) => BaseInfoScreen(country: findCountryByCode(null))));
    }
  }
}
