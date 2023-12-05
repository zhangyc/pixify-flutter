import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sona/utils/global/global.dart';

Future<Uint8List?> cropImage(Uint8List data) {
  return navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => _CropImageScreen(data: data)));
}

class _CropImageScreen extends StatefulWidget {
  const _CropImageScreen({super.key, required this.data});
  final Uint8List data;

  @override
  State<StatefulWidget> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<_CropImageScreen> {

  final _controller = CropController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          if (didPop) return;
          EasyLoading.dismiss();
        },
        child: Crop(
          image: widget.data,
          controller: _controller,
          onCropped: (image) {
            // do something with image, ex: upload to Firebase storage
            EasyLoading.dismiss();
            Navigator.of(context).pop(image);
          },
          aspectRatio: 3 / 4,
          // initialSize: 0.5,
          // initialArea: Rect.fromLTWH(240, 212, 800, 600),
          // initialAreaBuilder: (rect) => Rect.fromLTRB(
          //     rect.left + 24, rect.top + 32, rect.right - 24, rect.bottom - 32
          // ),
          // withCircleUi: true,
          baseColor: Colors.blue.shade900,
          maskColor: Colors.white.withAlpha(100),
          radius: 20,
          onMoved: (newRect) {
            // do something with current cropping area.
          },
          onStatusChanged: (status) {
            // do something with current CropStatus
          },
          cornerDotBuilder: (size, edgeAlignment) => DotControl(color: Theme.of(context).primaryColor),
          interactive: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EasyLoading.show();
          _controller.crop();
        },
        child: const Icon(Icons.crop),
      )
    );
  }
}

