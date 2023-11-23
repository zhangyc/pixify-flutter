import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sona/generated/assets.dart';

class GalleyItem extends StatelessWidget {
  const GalleyItem({super.key, required this.images});
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: images.map((e) => Container(
          margin: EdgeInsets.only(
            bottom: 16
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(imageUrl: e,width: MediaQuery.of(context).size.width-16*2,height: 457,fit: BoxFit.cover,))).toList(),
    );
  }
}
