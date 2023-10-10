import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black,child: Column(
      children: [
        SizedBox(height: 128,),
        const Text('oOps, no data right now ',
          style: TextStyle(
              color: Colors.white
          ),
        ),
        SizedBox(height: 10,),
        ClipOval(
          child: Image.asset(Assets.imagesError,width: 151,height: 148,fit: BoxFit.cover,),
        ),
        SizedBox(height: 10,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 55 ),
          child: Text('Please check your internet or Tap to Refresh and try again',
            style: TextStyle(
                color: Colors.white
            ),
          ),
        )
      ],
    ),);
  }
}
