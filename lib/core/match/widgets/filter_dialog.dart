import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/screens/match.dart';
import 'package:sona/core/match/widgets/avatar_animation.dart';
import 'package:sona/utils/global/global.dart';

import '../../../generated/assets.dart';
import '../../chat/models/message.dart';
import '../../chat/services/chat.dart';
import '../util/event.dart';

void showFilter(BuildContext context,VoidCallback onSave) {
  showDialog(context: context, builder: (c){
    return Consumer(builder: (_,ref,__){
      return Column(
        children: [
          Container(
            width:335,
            height: 200,
            decoration: BoxDecoration(
                color: Color(0xff2969E9),
                borderRadius: BorderRadius.circular(40)
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 90
            ),
            child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Gender',style: TextStyle(
                      fontSize: 24,
                      color: Color(0xfff9f9f9)
                  ),),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...FilterGender.values.map((e) => GestureDetector(
                        onTap: (){
                          currentFilterGender=e.index;
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 10
                            ),
                            child:  ValueListenableBuilder(valueListenable: appCommonBox.listenable(), builder: (c,b,_){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  e.index==currentFilterGender?Image.asset(Assets.iconsSelected,width: 24,height: 24,):Container(),
                                  Text(e.name,style: TextStyle(
                                      fontSize: 24,
                                      color:e.index==currentFilterGender?Color(0xfff9f9f9):Colors.white.withOpacity(0.2)
                                  ),)
                                ],
                              );
                            })
                        ),
                      )).toList(),
                    ],
                  ))

                ]
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width:335,
            height: 138,
            decoration: BoxDecoration(
                color: Color(0xff2969E9),
                borderRadius: BorderRadius.circular(40)
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text('Age',style: TextStyle(
                    fontSize: 24,
                    color: Color(0xfff9f9f9)
                ),),
                SizedBox(height: 8),
                SizedBox(width: 277,child: ValueListenableBuilder(valueListenable: appCommonBox.listenable(), builder: (c,b,_){
                  RangeValues rv=RangeValues(currentFilterMinAge.toDouble(), currentFilterMaxAge.toDouble());
                  return RangeSlider(
                      activeColor: Colors.white,
                      inactiveColor:Color(0xff54b7ed) ,
                      min: 18,
                      max: 80,
                      divisions: 10,
                      labels: RangeLabels(rv.start.toStringAsFixed(0), rv.end.toStringAsFixed(0)),
                      values: rv,
                      onChanged: (rv) {
                        currentFilterMinAge=rv.start.toInt();
                        currentFilterMaxAge=rv.end.toInt();
                      }
                  );
                }),),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: Container(
              width:335,
              height: 70,
              decoration: BoxDecoration(
                  color: Color(0xff2969E9),
                  borderRadius: BorderRadius.circular(40)
              ),
              alignment: Alignment.center,
              child: Text('Save',style: TextStyle(
                  fontSize: 24,
                  color: Color(0xfff9f9f9)
              ),),
            ),
            onTap: (){
              onSave.call();
              Navigator.pop(context);
            },
          )

        ],
      );
    });
  });
}
void showMatched(BuildContext context,VoidCallback onSave,{required UserInfo target}) {
  String sayHi='Let SONA Say Hi';

  showGeneralDialog(context: context, pageBuilder: (_,__,___){
    return Consumer(builder: (b,ref,_){
      return StatefulBuilder(
        builder: (BuildContext context, void Function(void Function()) setState) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: Color(0xffe74e27),
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 358,
                    ),
                    Image.asset(Assets.imagesMatched),
                  ],
                ),
                Positioned(
                  left: 60,
                  top: 212,
                  child: AvatarAnimation(
                      avatar: ref.watch(myProfileProvider)?.avatar??'',
                      name: ref.watch(myProfileProvider)?.name??'',
                      direction: AnimationDirection.right,
                  ),
                ),
                Positioned(
                  right: 60,
                  top: 212,
                  child: AvatarAnimation(
                      avatar: target.avatar??'',
                      name: target.name??'',
                      direction: AnimationDirection.left,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 515,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: OutlinedButton(onPressed: (){
                        sayHi='Sent √';
                        setState((){});
                        Future.delayed(Duration(milliseconds: 500),(){
                          onSave.call();
                          SonaAnalytics.log(MatchEvent.match_popup_sona.name);
                          Navigator.pop(context);
                        });
                        callSona(
                            userId: target.id,
                            type: CallSonaType.PROLOGUE);
                       },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: Colors.white,
                            width: 2
                          )
                        ), child: Text(sayHi,style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                      ),),
                      ),
                    ),
                    sayHi=='Sent √'?Container():TextButton(onPressed: (){
                      Navigator.pop(context);
                     }, child: Text('Later',style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 16
                    ),))
                  ],
                )
              ],
            ),
          );
        },
      );
    });
  });
  // showDialog(context: context, builder: (c){
  //   return
  //
  // });
}
int get currentFilterGender => appCommonBox.get('currentFilterGender',defaultValue: 0);
set currentFilterGender(value){
  appCommonBox.put('currentFilterGender', value);
}
int get currentFilterMinAge => appCommonBox.get('currentFilterMinAge',defaultValue: 18);
set currentFilterMinAge(value){
  appCommonBox.put('currentFilterMinAge', value);
}
int get currentFilterMaxAge => appCommonBox.get('currentFilterMaxAge',defaultValue: 80);
set currentFilterMaxAge(value){
  appCommonBox.put('currentFilterMaxAge', value);
}

double get longitude => appCommonBox.get('longitude',defaultValue: null);
set longitude(value){
  appCommonBox.put('longitude', value);
}
double get latitude => appCommonBox.get('latitude',defaultValue: null);
set latitude(value){
  appCommonBox.put('latitude', value);
}