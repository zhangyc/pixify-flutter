import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 通知数据模型
class GlobalNotification {
  final String id;
  final String title;
  final String? content;
  final IconData? icon;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final DateTime createdAt;

  GlobalNotification({
    required this.id,
    required this.title,
    this.content,
    this.icon,
    this.backgroundColor,
    this.onTap,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlobalNotification &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// 全局通知状态管理
class GlobalNotificationNotifier extends StateNotifier<GlobalNotification?> {
  GlobalNotificationNotifier() : super(null);

  void showNotification(GlobalNotification notification) {
    state = notification;
  }

  void hideNotification() {
    state = null;
  }

  void hideNotificationById(String id) {
    if (state?.id == id) {
      state = null;
    }
  }
}

// Provider
final globalNotificationProvider =
    StateNotifierProvider<GlobalNotificationNotifier, GlobalNotification?>(
  (ref) => GlobalNotificationNotifier(),
);

// 全局通知浮动层
class GlobalNotificationOverlay extends ConsumerWidget {
  const GlobalNotificationOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notification = ref.watch(globalNotificationProvider);

    if (notification == null) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: MediaQuery.of(context).viewPadding.top + kToolbarHeight,
      left: 0,
      right: 0,
      child: _GlobalNotificationBanner(
        notification: notification,
        onClose: () =>
            ref.read(globalNotificationProvider.notifier).hideNotification(),
      ),
    );
  }
}

// 通知横幅组件
class _GlobalNotificationBanner extends StatefulWidget {
  const _GlobalNotificationBanner({
    required this.notification,
    required this.onClose,
  });

  final GlobalNotification notification;
  final VoidCallback onClose;

  @override
  State<_GlobalNotificationBanner> createState() =>
      _GlobalNotificationBannerState();
}

class _GlobalNotificationBannerState extends State<_GlobalNotificationBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleClose() async {
    await _animationController.reverse();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.notification.backgroundColor ??
                theme.primaryColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: theme.primaryColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.notification.onTap,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // 图标
                    if (widget.notification.icon != null) ...[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          widget.notification.icon!,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],

                    // 内容区域
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.notification.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          if (widget.notification.content != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              widget.notification.content!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    // 关闭按钮
                    GestureDetector(
                      onTap: _handleClose,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
