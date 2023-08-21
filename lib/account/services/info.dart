import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/account/models/user_info.dart';

Future<Response> updateMyInfo({
  required Dio httpClient,
  String? name,
  Gender? gender,
  DateTime? birthday,
  Set<String>? interests,
  String? avatar
}) async {
  return httpClient.post(
      '/user/update',
      data: {
        'nickname': name,
        'gender': gender?.index,
        'birthday': birthday?.toBirthdayString(),
        'interest': interests?.join(','),
        'imageUrl': avatar
      }
  );
}

Future<MyInfo> getMyInfo({
  required Dio httpClient,
}) async {
  final resp = await httpClient.post(
      '/user/find-myself'
  );
  try {
    final d = MyInfo.fromJson(resp.data);
    return d;
  } catch(e) {
    debugPrint(e.toString());
    rethrow;
  }
}

/// * return url
Future<String> addPhoto({
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
  ).then((resp) => resp.data['attachmentUrl']);
}