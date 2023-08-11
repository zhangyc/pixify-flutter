import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class BubbleButtonn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BubbleButtonState();
}

class _BubbleButtonState extends State<BubbleButtonn> with SingleTickerProviderStateMixin {
  // 动画控制器
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}