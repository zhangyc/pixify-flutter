import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/permission/permission.dart';
import '../../../generated/assets.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        CachedNetworkImage(imageUrl: url,width: 343,height: 457,),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(Assets.svgDownload,width: 56,height: 56,),

            SvgPicture.asset(Assets.svgShare,width: 56,height: 56,),
          ],
        )
      ],
    );
  }
}
