import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/overlay/global_notification_overlay.dart';

/// 全局通知服务的便捷调用类
class GlobalNotifications {
  static WidgetRef? _ref;

  /// 初始化服务（在应用启动时调用）
  static void init(WidgetRef ref) {
    _ref = ref;
  }

  /// 显示占星相关通知
  static void showAstroNotification({
    required String title,
    String? content,
    VoidCallback? onTap,
  }) {
    _showNotification(
      id: 'astro_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      content: content,
      icon: Icons.auto_awesome,
      backgroundColor: const Color(0xFF6A5AE0), // 占星紫色
      onTap: onTap,
    );
  }

  /// 显示系统通知
  static void showSystemNotification({
    required String title,
    String? content,
    VoidCallback? onTap,
  }) {
    _showNotification(
      id: 'system_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      content: content,
      icon: Icons.info_outline,
      backgroundColor: const Color(0xFF00EED1), // 主题青绿色
      onTap: onTap,
    );
  }

  /// 显示匹配通知
  static void showMatchNotification({
    required String title,
    String? content,
    VoidCallback? onTap,
  }) {
    _showNotification(
      id: 'match_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      content: content,
      icon: Icons.favorite,
      backgroundColor: const Color(0xFFFF6B9D), // 浪漫粉色
      onTap: onTap,
    );
  }

  /// 显示会员通知
  static void showVipNotification({
    required String title,
    String? content,
    VoidCallback? onTap,
  }) {
    _showNotification(
      id: 'vip_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      content: content,
      icon: Icons.diamond,
      backgroundColor: const Color(0xFFFF9E7D), // 珊瑚橙色
      onTap: onTap,
    );
  }

  /// 显示自定义通知
  static void showCustomNotification({
    required String id,
    required String title,
    String? content,
    IconData? icon,
    Color? backgroundColor,
    VoidCallback? onTap,
  }) {
    _showNotification(
      id: id,
      title: title,
      content: content,
      icon: icon,
      backgroundColor: backgroundColor,
      onTap: onTap,
    );
  }

  /// 隐藏当前通知
  static void hide() {
    if (_ref != null) {
      _ref!.read(globalNotificationProvider.notifier).hideNotification();
    }
  }

  /// 根据 ID 隐藏特定通知
  static void hideById(String id) {
    if (_ref != null) {
      _ref!.read(globalNotificationProvider.notifier).hideNotificationById(id);
    }
  }

  /// 内部方法：显示通知
  static void _showNotification({
    required String id,
    required String title,
    String? content,
    IconData? icon,
    Color? backgroundColor,
    VoidCallback? onTap,
  }) {
    if (_ref == null) {
      print(
          'GlobalNotifications not initialized. Call GlobalNotifications.init(ref) first.');
      return;
    }

    final notification = GlobalNotification(
      id: id,
      title: title,
      content: content,
      icon: icon,
      backgroundColor: backgroundColor,
      onTap: onTap,
    );

    _ref!
        .read(globalNotificationProvider.notifier)
        .showNotification(notification);
  }
}

/// 使用示例：
/// 
/// ```dart
/// // 在应用初始化时
/// GlobalNotifications.init(ref);
/// 
/// // 显示占星通知
/// GlobalNotifications.showAstroNotification(
///   title: '今日运势已更新',
///   content: '查看您的专属星座运势',
///   onTap: () => Navigator.pushNamed(context, '/horoscope'),
/// );
/// 
/// // 显示匹配通知
/// GlobalNotifications.showMatchNotification(
///   title: '新的缘分出现',
///   content: '有人对您感兴趣，快去看看吧',
///   onTap: () => Navigator.pushNamed(context, '/likes'),
/// );
/// 
/// // 显示系统通知
/// GlobalNotifications.showSystemNotification(
///   title: '完善您的资料',
///   content: '添加更多照片提升匹配率',
///   onTap: () => Navigator.pushNamed(context, '/profile'),
/// );
/// ```
