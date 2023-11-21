import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sona/account/screens/login_pin.dart';
import 'package:sona/account/services/auth.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/utils/global/global.dart';

import '../../common/widgets/webview.dart';


class LoginPhoneNumberScreen extends StatefulHookConsumerWidget {
  const LoginPhoneNumberScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginPhoneNumberScreen> {
  final _phoneController = TextEditingController();
  PhoneNumber? _pn;
  final _phoneFocusNode = FocusNode();
  final _phoneKey = GlobalKey<FormState>(debugLabel: 'phone_number');

  bool _validate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  'What\'s your phone number?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Form(
                key: _phoneKey,
                child: IntlPhoneField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 4,
                        color: Theme.of(context).primaryColor
                      ),
                      borderRadius: BorderRadius.circular(12),
                      gapPadding: 8
                    ),
                    hintText: 'Mobile Number',
                    // hintStyle: TextStyle(color: Color(0xFFE9C6EE))
                  ),
                  flagsButtonMargin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  flagsButtonPadding: EdgeInsets.symmetric(horizontal: 4),
                  showDropdownIcon: false,
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 3.6
                  ),
                  dropdownDecoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 1.2,
                        color: Theme.of(context).primaryColor.withOpacity(0.2)
                      )
                    )
                  ),
                  disableLengthCheck: _validate,
                  initialValue: _pn?.completeNumber,
                  invalidNumberMessage: _validate ? '' : 'Invalid Mobile Number',
                  onChanged: (PhoneNumber? pn) {
                    _pn = pn;
                    if (pn == null) return;
                    final country = countries.firstWhere((c) => c.code == pn.countryISOCode);
                    if (pn.number.length > country.maxLength) {
                      _validate = false;
                    } else {
                      _validate = true;
                    }
                    setState(() {});
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    text: 'By tapping “Continue”, you agree to our '
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (c){
                        return WebView(url: 'https://h5.sona.pinpon.fun/privacy-policy.html', title: 'Privacy policy');
                      }))
                  ),
                  TextSpan(
                    text: ' and '
                  ),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (c){
                        return WebView(url: 'https://h5.sona.pinpon.fun/terms-and-conditions.html', title: 'Terms and conditions');
                      }))
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
              text: 'Continue',
              onTap: _next,
              loadingWhenAsyncAction: true,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future _next() async {
    if (_pn == null) return;
    if (_pn!.isValidNumber()) {
      final result = await _sendPin();
      if (!result) return;
      if (mounted) setState(() {});
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPinScreen(phoneNumber: _pn!)));
      SonaAnalytics.log('reg_phone');
    } else {
      setState(() {
        _validate = false;
      });
    }
  }

  Future<bool> _sendPin() async {
    try {
      final resp = await sendPin(countryCode: _pn!.countryCode.substring(1), phoneNumber: _pn!.number);
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
