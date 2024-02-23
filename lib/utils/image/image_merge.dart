// import 'dart:ui' as ui;
//
// import 'package:flutter/services.dart';
//
// Future<void> _loadImages() async {
//   ByteData leftImageData = await rootBundle.load('assets/left_image.png'); // 替换为您的左侧图片路径
//   Uint8List leftImageList = leftImageData.buffer.asUint8List();
//   _leftImage = await decodeImageFromList(leftImageList);
//
//   ByteData rightImageData = await rootBundle.load('assets/right_image.png'); // 替换为您的右侧图片路径
//   Uint8List rightImageList = rightImageData.buffer.asUint8List();
//   _rightImage = await decodeImageFromList(rightImageList);
//
//   _mergeImages();
// }
// Future<void> _mergeImages() async {
//   ui.PictureRecorder recorder = ui.PictureRecorder();
//   ui.Canvas canvas = ui.Canvas(recorder);
//
//   // 在 canvas 上绘制左侧图片
//   canvas.drawImage(_leftImage, Offset.zero, ui.Paint());
//
//   // 在 canvas 上绘制右侧图片
//   canvas.drawImage(_rightImage, Offset(_leftImage.width.toDouble(), 0), ui.Paint());
//
//   // 完成录制
//   ui.Picture picture = recorder.endRecording();
//
//   // 转换为 ui.Image
//   ui.Image mergedImage = await picture.toImage((_leftImage.width + _rightImage.width).toInt(), _leftImage.height.toInt());
//
//   // 将合并后的图像保存到本地文件或分享
//   _saveImageToFile(mergedImage);
//
// }
// // 保存合并后的图像到本地文件
// Future<void> _saveImageToFile(ui.Image image) async {
//   // 将合并后的图像编码为 PNG
//   ui.Codec codec = await ui.instantiateImageCodec(ui.encodePng(image));
//   List<int> byteList = await codec.getNextFrame().then((frame) => frame!.buffer.asUint8List());
//
//   // TODO: 将图像保存到本地文件或分享
// }