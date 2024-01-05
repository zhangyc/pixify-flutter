import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class NoLocation extends StatelessWidget {
  const NoLocation({super.key, required this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Assets.imagesTenderAffection),
        Text("Sorry,you've got to allow location access before you can use this service "),
        SizedBox(height: 12,),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 33
          ),
          child: ElevatedButton(onPressed: (){
            onTap.call();
           }, child: Container(child: Text('Authorize',style: TextStyle(
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
