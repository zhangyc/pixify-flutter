import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sona/account/screens/email_sign_in.dart';
import 'package:sona/account/screens/phone_sign_in.dart';
import 'package:sona/account/services/auth.dart';
import 'package:sona/common/widgets/image/icon.dart';

import '../../common/env.dart';
import '../../common/widgets/webview.dart';
import '../../core/providers/token.dart';
import '../../core/travel_wish/models/country.dart';
import '../../generated/l10n.dart';
import '../../utils/global/global.dart';
import '../models/my_profile.dart';
import '../providers/profile.dart';
import '../services/info.dart';
import 'base_info.dart';

class AuthLandingScreen extends ConsumerStatefulWidget {
  const AuthLandingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthLandingScreenState();
}

class _AuthLandingScreenState extends ConsumerState<AuthLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sign_in_bg.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter
          )
        ),
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 56 * 3 + 12 * 4 + 158 + MediaQuery.of(context).padding.bottom,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding_fg.png'),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                scale: 2.6
              )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: OutlinedButton.icon(
                    onPressed: _signInWithSMS,
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                      foregroundColor: MaterialStatePropertyAll(Colors.white)
                    ),
                    icon: SonaIcon(icon: SonaIcons.phone),
                    label: Text('Continue with Phone')
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: OutlinedButton.icon(
                    onPressed: _signInWithEmail,
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    icon: SonaIcon(icon: SonaIcons.email),
                    label: Text('Continue with Email')
                ),
              ),
              if (Platform.isAndroid) Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: OutlinedButton.icon(
                  onPressed: _signInWithGoogle,
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                  icon: SonaIcon(icon: SonaIcons.google),
                  label: Text('Continue with Google')
                ),
              ),
              if (Platform.isIOS) Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: OutlinedButton.icon(
                    onPressed: _signInWithApple,
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    icon: SonaIcon(icon: SonaIcons.apple),
                    label: Text('Continue with Apple')
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text.rich(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithSMS() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignInWithPhoneNumberScreen()));
  }

  void _signInWithEmail() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignInWithEmailScreen()));
  }

  void _signInWithGoogle() async {
    String? t;
    try {
      final account = await GoogleSignIn.standard(scopes: const ['email']).signIn();
      if (account == null) throw(Exception('Account is null'));
      t = (await account.authentication).accessToken;
    } catch (e) {
      if (kDebugMode) print(e);
    }
    if (t != null) _signInWithOAuth('GOOGLE', {'token': t});
  }

  void _signInWithApple() async {
    Map<String, dynamic> params = {};
    try {
      final account = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email]);
      params.addAll({
        'token': account.identityToken,
        'code': account.authorizationCode
      });
    } catch (e) {
      //
      if (kDebugMode) print(e);
    }
    if (params.isNotEmpty) _signInWithOAuth('APPLE', params);
  }

  Future _signInWithOAuth(String source, Map<String, dynamic> params) async {
    try {
      EasyLoading.show();
      final resp = await signInWithOAuth(
          source: source,
          params: params
      );

      if (resp.statusCode == 0 || resp.statusCode == 2) {
        SonaAnalytics.log('reg_$source');
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

  void _completeRequiredInfo() async {
    if (mounted) {
      await Navigator.push(context, MaterialPageRoute(
          builder: (_) => BaseInfoScreen(country: findCountryByCode(null))));
    }
  }
}