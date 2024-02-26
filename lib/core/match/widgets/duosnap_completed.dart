import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../generated/assets.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/matched.dart';

class DuosnapCompleted extends StatelessWidget {
  const DuosnapCompleted({super.key, required this.close});
  final Function close;
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
        Image.asset(Assets.imagesTenderAffection),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            SvgPicture.asset(Assets.svgDownload,width: 40,height: 40,),
            SvgPicture.asset(Assets.svgShare,width: 40,height: 40,),
            Consumer(

              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return OutlinedButton(onPressed: (){
                  if(canArrow){
                    arrow=arrow-1;
                    //MatchApi.sendImageMsg(info.id,controller.text);
                    // next.call();
                    Navigator.pop(context);
                  }else {
                    bool isMember=ref.read(myProfileProvider)?.isMember??false;
                    if(isMember){
                      Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                    }else{
                      Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                        return SubscribePage(SubscribeShowType.unlockDM(),fromTag: FromTag.pay_match_arrow,);
                      }));
                    }
                  }
                 }, child: Text('Send to Her'));
              },
            )
          ],
        )
      ],
    );
  }
}
