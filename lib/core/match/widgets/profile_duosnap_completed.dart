import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sona/common/app_config.dart';
import 'package:sona/core/ai_dress/ai_dress_event.dart';
import 'package:sona/core/match/util/http_util.dart';
import 'package:sona/core/match/widgets/duosnap_loading.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../util/event.dart';

class ProfileDuosnapCompleted extends StatelessWidget {
  const ProfileDuosnapCompleted({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 16,
        ),
        ClipRRect(
          // borderRadius: BorderRadius.circular(24), // 设置圆角半径
          child: CachedNetworkImage(imageUrl: url,width: MediaQuery.of(context).size.width,placeholder: (_,__){
            return DuosnapLoading();
          },
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              !firstShare?Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 44,
                  width: 224,
                  child: Stack(
                    children: [
                      Positioned(child: SvgPicture.asset(Assets.svgTooltip),
                        bottom: 0,
                        left: 224/2-16/2,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xff2c2c2c),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        alignment: Alignment.center,
                        height: 38,
                        width: 224,
                        child: Text('Share to get more AI Dress tries!👇',style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        ),),
                      ),
                    ],
                  ),
                ),
              ):Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(child: Container(child: Row(
                    children: [
                      Icon(Icons.arrow_circle_down_sharp),
                      SizedBox(
                        width: 4,
                      ),
                      // SvgPicture.asset(Assets.svgDownload,width: 56,height: 56,),
                      Text('Save',style: TextStyle(
                        fontWeight: FontWeight.w800
                      ),)
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                    decoration: BoxDecoration(
                        color: Color(0xffF6F3F3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Color(0xff2c2c2c)
                        )
                    ),
                    width: 160,
                    height: 56,
                  ),
                    onTap: () async{
                      SonaAnalytics.log(AiDressEvent.Dress_photo_download.name);
                      FileInfo? f=await DefaultCacheManager().getFileFromCache(url);
                      if(f!=null){
                        final hasAccess = await Gal.hasAccess(toAlbum: true);
                        if(hasAccess){
                          await Gal.requestAccess(toAlbum: true);
                          await Gal.putImageBytes(f.file.readAsBytesSync(),album: 'sona',name: 'sona_${uuid.v1()}');
                          Fluttertoast.showToast(msg: 'Done');
                        }else {
                          Fluttertoast.showToast(msg: S.current.issues);
                        }
                        Navigator.pop(context);

                      }
                    },
                  ),

                  GestureDetector(child: Container(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share),
                      SizedBox(
                        width: 4,
                      ),
                      Text('Share',style: TextStyle(
                          fontWeight: FontWeight.w800
                      ),)
                    ],
                  ),
                    decoration: BoxDecoration(
                        color: Color(0xffBEFF06),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Color(0xff2c2c2c)
                        )
                    ),
                    width: 160,
                    height: 56,

                  ),
                    onTap: () async{
                      SonaAnalytics.log(AiDressEvent.Dress_photo_share.name);
                      firstShare=true;
                      post('/merge-photo/share-award');
                      String cache=(await getApplicationCacheDirectory()).path;
                      File? f=await DefaultCacheManager().getSingleFile(url);
                      File file=File('$cache/tmp.png');
                      file.writeAsBytesSync(f.readAsBytesSync());
                      if(f!=null){
                        XFile x=XFile(file.path);
                        Share.shareXFiles([x]);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        )

      ],
    );
  }
}
