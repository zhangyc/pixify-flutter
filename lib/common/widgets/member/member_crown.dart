import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/subscribe/model/member.dart';

/// 会员皇冠组件
/// 在头像上显示皇冠标识
class MemberCrown extends ConsumerWidget {
  const MemberCrown({
    super.key,
    this.size = 24,
    this.position = CrownPosition.topRight,
  });

  final double size;
  final CrownPosition position;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(myProfileProvider);
    final memberType = profile?.memberType ?? MemberType.plus;

    if (memberType != MemberType.plus) {
      return const SizedBox.shrink();
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getCrownColor(),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: _getCrownColor().withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(
        Icons.star,
        color: Colors.white,
        size: size * 0.7,
      ),
    );
  }

  Color _getCrownColor() {
    return const Color(0xFF9370DB); // 紫色
  }
}

/// 皇冠位置枚举
enum CrownPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// 带皇冠的头像组件
class AvatarWithCrown extends ConsumerWidget {
  const AvatarWithCrown({
    super.key,
    required this.avatarUrl,
    this.size = 60,
    this.crownSize = 20,
    this.crownPosition = CrownPosition.topRight,
    this.borderColor,
    this.borderWidth = 2,
  });

  final String? avatarUrl;
  final double size;
  final double crownSize;
  final CrownPosition crownPosition;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(myProfileProvider);
    final memberType = profile?.memberType ?? MemberType.none;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 头像
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor ?? Colors.white,
              width: borderWidth,
            ),
          ),
          child: ClipOval(
            child: avatarUrl != null && avatarUrl!.isNotEmpty
                ? Image.network(
                    avatarUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildDefaultAvatar(),
                  )
                : _buildDefaultAvatar(),
          ),
        ),

        // 皇冠
        if (memberType == MemberType.plus)
          Positioned(
            top: _getCrownTop(),
            left: _getCrownLeft(),
            child: MemberCrown(
              size: crownSize,
            ),
          ),
      ],
    );
  }

  double _getCrownTop() {
    switch (crownPosition) {
      case CrownPosition.topLeft:
      case CrownPosition.topRight:
        return -crownSize * 0.2;
      case CrownPosition.bottomLeft:
      case CrownPosition.bottomRight:
        return size - crownSize * 0.8;
    }
  }

  double _getCrownLeft() {
    switch (crownPosition) {
      case CrownPosition.topLeft:
      case CrownPosition.bottomLeft:
        return -crownSize * 0.2;
      case CrownPosition.topRight:
      case CrownPosition.bottomRight:
        return size - crownSize * 0.8;
    }
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        size: size * 0.5,
        color: Colors.white,
      ),
    );
  }
}

/// 会员状态文本组件
class MemberStatusText extends ConsumerWidget {
  const MemberStatusText({
    super.key,
    this.vipEndDate,
    this.style,
    this.showExpiry = false,
  });
  final int? vipEndDate;
  final TextStyle? style;
  final bool showExpiry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(myProfileProvider);
    final memberType = profile?.memberType ?? MemberType.none;

    if (memberType != MemberType.plus) {
      return const SizedBox.shrink();
    }

    final String text = _getStatusText();
    final Color color = _getStatusColor();

    return Text(
      text,
      style: style ??
          TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  String _getStatusText() {
    final String baseText = 'Plus Member';

    if (showExpiry && vipEndDate != null) {
      final expiryDate =
          DateTime.fromMillisecondsSinceEpoch(vipEndDate! * 1000);
      final now = DateTime.now();
      final daysLeft = expiryDate.difference(now).inDays;

      if (daysLeft > 0) {
        return '$baseText (${daysLeft}d left)';
      } else {
        return '$baseText (Expired)';
      }
    }

    return baseText;
  }

  Color _getStatusColor() {
    return const Color(0xFF9370DB); // 紫色
  }
}
