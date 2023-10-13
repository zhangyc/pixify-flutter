import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/common/widgets/button/next.dart';

import '../../common/services/common.dart';

class ConfirmPhotoScreen extends StatefulWidget {
  const ConfirmPhotoScreen({super.key, required this.bytes});
  final Uint8List bytes;

  @override
  State<StatefulWidget> createState() => _ConfirmPhotoState();
}

class _ConfirmPhotoState extends State<ConfirmPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Image.memory(
              widget.bytes,
              height: MediaQuery.of(context).size.height / 2,
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                child: NextButton(
                  size: ButtonSize.medium,
                  loadingWhenAsyncAction: true,
                  onTap: _onConfirm,
                ),
              ),
            ),
            Expanded(child: Container()),
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Choose Another')),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Future _onConfirm() async {
    final value = await uploadImage(bytes: widget.bytes);
    if (mounted) Navigator.pop(context, value);
  }
}