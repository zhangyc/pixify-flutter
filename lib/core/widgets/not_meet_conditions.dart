import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/assets.dart';

class NotMeetConditions extends StatelessWidget {
  const NotMeetConditions({super.key, required this.close, required this.camera, required this.gallery});
  final Function close;
  final Function camera;
  final Function gallery;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
        Image.asset(Assets.imagesSnap1,width: 90,height: 90,),
        SizedBox(height: 12.0),
        Text('Duo snap require your real photo',
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
        )
      ],
    );
  }
}
