import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class NoMoreWidget extends StatelessWidget {
  const NoMoreWidget({super.key, required this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Assets.imagesError,width: 132,height: 166,fit: BoxFit.cover,),
        SizedBox(height: 32,),
        Text('Sona Recommendation: Cooldown \nWhat to do: Wait\nSuggestion: Watch a movie?',
          style: TextStyle(
              color: Color(0xff2c2c2c),
              fontSize: 14

          ),
        ),
        SizedBox(height: 12,),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 33
          ),
          child: ElevatedButton(onPressed: (){
            onTap.call();
          }, child: Container(child: Text('Refresh',style: TextStyle(
              color: Colors.white,
          ),),
            height: 56,
            alignment: Alignment.center,
          ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff2c2c2c)
            ),
          ),
        ),
      ],
    );
  }
}
