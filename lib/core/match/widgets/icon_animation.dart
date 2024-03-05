import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../generated/assets.dart';
import '../providers/match_provider.dart';
import 'custom_pageview/src/skip_transformer.dart';

ValueNotifier<double> pageControllerProgress=ValueNotifier<double>(0);
class IconAnimation extends ConsumerStatefulWidget {
  const IconAnimation({super.key});

  @override
  ConsumerState createState() => _IconAnimationState();
}

class _IconAnimationState extends ConsumerState<IconAnimation> {
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<TransformStatus>(
      valueListenable: matchAnimation,
      builder: (context, value, child) {
        if(value==TransformStatus.idle){
          return Container();
        }
        double fractionalPart = pageControllerProgress.value % 1;
        if(fractionalPart==0.0){
          return Container();
        }
        if (fractionalPart<0.1) {
          return Container(alignment: Alignment.topCenter,
           width: MediaQuery.of(context).size.width-16*2,child: SvgPicture.asset(value==TransformStatus.rightRotate?Assets.svgLikeTag:Assets.svgDislikeTag),
          );
        } else {
          return Container();
        }
      },
    );
  }

}

