import 'package:dio/dio.dart';
import 'package:sona/utils/global/global.dart';

Future<Response> report({
  required int type,
  required int id,
  required int reason
}) async {
  return dio.post(
      '/report/create',
      data: {
        'sourceType': type,
        'sourceId': id,
        'reasonId': reason
      }
  );
}