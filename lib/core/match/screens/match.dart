import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/match/widgets/user_card.dart';

import '../../../common/widgets/button/colored.dart';
import '../widgets/scroller.dart';

class MatchScreen extends StatefulHookConsumerWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen>
    with AutomaticKeepAliveClientMixin {
  late final Controller controller;

  void _handleCallbackEvent(ScrollDirection direction, ScrollSuccess success,
      {int? currentIndex}) {


    print(
        "Scroll callback received with data: {direction: $direction, success: $success and index: ${currentIndex ?? 'not given'}}");
  }

  @override
  void initState() {
    controller = Controller()
      ..addListener((event) {
        _handleCallbackEvent(event.direction, event.success);
      });
    super.initState();
  }

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
              child: TikTokStyleFullPageScroller(
                contentSize: users.length,
                swipePositionThreshold: 0.2,
                // ^ the fraction of the screen needed to scroll
                swipeVelocityThreshold: 1000,
                // ^ the velocity threshold for smaller scrolls
                animationDuration: const Duration(milliseconds: 400),
                // ^ how long the animation will take
                controller: controller,
                // ^ registering our own function to listen to page changes
                builder: (context, index) => UserCard(
                  key: ValueKey(users[index].id),
                  user: users[index],
                  onLike: () {
                    ///like某个用户
                    ref.read(asyncMatchRecommendedProvider.notifier).like(users[index].id).then((value){

                    });

                    if (index < users.length - 1) {
                      controller.animateToPosition(index + 1);
                    }
                  },
                  onArrow: () => ref
                      .read(asyncMatchRecommendedProvider.notifier)
                      .arrow(users[index].id),
                ),
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
      loading: () => Container(
        color: Colors.white54,
        alignment: Alignment.center,
        child: const SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(strokeWidth: 2.5)
        ),
      ),
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

  @override
  bool get wantKeepAlive => true;
}
