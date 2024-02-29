import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/bean/duosnap_task.dart';

import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../generated/assets.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/matched.dart';

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
              'Duo Snap',
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
        SizedBox(
          height: 16,
        ),
        CachedNetworkImage(imageUrl: task.targetPhotoUrl??'',width: 343,height: 457,),
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
                    MatchApi.sendImageMsg(task.targetUserId!, task.targetPhotoUrl!);
                  }else {
                    bool isMember=ref.read(myProfileProvider)?.isMember??false;
                    if(isMember){
                      Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                    }else{
                      Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                        return SubscribePage(fromTag: FromTag.pay_match_arrow,);
                      }));
                    }
                  }
                 },
                    child: Container(
                        alignment: Alignment.center,
                        child: Text('Send to Her'),
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
}
