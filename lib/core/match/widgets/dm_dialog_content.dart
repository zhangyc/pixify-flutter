import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/core/match/widgets/tuosnap_dialog.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../../account/providers/interests.dart';
import '../../../account/providers/profile.dart';
import '../../../account/services/info.dart';
import '../../../common/permission/permission.dart';
import '../../../common/widgets/button/colored.dart';
import '../../../common/widgets/tag/hobby.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/dialog/crop_image.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../bean/match_user.dart';
import '../providers/matched.dart';
import '../providers/update_info_provider.dart';
import '../util/event.dart';
import 'package:sona/core/match/widgets/avatar_animation.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';

class Dm_dialog_content extends StatelessWidget {
  const Dm_dialog_content({
    super.key,
    required this.controller, required this.next, required this.info,
  });
  final VoidCallback next;
  final TextEditingController controller;
  final MatchUserInfo info;
  @override
  Widget build(BuildContext context) {
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
                          // onTapOutside: (cv){
                          //   FocusManager.instance.primaryFocus?.unfocus();
                          // },
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
                              SonaAnalytics.log(MatchEvent.match_arrow_send.name);
                              next.call();
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
                          MatchApi.sayHi(info.id,'dm');
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
  }
}
