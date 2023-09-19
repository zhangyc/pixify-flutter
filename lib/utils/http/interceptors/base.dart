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
    if (response.statusCode == 200) {
      if (response.data['code'] == '10040') {
        ref.read(tokenProvider.notifier).state = null;
      } else if(response.data['code'] == '10030') {
        ref.read(tokenProvider.notifier).state = null;
      }
      response.statusCode = int.parse(response.data['code']);
      response.data = response.data['data'];
      super.onResponse(response, handler);
    }
    super.onResponse(response, handler);
  }
}