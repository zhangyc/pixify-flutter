import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/services/global_notification_service.dart';
import 'package:sona/generated/assets.dart';
import '../enums/discover_channel.dart';
import '../models/discover_user.dart';
import '../providers/discover_provider.dart';
import '../services/discover_service.dart';
import '../widgets/discover_user_card.dart';
import '../widgets/photo_gallery_screen.dart';
import '../widgets/astro_light_report_sheet.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  void _loadInitialData() {
    ref.read(destinyUsersProvider.notifier).loadUsers();
    ref.read(nearbyUsersProvider.notifier).loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final currentChannel = ref.watch(discoverChannelProvider);
    final users = ref.watch(currentUsersProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              Assets.iconsSona,
              width: 96,
              height: 24,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _showDemoNotification,
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: theme.primaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: 导航到筛选页面
                  },
                  icon: Icon(
                    Icons.tune,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 双通道切换
          _buildChannelTabs(theme, currentChannel),

          const SizedBox(height: 16),

          // 用户列表
          Expanded(
            child: _buildUserList(users),
          ),
        ],
      ),
    );
  }

  Widget _buildChannelTabs(ThemeData theme, DiscoverChannel currentChannel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? const Color(0xFF1A1A1F)
            : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              theme,
              '🌟 天选配对',
              DiscoverChannel.destiny,
              currentChannel == DiscoverChannel.destiny,
            ),
          ),
          Expanded(
            child: _buildTabButton(
              theme,
              '📍 附近可聊',
              DiscoverChannel.nearby,
              currentChannel == DiscoverChannel.nearby,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    ThemeData theme,
    String title,
    DiscoverChannel channel,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        ref.read(discoverChannelProvider.notifier).state = channel;
        // 埋点
        if (channel == DiscoverChannel.destiny) {
          // SonaAnalytics.log('destiny_tab_view');
        } else {
          // SonaAnalytics.log('nearby_tab_view');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            color: isSelected
                ? (theme.brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white)
                : theme.textTheme.bodyMedium?.color,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildUserList(AsyncValue<List<DiscoverUser>> usersAsync) {
    return usersAsync.when(
      data: (users) => _buildUserGrid(users),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorState(),
    );
  }

  Widget _buildUserGrid(List<DiscoverUser> users) {
    if (users.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: GridView.builder(
        padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: MediaQuery.of(context).padding.bottom + 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 0.65, // 调整卡片宽高比，给内容更多空间
          mainAxisSpacing: 16,
        ),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return DiscoverUserCard(
            user: user,
            onPhotoTap: (photoIndex) => _openPhotoGallery(user, photoIndex),
            onAstroBadgeTap: () => _showLightReport(user),
            onLike: () => _handleLike(user),
            onSkip: () => _handleSkip(user),
            onSendMessage: () => _handleSendMessage(user),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_awesome_outlined,
            size: 64,
            color: theme.hintColor,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无新的缘分',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.hintColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '稍后再来看看吧',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            '加载失败',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _loadInitialData,
            child: const Text('重试'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async {
    final currentChannel = ref.read(discoverChannelProvider);
    if (currentChannel == DiscoverChannel.destiny) {
      await ref.read(destinyUsersProvider.notifier).refreshUsers();
    } else {
      await ref.read(nearbyUsersProvider.notifier).refreshUsers();
    }
  }

  void _openPhotoGallery(DiscoverUser user, int initialIndex) {
    if (user.photos.isEmpty) {
      _handleSendMessage(user);
      return;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            PhotoGalleryScreen(
          user: user,
          initialIndex: initialIndex,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  void _showLightReport(DiscoverUser user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => AstroLightReportSheet(user: user),
    );

    // 埋点
    // SonaAnalytics.log('astro_card_impression', parameters: {
    //   'user_id': user.id,
    //   'fate': user.astroScore?.fate,
    //   'harmony': user.astroScore?.harmony,
    //   'risk': user.astroScore?.risk,
    // });
  }

  void _handleLike(DiscoverUser user) async {
    ref.read(userInteractionProvider.notifier).likeUser(user.id);

    try {
      final success = await DiscoverService.likeUser(user.id);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('已发送喜欢给 ${user.name}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('发送失败，请重试')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('网络错误，请重试')),
      );
    }

    // 埋点
    // SonaAnalytics.log('discover_like', parameters: {'user_id': user.id});
  }

  void _handleSkip(DiscoverUser user) async {
    ref.read(userInteractionProvider.notifier).skipUser(user.id);

    try {
      await DiscoverService.skipUser(user.id);
    } catch (e) {
      print('Skip user failed: $e');
    }

    // 埋点
    // SonaAnalytics.log('discover_skip', parameters: {'user_id': user.id});
  }

  void _handleSendMessage(DiscoverUser user) {
    if (user.photos.isEmpty) {
      // 显示发送消息解锁相册的对话框
      _showUnlockPhotoDialog(user);
    } else {
      // 直接进入聊天
      _navigateToChat(user);
    }
  }

  void _showUnlockPhotoDialog(DiscoverUser user) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          '解锁 ${user.name} 的相册',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.primaryColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '发送一条星语问候，解锁TA的神秘相册',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            if (user.astroScore != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '你们的缘分指数：${user.astroScore!.fate}%',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);

              try {
                final success = await DiscoverService.sendMessageToUnlock(
                    user.id, '你好，很想了解更多关于你的故事 ✨');

                if (success) {
                  _navigateToChat(user);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('问候已发送给 ${user.name}')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('发送失败，请重试')),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('网络错误，请重试')),
                );
              }

              // 埋点
              // SonaAnalytics.log('unlock_photo_send_message', parameters: {
              //   'user_id': user.id,
              // });
            },
            child: const Text('发送问候'),
          ),
        ],
      ),
    );
  }

  void _navigateToChat(DiscoverUser user) {
    // TODO: 导航到聊天页面
    print('Navigate to chat with ${user.name}');
  }

  void _showDemoNotification() {
    GlobalNotifications.showAstroNotification(
      title: '今日运势已更新',
      content: '查看您的专属星座运势和缘分指引',
      onTap: () {
        print('Navigate to horoscope');
      },
    );
  }
}
