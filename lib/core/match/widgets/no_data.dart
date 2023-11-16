import 'package:flutter/material.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black,child: Column(
      children: [
        SizedBox(height: 128,),
        Text(S.current.noDataTips,
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
          child: Text(S.current.checkInternet,
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
