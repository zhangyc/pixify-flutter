import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/assets.dart';

class MatchInitAnimation extends StatelessWidget {
  const MatchInitAnimation({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(color: Colors.white,alignment: Alignment.center,child: Lottie.asset(Assets.lottieSearch),);
  }
}
