import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/providers/env.dart';

import '../http/interceptors/base.dart';

final dioProvider = Provider<Dio>((ref) {
  final token = ref.watch(tokenProvider);
  final baseUrl = ref.read(envProvider);
  final options = BaseOptions(
    connectTimeout: const Duration(milliseconds: 15000),
    receiveTimeout: const Duration(milliseconds: 15000),
    sendTimeout: const Duration(milliseconds: 15000),
    baseUrl: baseUrl,
    headers: {
      'device': Platform.operatingSystem,
      'version': 'v1.0.0',
      'token': token
    }
  );
  final dio = Dio(options);

  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true, logPrint: (i) => log(i.toString())));
  }
  dio.interceptors.add(BaseInterceptor(ref: ref));
  // dio.interceptors.add(TokenInterceptor(ref: ref));

  return dio;
}, dependencies: [tokenProvider]);



///start

final options = BaseOptions(
    connectTimeout: const Duration(milliseconds: 15000),
    receiveTimeout: const Duration(milliseconds: 15000),
    sendTimeout: const Duration(milliseconds: 15000),
    baseUrl: 'http://admin-test.sona.pinpon.fun/api',
    headers: {
      'device': Platform.operatingSystem,
      'version': 'v1.0.0',
      'token': token
    }
);
String get token => appCommonBox.get('token',defaultValue: '');
set token(String token){
  appCommonBox.put('token', token);
}
Dio dio=Dio(options);
Future<HttpResult> post(String path,{Object? data, Map<String, dynamic>? queryParameters,CancelToken? cancelToken}) async{
  Response? resp;
  try{
    resp=await dio.post(path,data: data,queryParameters: queryParameters,cancelToken: cancelToken);
    return HttpResult(resp);
  } catch(e){
    log(e.toString());
    return HttpResult.error(e);

  }
}
class HttpResult{
  bool get isSuccess =>0==statusCode;
  int statusCode=-1;
  dynamic data;
  String message='';
  HttpResult(Response response){
    statusCode=int.tryParse(response.data['code'])??-1;
    data=response.data['data'];
    message=response.data['msg'];
  }
  HttpResult.error(e){
    statusCode=-1;
    data=e;
    message='framework error';
  }
}