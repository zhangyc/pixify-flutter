import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/bean/duosnap_task.dart';

import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/matched.dart';
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
        Row(
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
        SmallDuoSnap(task: task),
        SizedBox(
          height: 16,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(24), // 设置圆角半径
          child: CachedNetworkImage(imageUrl: task.targetPhotoUrl??'',width: 343,height: 457,placeholder: (_,__){
            return ImageLoadingAnimation();
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
            SvgPicture.asset(Assets.svgDownload,width: 56,height: 56,),

            SvgPicture.asset(Assets.svgShare,width: 56,height: 56,),

            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return GestureDetector(onTap: (){
                  if(canArrow){
                    arrow=arrow-1;
                    //MatchApi.sendImageMsg(info.id,controller.text);
                    // next.call();
                    Navigator.pop(context);
                    MatchApi.sendImageMsg(task.targetUserId!, task.targetPhotoUrl!).then((value){
                      if(value.isSuccess){
                        Fluttertoast.showToast(msg: 'done');
                      }
                    });
                  }else {
                    bool isMember=ref.read(myProfileProvider)?.isMember??false;
                    if(isMember){
                      Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                    }else{
                      Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                        return SubscribePage(fromTag: FromTag.duo_snap,);
                      }));
                    }
                  }
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
