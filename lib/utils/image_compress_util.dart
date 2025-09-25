// lib/core/utils/image_compress_util.dart
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class ImageCompressUtil {
  /// 压缩图片文件
  /// [file] - 原始图片文件
  /// [quality] - 压缩质量 (0-100), 默认 80
  /// [minWidth] - 压缩后最小宽度, 默认 1080
  /// [minHeight] - 压缩后最小高度, 默认 1920
  static Future<File?> compressImage(
    File file, {
    int quality = 80,
    int minWidth = 1080,
    int minHeight = 1920,
  }) async {
    // 如果文件大小小于 200KB，则不进行压缩
    if (file.lengthSync() < 200 * 1024) {
      return file;
    }

    try {
      // 获取临时目录
      final tempDir = await getTemporaryDirectory();
      final targetPath = p.join(
        tempDir.path,
        '${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      // 调用压缩方法
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: quality,
        minWidth: minWidth,
        minHeight: minHeight,
        format: CompressFormat.jpeg, // 推荐使用 jpeg 格式
      );

      print('Original image size: ${file.lengthSync() / 1024} KB');
      if (result != null) {
        print('Compressed image size: ${await result.length() / 1024} KB');
        return File(result.path);
      }
      return null;
    } catch (e) {
      print('Failed to compress image: $e');
      return null;
    }
  }
}
