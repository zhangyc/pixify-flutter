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
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sona/core/match/bean/duosnap_task.dart';
import 'package:sona/core/match/widgets/duosnap_loading.dart';

import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/matched.dart';
import '../util/event.dart';
import 'image_loading_animation.dart';
import 'small_duo.dart';

class DuosnapCompleted extends StatelessWidget {
  const DuosnapCompleted({super.key, required this.close, required this.task});
  final Function close;
  final DuoSnapTask task;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Me and ${task.targetUserNickname??''}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
              ),
              IconButton(
                icon: SvgPicture.asset(Assets.svgDislike,width: 40,height: 40,),
                onPressed: (){
                  close.call();
                },
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
                angle: -15 * 3.14 / 180,
                child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return Container(
                    width: 50,
                    height: 66,
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
                  height: 66,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      image: DecorationImage(image: CachedNetworkImageProvider(task.targetUserAvatar??''),fit: BoxFit.cover,)
                  ),
                )
            ), // 替换为您的右侧图片路径
          ],
        ),
        SizedBox(
          height: 16,
        ),
        ClipRRect(
          // borderRadius: BorderRadius.circular(24), // 设置圆角半径
          child: CachedNetworkImage(imageUrl: task.targetPhotoUrl??'',width: MediaQuery.of(context).size.width,placeholder: (_,__){
            return DuosnapLoading();
          },
          fit: BoxFit.cover ,
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
                SonaAnalytics.log(DuoSnapEvent.duo_download.name);

                FileInfo? f=await DefaultCacheManager().getFileFromCache(task.targetPhotoUrl??'');
                if(f!=null){
                  final hasAccess = await Gal.hasAccess(toAlbum: true);
                  if(hasAccess){
                    await Gal.requestAccess(toAlbum: true);
                    await Gal.putImageBytes(f.file.readAsBytesSync(),album: 'sona',name: 'sona_${uuid.v1()}');
                    Fluttertoast.showToast(msg: 'Done');
                  }else {
                    Fluttertoast.showToast(msg: S.current.issues);
                  }

                }
              },
            ),

            GestureDetector(child: SvgPicture.asset(Assets.svgShare,width: 56,height: 56,),
              onTap: () async{
                SonaAnalytics.log(DuoSnapEvent.duo_share.name);

                String cache=(await getApplicationCacheDirectory()).path;
                File? f=await DefaultCacheManager().getSingleFile(task.targetPhotoUrl??'');
                File file=File('$cache/tmp.png');
                file.writeAsBytesSync(f.readAsBytesSync());
                if(f!=null){
                  XFile x=XFile(file.path);
                  Share.shareXFiles([x]);
                }
              },
            ),

            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return GestureDetector(onTap: (){
                  SonaAnalytics.log(DuoSnapEvent.duo_send.name);
                  SonaAnalytics.logFacebookEvent(DuoSnapEvent.duo_send.name);
                  Navigator.pop(context);
                  MatchApi.sendImageMsg(task.targetUserId!, task.targetPhotoUrl!).then((value){
                    if(value.isSuccess){
                      Fluttertoast.showToast(msg: 'done');
                    }
                  });
                  // if(canArrow){
                  //   arrow=arrow-1;
                  //   //MatchApi.sendImageMsg(info.id,controller.text);
                  //   // next.call();
                  //   Navigator.pop(context);
                  //   MatchApi.sendImageMsg(task.targetUserId!, task.targetPhotoUrl!).then((value){
                  //     if(value.isSuccess){
                  //       Fluttertoast.showToast(msg: 'done');
                  //     }
                  //   });
                  // }else {
                  //   bool isMember=ref.read(myProfileProvider)?.isMember??false;
                  //   if(isMember){
                  //     Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                  //   }else{
                  //     Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                  //       return SubscribePage(fromTag: FromTag.duo_snap,);
                  //     }));
                  //   }
                  // }
                 },
                    child: Container(
                        alignment: Alignment.center,
                        child: _buildSendButton(context,task),
                        width: 199,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Color(0xffBEFF06),
                          border: Border.all(
                            color: Color(0xff2c2c2c),
                            width: 2
                          ),
                          borderRadius: BorderRadius.circular(20)
                        ),
                    ));
              },
            )
          ],
        )
      ],
    );
  }

  _buildSendButton(BuildContext context,DuoSnapTask task) {
      if(task.targetUserGender==null){
        return Text('Send to Them',style: Theme.of(context).textTheme.bodyLarge,);
      }else if(task.targetUserGender==1){
        return Text('Send to Him',style: Theme.of(context).textTheme.bodyLarge,);
      }else if(task.targetUserGender==2){
        return Text('Send to her',style: Theme.of(context).textTheme.bodyLarge,);
      }else if(task.targetUserGender==3){
        return Text('Send to Them',style: Theme.of(context).textTheme.bodyLarge,);
      }
  }
}
