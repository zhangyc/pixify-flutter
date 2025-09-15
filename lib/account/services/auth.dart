import 'package:dio/dio.dart';
import 'package:sona/utils/global/global.dart';

import '../../firebase/sona_firebase.dart';
Future<Response> sendSMSPin({
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

Future<Response> sendEmailPin({
  required String email,
}) async {
  return dio.post(
      '/auth/send-email-code',
      data: {
        'email': email,
      }
  );
}

Future<Response> signInWithPhone({
  required String countryCode,
  required String phoneNumber,
  required String pinCode
}) async {
  return dio.post(
      '/v2/auth/login-phone-code',
      data: {
        'phonePrefix': countryCode,
        'phone': phoneNumber,
        'code': pinCode,
        'deviceToken': deviceToken,
        'timezone':'${DateTime.now().timeZoneOffset.inHours}'
      }..removeWhere((key, value) => value==null)
  );
}

Future<Response> signInWithEmail({
  required String email,
  required String pinCode
}) async {
  return dio.post(
      '/auth/login-email-code',
      data: {
        'email': email,
        'code': pinCode,
        'deviceToken': deviceToken,
        'timezone':'${DateTime.now().timeZoneOffset.inHours}'
      }..removeWhere((key, value) => value==null)
  );
}

Future<Response> signInWithOAuth({
  required String source,
  required Map<String, dynamic> params
}) async {
  return dio.post(
      '/auth/ext-login/login',
      data: params..addAll({
        'loginType': source,
        'deviceToken': deviceToken,
        'timezone':'${DateTime.now().timeZoneOffset.inHours}'
      })..removeWhere((key, value) => value==null)
  );
}