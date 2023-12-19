import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../generated/assets.dart';
import '../providers/match_provider.dart';
import 'custom_pageview/src/skip_transformer.dart';


class IconAnimation extends ConsumerStatefulWidget {
  const IconAnimation({super.key});

  @override
  ConsumerState createState() => _IconAnimationState();
}

class _IconAnimationState extends ConsumerState<IconAnimation> {
  @override
  Widget build(BuildContext context) {

    final co = ref.watch(pageControllerProvider);

    return co.hasClients?ValueListenableBuilder<TransformStatus>(
      valueListenable: matchAnimation,
      builder: (context, value, child) {
        if(value==TransformStatus.idle||!co.hasClients){
          return Container();
        }
        double fractionalPart = co.page! % 1;

        if (co.position.isScrollingNotifier.value&&fractionalPart<0.1) {
          return Container(child: SvgPicture.asset(value==TransformStatus.rightRotate?Assets.svgLikeTag:Assets.svgDislikeTag),alignment: Alignment.topCenter,
          width: MediaQuery.of(context).size.width-16*2,
          );
        } else {
          return Container();
        }
      },
    ):Container();
  }
}

