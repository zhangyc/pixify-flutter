import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/assets.dart';

class MatchLoading extends StatelessWidget {
  const MatchLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Lottie.asset(Assets.lottieLoading),
    );
  }
}
