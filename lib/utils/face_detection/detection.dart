import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:sona/utils/toast/flutter_toast.dart';
import 'package:path_provider/path_provider.dart';
Future<bool> faceDetection(String path) async {
  return true;

  // final options = FaceDetectorOptions(
  //     enableClassification: false,
  //     enableContours: false,
  //     enableLandmarks: false,
  //     enableTracking: false,
  //     performanceMode: FaceDetectorMode.accurate
  // );
  // final faceDetector = FaceDetector(options: options);
  // final List<Face> faces = await faceDetector.processImage(InputImage.fromFilePath(path));
  // if(faces.isEmpty){
  //   // Fluttertoast.showToast(msg: 'Please upload photos according to the recommended standards.');
  //   return false;
  // }else {
  //   return true;
  // }
}
Future<bool> faceDetectionByByte(Uint8List image) async {
  return true;
  // final options = FaceDetectorOptions(
  //     enableClassification: false,
  //     enableContours: false,
  //     enableLandmarks: false,
  //     enableTracking: false,
  //     performanceMode: FaceDetectorMode.accurate
  // );
  // final faceDetector = FaceDetector(options: options);
  // // Directory directory=await getTemporaryDirectory();
  // // String path='${directory.path}/face/temp.png';
  //
  // final List<Face> faces = await faceDetector.processImage(InputImage.fromBytes(bytes: image,metadata: InputImageMetadata(
  //   size: Size(600, 800), rotation: InputImageRotation.rotation0deg, format: InputImageFormat.bgra8888, bytesPerRow: 600,
  // )));
  // if(faces.isEmpty){
  //   // Fluttertoast.showToast(msg: 'Please upload photos according to the recommended standards.');
  //   return false;
  // }else {
  //   return true;
  // }
}