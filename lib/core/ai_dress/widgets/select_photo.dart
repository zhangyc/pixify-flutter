import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/core/ai_dress/ai_dress_event.dart';
import 'package:sona/core/ai_dress/dislogs.dart';
import 'package:sona/core/ai_dress/widgets/base_dialog_container.dart';
import 'package:sona/utils/global/global.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/dialog/crop_image.dart';
import '../bean/sd_template.dart';

class SelectPhoto extends StatelessWidget {
  const  SelectPhoto({super.key, required this.template});
  final SdTemplate template;
  @override
  Widget build(BuildContext context) {
    return BaseDialogContainer(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text('Photo',style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18
                ),),
                GestureDetector(
                  child: SvgPicture.asset(Assets.svgDislike,width: 40,height: 40,),
                  onTap: (){
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Image.asset(Assets.imagesSnap1,width: 90,height: 90,),
            SizedBox(
              height: 12,
            ),
            Text(S.current.betterQualityMessage,style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: Color(0xff2c2c2c)
            ),),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () async{
                final picker = ImagePicker();
                final file = await picker.pickImage(source: ImageSource.gallery);

                if (file == null) throw Exception('No file');
                if (file.name.toLowerCase().endsWith('.gif')) {
                  Fluttertoast.showToast(msg: 'GIF is not allowed');
                  return;
                }
                Uint8List? bytes = await file.readAsBytes();
                bytes = await cropImage(bytes);
                if (bytes == null) return;

                Navigator.pop(context,bytes);
                // await  showYourPortrait(context, bytes,template);

              },
              child: Container(
                width: 327,
                height: 56,
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(
                //     vertical: 16
                // ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.black), // 底部边框样式
                    top: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                    left: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                    right: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                  ),
                ),
                child: Text(S.current.fromLibrary,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () async{
                Uint8List? u=await showProfilePhotos(context,template);
                Navigator.pop(context,u);
              },
              child: Container(
                width: 327,
                height: 56,
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(
                //     vertical: 16
                // ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.black), // 底部边框样式
                    top: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                    left: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                    right: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                  ),
                ),
                child: Text(S.current.fromProfile,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () async{
                final picker = ImagePicker();
                final file = await picker.pickImage(source: ImageSource.camera);

                if (file == null) throw Exception('No file');
                if (file.name.toLowerCase().endsWith('.gif')) {
                  Fluttertoast.showToast(msg: 'GIF is not allowed');
                  return;
                }
                Uint8List? bytes = await file.readAsBytes();
                bytes = await cropImage(bytes);
                if (bytes == null) return;
                Navigator.pop(context,bytes);
                //await showYourPortrait(context, bytes,template);
              },
              child: Container(
                width: 327,
                height: 56,
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(
                //     vertical: 16
                // ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border(
                    bottom: BorderSide(width: 2.0, color: Colors.black), // 底部边框样式
                    top: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                    left: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                    right: BorderSide(width: 1.0, color: Colors.black), // 底部边框样式
                  ),
                ),
                child: Text(S.current.fromTakeAPhoto,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        )
    );
  }
}
