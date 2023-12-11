import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class NoMoreWidget extends StatelessWidget {
  const NoMoreWidget({super.key, required this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap.call();
      },
      child: Container(color: Colors.black,
        width: MediaQuery.of(context).size.width,child: Column(
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

      ),
    );
  }
}
