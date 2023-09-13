import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sona/generated/assets.dart';

class LikeAnimation extends StatefulWidget {
  const LikeAnimation({super.key, required this.onTap});
  final Function onTap;
  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 200));
    _animationController.addListener(() {
      if(_animationController.isCompleted){
        widget.onTap.call();
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Lottie.asset(Assets.lottieLike,controller: _animationController,repeat: false),
      onTap: (){

        _animationController.forward();
      },
    );
  }
}
