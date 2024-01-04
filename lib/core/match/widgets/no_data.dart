import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, required this.onTap});
  final Function onTap;

  @override
  Widget build(BuildContext context) {

   return Column(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [ 
       Image.asset(Assets.imagesError,width: 132,height: 166,fit: BoxFit.cover,),
       const SizedBox(height: 32,),
       const Text('Oops, no data right now ',
         style: TextStyle(
             color: Color(0xff2c2c2c),
             fontSize: 16,
             fontWeight: FontWeight.w900
         ),
       ),
       const SizedBox(height: 4,),
       Text.rich(
           TextSpan(
               children: [
                 TextSpan(text: "Please check your internet or Tap to ",style: TextStyle(
                     color: Color(0xff727272),
                     fontSize: 14

                 ),),
                 TextSpan(text: "Refresh\n", style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff2c2c2c),)),
                 TextSpan(text: " and try again",style: TextStyle(
                     color: Color(0xff727272),
                     fontSize: 14

                 ),),
               ]
           ),
         textAlign: TextAlign.center,
       ),
       const SizedBox(height: 12,),
       Padding(
         padding: const EdgeInsets.symmetric(
             horizontal: 33
         ),
         child: ElevatedButton(onPressed: (){
           onTap.call();
          }, child: Container(child: const Text('Refresh',style: TextStyle(
           color: Colors.white,
         ),),
           height: 56,
           alignment: Alignment.center,
         ),
           style: ElevatedButton.styleFrom(
               backgroundColor: const Color(0xff2c2c2c)
           ),
         ),
       ),
     ],
   );
  }
}
