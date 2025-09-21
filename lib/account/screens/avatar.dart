import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/gender.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/utils/face_detection/detection.dart';
import 'package:sona/utils/global/global.dart';

import '../../generated/l10n.dart';
import '../../utils/dialog/crop_image.dart';
import '../../utils/toast/flutter_toast.dart';
import '../event/account_event.dart';
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
      extendBody: false,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: MediaQuery.of(context).viewPadding.top + 16,
              bottom: 16
          ),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  S.current.uploadYourPhoto,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(height: 36),
              if (_avatar == null) DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(24),
                color: Color(0xFFB7B7B7),
                dashPattern: [5, 5],
                strokeWidth: 1.2,
                padding: EdgeInsets.zero,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _getPhotoAndUpload(ImageSource.gallery),
                  child: Container(
                    width: 150,
                    height: 200,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F3F3),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    clipBehavior: Clip.antiAlias,
                    alignment: Alignment.center,
                    child: Icon(Icons.add, size: 32, color: Theme.of(context).primaryColor),
                  ),
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
              SizedBox(height: 16),
              Text(S.current.uploadYourPhotoHint, style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_avatar == null) OutlinedButton(
                onPressed: () => _getPhotoAndUpload(ImageSource.camera),
                child: Text(S.current.userAvatarOptionCamera)
            ) else FilledButton(
                onPressed: _next,
                child: Text(S.current.buttonNext)
            ),
            SizedBox(height: 16),
            if (_avatar == null) FilledButton(
                onPressed: () => _getPhotoAndUpload(ImageSource.gallery),
                child: Text(S.current.userAvatarOptionGallery)
            ) else TextButton(
                onPressed: _change,
                child: Text(S.current.buttonChange)
            ),
          ],
        ),
      ),
    );
  }


  void _getPhotoAndUpload(ImageSource source) async {
    if(source==ImageSource.camera){
      SonaAnalytics.log(AccountEvent.reg_photo_take.name);

    }else if(source==ImageSource.gallery){
      SonaAnalytics.log(AccountEvent.reg_photo_album.name);
    }
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
    } finally {
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
    SonaAnalytics.log(AccountEvent.reg_photo_next.name);

  }
}