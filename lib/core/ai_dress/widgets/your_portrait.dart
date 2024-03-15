import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/ai_dress/bean/sd_template.dart';
import 'package:sona/core/ai_dress/widgets/base_dialog_container.dart';
import 'package:sona/core/chat/screens/chat.dart';
import 'package:sona/core/match/widgets/loading_button.dart';

import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../common/services/common.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../../match/util/event.dart';
import '../../match/util/http_util.dart';
import '../../persona/screens/persona.dart';
import '../../subscribe/model/member.dart';
import '../../subscribe/subscribe_page.dart';
import '../../widgets/generate_banner.dart';

class YourPortrait extends StatelessWidget {
  const YourPortrait({super.key, required this.image, required this.template});
  final Uint8List image;
  final SdTemplate template;
  @override
  Widget build(BuildContext context) {
    return BaseDialogContainer(child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text('Your portrait',style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18
            ),),
            GestureDetector(
              child: SvgPicture.asset(Assets.svgDislike,width: 40,height: 40,),
              onTap: (){
                Navigator.pop(context);
              },
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: 168,
          height: 224,
          decoration: BoxDecoration(
            image: DecorationImage(image: MemoryImage(image)),
            border: Border.all(
              color: Color(0xff2c2c2c),
              width: 2
            ),
            borderRadius: BorderRadius.circular(24)
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return LoadingButton(onPressed: ()async{
            if(!canDuoSnap){
              duosnap-=1;
              if(ref.read(myProfileProvider)!.memberType==MemberType.none){
                SonaAnalytics.log(DuoSnapEvent.Duo_click_pay.name);
                Navigator.push(context, MaterialPageRoute(builder:(c){
                  return const SubscribePage(fromTag: FromTag.duo_snap,);
                }));
              }else if(ref.read(myProfileProvider)!.memberType==MemberType.club){
                SonaAnalytics.log(DuoSnapEvent.plus_duo_limit.name);

                Navigator.push(context, MaterialPageRoute(builder:(c){
                  return const SubscribePage(fromTag: FromTag.pay_match_arrow,);
                }));
              }else if(ref.read(myProfileProvider)!.memberType==MemberType.plus){
                SonaAnalytics.log(DuoSnapEvent.club_clickduo_payplus.name);

                Fluttertoast.showToast(msg: S.current.weeklyLimitReached);
              }
              return;
            }
            final s =await uploadFile(bytes: image);
            final response=await post('/merge-photo/create',data: {
              // 原图URL
              "photoUrl":s,
              // 模型 - 测试是任意写
              "modelId":template.id,
              "scene":GenerateType.profile.name
            });
            if(response.isSuccess){
              Future.delayed(Duration(milliseconds: 300),(){
                startGenerate.value=uuid.v1();
              });
            }else {
              Fluttertoast.showToast(msg:S.current.issues);
            }
            Navigator.pop(context);
          }, child: Container(
            alignment: Alignment.center,
            width: 343,
            height: 56,
            child: Text(S.current.generateButtonLabel,style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Colors.white
            ),),
            decoration: BoxDecoration(
                color: Color(0xff2c2c2c),
                borderRadius: BorderRadius.circular(20)
            ),
          ), placeholder: Container(
            alignment: Alignment.center,
            width: 343,
            height: 56,
            child: SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(color: Colors.white,),
            ),
            decoration: BoxDecoration(
                color: Color(0xff2c2c2c),
                borderRadius: BorderRadius.circular(20)
            ),
          ));
        },)
        ,
      ],
    ));
  }
}
