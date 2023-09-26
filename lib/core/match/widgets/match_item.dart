import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../account/providers/profile.dart';
import '../../../common/models/user.dart';
import '../../../generated/assets.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/matched.dart';
import 'like_animation.dart';
import 'user_card.dart';

class MatchItem extends ConsumerStatefulWidget {
  const MatchItem(this.index, {super.key,
    required this.userInfo,
    required this.controller,
    // required this.onArrow,
    required this.onLike,
    required this.length,
  });
  final UserInfo userInfo;
  final PageController controller;
  // final Function onArrow;
  final Function onLike;
  final int index;
  final int length;
  @override
  ConsumerState<MatchItem> createState() => _MatchItemState();
}

class _MatchItemState extends ConsumerState<MatchItem> with SingleTickerProviderStateMixin{
  late AnimationController arrowController;

  @override
  void initState() {
    arrowController=AnimationController(vsync: this,duration: Duration(milliseconds: 1500),lowerBound: 0.1,upperBound: 1);
    arrowController.addListener(() {
      if(arrowController.isCompleted){
        if (widget.index < widget.length - 1) {
          widget.controller.animateToPage(widget.index + 1, duration: const Duration(milliseconds: 200),
              curve: Curves.linearToEaseOut);
        }
        setState(() {

        });
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    arrowController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        UserCard(
          key: ValueKey(widget.userInfo.id),
          user: widget.userInfo,
        ),
        Arrow(animationController: arrowController),
        Positioned(child: LikeAnimation(onLike: widget.onLike, userInfo: widget.userInfo),
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 150,),
        Positioned(
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 80,
            child:  GestureDetector(child: Image.asset(Assets.iconsArrow,width: 50,height: 50,),
              onTap: () async {
                final resp=await ref.read(asyncMatchRecommendedProvider.notifier).arrow(widget.userInfo.id);
                if(resp.isSuccess){
                  arrowController.reset();
                  arrowController.forward() ;
                  widget.userInfo.arrowed=true;
                }else if(resp.statusCode==10150){
                  /// 判断如果不是会员，跳转道会员页面
                  if(ref.read(myProfileProvider)?.isMember??false){
                    Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                      return SubscribePage();
                    }));
                  }else {
                    Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                  }
                }
                setState(() {

                });
              },
            )
        )
      ],
    );
  }
}
class Arrow extends StatelessWidget {
  const Arrow({
    super.key,
    required AnimationController animationController,
  }) : _animationController2 = animationController;

  final AnimationController _animationController2;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ColoredBox(
        color: _animationController2.isAnimating?Colors.black.withOpacity(0.5):Colors.transparent,
        child: Center(child: _animationController2.isAnimating?Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(duration: Duration(milliseconds: 1500),
              child: Image.asset(Assets.imagesArrow,),
              curve: Curves.fastOutSlowIn,
              width: 300,
              height:300,
            ),
            Lottie.asset(Assets.lottieArrowAnimation,
                controller: _animationController2,repeat: true),

          ],
        ):Container()),
      ),
    );
  }
}