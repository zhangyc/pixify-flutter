import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Future<ui.Image> loadImage(String url) async {
  FileInfo fileInfo=await DefaultCacheManager().downloadFile(url);
  Uint8List image =await fileInfo.file.readAsBytes();
  return tinypng(image);
}
Future<ui.Image> tinypng(Uint8List bytes) async {
  // copy from decodeImageFromList of package:flutter/painting.dart
  final codec = await ui.instantiateImageCodec(bytes);
  final frameInfo = await codec.getNextFrame();
  return frameInfo.image;
}
Future<Uint8List?> mergeImages(ui.Image left,ui.Image right) async {
  ui.PictureRecorder recorder = ui.PictureRecorder();
  ui.Canvas canvas = ui.Canvas(recorder);

  // 在 canvas 上绘制左侧图片
  canvas.drawImage(left, Offset.zero, ui.Paint());

  // 在 canvas 上绘制右侧图片
  canvas.drawImage(right, Offset(left.width.toDouble(), 0), ui.Paint());

  // 完成录制
  ui.Picture picture = recorder.endRecording();

  // 转换为 ui.Image
  ui.Image mergedImage = await picture.toImage((left.width + right.width).toInt(), left.height.toInt());
  ByteData? byteData=await mergedImage.toByteData();
  // 将合并后的图像保存到本地文件或分享
  return byteData?.buffer.asUint8List();
}
