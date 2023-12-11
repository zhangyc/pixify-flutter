part of './global.dart';

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
        logPrint: (i) => kDebugMode ? log(i.toString()) : null));
  }
  dio.interceptors.add(BaseInterceptor());

  return dio;
}

Dio _dio = _createDioInstance();
Dio get dio => _dio;