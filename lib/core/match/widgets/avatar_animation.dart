import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sona/common/models/user.dart';

import '../../../generated/assets.dart';

class AvatarAnimation extends StatefulWidget {
  const AvatarAnimation({super.key, required this.avatar, required this.name, required this.direction});
  final String avatar;
  final String name;
  final AnimationDirection direction;
  @override
  State<AvatarAnimation> createState() => _AvatarAnimationState();
}

class _AvatarAnimationState extends State<AvatarAnimation>  with SingleTickerProviderStateMixin{
  late AnimationController animatedContainer;
  late Animation<Offset> animation;
  bool showName=false;
  @override
  void initState() {
    animatedContainer=AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    animatedContainer.forward();
    animatedContainer.addListener(() {
      if(animatedContainer.isCompleted){
        showName=true;
      }
      setState(() {

      });
    });
    //animation=CurvedAnimation(parent: animatedContainer, curve: Curves.easeIn);
     if(widget.direction==AnimationDirection.left){
       animation = Tween<Offset>(begin:Offset(-5, 0), end:  Offset.zero)
           .animate(animatedContainer);
     }else if(widget.direction==AnimationDirection.right){
       animation = Tween<Offset>(begin:Offset(5, 0) , end:Offset.zero )
           .animate(animatedContainer);
     }
    super.initState();
  }
  @override
  void dispose() {
    animatedContainer.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        SlideTransition(
          position: animation,
          child: ClipOval(
            child: CachedNetworkImage(imageUrl:widget.avatar,width: 160,height: 160,
              fit: BoxFit.cover,placeholder: (_,__){
                return Lottie.asset(Assets.lottieSearch,width: 160,height: 160);
              },),
          ),
        ),
        Container(
          width: 115,alignment: Alignment.center,
          child: Text(
            showName ? widget.name : '',
            maxLines: 2,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14
            )
          )
        )
      ],
    );
  }
}
enum AnimationDirection{
  left,
  right
}