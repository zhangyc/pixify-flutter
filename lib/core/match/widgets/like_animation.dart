import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/screens/match.dart';
import 'package:sona/generated/assets.dart';

class LikeAnimation extends StatefulWidget {
  const LikeAnimation({super.key, required this.onLike, required this.userInfo,});
  final Function onLike;
  final UserInfo userInfo;
  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation> with TickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 800),lowerBound: 0.1,upperBound: 1);

    _animationController.addListener(() {
      setState(() {

      });
      if(_animationController.value.toStringAsFixed(1)=='0.8'){
        widget.onLike.call();
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

    return GestureDetector(child: Container(
      child: UnconstrainedBox(child: _animationController.isAnimating?
       Lottie.asset(Assets.lottieLike,controller: _animationController,repeat: true,width: 50,height: 50,):
       Image.asset(Assets.iconsLike,width: 50,height: 50,),),
    ),
      onTap: (){
        _animationController.reset();
        _animationController.forward();
      },
    );
  }
}
