import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../generated/assets.dart';


class IconAnimation extends ConsumerStatefulWidget {
  const IconAnimation({super.key});

  @override
  ConsumerState createState() => _IconAnimationState();
}

class _IconAnimationState extends ConsumerState<IconAnimation> {
  @override
  Widget build(BuildContext context) {
    return Container(alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width-16*2,child: SvgPicture.asset(Assets.svgLikeTag),
    );
  }

}

