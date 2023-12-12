import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/helpers.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sona/account/screens/login_pin.dart';
import 'package:sona/account/services/auth.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/locale/locale.dart';
import 'package:sona/utils/picker/country/country.dart';

import '../../common/widgets/webview.dart';


class LoginPhoneNumberScreen extends StatefulHookConsumerWidget {
  const LoginPhoneNumberScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginPhoneNumberScreen> {
  late SonaCountry _country;
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _phoneKey = GlobalKey<FormState>(debugLabel: 'phone_number');

  bool _validate = true;

  @override
  void initState() {
    final initialCountryCode = findMatchedSonaLocale(Platform.localeName).locale.countryCode;
    _country = findCountryByCode(initialCountryCode);
    super.initState();
  }

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
                child: TextFormField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).primaryColor
                      ),
                      borderRadius: BorderRadius.circular(12),
                      gapPadding: 8
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).primaryColor
                      ),
                      borderRadius: BorderRadius.circular(12),
                      gapPadding: 8
                    ),
                    prefixIcon: GestureDetector(
                      onTap: () async {
                        final c = await showCountryPicker(context: context, initialValue: _country);
                        if (c != null) {
                          setState(() {
                            _country = c;
                          });
                        }
                      },
                      child: FittedBox(
                        child: Container(
                          key: ValueKey(_country.code),
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border(right: BorderSide(width: 1, color: Color(0xFFE8E6E6)))
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${_country.flag} +${_country.dialCode}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 14,
                              letterSpacing: 1.6
                            )
                          ),
                        ),
                      )
                    ),
                    hintText: 'Mobile Number',
                  ),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    letterSpacing: 3.6
                  ),
                  onChanged: (_) {
                    setState(() {
                      _validate = true;
                    });
                  },
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  String? _validator(String? value) {
    var validatorMessage = 'Invalid Phone Number';
    if (value == null || !isNumeric(value)) return validatorMessage;
    final selectedCountry = countries.firstWhere((c) => c.code == _country.code);
    return value.length >= selectedCountry.minLength && value.length <= selectedCountry.maxLength
        ? null
        : validatorMessage;
  }

  Future _next() async {
    try {
      final pn = PhoneNumber(countryISOCode: _country.code, countryCode: _country.dialCode, number: _phoneController.text);
      if (pn.isValidNumber()) {
        final result = await _sendPin();
        if (!result) return;
        if (mounted) setState(() {});
        Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPinScreen(phoneNumber: pn)));
        SonaAnalytics.log('reg_phone');
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

  Future<bool> _sendPin() async {
    try {
      final resp = await sendPin(countryCode: _country.dialCode, phoneNumber: _phoneController.text);
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
