import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class NoMoreWidget extends StatelessWidget {
  const NoMoreWidget({super.key, required this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
          horizontal: 33
      ),child: Column(
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

    );
  }
}
