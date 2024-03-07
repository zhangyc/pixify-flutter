import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class DuosnapLoading extends StatefulWidget {
  const DuosnapLoading({super.key});
  
  @override
  State<DuosnapLoading> createState() => _ImageLoadingAnimationState();
}

class _ImageLoadingAnimationState extends State<DuosnapLoading> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  // 渐变起始和结束颜色
  Color startColor = Color(0xffE8E6E6).withOpacity(0.5);
  Color endColor = Color(0xffE8E6E6).withOpacity(0.5);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 初始化动画控制器和动画
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // 添加监听器，当动画值发生变化时调用setState
    _animation.addListener(() {
      setState(() {});
    });

    // 添加循环动画
    _controller.repeat(reverse: true);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            foregroundDecoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                stops: [0,_animation.value,1],
                colors: [
                  Color.lerp(startColor, endColor, _animation.value)!,
                  Colors.white,
                  Color.lerp(startColor, endColor, _animation.value * 0.5)!
                ],
              ),
            ),

          child: Container(
            foregroundDecoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Assets.imagesSona)),
            ),
            alignment: Alignment.center,
            width: 95,
            height: 95,
          ),
        )
      ],
    );
  }
}
