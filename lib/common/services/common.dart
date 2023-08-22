import 'dart:typed_data';

import 'package:dio/dio.dart';

Future<Response> fetchAvailableInterests({
  required Dio httpClient,
}) async {
  return httpClient.post(
    '/common/dict',
    data: {
      'type': 'INTEREST'
    }
  );
}

/// * return url
Future<String> uploadFile({
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
      '/common/file-upload',
      data: formData
  ).then((resp) => resp.data);
}