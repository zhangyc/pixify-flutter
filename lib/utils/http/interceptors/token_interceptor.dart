import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/screens/login.dart';
import 'package:sona/utils/global/global.dart';

class TokenInterceptor extends Interceptor{
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response?.statusCode ==401){
      Navigator.pushAndRemoveUntil(navigatorKey.currentContext!, MaterialPageRoute(builder: (c){
        return LoginScreen();
      }), (route) => false);
      //ref.watch(navigatorKeyProvider).
    }
    super.onResponse(response, handler);
  }
}
