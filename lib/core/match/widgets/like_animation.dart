import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/screens/match.dart';
import 'package:sona/generated/assets.dart';

class ActionAnimation extends StatefulWidget {
  const ActionAnimation({super.key, required this.onLike, required this.onArrow, required this.userInfo,});
  final Function onLike;
  final Function onArrow;
  final UserInfo userInfo;
  @override
  State<ActionAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<ActionAnimation> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late AnimationController arrowController;

  @override
  void initState() {
    _animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 800),lowerBound: 0.1,upperBound: 1);
    arrowController=AnimationController(vsync: this,duration: Duration(milliseconds: 1500),lowerBound: 0.1,upperBound: 1);

    _animationController.addListener(() {
      setState(() {

      });
      if(_animationController.value.toStringAsFixed(1)=='0.8'){
        widget.onLike.call();
      }

    });
    arrowController.addListener(() {
      if(arrowController.isCompleted){
        widget.onArrow.call();
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

    return Stack(
      children: [
        Arrow(animationController2: arrowController),
        Container(
          margin: EdgeInsets.only(
            right: 20
          ),
          child: Column(
            children: [
              GestureDetector(child: Container(
                child: UnconstrainedBox(child: _animationController.isAnimating?
                 Lottie.asset(Assets.lottieLike,controller: _animationController,repeat: true,width: 50,height: 50,):
                 Image.asset(Assets.iconsLike,width: 50,height: 50,),),
              ),
                onTap: (){
                  _animationController.reset();
                  _animationController.forward();
                },
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(child: UnconstrainedBox(child: SizedBox(child: Image.asset(Assets.iconsArrow),width: 50,height: 50,)),
                onTap: (){
                  arrowController.reset();
                  arrowController.forward();
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
