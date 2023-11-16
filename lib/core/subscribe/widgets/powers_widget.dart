import 'package:flutter/material.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';

class PowersWidget extends StatelessWidget {
  const PowersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
          horizontal: 8
      ),
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
            Image.asset(Assets.iconsSub1,width: 36,height: 34,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: S.current.powerSonaMessage,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: ' ${S.current.daily}',style: TextStyle(
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
            Image.asset(Assets.iconsSub2,width: 36,height: 34,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: S.current.powerUnlock,style: TextStyle(
                      color: Colors.black
                  )),
                  TextSpan(text: ' ${S.current.powerWhoLike}',style: TextStyle(
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
            Image.asset(Assets.iconsSub3,width: 36,height: 34,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: S.current.unlimited,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: ' ${S.current.likes}',style: TextStyle(
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
            Image.asset(Assets.iconsSub4,width: 36,height: 34,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: '${S.current.arrow} ',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: S.current.arrowInfo,style: TextStyle(
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
            Image.asset(Assets.iconsSub6,width: 36,height: 34,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: S.current.strategy,style: TextStyle(
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
            Image.asset(Assets.iconsSub7,width: 36,height: 34,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: S.current.chatStyle,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: S.current.chatStyleInfo ,style: TextStyle(
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