import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:sona/common/permission/permission.dart';

import '../../../account/providers/profile.dart';
import '../../../common/models/user.dart';
import '../../../generated/assets.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/matched.dart';
import '../util/event.dart';
import 'like_animation.dart';

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
          widget.controller.animateToPage(widget.index + 1, duration: const Duration(milliseconds: 1000),
              curve: Curves.linearToEaseOut);
        }
        // setState(() {
        //
        // });
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
        // UserCard(
        //   key: ValueKey(widget.userInfo.id),
        //   user: widget.userInfo,
        // ),
        Arrow(animationController: arrowController),
        Positioned(
          right: 20,
          bottom: MediaQuery.of(context).padding.bottom+16,
          child: LikeAnimation(onLike: widget.onLike, userInfo: widget.userInfo)
        ),
        kReleaseMode?Container():Positioned(
            top: 50,
            child: Text(widget.userInfo.allScore??'')
        ),
        Positioned(
            right: 20,
            bottom:  MediaQuery.of(context).padding.bottom+10+50+24,
            child:  GestureDetector(child: Image.asset(Assets.iconsArrow,width: 50,height: 50,),
              onTap: (){
                if(canArrow){
                  arrow=arrow-1;
                  MatchApi.arrow(widget.userInfo.id);
                  SonaAnalytics.log(MatchEvent.match_arrow_send.name);
                  arrowController.reset();
                  arrowController.forward() ;
                }else {
                  bool isMember=ref.read(myProfileProvider)?.isMember??false;
                  if(isMember){
                    Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                  }else{
                    Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                      return SubscribePage(SubscribeShowType.unLockDM(),fromTag: FromTag.pay_match_arrow,);
                    }));
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
            _animationController2.isCompleted?Container():AnimatedContainer(duration: const Duration(milliseconds: 1500),
              curve: Curves.fastOutSlowIn,
              width: 300,
              height:300,
              child: Image.asset(Assets.imagesArrow,),
            ),
            Lottie.asset(Assets.lottieArrowAnimation,
                controller: _animationController2,repeat: true),

          ],
        ):Container()),
      ),
    );
  }
}
