import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:sona/core/match/widgets/match_user_card.dart';
import 'package:sona/utils/toast/flutter_toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/screens/filter_page.dart';
import 'package:sona/core/match/widgets/button_animations.dart';
import 'package:sona/core/match/widgets/no_data.dart';
import 'package:sona/core/match/widgets/no_more.dart';
import 'package:sona/generated/assets.dart';
import 'package:sona/utils/locale/locale.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../common/widgets/text/neon_word_mark.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../bean/match_user.dart';
import '../providers/matched.dart';
import '../util/event.dart';
import '../util/http_util.dart';
import '../util/local_data.dart';
import '../widgets/dialogs.dart';
import '../widgets/match_init_animation.dart';

var languageNotifier =
    ValueNotifier<SonaLocale>(SonaLocale.fromLanguageTag('en', 'English (US)'));

class MatchScreen extends StatefulHookConsumerWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initData();
    });
    super.initState();
  }

  List<MatchUserInfo> users = [];
  CardSwiperController swiperController = CardSwiperController();
  @override
  void dispose() {
    swiperController.dispose();
    super.dispose();
  }

  int currentPage = 0;
  bool detecting = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const NeonWordmark(text: 'Pair', fontSize: 28),
            Row(
              children: [
                GestureDetector(
                  child: SvgPicture.asset(
                    Assets.homeFliter,
                    width: 32,
                    height: 32,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) {
                      return FilterPage();
                    })).then((value) {
                      _initData();
                      if (mounted) {
                        setState(() {});
                      }
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          _buildMatch(),
          (users.isNotEmpty && users[currentPage].id == -1) ||
                  _state == PageState.fail ||
                  _state == PageState.noData ||
                  _state == PageState.loading
              ? Container()
              : Positioned(
                  bottom: 8 + MediaQuery.of(context).padding.bottom,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 68),
                    child: (users.isNotEmpty && users[currentPage].matched)
                        ? TextButton(
                            onPressed: () {
                              swiperController.swipe(CardSwiperDirection.right);
                              MatchApi.like(
                                users[currentPage].id,
                              );
                              SonaAnalytics.log(
                                  MatchEvent.match_like_justlike.name);
                            },
                            child: Text(
                              '${S.of(context).justSendALike} >',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ))
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // 跳过按钮
                                _buildActionButton(
                                  onTap: () {
                                    if (currentPage == users.length - 1) return;
                                    SonaAnalytics.log(
                                        MatchEvent.match_dislike.name);
                                    swiperController
                                        .swipe(CardSwiperDirection.left);
                                    MatchApi.skip(users[currentPage].id);
                                  },
                                  icon: Assets.matchCancel,
                                  size: 40,
                                  backgroundColor: const Color(0xFF2A2A35),
                                  borderColor: const Color(0xFF4A4A55),
                                  iconColor: const Color(0xFFFF6B6B),
                                ),

                                // 喜欢按钮（主要操作）
                                _buildActionButton(
                                  onTap: () {
                                    if (currentPage == users.length - 1) return;
                                    if (true) {
                                      if (like > 0) like = like - 1;
                                      swiperController
                                          .swipe(CardSwiperDirection.right);
                                      if (users[currentPage].likeMe == 1) {
                                        SonaAnalytics.log(
                                            MatchEvent.match_matched.name);
                                        MatchApi.like(users[currentPage].id);
                                        showMatched(context,
                                            target: users[currentPage],
                                            next: () {});
                                      }
                                      setState(() {});
                                      SonaAnalytics.log(
                                          MatchEvent.match_like.name);
                                    } else {
                                      SonaAnalytics.log(
                                          MatchEvent.match_like_limit.name);
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (c) {
                                        return SubscribePage(
                                            fromTag:
                                                FromTag.pay_match_likelimit);
                                      }));
                                    }
                                  },
                                  icon: Assets.matchLike,
                                  size: 68,
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.15),
                                  borderColor: Theme.of(context).primaryColor,
                                  iconColor: Theme.of(context).primaryColor,
                                  glowEffect: true,
                                ),

                                // 消息按钮
                                _buildActionButton(
                                  onTap: () {
                                    if (currentPage == users.length - 1) return;
                                    Future.delayed(Duration(milliseconds: 200),
                                        () {
                                      if (canArrow) {
                                        showDm(context, users[currentPage], () {
                                          swiperController
                                              .swipe(CardSwiperDirection.right);
                                        });
                                      } else {
                                        bool isMember = ref
                                                .read(myProfileProvider)
                                                ?.isMember ??
                                            false;
                                        if (isMember) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'Arrow on cool down this week');
                                        } else {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (c) {
                                            return SubscribePage(
                                                fromTag:
                                                    FromTag.pay_match_arrow);
                                          }));
                                        }
                                      }
                                    });
                                  },
                                  icon: Assets.matchSend,
                                  size: 40,
                                  backgroundColor: const Color(0xFF2A2A35),
                                  borderColor: const Color(0xFF4A4A55),
                                  iconColor: const Color(0xFFFFD700),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildActionButton({
    required VoidCallback onTap,
    required String icon,
    required double size,
    required Color backgroundColor,
    required Color borderColor,
    required Color iconColor,
    bool glowEffect = false,
    bool isAsset = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size + 16,
        height: size + 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: glowEffect ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            if (glowEffect)
              BoxShadow(
                color: borderColor.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 0),
              ),
          ],
        ),
        child: Center(
          child: isAsset
              ? Image.asset(
                  icon,
                  width: size * 0.6,
                  height: size * 0.6,
                )
              : SvgPicture.asset(
                  icon,
                  width: size * 0.6,
                  height: size * 0.6,
                ),
        ),
      ),
    );
  }

  int current = 1;

  void _initData() async {
    longitude = ref.read(myProfileProvider)!.position?.longitude;
    latitude = ref.read(myProfileProvider)!.position?.latitude;
    _state = PageState.loading;
    if (mounted) {
      setState(() {});
    }
    current = 1;
    currentPage = 0;
    try {
      final resp = await post('/user/match-v2', data: {
        'gender': currentFilterGender,
        'minAge': currentFilterMinAge,
        'maxAge': currentFilterMaxAge,
        'longitude': longitude,
        'latitude': latitude,
        "page": current, // 页码
        "pageSize": 30, // 每页数量
        "recommendMode": recommendMode
      });
      if (resp.isSuccess) {
        List list = resp.data;
        if (list.isEmpty) {
          _state = PageState.noData;
        } else {
          _state = PageState.success;
        }

        List<MatchUserInfo> users1 =
            list.map((e) => MatchUserInfo.fromJson(e)).toList();
        users = users1;
        if (users.every((element) => element.id != -1) && users.length <= 30) {
          users.add(MatchUserInfo(
              id: -1, name: '', gender: null, birthday: null, avatar: null));
        }
        setState(() {});
      } else {
        _state = PageState.fail;
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) print(e);
      if (mounted) {
        _state = PageState.fail;
        setState(() {});
      }
    }
  }

  void _loadMore() async {
    try {
      final resp = await post('/user/match-v2', data: {
        'gender': currentFilterGender,
        'minAge': currentFilterMinAge,
        'maxAge': currentFilterMaxAge,
        'longitude': longitude,
        'latitude': latitude,
        "page": current, // 页码
        "pageSize": 30, // 每页数量,
        "recommendMode": recommendMode
      });
      if (resp.isSuccess) {
        List list = resp.data;

        if (list.isEmpty) {
          //_state=PageState.noData;
        } else {
          _state = PageState.success;
        }
        List<MatchUserInfo> users1 =
            list.map((e) => MatchUserInfo.fromJson(e)).toList();
        // users=[...users,...users1,...[UserInfo(id: -1, name: '', gender: null, birthday: null, avatar: null)]];

        users.addAll(users1);
        if (users.every((element) => element.id != -1)) {
          users.add(MatchUserInfo(
              id: -1, name: '', gender: null, birthday: null, avatar: null));
        } else {
          users.removeWhere((element) => element.id == -1);
          users.add(MatchUserInfo(
              id: -1, name: '', gender: null, birthday: null, avatar: null));
        }
        for (var element in users1) {
          if (element.avatar != null) {
            DefaultCacheManager().downloadFile(element.avatar!);
          }
        }
        setState(() {});
      } else {
        _state = PageState.fail;
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) print(e);
      if (mounted) {
        _state = PageState.fail;
        setState(() {});
      }
    }
  }

  PageState _state = PageState.loading;

  Widget _buildMatch() {
    if (_state == PageState.loading) {
      return Container(
        color: Colors.black,
        child: Center(child: MatchInitAnimation()),
      );
    } else if (_state == PageState.fail) {
      return NoDataWidget(
        onTap: () {
          _initData();
          setState(() {});
        },
      );
    } else if (_state == PageState.success) {
      return CardSwiper(

        controller: swiperController,
        cardsCount: users.length,
        cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
          if (index >= users.length) return const SizedBox.shrink();

          final user = users[index];
          return MatchUserCard(
            user: user,
          );
        },
        onSwipe: (previousIndex, currentIndex, direction) {
          if (currentIndex == null) return false;
          if (direction == CardSwiperDirection.left) {
            MatchApi.skip(users[currentIndex].id);
          } else if (direction == CardSwiperDirection.right) {
            MatchApi.like(users[currentIndex].id);
          }
          return true;
        },
        onEnd: () {
          // 没有更多卡片时的处理
        },
        // 自定义配置
        maxAngle: 30,
        threshold: 50,
        duration: Duration(milliseconds: 200),
        scale: 0.9,
        numberOfCardsDisplayed: 2,
        allowedSwipeDirection: const AllowedSwipeDirection.all(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      );
    } else if (_state == PageState.noData) {
      return NoMoreWidget(
        onTap: () {
          _initData();
          setState(() {});
        },
      );
    } else {
      return Container();
    }
  }
}

enum PageState {
  loading,
  noData,
  success,
  fail,
}

enum PageAnimStatus { dislike, like, dm }
