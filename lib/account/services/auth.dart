import 'package:dio/dio.dart';

import '../../firebase/sona_firebase.dart';
Future<Response> sendPin({
  required Dio httpClient,
  required String countryCode,
  required String phoneNumber
}) async {
  return httpClient.post(
      '/auth/send-phone-code',
      data: {
        'phonePrefix': countryCode,
        'phone': phoneNumber
      }
  );
}

Future<Response> login({
  required Dio httpClient,
  required String countryCode,
  required String phoneNumber,
  required String pinCode
}) async {
  return httpClient.post(
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