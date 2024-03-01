import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sona/account/screens/email_sign_in.dart';
import 'package:sona/account/screens/phone_sign_in.dart';
import 'package:sona/account/services/auth.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:video_player/video_player.dart';

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

  late final VideoPlayerController _videoController;

  @override
  void initState() {
    SonaAnalytics.log('auth_landing');
    super.initState();
    _videoController = VideoPlayerController.asset('assets/videos/landing.mp4',
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true
      )
    )..setLooping(true)..initialize().then((value) {
      setState(() {});
      _videoController.play().then((value) => _videoController.play());
    });
  }

  @override
  void dispose() {
    _videoController..pause()..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C2C2C),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
              child: _videoController.value.isInitialized ? VideoPlayer(
                _videoController
              ) : Container()
          ),
          Positioned.fill(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
                  alignment: Alignment.topCenter,
                  child: Image.asset('assets/images/logo_coconut.png', width: 78),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  child: FilledButton.icon(
                      onPressed: _signInWithSMS,
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        foregroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor)
                      ),
                      icon: SonaIcon(icon: SonaIcons.phone, color: Theme.of(context).primaryColor),
                      label: Text(S.current.continueWithPhone)
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: 16),
                    Flexible(child: Divider(color: Colors.white.withOpacity(0.12))),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Text('OR',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white
                            )
                        )
                    ),
                    Flexible(child: Divider(color: Colors.white.withOpacity(0.12))),
                    SizedBox(width: 16)
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 16),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                        child: OutlinedButton.icon(
                            onPressed: _signInWithEmail,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.12),
                              foregroundColor: Colors.white,
                              side: BorderSide(color: Color(0xFF656565)),
                            ),
                            icon: SonaIcon(icon: SonaIcons.email, color: Colors.white),
                            label: Text('E-mail')
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    if (Platform.isAndroid) Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                        child: OutlinedButton.icon(
                            onPressed: _signInWithGoogle,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.12),
                              foregroundColor: Colors.white,
                              side: BorderSide(color: Color(0xFF656565)),
                            ),
                            icon: SonaIcon(icon: SonaIcons.google),
                            label: Text('Google')
                        ),
                      ),
                    ),
                    if (Platform.isIOS) Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                        child: OutlinedButton.icon(
                            onPressed: _signInWithApple,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.12),
                              foregroundColor: Colors.white,
                              side: BorderSide(color: Color(0xFF656565)),
                            ),
                            icon: SonaIcon(icon: SonaIcons.apple),
                            label: Text('Apple ID')
                        ),
                      ),
                    ),
                    SizedBox(width: 16)
                  ],
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white
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
                        color: Color(0xFFB7B7B7)
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom + 32)
              ],
            ),
          ),
        ],
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
    Map<String, dynamic> params = {};
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final account = await googleSignIn.signIn();
      if (account == null) throw(Exception('Account is null'));
      final auth = await account.authentication;
      params.addAll({
        'id': account.id,
        'email': account.email,
        'name': account.displayName,
        'token': auth.idToken,
        'code': account.serverAuthCode
      });
    } catch (e) {
      if (kDebugMode) print(e);
    }
    if (params.isNotEmpty) _signInWithOAuth('GOOGLE', params);
  }

  void _signInWithApple() async {
    Map<String, dynamic> params = {};
    try {
      final account = await SignInWithApple.getAppleIDCredential(scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName]);
      params.addAll({
        'id': account.userIdentifier,
        'email': account.email,
        'name': '${account.givenName} ${account.familyName}',
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
          _completeRequiredInfo(name: params['name']);
          return;
        }

        final response = await getMyProfile();
        if (response.statusCode == 0) {
          final profile = MyProfile.fromJson(response.data);
          ref.read(myProfileProvider.notifier).update(profile);
          if (!profile.completed) {
            _completeRequiredInfo(name: params['name']);
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

  void _completeRequiredInfo({required String? name}) async {
    if (mounted) {
      await Navigator.push(context, MaterialPageRoute(
          builder: (_) => BaseInfoScreen(
            name: name,
            country: findCountryByCode(null)
          )));
    }
  }
}