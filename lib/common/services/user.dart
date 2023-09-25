import 'package:dio/dio.dart';
import 'package:sona/utils/global/global.dart';

Future<Response> fetchUserInfo({
  required int id
}) async {
  return dio.post(
      '/user/find-detail',
      data: {'id': id}
  );
}