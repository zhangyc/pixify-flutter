import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
Future<bool> faceDetection(String path) async {
  final options = FaceDetectorOptions(
      enableClassification: true,
      enableContours: true,
      enableLandmarks: true,
      enableTracking: true
  );
  final faceDetector = FaceDetector(options: options);
  final List<Face> faces = await faceDetector.processImage(InputImage.fromFilePath(path));
  if(faces.isEmpty){
    // Fluttertoast.showToast(msg: 'Please upload photos according to the recommended standards.');
    return false;
  }else {
    return true;
  }
}
