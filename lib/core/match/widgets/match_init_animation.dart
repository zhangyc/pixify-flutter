import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/assets.dart';

class MatchInitAnimation extends StatelessWidget {
  const MatchInitAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: Colors.white,
      child: UnconstrainedBox(
         child: SizedBox(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
             child: Lottie.asset(Assets.lottieSearch)
         )
      )
    );
  }
}
