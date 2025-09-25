import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sona/account/services/auth.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/firebase/sona_firebase.dart';
import 'package:video_player/video_player.dart';

import '../../common/env.dart';
import '../../common/widgets/text/neon_word_mark.dart';
import '../../common/widgets/webview.dart';
import '../../core/providers/token.dart';
import '../../core/travel_wish/models/country.dart';
import '../../generated/l10n.dart';
import '../../utils/global/global.dart';
import '../../utils/toast/flutter_toast.dart';
import '../event/account_event.dart';
import '../models/my_profile.dart';
import '../providers/profile.dart';
import '../services/info.dart';
import 'base_info.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class AuthLandingScreen extends ConsumerStatefulWidget {
  const AuthLandingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthLandingScreenState();
}

class _AuthLandingScreenState extends ConsumerState<AuthLandingScreen> {
  late final VideoPlayerController _videoController;

  @override
  void initState() {
    SonaAnalytics.log('auth_landing');
    super.initState();
    // 初始化 Google Sign-In
    // GoogleSignIn.instance.initialize().then((_) {
    //   // 尝试轻量认证，但不依赖 authenticationEvents
    //   GoogleSignIn.instance.attemptLightweightAuthentication();
    // });
    _videoController = VideoPlayerController.asset('assets/videos/landing.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..setLooping(true)
      ..initialize().then((value) {
        setState(() {});
        _videoController.play().then((value) => _videoController.play());
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E14),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
              child: _videoController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoController.value.aspectRatio,
                      child: VideoPlayer(_videoController),
                    )
                  : Container()),

          /// 霓虹渐变氛围层（紫→青，低透明度）
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF7C3AED).withOpacity(0.08),
                    const Color(0xFF22D3EE).withOpacity(0.08)
                  ],
                ),
              ),
            ),
          ),

          /// 底部玻璃模糊暗化，增强按钮与文案可读性
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 260,
            child: ClipRect(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 5),
                  alignment: Alignment.topCenter,
                  child: const NeonWordmark(text: 'AstroPair', fontSize: 44),
                )),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                //   child: FilledButton.icon(
                //       onPressed: _signInWithSMS,
                //       style: ButtonStyle(
                //           backgroundColor:
                //               const MaterialStatePropertyAll(Color(0xFF00EED1)),
                //           foregroundColor:
                //               const MaterialStatePropertyAll(Colors.white),
                //           shadowColor:
                //               const MaterialStatePropertyAll(Color(0x8000EED1)),
                //           elevation: const MaterialStatePropertyAll(8),
                //           overlayColor: MaterialStatePropertyAll(
                //               const Color(0xFF00EED1).withOpacity(0.16)),
                //           shape: MaterialStatePropertyAll(
                //               RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(20)))),
                //       icon: const SonaIcon(
                //           icon: SonaIcons.phone, color: Colors.white),
                //       label: Text(S.current.continueWithPhone)),
                // ),
                // Row(
                //   children: [
                //     SizedBox(width: 16),
                //     Flexible(
                //         child: Divider(color: Colors.white.withOpacity(0.10))),
                //     Padding(
                //         padding:
                //             EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                //         child: Text('OR',
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .bodySmall
                //                 ?.copyWith(color: Colors.white70))),
                //     Flexible(
                //         child: Divider(color: Colors.white.withOpacity(0.10))),
                //     SizedBox(width: 16)
                //   ],
                // ),
                //Row(
                //children: [
                // SizedBox(width: 16),
                // Flexible(
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(
                //         vertical: 6, horizontal: 0),
                //     child: OutlinedButton.icon(
                //         onPressed: _signInWithEmail,
                //         style: ButtonStyle(
                //           backgroundColor: MaterialStatePropertyAll(
                //               Colors.white.withOpacity(0.08)),
                //           foregroundColor:
                //               const MaterialStatePropertyAll(Colors.white),
                //           overlayColor: MaterialStatePropertyAll(
                //               const Color(0xFF22D3EE).withOpacity(0.10)),
                //           side: MaterialStatePropertyAll(BorderSide(
                //               color:
                //                   const Color(0xFF22D3EE).withOpacity(0.70),
                //               width: 1.5)),
                //           shape: MaterialStatePropertyAll(
                //               RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(24))),
                //         ),
                //         icon: const SonaIcon(
                //             icon: SonaIcons.email, color: Colors.white),
                //         label: Text('E-mail')),
                //   ),
                // ),

                // ],
                //),
                Container(
                  height: 260,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (Platform.isAndroid)
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 64),
                                  child: OutlinedButton.icon(
                                      onPressed: _signInWithGoogle,
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.white.withOpacity(0.05)),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                Colors.white),
                                        overlayColor: MaterialStatePropertyAll(
                                            const Color(0xFF22D3EE)
                                                .withOpacity(0.10)),
                                        side: MaterialStatePropertyAll(
                                            BorderSide(
                                                color: const Color(0xFF22D3EE)
                                                    .withOpacity(0.70),
                                                width: 1.5)),
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24))),
                                      ),
                                      icon: const SonaIcon(
                                          icon: SonaIcons.google,
                                          color: Colors.white),
                                      label: Text('Google')),
                                ),
                              ),
                            if (Platform.isIOS)
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 0),
                                  child: OutlinedButton.icon(
                                      onPressed: _signInWithApple,
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.white.withOpacity(0.08)),
                                        foregroundColor:
                                            const MaterialStatePropertyAll(
                                                Colors.white),
                                        overlayColor: MaterialStatePropertyAll(
                                            const Color(0xFF22D3EE)
                                                .withOpacity(0.10)),
                                        side: MaterialStatePropertyAll(
                                            BorderSide(
                                                color: const Color(0xFF22D3EE)
                                                    .withOpacity(0.70),
                                                width: 1.5)),
                                        shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24))),
                                      ),
                                      icon: const SonaIcon(
                                          icon: SonaIcons.apple,
                                          color: Colors.white),
                                      label: Text('Apple ID')),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                                text: S.current.userPhoneNumberPageTermsPrefix),
                            TextSpan(
                                text: S.current.userPhoneNumberPageTermsText,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(context,
                                          MaterialPageRoute<void>(builder: (c) {
                                        return WebView(
                                            url: env.termsOfService,
                                            title:
                                                S.of(context).termsOfService);
                                      }))),
                            TextSpan(
                                text: S.current.userPhoneNumberPageTermsAnd),
                            TextSpan(
                                text: S.current.userPhoneNumberPagePrivacyText,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(context,
                                          MaterialPageRoute<void>(builder: (c) {
                                        return WebView(
                                            url: env.privacyPolicy,
                                            title: S.of(context).privacyPolicy);
                                      }))),
                            TextSpan(
                                text:
                                    S.current.userPhoneNumberPagePrivacySuffix),
                          ]),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Color(0xFFB5B6C8)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
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

  void _signInWithGoogle() async {
    Map<String, dynamic> params = {};
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn.instance;
      await _googleSignIn.initialize(
          serverClientId:
              "972955903429-fe5r0tp9fbuu3mqk94u911iat1coelar.apps.googleusercontent.com");
      //
      if (!GoogleSignIn.instance.supportsAuthenticate()) {
        throw UnsupportedError('GoogleSignIn.authenticate 在当前平台不可用');
      }

      // 先登出当前用户，确保选择账号
      await GoogleSignIn.instance.signOut();

      // 重新认证，让用户选择账号
      GoogleSignInAccount? account = await GoogleSignIn.instance.authenticate();

      final auth = await account.authentication; // 可获取 idToken
      params.addAll({
        'id': account.id,
        'email': account.email,
        'name': account.displayName,
        'token': auth.idToken,
        'code': null
      });
    } catch (e) {
      if (kDebugMode) print('Google sign in error: $e');
    }
    if (params.isNotEmpty) _signInWithOAuth('GOOGLE', params);
  }

  void _signInWithApple() async {
    Map<String, dynamic> params = {};
    try {
      final account = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ]);
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
      final resp = await signInWithOAuth(source: source, params: params);

      if (resp.statusCode == 0 || resp.statusCode == 2) {
        SonaAnalytics.log('reg_$source');
        final token = resp.data['token'];
        ref.read(tokenProvider.notifier).state = token;
        //userToken=token;
        // 未注册
        if (resp.statusCode == 2) {
          if (source == 'APPLE') {
            SonaAnalytics.log(AccountEvent.reg_click_apple.name);
          } else if (source == 'GOOGLE') {
            SonaAnalytics.log(AccountEvent.reg_click_google.name);
          }

          _completeRequiredInfo(name: params['name']);
          return;
        }

        final response = await getMyProfile();

        if (response.statusCode == 0) {
          final profile = MyProfile.fromJson(response.data);

          ///注册成功后，继续注册在fireauth和firestore中进行保存
          await _registerOrLoginUser(params['email'], profile);
          ref.read(myProfileProvider.notifier).update(profile);
          if (!profile.completed) {
            _completeRequiredInfo(name: params['name']);
            return;
          }
          await Future<void>.delayed(const Duration(milliseconds: 200));
          if (source == 'APPLE') {
            SonaAnalytics.log(AccountEvent.reg_apple_login.name);
          } else if (source == 'GOOGLE') {
            SonaAnalytics.log(AccountEvent.reg_google_login.name);
          }

          if (mounted)
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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
      await Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (_) => BaseInfoScreen(
                  name: name, country: findCountryByCode(null))));
    }
  }

  /// 注册或登录用户到 Firebase Auth 和 Firestore
  Future<void> _registerOrLoginUser(String email, MyProfile profile) async {
    try {
      /// firestore中查询用户是否存在
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(profile.id.toString())
          .get();

      if (userDoc.exists) {
        debugPrint('Firestore已存在');
        return;
      }
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          id: profile.id.toString(),
          firstName: profile.name,
          imageUrl: profile.avatar,
        ),
      );
    } catch (e) {
      debugPrint('注册/登录失败: $e');
      rethrow;
    }
  }
}
