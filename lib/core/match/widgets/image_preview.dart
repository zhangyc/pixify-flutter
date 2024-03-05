import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gal/gal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';

import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import 'image_loading_animation.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.url,required this.targetUrl});
  final String url;
  final String targetUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
                angle: -15 * 3.14 / 180,
                child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return Container(
                    width: 50,
                    height: 65,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Colors.white,
                            width: 2
                        ),
                        image: DecorationImage(image: CachedNetworkImageProvider(ref.read(myProfileProvider)!.avatar??'',),fit: BoxFit.cover,)

                    ),
                  );
                },)), // 替换为您的左侧图片路径
            Transform.rotate(
                angle: 15 * 3.14 / 180,
                child: Container(
                  width: 50,
                  height: 65,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      image: DecorationImage(image: CachedNetworkImageProvider(targetUrl),fit: BoxFit.cover,)
                  ),
                )
            ), // 替换为您的右侧图片路径
          ],
        ),
        SizedBox(
          height: 16,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(24), // 设置圆角半径
          child: CachedNetworkImage(imageUrl: url,width: 343,height: 457,placeholder: (_,__){
            return ImageLoadingAnimation();
          },
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(child: SvgPicture.asset(Assets.svgDownload,width: 56,height: 56,),
              onTap: () async{
                FileInfo? f=await DefaultCacheManager().getFileFromCache(url);
                if(f!=null){
                  final hasAccess = await Gal.hasAccess(toAlbum: true);
                  if(hasAccess){
                    await Gal.requestAccess(toAlbum: true);
                    await Gal.putImageBytes(f.file.readAsBytesSync(),album: 'sona');
                    Fluttertoast.showToast(msg: 'Done');
                  }else {
                    Fluttertoast.showToast(msg: S.current.issues);
                  }
                  Navigator.pop(context);

                }
              },
            ),

            GestureDetector(child: SvgPicture.asset(Assets.svgShare,width: 56,height: 56,),
              onTap: () async{
                FileInfo? f=await DefaultCacheManager().getFileFromCache(url);
                if(f!=null){
                  XFile x=XFile(f.file.path);
                  Share.shareXFiles([x]);

                  Navigator.pop(context);
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
