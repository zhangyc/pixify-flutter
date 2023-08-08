import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/utils/providers/env.dart';

final dioProvider = Provider<Dio>((ref) {
  final token = ref.watch(tokenProvider);
  final baseUrl = ref.watch(envProvider);
  final options = BaseOptions(
    connectTimeout: const Duration(milliseconds: 25000),
    receiveTimeout: const Duration(milliseconds: 25000),
    sendTimeout: const Duration(milliseconds: 25000),
    baseUrl: baseUrl,
    headers: {
      'app': 'sona',
      'token': token
    }
  );
  final dio = Dio(options);
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  return dio;
});