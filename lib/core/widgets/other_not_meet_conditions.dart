import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';

class OtherNotMeetConditions extends StatelessWidget {
  const OtherNotMeetConditions({super.key, required this.close, required this.gotit, required this.sendDM});
  final Function close;
  final Function gotit;
  final Function sendDM;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            // border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Duo Snap',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
              ),
              IconButton(
                icon: SvgPicture.asset(Assets.svgDislike,width: 40,height: 40,),
                onPressed: (){
                  close.call();
                },
              ),
            ],
          ),
        ),
        Image.asset(Assets.imagesSnap1,width: 90,height: 90,),
        SizedBox(height: 16.0),
        Text("The other person isn't a real photo, so we can't merge photos!",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800
          ),
        ),
        SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              height: 56,
              width: 168,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: GestureDetector(
                onTap: () {
                  gotit.call();
                },
                child: Text(
                  'Got it',
                  style: TextStyle(
                    color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
            ),
            Container(
              height: 56,
              width: 168,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xff2c2c2c)
              ),
              child: GestureDetector(
                onTap: () {
                  sendDM.call();
                },
                child: Text(
                  'Send DM',
                  style: TextStyle(
                    color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
