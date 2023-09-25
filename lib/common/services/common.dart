import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:sona/utils/global/global.dart';

Future<Response> fetchAvailableInterests() async {
  return dio.post(
    '/common/dict',
    data: {
      'type': 'INTEREST'
    }
  );
}

/// * return url
Future<String> uploadFile({
  required Uint8List bytes,
  required String filename
}) async {
  final formData = FormData.fromMap({
    'file': MultipartFile.fromBytes(
        bytes.toList(growable: false),
        filename: filename
    )
  });
  return dio.post(
      '/common/file-upload',
      data: formData
  ).then((resp) => resp.data);
}