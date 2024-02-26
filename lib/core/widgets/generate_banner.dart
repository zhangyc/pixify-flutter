import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/widgets/dialogs.dart';
import 'package:sona/core/match/widgets/duosnap_completed.dart';

import '../../account/providers/profile.dart';
import '../../generated/assets.dart';

class GenerateBanner extends ConsumerStatefulWidget {
  const GenerateBanner({super.key});

  @override
  ConsumerState createState() => _GenerateBannerState();
}

class _GenerateBannerState extends ConsumerState<GenerateBanner> {
  GenerateState _generateState=GenerateState.done;
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
        showDuoSnapCompleted(context,
          700,
          DuosnapCompleted(
              close:(){
                Navigator.pop(context);
              })
        );
      },
      child: Container(
         color: Color(0xff656565),
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
                         clipBehavior: Clip.antiAlias,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(8),
                             border: Border.all(
                                 color: Colors.white,
                                 width: 2
                             )
                         ),
                           child: CachedNetworkImage(
                             imageUrl: ref.read(myProfileProvider)!.avatar??'',
                             width: 26,
                             height: 35,
                           )
                       );
                     },)), // 替换为您的左侧图片路径
                 Transform.rotate(
                     angle: 15 * 3.14 / 180,
                     child: Container(
                         clipBehavior: Clip.antiAlias,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                             border: Border.all(
                             color: Colors.white,
                             width: 2
                           )
                         ),
                         child: CachedNetworkImage(
                           imageUrl: '',
                           width: 26,
                           height: 35,
                         )
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
   }else {
     return Container();
   }
  }

}
enum GenerateState{
  requesting,
  line,
  almost,
  done
}
