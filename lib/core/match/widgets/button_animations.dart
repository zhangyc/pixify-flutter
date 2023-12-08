import 'package:flutter/material.dart';

class ScaleAnimation extends StatefulWidget {
  const ScaleAnimation({super.key, required this.child, required this.onTap});
  final Widget child;
  final Function onTap;

  @override
  State<ScaleAnimation> createState() => _ScaleAnimationState();
}

class _ScaleAnimationState extends State<ScaleAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.7).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _controller.forward();
          widget.onTap.call();
        },
        child: Transform.scale(
          scale: _animation.value,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
