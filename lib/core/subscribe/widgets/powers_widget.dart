import 'package:flutter/material.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';

class PowersWidget extends StatelessWidget {
  const PowersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 9,
        ),
        Text('Super Sona Powers',style: TextStyle(
            color: Color(0xffFF3998),
            fontSize: 14
        ),),
        SizedBox(
          height: 9,
        ),
        Row(
          children: [
            Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: 'W...',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: ' daily',style: TextStyle(
                      color: Colors.black
                  )),
                ]
            )),

          ],
        ),
        SizedBox(
          height: 9,
        ),
        Row(
          children: [
            Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: 'Unlock',style: TextStyle(
                      color: Colors.black
                  )),
                  TextSpan(text: ' Who like',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),

                ]
            )),
          ],
        ),
        SizedBox(
          height: 9,
        ),
        Row(
          children: [
            Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: 'unlimited',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: ' likes',style: TextStyle(
                      color: Colors.black
                  )),
                ]
            )),
          ],
        ),
        SizedBox(
          height: 9,
        ),
        Row(
          children: [
            Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: 'DM ',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: 'DM',style: TextStyle(
                      color: Colors.black
                  )),
                ]
            )),
          ],
        ),
        // SizedBox(
        //   height: 9,
        // ),
        // Row(
        //   children: [
        //     Image.asset(Assets.iconsSub5,width: 36,height: 34,),
        //     SizedBox(
        //       width: 8,
        //     ),
        //     RichText(text: TextSpan(
        //         children: [
        //           TextSpan(text: 'Hook - ',style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               color: Colors.black
        //           )),
        //           TextSpan(text: 'Stand out and boost reply rate',style: TextStyle(
        //               color: Colors.black
        //           )),
        //         ]
        //     )),
        //   ],
        // ),
        SizedBox(
          height: 9,
        ),
        Row(
          children: [
            Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: 'strategy',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: 'Get advice from Sona anytime',style: TextStyle(
                      color: Colors.black
                  )),
                ]
            )),
          ],
        ),
        SizedBox(
          height: 9,
        ),
        Row(
          children: [
            Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: 'Chat Style',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: 'Chat Style' ,style: TextStyle(
                      color: Colors.black
                  )),
                ]
            )),
          ],
        ),
        SizedBox(
          height: 9,
        ),
      ],
    );
  }
}