import 'package:dio/dio.dart';

Future<Response> fetchAvailableInterests({
  required Dio httpClient,
}) async {
  return httpClient.post(
    '/common/dict',
    data: {
      'type': 'INTEREST'
    }
  );
}