import 'package:flutter/material.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';

class PowersWidget extends StatelessWidget {
  const PowersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
                SizedBox(
                  width: 8,
                ),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(text: S.current.plusFuncUnlockWhoLikesU,style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.black
                      )),
                      // TextSpan(text: ' your secret Sonamate',style: TextStyle(
                      //     color: Colors.black
                      // )),
                    ]
                )),

              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
                SizedBox(
                  width: 8,
                ),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(text: S.current.plusFuncAIInterpretation,style: TextStyle(
                          color: Colors.black
                      )),
                      // TextSpan(text: ' messages daily',style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black
                      // )),
                    ]
                )),
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
                SizedBox(
                  width: 8,
                ),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(text: S.current.plusFuncUnlimitedLikes,style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.black
                      )),
                      // TextSpan(text: ' Likes',style: TextStyle(
                      //     color: Colors.black
                      // )),
                    ]
                )),
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
                SizedBox(
                  width: 8,
                ),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(text: S.current.plusFuncDMPerWeek,style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.black
                      )),
                      // TextSpan(text: '- Message people you like directly',style: TextStyle(
                      //     color: Colors.black
                      // )),
                    ]
                )),
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
                SizedBox(
                  width: 8,
                ),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(text: S.current.plusFuncWishes,style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.black
                      )),
                      // TextSpan(text: '- make friends from specific countries',style: TextStyle(
                      //     color: Colors.black
                      // )),
                    ]
                )),
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
                SizedBox(
                  width: 8,
                ),
                RichText(text: TextSpan(
                    children: [
                      TextSpan(text: S.current.plusFuncSonaTips,style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.black
                      )),
                      // TextSpan(text: ' Get tips from SONA anytime' ,style: TextStyle(
                      //     color: Colors.black
                      // )),
                    ]
                )),
              ],
            ),
          ),
          SizedBox(
            height: 9,
          ),
        ],
      ),
    );
  }
}