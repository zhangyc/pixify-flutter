import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/providers/dio.dart';

import '../../../account/screens/login.dart';
import '../../../core/providers/navigator_key.dart';


class BaseInterceptor extends Interceptor {
  BaseInterceptor({required this.ref});
  final Ref ref;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method.toUpperCase() == 'POST') {
      if (options.data is FormData) {
        options.headers.addAll({HttpHeaders.contentTypeHeader: Headers.formUrlEncodedContentType});
      } else {
        options.headers.addAll({HttpHeaders.contentTypeHeader: Headers.jsonContentType});
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data['code'] == '0') {
      response.data = response.data['data'];
    } else if (response.data['code'] == '10040') {
      ref.read(tokenProvider.notifier).state = null;
    } else if(response.data['code']=="10030"){
      ref.read(tokenProvider.notifier).state = null;

      // Navigator.pushAndRemoveUntil(ref.watch(navigatorKeyProvider).currentContext!, MaterialPageRoute(builder: (c){
      //   return LoginScreen();
      // }), (route) => false);
      //ref.read(dioProvider).close();
    }else {
      print(response);
      var e = CustomDioException(requestOptions: response.requestOptions, code: response.data['code']);
      throw e;

    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final customErr = CustomDioException(requestOptions: err.requestOptions, code: err.response?.statusCode.toString());
    super.onError(customErr, handler);
  }
}

class CustomDioException extends DioException {
  CustomDioException({required super.requestOptions, this.code});
  final String? code;
}