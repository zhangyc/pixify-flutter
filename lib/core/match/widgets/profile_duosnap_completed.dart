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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(child: SvgPicture.asset(Assets.svgDownload,width: 56,height: 56,),
              onTap: () async{
                SonaAnalytics.log(DuoSnapEvent.chat_duo_download.name);

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

            GestureDetector(child: SvgPicture.asset(Assets.svgShare,width: 56,height: 56,),
              onTap: () async{
                SonaAnalytics.log(DuoSnapEvent.chat_duo_share.name);

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
    );
  }
}
