import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/gender.dart';

import '../../utils/dialog/crop_image.dart';
import 'location.dart';


class AvatarScreen extends StatefulWidget {
  const AvatarScreen({
    super.key,
    required this.name,
    required this.birthday,
    required this.gender
  });
  final String name;
  final DateTime birthday;
  final Gender gender;

  @override
  State<StatefulWidget> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {

  Uint8List? _avatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: false,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: MediaQuery.of(context).viewPadding.top + 16,
              bottom: 16
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Your portrait',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(height: 24),
              if (_avatar == null) Container(
                width: 150,
                height: 200,
                padding: const EdgeInsets.all(10),
                decoration: ShapeDecoration(
                  color: Color(0xFFF6F3F3),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFB6B6B6)),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Icon(Icons.add)
              ) else Container(
                  width: 150,
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    image: DecorationImage(
                      image: MemoryImage(_avatar!),
                      fit: BoxFit.cover
                    )
                  ),
              ),
              SizedBox(height: 24),
              if (_avatar == null) FilledButton(
                  onPressed: () => _getPhotoAndUpload(ImageSource.gallery),
                  child: Text('From library')
              ) else FilledButton(
                  onPressed: _next,
                  child: Text('Next')
              ),
              SizedBox(height: 16),
              if (_avatar == null) OutlinedButton(
                  onPressed: () => _getPhotoAndUpload(ImageSource.camera),
                  child: Text('Take a Photo')
              ) else TextButton(
                  onPressed: _change,
                  child: Text('Change')
              ),
              // Spacer()
            ],
          ),
        ),
      ),
    );
  }

  void _getPhotoAndUpload(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(source: source);
      if (file == null) throw Exception('No file');
      if (file.name.toLowerCase().endsWith('.gif')) {
        Fluttertoast.showToast(msg: 'GIF is not allowed');
        throw Error();
      }
      Uint8List? bytes = await file.readAsBytes();
      bytes = await cropImage(bytes);
      if (bytes == null) {
        throw Exception('No file');
      }
      if (mounted) {
        setState(() {
          _avatar = bytes;
        });
      }
    } catch (e) {
      //
      if (kDebugMode) print(e);
    }
  }

  void _change() {
    setState(() {
      _avatar = null;
    });
  }

  void _next() {
    if (_avatar == null) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LocationScreen(
      name: widget.name,
      birthday: widget.birthday,
      gender: widget.gender,
      avatar: _avatar!,
    )));
  }
}