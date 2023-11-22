import 'package:flutter/material.dart';
import 'package:sona/generated/assets.dart';

class GalleyItem extends StatelessWidget {
  const GalleyItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ['A','A','A','A','A','A',].map((e) => Container(
          margin: EdgeInsets.only(
            bottom: 16
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(Assets.imagesTest,width: MediaQuery.of(context).size.width-16*2,height: 457,fit: BoxFit.cover,))).toList(),
    );
  }
}
