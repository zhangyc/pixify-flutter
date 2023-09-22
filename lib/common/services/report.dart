import 'package:dio/dio.dart';

Future<Response> report({
  required Dio httpClient,
  required int type,
  required int id,
  required int reason
}) async {
  return httpClient.post(
      '/report/create',
      data: {
        'sourceType': type,
        'sourceId': id,
        'reasonId': reason
      }
  );
}