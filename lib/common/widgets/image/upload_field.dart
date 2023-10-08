import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadField extends StatefulWidget {
  const UploadField({
    super.key,
    required this.width,
    required this.height,
    required this.onChange
  });
  final double width;
  final double height;
  final void Function(XFile) onChange;

  @override
  State<StatefulWidget> createState() => _UploadFieldState();
}

class _UploadFieldState extends State<UploadField> {
  XFile? _file;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: widget.width,
        height: widget.height,
        child: _file == null
            ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.width / 8),
                border: Border.all(color: Colors.grey)
              ),
              child: Icon(Icons.add, size: widget.width / 3)
            )
            : Image.file(File(_file!.path), fit: BoxFit.contain),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;
    if (file.name.toLowerCase().endsWith('.gif')) {
      Fluttertoast.showToast(msg: 'Please select a screenshot.');
      return;
    }
    if (mounted) {
      setState(() {
        _file = file;
      });
      widget.onChange(file);
    }
  }
}