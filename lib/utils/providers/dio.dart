import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/http/interceptors/token_interceptor.dart';
import 'package:sona/utils/providers/env.dart';

import '../http/interceptors/base.dart';

final dioProvider = Provider<Dio>((ref) {
  final token = ref.watch(tokenProvider);
  final baseUrl = ref.watch(envProvider);
  final options = BaseOptions(
    connectTimeout: const Duration(milliseconds: 25000),
    receiveTimeout: const Duration(milliseconds: 25000),
    sendTimeout: const Duration(milliseconds: 25000),
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
});