import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/match/providers/setting.dart';
import 'package:sona/core/match/screens/setting.dart';

import '../../../common/widgets/button/colored.dart';
import '../../../firebase/sona_firebase.dart';
import '../widgets/scroller.dart';

class MatchScreen extends StatefulHookConsumerWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen>
    with AutomaticKeepAliveClientMixin {
  UserInfo? _current_user;

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
            _current_user ??= users.isNotEmpty ? users.first : null;
            return Stack(
              children: [
                Positioned.fill(
                    child: TikTokStyleFullPageScroller(
                        contentSize: users.length,
                        swipePositionThreshold: 0.2,
                        // ^ the fraction of the screen needed to scroll
                        swipeVelocityThreshold: 2000,
                        // ^ the velocity threshold for smaller scrolls
                        animationDuration: const Duration(milliseconds: 400),
                        // ^ how long the animation will take
                        controller: controller,
                        // ^ registering our own function to listen to page changes
                        builder: _cardBuilder)),
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
                          ]),
                    ),
                  ),
                )
              ],
            );
          },
          error: (err, stack) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () =>
                ref.watch(asyncMatchRecommendedProvider.notifier).refresh(),
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: const Text(
                  'Load match data error\nclick the screen to try again.',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 16, decoration: TextDecoration.none)),
            ),
          ),
          loading: () => Container(
            color: Colors.white54,
            alignment: Alignment.center,
            child: const SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(strokeWidth: 2.5)),
          ),
        );
  }

  Widget _cardBuilder(BuildContext context, int index) {
    final user = ref.read(asyncMatchRecommendedProvider).value![index];

    return Container(
      key: ValueKey(user.id),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: CachedNetworkImageProvider(user.photos.firstOrNull ?? ''),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            isAntiAlias: true),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          Positioned(
            left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${user.name}',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      shadows: const <Shadow>[
                        Shadow(
                          blurRadius: 5.0,
                          color: Color.fromARGB(10, 0, 0, 0),
                        ),
                      ],
                    )),
                Text('${user.age}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        shadows: const <Shadow>[
                          Shadow(
                            blurRadius: 5.0,
                            color: Color.fromARGB(10, 0, 0, 0),
                          ),
                        ]))
              ],
            ),
          ),
          Positioned(
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              child: Visibility(
                visible: _current_user != null,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context)
                              .colorScheme
                              .secondaryContainer)),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      size: 33,
                    ),
                    onPressed: () {
                      ref
                          .read(asyncMatchRecommendedProvider.notifier)
                          .like(_current_user!.id);
                      controller.animateToPosition(index + 1);
                    },
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Future _leftSwipeHandler() async {
    ref.read(asyncMatchRecommendedProvider.notifier).skip(_current_user!.id);
  }

  void _rightSwipeHandler() {
    ref.read(asyncMatchRecommendedProvider.notifier).like(_current_user!.id);
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
