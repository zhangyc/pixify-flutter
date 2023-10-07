

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sona/utils/global/global.dart';

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
Future<HttpResult> post(String path,{Object? data, Map<String, dynamic>? queryParameters,CancelToken? cancelToken}) async{
  try{
    Response resp=await _dio.post(path,data: data,queryParameters: queryParameters,cancelToken: cancelToken);
    return Future.value(HttpResult(resp));
  } catch(e){
    log(e.toString());
    return HttpResult.error(e);

  }
}///start

final options = BaseOptions(
    connectTimeout: const Duration(milliseconds: 15000),
    receiveTimeout: const Duration(milliseconds: 15000),
    sendTimeout: const Duration(milliseconds: 15000),
    baseUrl: 'https://admin-test.sona.pinpon.fun/api',
    headers: {
      'device': Platform.operatingSystem,
      'version': 'v1.0.0',
      'token': userToken
    }
);

String get userToken => appCommonBox.get('token',defaultValue: '');
set userToken(String token){
  appCommonBox.put('token', token);
}

Dio _dio=Dio(options);