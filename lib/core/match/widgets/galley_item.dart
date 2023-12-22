import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
            image: DecorationImage(image: CachedNetworkImageProvider(e),fit: BoxFit.cover),
          ),
          height: 457,
          width: MediaQuery.of(context).size.width-16*2,
      )).toList(),
    );
    // return Container(
    //   height: 500,
    //   color: Colors.black,
    // );
    if(images.isNotEmpty){
      images.removeAt(0);
    }
    return Column(
      children: images.map((e) => Container(
          height: 457,
          // margin: EdgeInsets.only(
          //   bottom: 16
          // ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.black,

          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(imageUrl: e,width: MediaQuery.of(context).size.width-16*2,height: 457,fit: BoxFit.cover,)
      )).toList(),
    );
  }
}
