import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/assets.dart';

class MatchInitAnimation extends StatelessWidget {
  const MatchInitAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: Colors.black,
      child: UnconstrainedBox(
         child: SizedBox(
             width: 200,
             height: 200,
             child: Lottie.asset(Assets.lottieSearch)
         )
      )
    );
  }
}
