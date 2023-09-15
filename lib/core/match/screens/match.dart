import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/match/widgets/custom_scrollphysics.dart';
import 'package:sona/core/match/widgets/user_card.dart';
import 'package:stacked_page_view/stacked_page_view.dart';

import '../../../common/widgets/button/colored.dart';
import '../widgets/match_init_animation.dart';
// import '../widgets/scroller.dart' as s;

class MatchScreen extends StatefulHookConsumerWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen>
    with AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin {
  // late final s.Controller controller;
  //
  // void _handleCallbackEvent(ScrollDirection direction, s.ScrollSuccess success,
  //     {int? currentIndex}) {
  //
  //
  //   print(
  //       "Scroll callback received with data: {direction: $direction, success: $success and index: ${currentIndex ?? 'not given'}}");
  // }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    // controller = s.Controller()
    //   ..addListener((s.ScrollEvent event) {
    //     _handleCallbackEvent(event.direction, event.success);
    //   });
    super.initState();
  }
  String imageUrl='';

  late AnimationController _controller;
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
            Positioned.fill(child: PageView.builder(itemBuilder: (c,index){
              return StackPageView(index: index, controller: pageController, child: UserCard(
                key: ValueKey(users[index].id),
                user: users[index],
                onLike: () {
                  ///like某个用户
                  ref.read(asyncMatchRecommendedProvider.notifier).like(users[index].id);
                  if (index < users.length - 1) {
                    pageController.animateToPage(index + 1, duration: Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
                  }
                },
                onArrow: () => ref
                    .read(asyncMatchRecommendedProvider.notifier)
                    .arrow(users[index].id),
              ));
            },
              itemCount: users.length,
              scrollDirection: Axis.vertical,
              controller: pageController,
              onPageChanged: (value){

              },
              // physics: scrollPhysics,
            ),
            ),
            // Positioned.fill(
            //   child: TransformerPageView(itemCount: users.length,
            //     itemBuilder: (c,index){
            //       return UserCard(
            //         key: ValueKey(users[index].id),
            //         user: users[index],
            //         onLike: () {
            //           ///like某个用户
            //           ref.read(asyncMatchRecommendedProvider.notifier).like(users[index].id);
            //           if (index < users.length - 1) {
            //             controller.animateToPosition(index + 1);
            //           }
            //         },
            //         onArrow: () => ref
            //             .read(asyncMatchRecommendedProvider.notifier)
            //             .arrow(users[index].id),
            //       );
            //     },
            //     scrollDirection: Axis.vertical,
            //     transformer: ScaleAndFadeTransformer(),
            //   ),
            // ),
            // Positioned.fill(
            //   child: TikTokStyleFullPageScroller(
            //     contentSize: users.length,
            //     swipePositionThreshold: 0.2,
            //     // ^ the fraction of the screen needed to scroll
            //     swipeVelocityThreshold: 1000,
            //     // ^ the velocity threshold for smaller scrolls
            //     animationDuration: const Duration(milliseconds: 400),
            //     // ^ how long the animation will take
            //     controller: controller,
            //     // ^ registering our own function to listen to page changes
            //     builder: (context, index) => UserCard(
            //       key: ValueKey(users[index].id),
            //       user: users[index],
            //       onLike: () {
            //         ///like某个用户
            //         ref.read(asyncMatchRecommendedProvider.notifier).like(users[index].id);
            //         if (index < users.length - 1) {
            //           controller.animateToPosition(index + 1);
            //         }
            //       },
            //       onArrow: () => ref
            //           .read(asyncMatchRecommendedProvider.notifier)
            //           .arrow(users[index].id),
            //     ),
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: CachedNetworkImageProvider("$imageUrl"),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            //   child: BackdropFilter(
            //     filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            //     child: Container(
            //       decoration:
            //       BoxDecoration(color: Colors.white.withOpacity(0.0)),
            //     ),
            //   ),
            // ),
            // Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       CardStack(onCardChanged: (u){
            //         setState(() {
            //            imageUrl=u;
            //         });
            //       },
            //       user: users,
            //       )
            //     ],
            //   ),
            // ),

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
