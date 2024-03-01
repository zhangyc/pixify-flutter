import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../../account/providers/profile.dart';
import '../../../account/services/info.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/dialog/crop_image.dart';
import '../../../utils/global/global.dart';
import '../util/event.dart';
class UploadPortrait extends StatelessWidget {
  const UploadPortrait({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        List<ProfilePhoto> fixedLengthList = [ProfilePhoto.idle(-1, ''),ProfilePhoto.idle(-1, ''),ProfilePhoto.idle(-1, '')];
        for(int i=0;i<ref.watch(myProfileProvider)!.photos.length;i++){
          fixedLengthList[i]=ref.watch(myProfileProvider)!.photos[i];
        }
        return Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7
          ),
          padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: MediaQuery.of(context).padding.bottom + 16),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 2,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: Color(0xFF2C2C2C),
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            shadows: [
              BoxShadow(
                color: Color(0xFF2C2C2C),
                blurRadius: 0,
                offset: Offset(0, -4),
                spreadRadius: 0,
              )
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.current.boostYourAppeal,style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18
                  ),),
                  GestureDetector(child: SvgPicture.asset(Assets.svgDislike,width: 40,height: 40,),
                    onTap: (){
                      SonaAnalytics.log(MatchEvent.match_avatar_cancel.name);
                      Navigator.pop(context);
                    },)
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Text(S.current.morePhotosMoreCharm,style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14
              ),),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: fixedLengthList.map((e){
                    if(e.id==-1){
                      return GestureDetector(child: Image.asset(Assets.imagesAddPhoto,width: 104,height: 140,),
                        onTap: () async {
                          SonaAnalytics.log(MatchEvent.match_avatar_up.name);

                          final source = await showActionButtons(context: context, options: {
                            S.current.photoFromGallery: ImageSource.gallery,
                            S.current.photoFromCamera: ImageSource.camera
                          });
                          if (source == null) throw Exception('No source');
                          final picker = ImagePicker();
                          final file = await picker.pickImage(source: source);

                          if (file == null) throw Exception('No file');
                          ///todo 人脸检测
                          ///faceDetection(file.path);

                          if (file.name.toLowerCase().endsWith('.gif')) {
                            Fluttertoast.showToast(msg: 'GIF is not allowed');
                            return;
                          }
                          Uint8List? bytes = await file.readAsBytes();
                          bytes = await cropImage(bytes);
                          if (bytes == null) return;
                          await addPhoto(bytes: bytes, filename: file.name);
                          ref.read(myProfileProvider.notifier).refresh();
                        },
                      );
                    }else {
                      return Container(child: CachedNetworkImage(imageUrl: e.url),decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24)
                      ),
                        clipBehavior: Clip.antiAlias,
                        width: 104,height: 140,
                      );
                    }
                  }).toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
