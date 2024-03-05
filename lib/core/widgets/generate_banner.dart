import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/bean/duosnap_task.dart';
import 'package:sona/core/match/util/http_util.dart';
import 'package:sona/core/match/util/local_data.dart';
import 'package:sona/core/match/widgets/catch_more.dart';
import 'package:sona/core/match/widgets/dialogs.dart';
import 'package:sona/core/match/widgets/duosnap_completed.dart';

import '../../account/providers/profile.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../match/widgets/small_duo.dart';

final ValueNotifier<String> startGenerate = ValueNotifier<String>('1');
final ValueNotifier<GenerateState> generateState = ValueNotifier<GenerateState>(GenerateState.idel);

class GenerateBanner extends ConsumerStatefulWidget {
  const GenerateBanner({super.key});

  @override
  ConsumerState createState() => _GenerateBannerState();
}

class _GenerateBannerState extends ConsumerState<GenerateBanner> {
  // GenerateState _generateState=GenerateState.cancel;
  late Timer timer;
  DuoSnapTask duoSnapTask=DuoSnapTask();
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  void initState() {
    _initTask();
    startGenerate.addListener(() {
      generateState.value=GenerateState.line;
      setState(() {

      });
      _initTask();
      timer=Timer.periodic(Duration(seconds: 15), (timer) {
        _initTask();
      });
    });
    super.initState();
  }

  _initTask() async{

    HttpResult result=await post('/merge-photo/find-last');
    if(result.isSuccess){
     duoSnapTask=DuoSnapTask.fromJson(result.data);
     if(duoSnapTask.status==null){
       generateState.value=GenerateState.line;
     }else if(duoSnapTask.status==1){
       generateState.value=GenerateState.line;

     }else if(duoSnapTask.status==2){
       generateState.value=GenerateState.generating;

     }else if(duoSnapTask.status==3){
       generateState.value=GenerateState.done;
       timer.cancel();
     }else if(duoSnapTask.status==4){
       generateState.value=GenerateState.fail;

     }else if(duoSnapTask.status==5){
       generateState.value=GenerateState.cancel;

     }
     setState(() {

     });
    }else if(result.statusCode.toString()=='60010'){
      generateState.value=GenerateState.cancel;
      setState(() {

      });
    }else {
      generateState.value=GenerateState.fail;
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return _buildTip();
  }

  _buildTip() {
   if(generateState.value==GenerateState.generating){
     return Container(
       color: Color(0xff2c2c2c),
       height: 56,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           SmallDuoSnap(task: duoSnapTask),
           SizedBox(
             width: 10,
           ),
           SvgPicture.asset(Assets.svgCamera,width: 24,height: 24,),
           SizedBox(
             width: 10,
           ),
           Text(S.current.generating,style: TextStyle(
             fontSize: 14,
             color: Colors.white,
             fontWeight: FontWeight.w900
           ),)
         ],
       ),
     );
   }else if(generateState.value==GenerateState.line){
    return Container(
       color: Color(0xff656565),
       height: 56,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           SmallDuoSnap(task: duoSnapTask),
           SizedBox(
             width: 10,
           ),
           Text("🚚 ${S.current.inLine}",style: TextStyle(
               fontSize: 14,
               color: Colors.white,
               fontWeight: FontWeight.w900
           ),)
         ],
       ),
     );
   } else if(generateState.value==GenerateState.done){
    return  GestureDetector(
      onTap: (){
        if(mounted){
          setState(() {

          });
        }
        generateState.value=GenerateState.cancel;
        post('/merge-photo/over',data: {
          "id": duoSnapTask.id
        });
        showDuoSnapCompleted(context,
          700,
          DuosnapCompleted(
              task: duoSnapTask,
              close:(){
                Navigator.pop(context);
              })
        ).whenComplete((){
          if(showCatchMore&&mounted){
            showDuoSnapTip(context, child: CatchMore(close: (){
              Navigator.pop(context);
            }), dialogHeight: 361);
            showCatchMore=false;
          }
        });
      },
      child: Container(
         color: Color(0xff0DF892),
         height: 56,
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SmallDuoSnap(task: duoSnapTask),
             SizedBox(
               width: 16,
             ),
             Text(S.current.duoSnapIsReady,style: TextStyle(
                 fontSize: 14,
                 color: Color(0xff2c2c2c),
                 fontWeight: FontWeight.w900
             ),)
           ],
         ),
       ),
    );
   }else if(generateState.value==GenerateState.fail){
     return  Container(
       color: Color(0xff797979),
       height: 56,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Text("❗ ${S.current.issues}",style: TextStyle(
               fontSize: 14,
               color: Colors.white,
               fontWeight: FontWeight.w900
           ),),
           GestureDetector(
             child: Container(
                 alignment: Alignment.center,
                 child: Text(S.current.retry),
                 width: 90,
                 height: 30,
               decoration: BoxDecoration(
                 color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                 border: Border.all(
                   color: Color(0xff2c2c2c),
                   width: 2
                 )
               ),
             ),
             onTap: () async{

               HttpResult overResponse=await post('/merge-photo/cancel',data: {
                 'id':duoSnapTask.id
               });
               if(overResponse.isSuccess){
                 await post('path',data: {
                   {
                     // 原图URL
                     "photoUrl":duoSnapTask.sourcePhotoUrl,
                     // 对方用户ID
                     "targetUserId":duoSnapTask.targetUserId,
                     // 模型 - 测试是任意写
                     "modelId":duoSnapTask.modelId
                   }
                 });
               }
             },
           ),
           GestureDetector(
             child: SvgPicture.asset(Assets.svgDislike,width: 20,height: 20,),
             onTap: (){
               generateState.value=GenerateState.cancel;
               post('/merge-photo/cancel',data: {
                 'id':duoSnapTask.id
               });
             },
           )
         ],
       ),
     );
   }else if(generateState.value==GenerateState.cancel||generateState.value==GenerateState.idel){
     return Container();
   }else {
     return Container();
   }
  }

}
enum GenerateState{
  generating,
  fail,
  line,
  done,
  cancel,
  idel
}
