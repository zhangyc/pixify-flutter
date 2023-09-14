import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/assets.dart';

class MatchInitAnimation extends StatelessWidget {
  const MatchInitAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(child: SizedBox(child: Lottie.asset(Assets.lottieSearch),width: 200,height: 200));
  }
}
