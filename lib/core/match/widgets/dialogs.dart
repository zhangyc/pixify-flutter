import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../account/providers/profile.dart';
import '../../../common/models/user.dart';
import '../../../common/permission/permission.dart';
import '../../../generated/assets.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../bean/match_user.dart';
import '../providers/matched.dart';
import '../util/event.dart';
import 'package:lottie/lottie.dart';
import 'package:sona/core/match/widgets/avatar_animation.dart';

showDm(BuildContext context,MatchUserInfo info,VoidCallback next){
  showBottomSheet(context: context, builder: (c){
    TextEditingController controller=TextEditingController();
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Container(
          height: 400,
          padding: EdgeInsets.symmetric(
              horizontal: 24
          ),
          child: Column(

            children: [
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Direct Message'),
                  GestureDetector(child: Icon(Icons.close),onTap: (){
                     Navigator.pop(context);
                   },
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Image.asset(Assets.imagesDm,width: 216,height: 155,),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Flexible(child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border:OutlineInputBorder(

                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(24)
                      ),
                    ),
                  ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    child: Icon(Icons.send),
                    onTap: (){
                      if(controller.text.isEmpty){
                        return ;
                      }

                      if(canArrow){
                        arrow=arrow-1;
                        ref.read(asyncMatchRecommendedProvider.notifier).customSend(info.id,controller.text);

                        //ref.read(asyncMatchRecommendedProvider.notifier).arrow(info.id);
                        SonaAnalytics.log(MatchEvent.match_arrow_send.name);
                        next.call();
                        Navigator.pop(context);
                        //arrowController.reset();
                        //arrowController.forward() ;
                        //widget.userInfo.arrowed=true;
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
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: (){
                  if(canArrow){
                    arrow=arrow-1;
                    ref.read(asyncMatchRecommendedProvider.notifier).sayHi(info.id);
                    SonaAnalytics.log(MatchEvent.match_arrow_send.name);
                    next.call();
                    Navigator.pop(context);
                    //arrowController.reset();
                    //arrowController.forward() ;
                    //widget.userInfo.arrowed=true;
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
                  child: Row(
                    children: [
                      Image.asset(Assets.iconsLogo,width: 20,height: 20,),
                      Text('Let SONA say hi for you '),
                      Icon(Icons.arrow_forward_outlined)
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              )

            ],
          ),
        );
      },
    );
  });

}
void showMatched(BuildContext context,{required dynamic target,required VoidCallback next}) {
  String sayHi='Let SONA Say Hi';
  // showModalBottomSheet(context: context, builder: (c){});
  showGeneralDialog(context: context,
      pageBuilder: (_,__,___){
    TextEditingController controller=TextEditingController();
    var height = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Consumer(builder: (b,ref,_){
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 164,
                      ),
                      Text('NEW MATCHED!',style: TextStyle(
                          fontSize: 24
                      ),),
                      SizedBox(
                        height: 16,
                      ),
                      AvatarAnimation(
                        avatar: target.avatar??'',
                        name: target.name??'',
                        direction: AnimationDirection.left,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: Text('''
                          I'd like to see exhibition at the Mori Art Museum with you.
                          '''),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 36
                        ),
                        child: Row(
                          children: [
                            Flexible(child: Container(
                              height: 54,

                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                minLines: 1,
                                controller: controller,
                                textAlign: TextAlign.center,

                                decoration: InputDecoration(
                                  isDense: true,

                                  contentPadding: EdgeInsets.zero,
                                  border:OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(24)
                                  ),
                                ),
                              ),
                            ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                              child: Icon(Icons.send),
                              onTap: (){
                                if(controller.text.isEmpty){
                                  return ;
                                }
                                next.call();
                                ///匹配成功，发送消息
                                ref.read(asyncMatchRecommendedProvider.notifier).customSend(target.id,controller.text);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: (){
                          ///发送一个快捷的sona打招呼
                          next.call();
                          ref.read(asyncMatchRecommendedProvider.notifier).sayHi(target.id);
                          Navigator.pop(context);

                        },
                        child: Container(
                          child: Row(
                            children: [
                              Image.asset(Assets.iconsLogo,width: 20,height: 20,),
                              Text('Let SONA say hi for you '),
                              Icon(Icons.arrow_forward_outlined)
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      )
                    ],
                  )
                ),
              );
            },
          );
        }),
      ),
    );
  });
}
void showArrowReward(BuildContext context){
  showGeneralDialog(context: context,
      pageBuilder: (_,__,___){
        return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState){
          return GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              height:MediaQuery.of(context).size.height,
              color: Color(0xff232323),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            // color: Colors.white,
                            alignment: Alignment.centerRight,
                            child: GestureDetector(onTap: (){
                              Navigator.pop(context);
                            }, child: Image.asset(Assets.iconsClose,
                              width: 41,
                              height: 41,
                              color: Colors.white,)),
                          ),
                          SizedBox(
                            width:  MediaQuery.of(context).viewPadding.top,
                          )
                        ],
                      ),
                      Image.asset(Assets.imagesRewardArrow,width: 165,height: 162,),

                      Text('You got 1 ninja star!',style: TextStyle(
                          color: Colors.white,
                          fontSize: 30
                      ),),
                      SizedBox(
                        height: 64,
                      ),
                      Image.asset(Assets.iconsArrow,width: 96,height: 97,),
                      SizedBox(
                        height: 64,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20
                        ),
                        child: Text('Use a star to directly start a chat with someone you like!',style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),),
                      )
                    ],
                  ),
                  Lottie.asset(Assets.lottieArrowAnimation,repeat: false,),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            // color: Colors.white,
                            alignment: Alignment.centerRight,
                            child: GestureDetector(onTap: (){
                              Navigator.pop(context);
                            }, child: Image.asset(Assets.iconsClose,
                              width: 41,
                              height: 41,
                              color: Colors.white,)),
                          ),
                          SizedBox(
                            width:  MediaQuery.of(context).viewPadding.top,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
      });
}