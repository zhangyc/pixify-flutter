import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
  final data = await compressImage(bytes);
  final formData = FormData.fromMap({
    'file': MultipartFile.fromBytes(
        data.toList(growable: false),
        filename: '.webp'
    )
  });
  return dio.post(
      '/common/file-upload',
      data: formData
  ).then((resp) => resp.data);
}


Future<Uint8List> compressImage(Uint8List list) async {
  var result = await FlutterImageCompress.compressWithList(
    list,
    minHeight: 800,
    minWidth: 600,
    quality: 80,
    rotate: 0,
    format: CompressFormat.webp,
  );
  return result;
}