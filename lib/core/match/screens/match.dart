import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sona/core/match/widgets/match_grid_item.dart';
import 'package:sona/core/match/screens/user_detail_page.dart';
import 'package:sona/core/match/widgets/luna_avatar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/screens/filter_page.dart';
import 'package:sona/core/match/widgets/no_data.dart';
import 'package:sona/core/match/widgets/no_more.dart';
import 'package:sona/generated/assets.dart';
import 'package:sona/utils/locale/locale.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../account/providers/profile.dart';
import '../../../common/widgets/text/neon_word_mark.dart';
import '../bean/match_user.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int currentPage = 1;
  bool isLoadingMore = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const NeonWordmark(text: "AstroLearn", fontSize: 18),
            Row(
              children: [
                GestureDetector(
                  child: SvgPicture.asset(
                    Assets.homeFliter,
                    width: 32,
                    height: 32,
                  ),
                  onTap: () {
                    Navigator.push<void>(context,
                        MaterialPageRoute(builder: (c) {
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
      body: Column(
        children: [
          // Luna AI导师引导区
          _buildLunaGuide(),
          // 主要内容区
          Expanded(child: _buildMatch()),
        ],
      ),
    );
  }

  /// Luna AI导师引导区
  Widget _buildLunaGuide() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor.withOpacity(0.1),
            Colors.transparent,
          ],
        ),
      ),
      child: Row(
        children: [
          const LunaAvatar(size: 50),
          const SizedBox(width: 12),
          Expanded(
            child: LunaSpeechBubble(
              message: users.isEmpty ? '让我为你推荐一些星盘案例吧！' : '点击查看星盘，我会为你详细讲解 ✨',
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _initData() async {
    longitude = ref.read(myProfileProvider)!.position?.longitude;
    latitude = ref.read(myProfileProvider)!.position?.latitude;
    _state = PageState.loading;
    if (mounted) {
      setState(() {});
    }
    currentPage = 1;
    try {
      final resp = await post('/user/match-ios', data: {
        'gender': currentFilterGender,
        'minAge': currentFilterMinAge,
        'maxAge': currentFilterMaxAge,
        'longitude': longitude,
        'latitude': latitude,
        "page": currentPage,
        "pageSize": 30,
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

        // 预加载图片
        for (var element in users) {
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

  void _loadMore() async {
    if (isLoadingMore) return;

    setState(() {
      isLoadingMore = true;
    });

    try {
      currentPage++;
      final resp = await post('/user/match-ios', data: {
        'gender': currentFilterGender,
        'minAge': currentFilterMinAge,
        'maxAge': currentFilterMaxAge,
        'longitude': longitude,
        'latitude': latitude,
        "page": currentPage,
        "pageSize": 30,
        "recommendMode": recommendMode
      });

      if (resp.isSuccess) {
        List list = resp.data;
        if (list.isNotEmpty) {
          List<MatchUserInfo> newUsers =
              list.map((e) => MatchUserInfo.fromJson(e)).toList();
          users.addAll(newUsers);

          // 预加载新图片
          for (var element in newUsers) {
            if (element.avatar != null) {
              DefaultCacheManager().downloadFile(element.avatar!);
            }
          }
        }
        setState(() {});
      }
    } catch (e) {
      if (kDebugMode) print(e);
      currentPage--; // 加载失败，回退页码
    } finally {
      setState(() {
        isLoadingMore = false;
      });
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
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoadingMore &&
              scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
            _loadMore();
          }
          return false;
        },
        child: RefreshIndicator(
          onRefresh: () async {
            _initData();
          },
          child: MasonryGridView.count(
            controller: _scrollController,
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            padding: const EdgeInsets.all(16),
            itemCount: users.length + (isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == users.length) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                );
              }

              final user = users[index];
              return MatchGridItem(
                user: user,
                onTap: () async {
                  final result = await Navigator.push<Map<String, dynamic>>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailPage(user: user),
                    ),
                  );

                  if (result != null) {
                    final action = result['action'];
                    if (action == 'like' || action == 'skip') {
                      // 移除该用户
                      setState(() {
                        users.removeAt(index);
                      });
                    } else if (action == 'message') {
                      // 处理发消息逻辑
                      final targetUser = result['user'] as MatchUserInfo?;
                      if (targetUser != null) {
                        showDm(context, targetUser, () {
                          setState(() {
                            users.removeAt(index);
                          });
                        });
                      }
                    }
                  }
                },
              );
            },
          ),
        ),
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
