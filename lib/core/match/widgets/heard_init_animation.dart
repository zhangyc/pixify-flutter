import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HeardInitAnimation extends StatefulWidget {
  const HeardInitAnimation({super.key, required this.child});
  final Widget child;
  @override
  State<HeardInitAnimation> createState() => _HeardInitAnimationState();
}

class _HeardInitAnimationState extends State<HeardInitAnimation> {
  double _scaleValue = 0.5;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300),
      builder: (BuildContext context, double value, Widget? child) {
        _scaleValue = 0.5 + value * 0.5; // 调整缩放值

        // 渐变的白色颜色，您可以根据需要调整颜色和透明度
        Color gradientColor = Colors.white.withOpacity(1.0 - value);

        return Transform.scale(
          scale: _scaleValue,
          child: Stack(
            children: [
              // 底层显示清晰的图片
              Container(
                width: MediaQuery.of(context).size.width - 16 * 2, // 根据需要调整宽度
                height: 457, // 根据需要调整高度
                child: widget.child,
              ),
              // 顶层渐变的白色容器
              Container(
                width: MediaQuery.of(context).size.width - 16 * 2, // 根据需要调整宽度
                height: 457, // 根据需要调整高度
                color: gradientColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
