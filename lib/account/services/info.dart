import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/locale/locale.dart';

import '../../common/services/common.dart';


/// country 只可以改一次，注册时
Future<Response> updateMyProfile({
  String? name,
  Gender? gender,
  DateTime? birthday,
  Set<String>? interests,
  String? avatar,
  String? bio,
  Position? position,
  SonaLocale? locale,
  String? country
}) async {
  return dio.post(
      '/user/update',
      data: {
        'nickname': name,
        'gender': gender?.index,
        'birthday': birthday?.toBirthdayString(),
        'interest': interests?.join(','),
        'imageUrl': avatar,
        'description': bio,
        'longitude': position?.longitude,
        'latitude': position?.latitude,
        'lang': locale?.locale.toLanguageTag(),
        'nation': country
      }
  );
}

Future<Response> getMyProfile() async {
  return dio.post(
    '/user/find-myself'
  );
}

Future<Response> addPhoto({
  required Uint8List bytes,
  required String filename
}) async {
  final data = await compressImage(bytes);
  final formData = FormData.fromMap({
    'file': MultipartFile.fromBytes(
      data.toList(growable: false),
      filename: '.webp'
    )
  });

  return dio.post(
    '/user/upload-image',
    data: formData
  );
}

Future<Response> removePhoto({
  required int photoId
}) async {
  return dio.post(
    '/user/delete-image',
    data: {'id': photoId}
  );
}

Future<Response> updatePhotoSorts({
  required data
}) async {
  return dio.post(
      '/user/update-image-sort',
      data: data
  );
}

Future<Response> deleteAccount() async {
  return dio.post(
      '/user/delete'
  );
}