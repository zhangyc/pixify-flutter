import 'package:dio/dio.dart';
import 'package:sona/utils/global/global.dart';

Future<Response> fetchLikedMeList() async {
  return dio.post(
    '/user/friend/find-like-me'
  );
}
