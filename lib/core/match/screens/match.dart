import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/match/widgets/custom_scrollphysics.dart';
import 'package:sona/core/match/widgets/user_card.dart';
import 'package:sona/generated/assets.dart';
import 'package:stacked_page_view/stacked_page_view.dart';

import '../../../common/widgets/button/colored.dart';
import '../widgets/like_animation.dart';
import '../widgets/match_init_animation.dart';
// import '../widgets/scroller.dart' as s;

class MatchScreen extends StatefulHookConsumerWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen>
    with AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin {
  late AnimationController _animationController2;

  @override
  void initState() {
    _animationController2=AnimationController(vsync: this,duration: Duration(milliseconds: 1500));
    _animationController2.addStatusListener((s) {
           setState(() {

           });
    });
    super.initState();
  }
  @override
  void dispose() {
    _animationController2.dispose();
    super.dispose();
  }
  String imageUrl='';

  int currentPage=0;
  PageController pageController=PageController();
  bool scrolling=true;
  ScrollPhysics scrollPhysics=AlwaysScrollableScrollPhysics();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ref.watch(asyncMatchRecommendedProvider).when<Widget>(
      data: (List<UserInfo> users) {
        if (users.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: const Text('No more.'),
          );
        }
        return Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                itemBuilder: (c,index) {
                  return StackPageView(
                    index: index,
                    controller: pageController,
                    child: UserCard(
                      key: ValueKey(users[index].id),
                      user: users[index],
                      actions: [
                        Positioned(
                          child: ColoredBox(
                            color: _animationController2.isAnimating?Colors.black.withOpacity(0.5):Colors.transparent,
                            child: Center(child: _animationController2.isAnimating?Lottie.asset(Assets.lottieArrowAnimation,
                                controller: _animationController2,repeat: true):Container()),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
                          child: ActionAnimation(

                              userInfo: users[index],
                              onLike: () {
                              users[index].matched=true;
                              ref.read(asyncMatchRecommendedProvider.notifier).like(users[index].id);
                              if (index < users.length - 1) {
                                pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 500),
                                    curve: Curves.linearToEaseOut);
                                }
                              },
                              onArrow: () {
                                users[index].arrowed=true;
                                ref.read(asyncMatchRecommendedProvider.notifier)
                                  .arrow(users[index].id);
                                if (index < users.length - 1) {
                                  pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 500),
                                      curve: Curves.linearToEaseOut);
                                }
                            }, arrowController: _animationController2,
                          ),
                        ),

                        // 加action组件
                      ],
                    )
                  );
                },
                itemCount: users.length,
                scrollDirection: Axis.vertical,
                controller: pageController,
                onPageChanged: (value){
                  ///滑动结束后调用这个回调，来表示当前是哪个index。此时需要处理上个page上的数据，来表示不喜欢的状态
                  if(users[value-1].arrowed||users[value-1].matched){
                    return;
                  }else {
                    users[value-1].skipped=true;
                    ref.read(asyncMatchRecommendedProvider.notifier)
                        .skip(users[value-1].id);
                  }
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).padding.top,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.0),
                    ]
                  ),
                ),
              ),
            )
          ],
        );
      },
      error: (err, stack) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => ref.refresh(asyncMatchRecommendedProvider),
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text(
            'Load match data error\nclick the screen to try again.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, decoration: TextDecoration.none)
          ),
        ),
      ),
      loading: () => MatchInitAnimation(),
    );
  }

  void _showActions(UserInfo user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Container(
                width: 30,
                height: 3,
                color: Colors.black12,
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...['分享名片', '取消匹配', '屏蔽', '举报'].map((t) => Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ColoredButton(
                                    onTap: () {
                                      Navigator.pop(context, t);
                                    },
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    text: t),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40)
            ],
          ),
        );
      },
    );
  }
  Widget _buildWidget(int position, Color color) {
    return Container(
      color: color,
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "0x${position.toRadixString(16).toUpperCase()}",
              style: TextStyle(
                color: Color(0xFF2e282a),
                fontSize: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
