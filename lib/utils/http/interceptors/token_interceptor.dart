import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sona/account/screens/auth_landing.dart';
import 'package:sona/utils/global/global.dart';

class TokenInterceptor extends Interceptor{
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if(response.statusCode == 401){
      navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(builder: (c){
        return AuthLandingScreen();
      }), (route) => false);
      //ref.watch(navigatorKeyProvider).
    }
    super.onResponse(response, handler);
  }
}
