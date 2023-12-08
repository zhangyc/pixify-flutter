import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'transformer_page_view.dart';

class RotateDepthPageTransformer extends PageTransformer {
  RotateDepthPageTransformer() : super(reverse: true);

  @override
  Widget transform(Widget child, TransformInfo info) {
    final position = info.position!;
    if (position <= 0) {
      double angle = position;
      angle += 2 * pi;
      return Transform(
        alignment: AlignmentDirectional(0, 1),
        transform: Matrix4.identity()
          ..rotateZ(angle),
        child: child,
      );
      return Opacity(
        opacity: 1.0,
        child: Transform.translate(
          offset: Offset.zero,
          child: Transform.scale(
            scale: 1.0,
            child: child,
          ),
        ),
      );
    } else if (position <= 1) {
      const minScale = 0.75;
      // Scale the page down (between minScale and 1)
      final scaleFactor = minScale + (1 - minScale) * (1 - position);

      return Opacity(
        opacity: 1.0 - position,
        child: Transform.translate(
          offset: Offset(info.width! * -position, 0.0),
          child: Transform.scale(
            scale: scaleFactor,
            child: child,
          ),
        ),
      );
    }

    return child;
  }
}