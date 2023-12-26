import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sona/core/match/widgets/image_loading_animation.dart';

import '../../../generated/assets.dart';

class GalleyItem extends StatelessWidget {
  const GalleyItem({super.key, required this.images});
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (_,i){
      if(i==0){
        return Container();
      }
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
            bottom: 16
        ),
        child: CachedNetworkImage(imageUrl: images[i],fit: BoxFit.cover,
          height: 457,
          width: MediaQuery.of(context).size.width-16*2,
          placeholder: (_,__){
            return ImageLoadingAnimation();
          },
        ),
      );
    },
    itemCount: images.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
    );
  }
}
