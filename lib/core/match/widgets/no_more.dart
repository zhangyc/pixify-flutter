import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class NoMoreWidget extends StatelessWidget {
  const NoMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black,child: Column(
      children: [
        SizedBox(height: 128,),
        ClipOval(
          child: Image.asset(Assets.imagesError,width: 151,height: 148,fit: BoxFit.cover,),
        ),
        SizedBox(height: 10,),
        const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 30
          ),
          child: Text('Your recommendation is on cooldown \nIt will be available again tomorrow',
            style: TextStyle(
                color: Colors.white
            ),
          ),
        )
      ],
    ),
      width: MediaQuery.of(context).size.width,

    );
  }
}
