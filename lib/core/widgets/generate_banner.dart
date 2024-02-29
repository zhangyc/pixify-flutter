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

final ValueNotifier<String> startGenerate = ValueNotifier<String>('1');

class GenerateBanner extends ConsumerStatefulWidget {
  const GenerateBanner({super.key});

  @override
  ConsumerState createState() => _GenerateBannerState();
}

class _GenerateBannerState extends ConsumerState<GenerateBanner> {
  GenerateState _generateState=GenerateState.cancel;
  late Timer timer;
  DuoSnapTask duoSnapTask=DuoSnapTask();
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  void initState() {
    timer=Timer.periodic(Duration(seconds: 5), (timer) {
      _initTask();
    });
    startGenerate.addListener(() {
      _generateState=GenerateState.requesting;
      setState(() {

      });
      _initTask();
    });
    super.initState();
  }

  _initTask() async{

    HttpResult result=await post('/merge-photo/find-last');
    if(result.isSuccess){
     duoSnapTask=DuoSnapTask.fromJson(result.data);
     if(duoSnapTask.status==null){
       _generateState=GenerateState.requesting;
     }else if(duoSnapTask.status==1){
       _generateState=GenerateState.line;

     }else if(duoSnapTask.status==2){
       _generateState=GenerateState.almost;

     }else if(duoSnapTask.status==3){
       _generateState=GenerateState.done;
     }else if(duoSnapTask.status==4){
       _generateState=GenerateState.fail;

     }else if(duoSnapTask.status==5){
       _generateState=GenerateState.cancel;

     }
     setState(() {

     });
    }else if(result.statusCode.toString()=='60010'){
      _generateState=GenerateState.cancel;
      setState(() {

      });
    }else {
      _generateState=GenerateState.fail;
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return _buildTip();
  }

  _buildTip() {
   if(_generateState==GenerateState.requesting){
     return Container(
       color: Color(0xff2c2c2c),
       height: 56,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           SvgPicture.asset(Assets.svgCamera,width: 24,height: 24,),
           SizedBox(
             width: 10,
           ),
           Text('Generating...',style: TextStyle(
             fontSize: 14,
             color: Colors.white,
             fontWeight: FontWeight.w900
           ),)
         ],
       ),
     );
   }else if(_generateState==GenerateState.line){
    return Container(
       color: Color(0xff656565),
       height: 56,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text("🚚 You're in line, please hold on...",style: TextStyle(
               fontSize: 14,
               color: Colors.white,
               fontWeight: FontWeight.w900
           ),)
         ],
       ),
     );
   }else if(_generateState==GenerateState.almost){
    return Container(
       color: Color(0xff656565),
       height: 56,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text("🚚 Almost there, almost!",style: TextStyle(
               fontSize: 14,
               color: Colors.white,
               fontWeight: FontWeight.w900
           ),)
         ],
       ),
     );
   }else if(_generateState==GenerateState.done){
    return  GestureDetector(
      onTap: (){
        if(mounted){
          setState(() {

          });
        }
        _generateState=GenerateState.cancel;
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
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 Transform.rotate(
                     angle: -15 * 3.14 / 180,
                     child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                       return Container(
                           width: 26,
                           height: 35,
                         clipBehavior: Clip.antiAlias,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(8),
                             border: Border.all(
                                 color: Colors.white,
                                 width: 2
                             ),
                             image: DecorationImage(image: CachedNetworkImageProvider(ref.read(myProfileProvider)!.avatar??'',),fit: BoxFit.cover,)

                         ),
                       );
                     },)), // 替换为您的左侧图片路径
                 Transform.rotate(
                     angle: 15 * 3.14 / 180,
                     child: Container(
                       width: 26,
                       height: 35,
                         clipBehavior: Clip.antiAlias,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                             border: Border.all(
                             color: Colors.white,
                             width: 2,
                           ),
                           image: DecorationImage(image: CachedNetworkImageProvider(duoSnapTask?.targetUserAvatar??''),fit: BoxFit.cover,)
                         ),
                         // child: CachedNetworkImage(
                         //   imageUrl: duoSnapTask?.targetPhotoUrl??'',
                         //
                         //   fit: BoxFit.cover,
                         // ),
                     )
                 ), // 替换为您的右侧图片路径
               ],
             ),
             SizedBox(
               width: 16,
             ),
             Text("Duo snap is ready!",style: TextStyle(
                 fontSize: 14,
                 color: Colors.white,
                 fontWeight: FontWeight.w900
             ),)
           ],
         ),
       ),
    );
   }else if(_generateState==GenerateState.fail){
     return  Container(
       color: Color(0xff797979),
       height: 56,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text("❗ Issues, please retry",style: TextStyle(
               fontSize: 14,
               color: Colors.white,
               fontWeight: FontWeight.w900
           ),),
           GestureDetector(
             child: Container(
                 child: Text('Retry'),
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
             child: SvgPicture.asset(Assets.svgDislike),
             onTap: (){
               post('/merge-photo/cancel',data: {
                 'id':duoSnapTask.id
               });
             },
           )
         ],
       ),
     );
   }else if(_generateState==GenerateState.cancel){
     return Container();
   }else {
     return Container();
   }
  }

}
enum GenerateState{
  requesting,
  fail,
  line,
  almost,
  done,
  cancel
}
