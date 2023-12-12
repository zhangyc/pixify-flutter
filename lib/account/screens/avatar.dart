import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/core/travel_wish/models/country.dart';

import '../../utils/dialog/crop_image.dart';
import 'location.dart';


class AvatarScreen extends StatefulWidget {
  const AvatarScreen({
    super.key,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.country
  });
  final String name;
  final DateTime birthday;
  final Gender gender;
  final SonaCountry country;

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
                  'Upload\nYour portrait',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(height: 24),
              if (_avatar == null) Container(
                width: 316,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 200,
                          padding: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              image: DecorationImage(
                                  image: AssetImage(widget.gender == Gender.male ? 'assets/images/human_portrait.png' : 'assets/images/girl_portrait.jpeg'),
                                  fit: BoxFit.cover
                              )
                          ),
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            foregroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Theme.of(context).primaryColor, width: 2)
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF0DF892),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Icon(Icons.check, size: 16),
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          width: 150,
                          height: 200,
                          padding: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 2),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              image: DecorationImage(
                                  image: AssetImage(widget.gender == Gender.male ? 'assets/images/pet_portrait.png' : 'assets/images/cat_portrait.jpeg'),
                                  fit: BoxFit.cover
                              )
                          ),
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            foregroundDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Theme.of(context).primaryColor, width: 2)
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFEA4710),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Icon(Icons.close, size: 16),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'A good portrait really helps you get more matches, please use a real portrait image',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                ),
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
      country: widget.country
    )));
  }
}