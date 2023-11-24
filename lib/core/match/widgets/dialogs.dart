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
import '../providers/matched.dart';
import '../util/event.dart';

showDm(BuildContext context,UserInfo info){
  showBottomSheet(context: context, builder: (c){
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
                      if(canArrow){
                        arrow=arrow-1;
                        ref.read(asyncMatchRecommendedProvider.notifier).arrow(info.id);
                        SonaAnalytics.log(MatchEvent.match_arrow_send.name);
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
                    ref.read(asyncMatchRecommendedProvider.notifier).arrow(info.id);
                    SonaAnalytics.log(MatchEvent.match_arrow_send.name);
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
                      Icon(Icons.ac_unit_outlined),
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