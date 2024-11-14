// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sona/common/app_config.dart';
// import 'package:sona/common/permission/permission.dart';
// import 'package:sona/core/match/bean/duosnap_task.dart';
// import 'package:sona/core/match/util/http_util.dart';
// import 'package:sona/core/match/util/local_data.dart';
// import 'package:sona/core/match/widgets/catch_more.dart';
// import 'package:sona/core/match/widgets/dialogs.dart';
// import 'package:sona/core/match/widgets/duosnap_completed.dart';
// import 'package:sona/core/match/widgets/loading_button.dart';
// import 'package:sona/core/match/widgets/profile_duosnap_completed.dart';
//
// import '../../generated/assets.dart';
// import '../../generated/l10n.dart';
// import '../../utils/global/global.dart';
// import '../ai_dress/ai_dress_event.dart';
// import '../match/util/event.dart';
// import '../match/widgets/small_duo.dart';
//
// final ValueNotifier<String> startGenerate = ValueNotifier<String>('1');
//
// class GenerateBanner extends ConsumerStatefulWidget {
//   const GenerateBanner({super.key});
//   @override
//   ConsumerState createState() => _GenerateBannerState();
// }
//
// class _GenerateBannerState extends ConsumerState<GenerateBanner> {
//   GenerateState generateState = GenerateState.idel;
//   Timer? timer;
//   DuoSnapTask duoSnapTask=DuoSnapTask();
//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }
//   @override
//   void initState() {
//     _initTask();
//     startGenerate.addListener(() {
//       generateState=GenerateState.line;
//       if(mounted){
//         setState(() {
//
//         });
//       }
//       _initTask();
//       timer=Timer.periodic(Duration(seconds: 15), (timer) {
//         _initTask();
//       });
//     });
//     super.initState();
//   }
//
//   _initTask() async{
//
//     HttpResult result=await post('/merge-photo/find-last');
//     if(result.isSuccess){
//      duoSnapTask=DuoSnapTask.fromJson(result.data);
//      if(duoSnapTask.status==null){
//        generateState=GenerateState.line;
//      }else if(duoSnapTask.status==1){
//        generateState=GenerateState.line;
//
//      }else if(duoSnapTask.status==2){
//        generateState=GenerateState.generating;
//
//      }else if(duoSnapTask.status==3){
//        SonaAnalytics.log(DuoSnapEvent.duo_done.name);
//        generateState=GenerateState.done;
//        isDuoSnapSuccess=true;
//        initUserPermission();
//        timer?.cancel();
//      }else if(duoSnapTask.status==4){
//        SonaAnalytics.log(DuoSnapEvent.duo_fail.name);
//        generateState=GenerateState.fail;
//
//      }else if(duoSnapTask.status==5){
//        generateState=GenerateState.cancel;
//
//      }
//      if(mounted){
//        setState(() {
//
//        });
//      }
//
//     }else if(result.statusCode.toString()=='60010'){
//       generateState=GenerateState.cancel;
//       if(mounted){
//         setState(() {
//
//         });
//       }
//     }else {
//       generateState=GenerateState.idel;
//       if(mounted){
//         setState(() {
//
//         });
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return _buildTip();
//   }
//
//   _buildTip() {
//    if(generateState==GenerateState.generating){
//      return Container(
//        color: Color(0xff2c2c2c),
//        height: 56,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            (duoSnapTask.scene==GenerateType.profile_one.name||duoSnapTask.scene==GenerateType.profile_two.name)?Container():SmallDuoSnap(task: duoSnapTask),
//            SizedBox(
//              width: 10,
//            ),
//            SvgPicture.asset(Assets.svgCamera,width: 24,height: 24,),
//            SizedBox(
//              width: 10,
//            ),
//            Text(S.current.generating,style: TextStyle(
//              fontSize: 14,
//              color: Colors.white,
//              fontWeight: FontWeight.w900
//            ),)
//          ],
//        ),
//      );
//    }else if(generateState==GenerateState.line){
//     return Container(
//        color: Color(0xff656565),
//        height: 56,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: [
//            (duoSnapTask.scene==GenerateType.profile_one.name||duoSnapTask.scene==GenerateType.profile_two.name)?Container():SmallDuoSnap(task: duoSnapTask),
//            SizedBox(
//              width: 10,
//            ),
//            Text("🚚 ${S.current.inLine}",style: TextStyle(
//                fontSize: 14,
//                color: Colors.white,
//                fontWeight: FontWeight.w900
//            ),)
//          ],
//        ),
//      );
//    } else if(generateState==GenerateState.done){
//     return  GestureDetector(
//       onTap: (){
//         if(mounted){
//           setState(() {
//
//           });
//         }
//         SonaAnalytics.log(DuoSnapEvent.click_duo_done.name);
//
//         generateState=GenerateState.cancel;
//         post('/merge-photo/over',data: {
//           "id": duoSnapTask.id
//         });
//         if((duoSnapTask.scene==GenerateType.profile_one.name||duoSnapTask.scene==GenerateType.profile_two.name)){
//           if(duoSnapTask.scene==GenerateType.profile_one.name){
//             SonaAnalytics.log(AiDressEvent.Dress_solo_watch.name);
//           }else if(duoSnapTask.scene==GenerateType.profile_two.name){
//             SonaAnalytics.log(AiDressEvent.Dress_duo_watch.name);
//
//           }
//
//           showDialog(context: context, builder: (b){
//             return ProfileDuosnapCompleted(url: duoSnapTask.targetPhotoUrl!);
//           });
//         }else {
//           showDuoSnapCompleted(context,
//               700,
//               DuosnapCompleted(
//                   task: duoSnapTask,
//                   close:(){
//                     Navigator.pop(context);
//                   })
//           ).whenComplete((){
//             if(showCatchMore&&mounted){
//               showDuoSnapTip(context, child: CatchMore(close: (){
//                 Navigator.pop(context);
//               }), dialogHeight: 361);
//               showCatchMore=false;
//             }
//           });
//         }
//
//       },
//       child: Container(
//          color: Color(0xff0DF892),
//          height: 56,
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              (duoSnapTask.scene==GenerateType.profile_one.name||duoSnapTask.scene==GenerateType.profile_two.name)?Container():SmallDuoSnap(task: duoSnapTask),
//              SizedBox(
//                width: 16,
//              ),
//              Text((duoSnapTask.scene==GenerateType.profile_one.name||duoSnapTask.scene==GenerateType.profile_two.name)?S.current.yourPictureIsReady:S.current.duoSnapIsReady,style: TextStyle(
//                  fontSize: 14,
//                  color: Color(0xff2c2c2c),
//                  fontWeight: FontWeight.w900
//              ),)
//            ],
//          ),
//        ),
//     );
//    }else if(generateState==GenerateState.fail){
//      return  Container(
//        color: Color(0xff797979),
//        height: 56,
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: [
//            Text("❗ ${S.current.issues}",style: TextStyle(
//                fontSize: 14,
//                color: Colors.white,
//                fontWeight: FontWeight.w900
//            ),),
//            LoadingButton(onPressed: () async{
//              SonaAnalytics.log(DuoSnapEvent.duo_retry.name);
//              try{
//                HttpResult response=await post('/merge-photo/retry',data: {
//                  'id':duoSnapTask.id
//                });
//                if(response.isSuccess){
//                  if(mounted){
//                    setState(() {
//                      generateState=GenerateState.line;
//                    });
//                  }
//                }else {
//                  Fluttertoast.showToast(msg: S.current.issues);
//                  if(mounted){
//                    setState(() {
//                      generateState=GenerateState.fail;
//                    });
//                  }
//                }
//              }catch(e){
//                Fluttertoast.showToast(msg: S.current.issues);
//                if(mounted){
//                  setState(() {
//                    generateState=GenerateState.fail;
//                  });
//                }
//              }
//
//             },
//             placeholder: Container(
//               alignment: Alignment.center,
//               child: SizedBox(child: CircularProgressIndicator(),width: 20,height: 20,),
//               width: 90,
//               height: 30,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(
//                       color: Color(0xff2c2c2c),
//                       width: 2
//                   )
//               ),
//             ),
//             child: Container(
//              alignment: Alignment.center,
//              child: Text(S.current.retry),
//              width: 90,
//              height: 30,
//              decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.circular(20),
//                  border: Border.all(
//                      color: Color(0xff2c2c2c),
//                      width: 2
//                  )
//              ),
//             )
//            ),
//            LoadingButton(onPressed: () async{
//
//              await post('/merge-photo/cancel',data: {
//                'id':duoSnapTask.id
//              });
//              generateState=GenerateState.cancel;
//              if(mounted){
//                setState(() {
//
//                });
//              }
//             }, placeholder: SizedBox(
//              width: 20,
//              height: 20,
//              child: CircularProgressIndicator(),
//            ),
//            child: SvgPicture.asset(Assets.svgDislike,width: 20,height: 20,),)
//          ],
//        ),
//      );
//    }else if(generateState==GenerateState.cancel||generateState==GenerateState.idel){
//      return Container();
//    }else {
//      return Container();
//    }
//   }
//
// }
// enum GenerateState{
//   generating,
//   fail,
//   line,
//   done,
//   cancel,
//   idel
// }
// enum GenerateType{
//   match,
//   chat,
//   profile_one,
//   profile_two,
//
// }
