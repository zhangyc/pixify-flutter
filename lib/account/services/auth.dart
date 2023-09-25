import 'package:dio/dio.dart';
import 'package:sona/utils/global/global.dart';

import '../../firebase/sona_firebase.dart';
Future<Response> sendPin({
  required String countryCode,
  required String phoneNumber
}) async {
  return dio.post(
      '/auth/send-phone-code',
      data: {
        'phonePrefix': countryCode,
        'phone': phoneNumber
      }
  );
}

Future<Response> login({
  required String countryCode,
  required String phoneNumber,
  required String pinCode
}) async {
  return dio.post(
      '/auth/login-phone-code',
      data: {
        'phonePrefix': countryCode,
        'phone': phoneNumber,
        'code': pinCode,
        'deviceToken': deviceToken,
        'timezone':'${DateTime.now().timeZoneOffset.inHours}'
      }..removeWhere((key, value) => value==null)
  );
}