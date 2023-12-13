import 'package:flutter/material.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, required this.onTap});
  final Function onTap;

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
      onTap: (){
        onTap.call();
      },
      child: Container(color: Colors.black,child: Column(
        children: [
          SizedBox(height: 128,),
          Text('No Data',
            style: TextStyle(
                color: Colors.white
            ),
          ),
          SizedBox(height: 10,),
          ClipOval(
            child: Image.asset(Assets.imagesError,width: 151,height: 148,fit: BoxFit.cover,),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 55 ),
            child: Text('Check internet',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          )
        ],
      ),
        width: MediaQuery.of(context).size.width,

      ),
    );
  }
}
