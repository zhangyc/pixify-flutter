import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyImageAnimation extends StatefulWidget {
  const MyImageAnimation({super.key, required this.url});
  @override
  _MyImageAnimationState createState() => _MyImageAnimationState();
  final String url;
}

class _MyImageAnimationState extends State<MyImageAnimation> {
  double _containerWidth = 343; // 初始宽度
  double _containerHeight =457; // 初始高度
  @override
  void initState() {
    _startAnimation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1), // 动画持续时间
      width: _containerWidth,
      height: _containerHeight,
      child: CachedNetworkImage(imageUrl: widget.url),
    );
  }

  void _startAnimation() {
    setState(() {
      // 在这里修改目标宽高比例
      _containerWidth = 95;
      _containerHeight = 118;
    });
  }
}