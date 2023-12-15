import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, required this.onTap});
  final Function onTap;

  @override
  Widget build(BuildContext context) {
   return Container(color: Colors.white,child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Image.asset(Assets.imagesError,width: 132,height: 166,fit: BoxFit.cover,),
       SizedBox(height: 32,),
       Text('Oops, no data right now ',
         style: TextStyle(
             color: Color(0xff2c2c2c),
             fontSize: 16,
             fontWeight: FontWeight.w900
         ),
       ),
       SizedBox(height: 4,),

       Text('Please check your internet or Tap to Refresh and try again',
         style: TextStyle(
             color: Color(0xff2c2c2c),
             fontSize: 14

         ),
       ),
       SizedBox(height: 12,),
       ElevatedButton(onPressed: (){
         onTap.call();
       }, child: Center(child: Text('Refresh',style: TextStyle(
         color: Colors.white
       ),)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff2c2c2c)
        ),
       ),
     ],
   ),
     width: MediaQuery.of(context).size.width,
     padding: EdgeInsets.symmetric(
         horizontal: 33
     ),

   );
  }
}
