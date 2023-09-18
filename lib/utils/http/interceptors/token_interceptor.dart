//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sona/account/providers/profile.dart';
// import 'package:sona/account/screens/login.dart';
// import 'package:sona/core/providers/token.dart';
// import 'package:sona/utils/providers/dio.dart';
//
// import '../../../core/providers/navigator_key.dart';
//
// class TokenInterceptor extends Interceptor{
//   TokenInterceptor({required this.ref});
//   final Ref ref;
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//
//     if(err.response?.statusCode ==401){
//       Navigator.pushAndRemoveUntil(ref.watch(navigatorKeyProvider).currentContext!, MaterialPageRoute(builder: (c){
//         return LoginScreen();
//       }), (route) => false);
//       //ref.watch(navigatorKeyProvider).
//     }
//     super.onError(err, handler);
//   }
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     print(response);
//
//     super.onResponse(response, handler);
//   }
// }
