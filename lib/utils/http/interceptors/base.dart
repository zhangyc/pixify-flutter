import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sona/utils/global/global.dart';


class BaseInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'token': token});
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
        token = null;
      } else if(response.data['code'] == '10030') {
        token = null;
      }
      response.statusCode = int.parse(response.data['code']);
      response.data = response.data['data'];
    }
    super.onResponse(response, handler);
  }
}