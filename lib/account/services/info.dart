import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/account/models/user_info.dart';

Future<Response> updateMyInfo({
  required Dio httpClient,
  String? name,
  Gender? gender,
  DateTime? birthday,
  Set<String>? interests,
  String? avatar,
  String? bio,
  Position? position
}) async {
  return httpClient.post(
      '/user/update',
      data: {
        'nickname': name,
        'gender': gender?.index,
        'birthday': birthday?.toBirthdayString(),
        'interest': interests?.join(','),
        'imageUrl': avatar,
        'description': bio,
        'longitude': position?.longitude,
        'latitude': position?.latitude
      }
  );
}

Future<MyProfile> getMyInfo({
  required Dio httpClient,
}) async {
  final resp = await httpClient.post(
      '/user/find-myself'
  );
  try {

    final d = MyProfile.fromJson(resp?.data);
    return d;
  } catch(e) {
    debugPrint('get-my-info-error: ${e.toString()}');
    rethrow;
  }
}

Future<Response> addPhoto({
  required Dio httpClient,
  required Uint8List bytes,
  required String filename
}) async {
  final formData = FormData.fromMap({
    'file': MultipartFile.fromBytes(
      bytes.toList(growable: false),
      filename: filename
    )
  });

  return httpClient.post(
    '/user/upload-image',
    data: formData
  );
}

Future<Response> removePhoto({
  required Dio httpClient,
  required int photoId
}) async {
  return httpClient.post(
    '/user/delete-image',
    data: {'id': photoId}
  );
}

Future<Response> updatePhotoSorts({
  required Dio httpClient,
  required data
}) async {
  return httpClient.post(
      '/user/update-image-sort',
      data: data
  );
}