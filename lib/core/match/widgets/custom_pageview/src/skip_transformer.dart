import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../providers/match_provider.dart';
import 'transformer_page_view.dart';
enum TransformStatus {
  leftRotate,
  rightRotate,
  idle
}
///这个设计一般般，权宜之计
// TransformStatus currentStatus = TransformStatus.leftRotate;
class RotatePageTransformer extends PageTransformer {
  RotatePageTransformer() : super(reverse: false);

  @override
  Widget transform(Widget child, TransformInfo info) {
    final position = info.position!;

    if(matchAnimation.value==TransformStatus.leftRotate){
      if (position <= 0) {
        double angle = position;
        angle += 2 * pi;
        return Transform(
          alignment: AlignmentDirectional(0, 1),
          transform: Matrix4.identity()
            ..rotateZ(angle),
          child: child,
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
    }else if(matchAnimation.value==TransformStatus.rightRotate){
      if (position <= 0) {

        double angle = -position * pi / 2;

        return Transform(
          alignment: AlignmentDirectional(0, 2),
          transform: Matrix4.identity()
            // ..translate(0.0, 0.0)
            ..rotateZ(angle),
          child: child,
        );
      } else if (position <= 1) {
        // 离场部分改为底部中心旋转
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
    }
    return child;
  }
}
class RotateRightPageTransformer extends PageTransformer {

  @override
  Widget transform(Widget child, TransformInfo info) {
    final position = info.position!;

    if (position <= 0) {
      double angle = -position * pi / 2;

      return Transform(
        alignment: AlignmentDirectional(0, 1),
        transform: Matrix4.identity()
          ..translate(0.0, 0.0)
          ..rotateZ(angle),
        child: child,
      );
    } else if (position <= 1) {
      // 离场部分改为底部中心旋转
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