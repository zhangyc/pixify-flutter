import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

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
          Row(
            children: [
              Image.asset(Assets.iconsCorrect,width: 14,height: 14,),
              SizedBox(
                width: 8,
              ),
              RichText(text: TextSpan(
                  children: [
                    TextSpan(text: 'Uncover',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    )),
                    TextSpan(text: ' your secret Sonamate',style: TextStyle(
                        color: Colors.black
                    )),
                  ]
              )),

            ],
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
                      TextSpan(text: '1000 AI Interpretation',style: TextStyle(
                          color: Colors.black
                      )),
                      TextSpan(text: ' messages daily',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      )),

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
                      TextSpan(text: 'DM ',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      )),
                      TextSpan(text: '- Message people you like directly',style: TextStyle(
                          color: Colors.black
                      )),
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
                      TextSpan(text: '3 Wishes ',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      )),
                      TextSpan(text: '- make friends from specific countries',style: TextStyle(
                          color: Colors.black
                      )),
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
                      TextSpan(text: 'SONA Tips -',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      )),
                      TextSpan(text: ' Get tips from SONA anytime' ,style: TextStyle(
                          color: Colors.black
                      )),
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