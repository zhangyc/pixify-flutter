import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';

class OtherNotMeetConditions extends StatelessWidget {
  const OtherNotMeetConditions({super.key, required this.close, required this.gotit, required this.sendDM, required this.anyway});
  final Function close;
  final Function gotit;
  final Function sendDM;
  final Function anyway;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            // border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current.duoSnap,
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
        Text(S.current.photoMightNotBeReal,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800
          ),
        ),
        SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                gotit.call();
              },
              child: Container(
                alignment: Alignment.center,
                height: 56,
                width: 168,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white
                ),
                child: Text(
                  S.current.gotIt,
                  style: TextStyle(
                    color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                sendDM.call();
              },
              child: Container(
                height: 56,
                width: 168,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xff2c2c2c)
                ),
                child: Text(
                  S.current.sendDm,
                  style: TextStyle(
                    color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(
          onPressed: () {
            anyway.call();
          },
          child: Text(
            S.current.duosnapAnyway,
            style: TextStyle(
                color: Color(0xff0066FF),
                fontWeight: FontWeight.w800,
                fontSize: 16),
          ),
        )
      ],
    );
  }
}
