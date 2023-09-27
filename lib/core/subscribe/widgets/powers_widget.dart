import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class PowersWidget extends StatelessWidget {
  const PowersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
          horizontal: 16
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
                  TextSpan(text: '100 Sona messages',style: TextStyle(
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
            Image.asset(Assets.iconsSub2,width: 36,height: 34,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: 'Unlock to see',style: TextStyle(
                      color: Colors.black
                  )),
                  TextSpan(text: ' who liked me',style: TextStyle(
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
                  TextSpan(text: 'Unlimited',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: ' Likes',style: TextStyle(
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
                  TextSpan(text: 'Arrows -1 ',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: 'Message people you like directly',style: TextStyle(
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
            Image.asset(Assets.iconsSub5,width: 36,height: 34,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: 'Hook - ',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: 'Stand out and boost reply rate',style: TextStyle(
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
            Image.asset(Assets.iconsSub6,width: 36,height: 34,),
            SizedBox(
              width: 8,
            ),
            RichText(text: TextSpan(
                children: [
                  TextSpan(text: 'Advisor - ',style: TextStyle(
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
                  TextSpan(text: 'Chat Styles - ',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )),
                  TextSpan(text: 'Unlock 6 chat styles',style: TextStyle(
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