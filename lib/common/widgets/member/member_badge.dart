import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/subscribe/model/member.dart';

/// 会员标识组件
/// 根据会员类型显示不同的标识样式
class MemberBadge extends ConsumerWidget {
  const MemberBadge({
    super.key,
    this.size = 20,
    this.showText = false,
    this.textStyle,
    this.borderColor,
    this.backgroundColor,
  });
  final double size;
  final bool showText;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(myProfileProvider);

    // 只在Plus会员时显示标识
    if (!(profile?.isMember ?? false)) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.3,
        vertical: size * 0.15,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? _getBackgroundColor().withOpacity(0.1),
        border: Border.all(
          color: borderColor ?? _getBorderColor(),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(size * 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIcon(),
            size: size * 0.8,
            color: _getIconColor(),
          ),
          if (showText) ...[
            SizedBox(width: size * 0.2),
            Text(
              _getText(),
              style: textStyle ??
                  TextStyle(
                    fontSize: size * 0.6,
                    fontWeight: FontWeight.bold,
                    color: _getTextColor(),
                  ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    return const Color(0xFF9370DB); // 紫色
  }

  Color _getBorderColor() {
    return const Color(0xFF9370DB); // 紫色
  }

  Color _getIconColor() {
    return const Color(0xFF9370DB); // 紫色
  }

  Color _getTextColor() {
    return const Color(0xFF9370DB); // 紫色
  }

  IconData _getIcon() {
    return Icons.verified; // Plus会员用验证图标
  }

  String _getText() {
    return 'PLUS';
  }
}

/// 简化的会员标识组件（只显示图标）
class MemberIcon extends ConsumerWidget {
  const MemberIcon({
    super.key,
    this.size = 16,
    this.color,
  });
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(myProfileProvider);

    if (!(profile?.isMember ?? false)) {
      return const SizedBox.shrink();
    }

    return Icon(
      _getIcon(),
      size: size,
      color: color ?? _getDefaultColor(),
    );
  }

  IconData _getIcon() {
    return Icons.verified;
  }

  Color _getDefaultColor() {
    return const Color(0xFF9370DB); // 紫色
  }
}
