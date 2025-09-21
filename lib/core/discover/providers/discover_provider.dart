import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../enums/discover_channel.dart';
import '../models/discover_user.dart';
import '../services/discover_service.dart';

// 当前选中的通道
final discoverChannelProvider = StateProvider<DiscoverChannel>((ref) => DiscoverChannel.destiny);

// 天选用户列表状态
class DestinyUsersNotifier
    extends StateNotifier<AsyncValue<List<DiscoverUser>>> {
  DestinyUsersNotifier(this.ref) : super(const AsyncValue.loading());

  final Ref ref;

  Future<void> loadUsers() async {
    state = const AsyncValue.loading();
    try {
      final users = await DiscoverService.getDestinyUsers();
      state = AsyncValue.data(users);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshUsers() async {
    try {
      final users = await DiscoverService.getDestinyUsers();
      state = AsyncValue.data(users);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// 附近用户列表状态
class NearbyUsersNotifier
    extends StateNotifier<AsyncValue<List<DiscoverUser>>> {
  NearbyUsersNotifier(this.ref) : super(const AsyncValue.loading());

  final Ref ref;

  Future<void> loadUsers() async {
    state = const AsyncValue.loading();
    try {
      final users = await DiscoverService.getNearbyUsers();
      state = AsyncValue.data(users);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshUsers() async {
    try {
      final users = await DiscoverService.getNearbyUsers();
      state = AsyncValue.data(users);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> loadMore() async {
    if (state.value == null) return;

    try {
      final currentPage = (state.value!.length / 30).ceil() + 1;
      final moreUsers = await DiscoverService.getNearbyUsers(
        page: currentPage,
      );
      final currentUsers = state.value!;
      state = AsyncValue.data([...currentUsers, ...moreUsers]);
    } catch (error, stackTrace) {
      // 加载更多失败时保持当前状态
      print('Load more failed: $error');
    }
  }
}

// Providers
final destinyUsersProvider =
    StateNotifierProvider<DestinyUsersNotifier, AsyncValue<List<DiscoverUser>>>(
        (ref) {
  return DestinyUsersNotifier(ref);
});

final nearbyUsersProvider =
    StateNotifierProvider<NearbyUsersNotifier, AsyncValue<List<DiscoverUser>>>(
        (ref) {
  return NearbyUsersNotifier(ref);
});

// 当前显示的用户列表（根据选中通道）
final currentUsersProvider = Provider<AsyncValue<List<DiscoverUser>>>((ref) {
  final channel = ref.watch(discoverChannelProvider);
  switch (channel) {
    case DiscoverChannel.destiny:
      return ref.watch(destinyUsersProvider);
    case DiscoverChannel.nearby:
      return ref.watch(nearbyUsersProvider);
  }
});

// 轻报告显示状态
final lightReportProvider = StateProvider<DiscoverUser?>((ref) => null);

// 用户交互状态
class UserInteractionNotifier
    extends StateNotifier<Map<int, UserInteractionState>> {
  UserInteractionNotifier() : super({});

  void likeUser(int userId) {
    state = {
      ...state,
      userId: UserInteractionState.liked,
    };
  }

  void skipUser(int userId) {
    state = {
      ...state,
      userId: UserInteractionState.skipped,
    };
  }

  void sendMessage(int userId) {
    state = {
      ...state,
      userId: UserInteractionState.messaged,
    };
  }

  UserInteractionState? getInteractionState(int userId) {
    return state[userId];
  }
}

enum UserInteractionState {
  liked,
  skipped,
  messaged,
}

final userInteractionProvider = StateNotifierProvider<UserInteractionNotifier,
    Map<int, UserInteractionState>>((ref) {
  return UserInteractionNotifier();
});
