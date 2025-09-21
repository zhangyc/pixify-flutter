// lib/core/match/providers/match_screen_provider.dart
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/providers/matched.dart';
import '../bean/match_user.dart';
import '../util/http_util.dart';
import '../../../account/providers/profile.dart';

// 页面状态
enum MatchPageState { loading, success, fail, noData }

// 筛选条件
class MatchFilters {
  final int? gender;
  final int? minAge;
  final int? maxAge;
  final String? recommendMode;

  const MatchFilters({
    this.gender,
    this.minAge,
    this.maxAge,
    this.recommendMode,
  });
}

// 匹配页面状态
class MatchScreenState {
  final MatchPageState pageState;
  final List<MatchUserInfo> users;
  final int currentIndex;
  final MatchFilters filters;
  final bool isLoadingMore;
  final String? backgroundImage;
  final int likeCount;
  final bool canUndo;

  const MatchScreenState({
    this.pageState = MatchPageState.loading,
    this.users = const [],
    this.currentIndex = 0,
    this.filters = const MatchFilters(),
    this.isLoadingMore = false,
    this.backgroundImage,
    this.likeCount = 0,
    this.canUndo = false,
  });

  MatchScreenState copyWith({
    MatchPageState? pageState,
    List<MatchUserInfo>? users,
    int? currentIndex,
    MatchFilters? filters,
    bool? isLoadingMore,
    String? backgroundImage,
    int? likeCount,
    bool? canUndo,
  }) {
    return MatchScreenState(
      pageState: pageState ?? this.pageState,
      users: users ?? this.users,
      currentIndex: currentIndex ?? this.currentIndex,
      filters: filters ?? this.filters,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      likeCount: likeCount ?? this.likeCount,
      canUndo: canUndo ?? this.canUndo,
    );
  }
}

// 匹配页面状态管理
class MatchScreenNotifier extends StateNotifier<MatchScreenState> {
  MatchScreenNotifier(this.ref) : super(const MatchScreenState());

  final Ref ref;
  final List<MatchUserInfo> _swipedUsers = [];

  // 初始化数据
  Future<void> initData() async {
    state = state.copyWith(pageState: MatchPageState.loading);

    final profile = ref.read(myProfileProvider);
    final longitude = profile?.position?.longitude;
    final latitude = profile?.position?.latitude;

    try {
      final resp = await post('/user/match-v2', data: {
        'gender': state.filters.gender,
        'minAge': state.filters.minAge,
        'maxAge': state.filters.maxAge,
        'longitude': longitude,
        'latitude': latitude,
        'page': 1,
        'pageSize': 30,
        'recommendMode': state.filters.recommendMode,
      });

      if (resp.isSuccess) {
        final List list = resp.data;
        final users = list.map((e) => MatchUserInfo.fromJson(e)).toList();

        state = state.copyWith(
          pageState:
              users.isEmpty ? MatchPageState.noData : MatchPageState.success,
          users: users,
          currentIndex: 0,
          canUndo: false,
        );
      } else {
        state = state.copyWith(pageState: MatchPageState.fail);
      }
    } catch (e) {
      state = state.copyWith(pageState: MatchPageState.fail);
    }
  }

  // 加载更多
  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final profile = ref.read(myProfileProvider);
      final longitude = profile?.position?.longitude;
      final latitude = profile?.position?.latitude;

      final resp = await post('/user/match-v2', data: {
        'gender': state.filters.gender,
        'minAge': state.filters.minAge,
        'maxAge': state.filters.maxAge,
        'longitude': longitude,
        'latitude': latitude,
        'page': (state.users.length ~/ 30) + 1,
        'pageSize': 30,
        'recommendMode': state.filters.recommendMode,
      });

      if (resp.isSuccess) {
        final List list = resp.data;
        final newUsers = list.map((e) => MatchUserInfo.fromJson(e)).toList();

        state = state.copyWith(
          users: [...state.users, ...newUsers],
          isLoadingMore: false,
        );
      }
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  // 更新筛选条件
  void updateFilters(MatchFilters filters) {
    state = state.copyWith(filters: filters);
    _swipedUsers.clear();
    initData();
  }

  // 处理卡片滑动
  bool onSwipe(
      int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    if (previousIndex >= state.users.length) return false;

    final user = state.users[previousIndex];
    _swipedUsers.add(user);

    // 根据滑动方向执行不同操作
    switch (direction) {
      case CardSwiperDirection.left:
        _skipUser(user);
        break;
      case CardSwiperDirection.right:
        _likeUser(user);
        break;
      case CardSwiperDirection.top:
        _superLikeUser(user);
        break;
      case CardSwiperDirection.bottom:
        _passUser(user);
        break;
      default:
        break;
    }

    // 更新状态
    state = state.copyWith(
      currentIndex: currentIndex ?? 0,
      canUndo: true,
    );

    return true;
  }

  // 撤销滑动
  bool onUndo() {
    if (_swipedUsers.isEmpty) return false;

    final lastUser = _swipedUsers.removeLast();
    state = state.copyWith(
      currentIndex: state.currentIndex - 1,
      canUndo: _swipedUsers.isNotEmpty,
    );

    return true;
  }

  // 喜欢用户
  Future<void> _likeUser(MatchUserInfo user) async {
    try {
      await MatchApi.like(user.id);
      state = state.copyWith(likeCount: state.likeCount + 1);
    } catch (e) {
      // 处理错误
    }
  }

  // 跳过用户
  Future<void> _skipUser(MatchUserInfo user) async {
    try {
      //await MatchApi.skip(user.id);
    } catch (e) {
      // 处理错误
    }
  }

  // 超级喜欢用户
  Future<void> _superLikeUser(MatchUserInfo user) async {
    try {
      //await MatchApi.superLike(user.id);
      state = state.copyWith(likeCount: state.likeCount + 1);
    } catch (e) {
      // 处理错误
    }
  }

  // 通过用户
  Future<void> _passUser(MatchUserInfo user) async {
    try {
      // await MatchApi.pass(user.id);
    } catch (e) {
      // 处理错误
    }
  }

  // 更新背景图片
  void updateBackgroundImage(String? imageUrl) {
    state = state.copyWith(backgroundImage: imageUrl);
  }
}

// Providers
final matchScreenProvider =
    StateNotifierProvider<MatchScreenNotifier, MatchScreenState>((ref) {
  return MatchScreenNotifier(ref);
});

// 当前用户
final currentUserProvider = Provider<MatchUserInfo?>((ref) {
  final state = ref.watch(matchScreenProvider);
  if (state.currentIndex < state.users.length) {
    return state.users[state.currentIndex];
  }
  return null;
});
