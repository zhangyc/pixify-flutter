import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sona/generated/assets.dart';

class ActionAnimation extends StatefulWidget {
  const ActionAnimation({super.key, required this.onTap, required this.onArrow});
  final Function onTap;
  final Function onArrow;
  @override
  State<ActionAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<ActionAnimation> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late AnimationController _animationController2;

  @override
  void initState() {
    _animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 200));
    _animationController2=AnimationController(vsync: this,duration: Duration(milliseconds: 200));

    _animationController.addListener(() {
      if(_animationController.isCompleted){
        widget.onTap.call();
      }
    });
    _animationController2.addListener(() {
      if(_animationController2.isCompleted){
        widget.onArrow.call();
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    _animationController.dispose();
    _animationController2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(child: Container(child: Lottie.asset(Assets.lottieLike,controller: _animationController,repeat: false),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(25),
                 bottomLeft: Radius.circular(25),
                 topRight: Radius.zero,
                 bottomRight: Radius.zero
               ),
               color: Colors.white.withOpacity(0.7)
             ),
            width: 100,
            height: 48,
            ),
            onTap: (){
              _animationController.forward();

            },
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(child: Container(child: Lottie.asset(Assets.lottieLike,controller: _animationController2,repeat: false),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    topRight: Radius.zero,
                    bottomRight: Radius.zero
                ),
                color: Colors.white.withOpacity(0.7)
            ),
            width: 100,
            height: 48,
          ),
            onTap: (){
              _animationController2.forward();
            },
          )
        ],
      ),
    );
    return GestureDetector(child: Lottie.asset(Assets.lottieLike,controller: _animationController,repeat: false),
      onTap: (){

        _animationController.forward();
      },
    );
  }
}
