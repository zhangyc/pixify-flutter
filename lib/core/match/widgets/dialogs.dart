import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../bean/match_user.dart';
import '../providers/matched.dart';
import '../util/event.dart';
import 'package:lottie/lottie.dart';
import 'package:sona/core/match/widgets/avatar_animation.dart';

showDm(BuildContext context,MatchUserInfo info,VoidCallback next){
  showModalBottomSheet(context: context,

      isScrollControlled: true,
      builder: (c){
    TextEditingController controller=TextEditingController();

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            controller.addListener(() {
              setState((){

              });
            });
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 400,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24
                ),
                child: Column(

                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).dm),
                        GestureDetector(child: Image.asset(Assets.iconsSkip,width: 40,height: 40,),onTap: (){
                          Navigator.pop(context);
                        },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Image.asset(Assets.imagesDm,width: 216,height: 155,),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Flexible(child: TextField(
                          controller: controller,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(160), // Maximum length of 10 characters
                          ],
                          decoration: InputDecoration(
                              hintText: S.of(context).wannaHollaAt,
                              border:OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 2
                                  ),
                                  borderRadius: BorderRadius.circular(24)
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16
                              )
                          ),
                        ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        controller.text.isNotEmpty?GestureDetector(
                          child:Image.asset(Assets.iconsSend,width: 56,height: 56,),
                          onTap: (){
                            if(controller.text.isEmpty){
                              return ;
                            }

                            if(canArrow){
                              arrow=arrow-1;
                              MatchApi.customSend(info.id,controller.text);

                              //MatchApi.arrow(info.id);
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
                                  return SubscribePage(SubscribeShowType.unlockDM(),fromTag: FromTag.pay_match_arrow,);
                                }));
                              }
                            }
                          },
                        ):Container(),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextButton(
                      onPressed: (){
                        if(canArrow){
                          arrow=arrow-1;
                          MatchApi.sayHi(info.id);
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
                              return SubscribePage(SubscribeShowType.unlockDM(),fromTag: FromTag.pay_match_arrow,);
                            }));
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(Assets.iconsLogo,width: 20,height: 20,),
                          const Text('Let SONA say hi for you ',style: TextStyle(
                              color: Colors.black
                          ),),
                          const Icon(Icons.arrow_forward_outlined)
                        ],
                      ),
                    )

                  ],
                ),
              ),
            );
          },

        );
      },
    );
  });

}
void showMatched(BuildContext context,{required MatchUserInfo target,required VoidCallback next}) {
  // showModalBottomSheet(context: context, builder: (c){});
  showGeneralDialog(context: context,
      pageBuilder: (_,__,___){
    TextEditingController controller=TextEditingController();

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Consumer(builder: (b,ref,_){
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              controller.addListener(() {
                setState((){

                });
              });
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 64,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(
                          right: 16
                        ),
                        child: GestureDetector(
                          onTap: (){
                             Navigator.pop(context);
                             next.call();
                          },
                          child: Image.asset(Assets.iconsSkip,width: 40,height: 40,),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Text(S.current.newMatch,style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900
                      ),),
                      const SizedBox(
                        height: 16,
                      ),
                      AvatarAnimation(
                        avatar: target.avatar??'',
                        name: target.name??'',
                        direction: AnimationDirection.left,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: Text.rich(
                          TextSpan(text: '"',style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 28
                          ),
                          children: [
                            TextSpan(
                              text:target.likeActivityName != null && target.likeActivityName!.isNotEmpty ? S.of(context).imVeryInterestedInSomething(target.likeActivityName!) : S.of(context).youSeemCool,
                              style: TextStyle(
                                color: Color(0xff2c2c2c),
                                fontWeight: FontWeight.w400,
                                fontSize: 20
                              ),
                            ),
                            TextSpan(
                              text: '"',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 28

                              ),
                            ),
                          ]
                          ),

                         ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 36
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(child: TextField(
                              // keyboardType: TextInputType.multiline,
                              // maxLines: null,
                              // minLines: 1,
                              controller: controller,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(160), // Maximum length of 10 characters
                              ],
                              decoration: InputDecoration(
                                hintText: S.of(context).wannaHollaAt,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16
                                ),
                                border:OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 2
                                    ),
                                    borderRadius: BorderRadius.circular(24)
                                ),
                              ),
                            ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            controller.text.isNotEmpty?GestureDetector(
                              child: Image.asset(Assets.iconsSend,width: 56,height: 56,),
                              onTap: (){
                                if(controller.text.isEmpty){
                                  return ;
                                }
                                next.call();
                                ///匹配成功，发送消息
                                MatchApi.customSend(target.id,controller.text);
                                Navigator.pop(context);
                              },
                            ):Container(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextButton(
                        onPressed: (){
                          ///发送一个快捷的sona打招呼
                          next.call();
                          MatchApi.sayHi(target.id);
                          Navigator.pop(context);

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Assets.iconsLogo,width: 20,height: 20,),
                            Text('${S.current.letSONASayHiForYou}',style: TextStyle(
                              color: Color(0xff2c2c2c),
                              fontSize: 16,
                              fontWeight: FontWeight.w800
                            ),),
                            const Icon(Icons.arrow_forward_outlined)
                          ],
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
              color: const Color(0xff232323),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.top,
                      ),
                      Row(
                        children: [
                          const Spacer(),
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

                      const Text('You got 1 ninja star!',style: TextStyle(
                          color: Colors.white,
                          fontSize: 30
                      ),),
                      const SizedBox(
                        height: 64,
                      ),
                      Image.asset(Assets.iconsArrow,width: 96,height: 97,),
                      const SizedBox(
                        height: 64,
                      ),
                      const Padding(
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
                          const Spacer(),
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