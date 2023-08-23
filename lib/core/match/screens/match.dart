import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/match/screens/setting.dart';

import '../../../common/widgets/button/colored.dart';

class MatchScreen extends StatefulHookConsumerWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen> with AutomaticKeepAliveClientMixin {
  late AppinioSwiperController _controller;
  UserInfo? _current_user;

  @override
  void initState() {
    _controller = AppinioSwiperController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Match'),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (_) => const MatchSettingScreen()
              )),
              icon: Icon(Icons.filter_alt)
          )
        ],
        elevation: 0,
      ),
      body: ref.watch(matchedProvider).when<Widget>(
          data: (List<UserInfo> users) {
            _current_user ??= users.first;
            return SafeArea(
              child: Stack(
                children: [
                  Positioned.fill(
                    bottom: 72,
                    child: AppinioSwiper(
                      controller: _controller,
                      cardsBuilder: _cardBuilder,
                      cardsCount: users.length,
                        onSwipe: (int index, AppinioSwiperDirection direction) {
                          _current_user = users[index];
                          switch (direction) {
                            case AppinioSwiperDirection.left:
                              _leftSwipeHandler();
                              break;
                            case AppinioSwiperDirection.right:
                              _rightSwipeHandler();
                              break;
                            case AppinioSwiperDirection.top:
                            case AppinioSwiperDirection.bottom:
                              break;
                            default:
                              _swipeExceptionHandler(index, direction);
                          }
                        },
                        onEnd: () {
                          print('onEnd');
                        },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 72,
                    child: Visibility(
                      visible: _current_user != null,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.secondaryContainer
                          )
                        ),
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Theme.of(context).colorScheme.primaryContainer,
                            size: 36,
                          ),
                          onPressed: () {
                            // ref.read(matchedProvider.notifier).like(_current_user!.id);
                            _controller.swipeRight();
                          },
                        ),
                      ),
                    )
                  )
                ],
              ),
            );
          },
          error: (err, stack) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => ref.watch(matchedProvider.notifier).refresh(),
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
          )
      ),
    );
  }

  Widget _cardBuilder(BuildContext context, int index) {
    final user = ref.read(matchedProvider).value![index];

    return Container(
      key: ValueKey(user.id),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: CachedNetworkImageProvider(user.photos.firstOrNull ?? ''),
          fit: BoxFit.cover,
          alignment: Alignment.center,
          isAntiAlias: true
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 148,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${user.name}  ${user.age}yo'),
                IconButton(onPressed: () => _showActions(user), icon: Icon(Icons.more_horiz_outlined))
              ],
            ),
            SizedBox(height: 4),
            Text(user.bio ?? '', textAlign: TextAlign.start, maxLines: 3, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Future _leftSwipeHandler() async {
    ref.read(matchedProvider.notifier).skip(_current_user!.id);
  }

  void _rightSwipeHandler() {
    ref.read(matchedProvider.notifier).like(_current_user!.id);
  }

  void _topSwipeHandler() {

  }

  void _swipeExceptionHandler(int index, AppinioSwiperDirection direction) {

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
          )
      ),
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...['分享名片', '取消匹配', '屏蔽', '举报'].map(
                                  (t) => Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ColoredButton(
                                    onTap: () {
                                      Navigator.pop(context, t);
                                    },
                                    color: Theme.of(context).colorScheme.background,
                                    text: t
                                ),
                              )
                          )
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
