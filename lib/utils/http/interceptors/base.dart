import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/timer/debounce.dart';
import 'package:sona/utils/timer/throttle.dart';


class BaseInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      'token': token,
      'locale': profile?.locale
    });
    if (options.method.toUpperCase() == 'POST') {
      if (options.data is FormData) {
        options.headers.addAll({HttpHeaders.contentTypeHeader: Headers.formUrlEncodedContentType});
      } else {
        options.headers.addAll({HttpHeaders.contentTypeHeader: Headers.jsonContentType});
      }
    }
    return handler.next(options);
    // super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      if (response.data['code'] == '10030' || response.data['code'] == '10040') {
        _onTokenInvalid();
      }
      response.statusCode = int.parse(response.data['code']);
      response.data = response.data['data'];
    }
    return handler.next(response);
    //super.onResponse(response, handler);
  }

  void _onTokenInvalid() {
    Throttle(const Duration(seconds: 30)).run(_clearAndLogin);
  }

  void _clearAndLogin() {
    token = null;
    kvStore.remove(profileKey);
    navigatorKey.currentState?.pushNamedAndRemoveUntil('login', (route) => false);
  }
}