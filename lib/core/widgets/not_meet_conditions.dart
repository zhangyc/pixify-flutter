import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';

class NotMeetConditions extends StatelessWidget {
  const NotMeetConditions({super.key, required this.close, required this.camera, required this.gallery, required this.anyway});
  final Function close;
  final Function camera;
  final Function gallery;
  final Function anyway;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
        Image.asset(Assets.imagesSnap1,width: 90,height: 90,),
        SizedBox(height: 12.0),
        Text(S.current.requireYourRealPhoto,
          style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800
         ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                camera.call();
              },
              child: Container(
                alignment: Alignment.center,

                height: 56,
                width: 168,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  'Take a photo',
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
                gallery.call();
              },
              child: Container(
                alignment: Alignment.center,

                height: 56,
                width: 168,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xff2c2c2c)
                ),
                child: Text(
                  'From libary',
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
        GestureDetector(
          child: Text(S.current.duosnapAnyway,style: TextStyle(
            color: Color(0xff0066FF),
            fontWeight: FontWeight.w800,
            fontSize: 16
           ),
          ),
          onTap: (){
             anyway.call();
          },
        )
      ],
    );
  }
}
