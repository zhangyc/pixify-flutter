import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/ai_dress/dislogs.dart';
import 'package:sona/core/ai_dress/widgets/base_dialog_container.dart';

import '../../../account/models/my_profile.dart';
import '../../../generated/assets.dart';
import '../bean/sd_template.dart';

class ProfilePhotos extends StatelessWidget {
  const ProfilePhotos({super.key, required this.template});
  final SdTemplate template;
  @override
  Widget build(BuildContext context) {
    return BaseDialogContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Profile',style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18
              ),),
              GestureDetector(
                child: SvgPicture.asset(Assets.svgDislike),
                onTap: (){
                  Navigator.pop(context);
                },
              )
            ],
          ),
          Expanded(
            child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
               return GridView.builder(
                 itemCount: ref.read(myProfileProvider)?.photos.length??0, // 子项数量
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   childAspectRatio: 0.75,
                   crossAxisCount: 2, // 每行显示的子项数量
                   mainAxisSpacing: 10.0, // 主轴方向（垂直方向）的间距
                   crossAxisSpacing: 10.0, // 交叉轴方向（水平方向）的间距
                 ),
                 itemBuilder: (BuildContext context, int index) {
                   ProfilePhoto? p=ref.read(myProfileProvider)?.photos[index];
                   if(p==null){
                     return Container();
                   }
                   return GestureDetector(
                     child:p.url==null?Container():Container(
                       decoration: BoxDecoration(
                           image: DecorationImage(image: CachedNetworkImageProvider(p.url!),fit: BoxFit.cover),
                           border: Border.all(
                               color: Color(0xff2c2c2c),
                               width: 2
                           ),
                           borderRadius: BorderRadius.circular(24)
                       ),
                       clipBehavior: Clip.antiAlias,
                     ),
                     onTap: () async{
                       // Navigator.pop(context);
                       File? file=await DefaultCacheManager().getSingleFile(p.url);
                       if(file!=null){
                         Navigator.pop(context,file.readAsBytesSync());
                         // showYourPortrait(context, file.readAsBytesSync(),template);
                       }
                     },
                   );
                 },
               );
             },
            ),
          ),
        ],
      ),
    );
  }
}
