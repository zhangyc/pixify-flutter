

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sona/common/env.dart';
import 'package:sona/utils/global/global.dart';

class HttpResult{
  bool get isSuccess =>0==statusCode;
  int statusCode=-1;
  dynamic data;
  // String message='';
  HttpResult(Response response){
    statusCode=response.statusCode??-1;
    data=response.data;
    // message=response.data['msg'];
  }
  HttpResult.error(e){
    statusCode=-1;
    data=e;
    // message='framework error';
  }
}
Future<HttpResult> post(String path,{Object? data, Map<String, dynamic>? queryParameters,CancelToken? cancelToken}) async{
  try{
    Response resp=await dio.post(path,data: data,queryParameters: queryParameters,cancelToken: cancelToken);
    return Future.value(HttpResult(resp));
  } catch(e){
    return Future.value(HttpResult.error(e));

  }
}///start