import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sona/core/ai_dress/widgets/add_two_image.dart';
import 'package:sona/core/ai_dress/widgets/profile_photos.dart';
import 'package:sona/core/ai_dress/widgets/select_photo.dart';
import 'package:sona/core/ai_dress/widgets/your_portrait.dart';

import 'bean/sd_template.dart';

Future<Uint8List?> showSelectPhoto(BuildContext context,SdTemplate template){
  return showModalBottomSheet<Uint8List?>(context: context, builder: (c){
     return SelectPhoto(template: template,);
   });
}
Future showDuoSnapSelectPhoto(BuildContext context,SdTemplate template){
  return showModalBottomSheet<String?>(context: context, builder: (c){
    return AddTwoImage(template: template,);
  },
    isScrollControlled: true
  );
}
Future showYourPortrait(BuildContext context,Uint8List image,SdTemplate template){
  return showModalBottomSheet<String?>(context: context, builder: (c){
    return YourPortrait(image: image,template: template,);
  });
}
Future<Uint8List?> showProfilePhotos(BuildContext context,SdTemplate template){
  return showModalBottomSheet<Uint8List?>(context: context, builder: (c){
    return ProfilePhotos(template: template,);
  });
}