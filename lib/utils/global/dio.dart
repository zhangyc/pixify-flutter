part of './global.dart';

final dio = _createDioInstance();

Dio _createDioInstance() {
  final options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 15000),
      receiveTimeout: const Duration(milliseconds: 15000),
      sendTimeout: const Duration(milliseconds: 15000),
      baseUrl: env.apiServer,
      headers: {
        'device': Platform.operatingSystem,
        'version': 'v1.0.0',
      }
  );
  final dio = Dio(options);

  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        logPrint: (i) => kDebugMode?log(i.toString()):{}));
  }
  dio.interceptors.add(BaseInterceptor());
  // dio.interceptors.add(TokenInterceptor(ref: ref));

  return dio;
}
