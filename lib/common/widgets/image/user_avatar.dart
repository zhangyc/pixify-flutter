import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserAvatar extends ConsumerWidget {
  const UserAvatar(
      {super.key,
      required this.url,
      this.name,
      this.size = const Size.square(50),
      this.borderRadius = const BorderRadius.all(Radius.circular(24)),
      this.borderSide = const BorderSide(color: Color(0xFFE8E6E6), width: 1)});

  final String? url;
  final String? name;
  final Size size;
  final BorderSide borderSide;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(borderRadius: borderRadius),
      foregroundDecoration: BoxDecoration(
          border: Border.fromBorderSide(borderSide),
          borderRadius: borderRadius),
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      child: _buildAvatarContent(context),
    );
  }

  Widget _buildAvatarContent(BuildContext context) {
    final theme = Theme.of(context);

    // 如果有 URL，显示网络图片
    if (url != null && url!.isNotEmpty) {
      return CachedNetworkImage(
        width: size.width,
        height: size.height,
        imageUrl: url!,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        placeholder: (context, url) => _buildInitialAvatar(theme),
        errorWidget: (context, url, error) => _buildInitialAvatar(theme),
      );
    }

    // 如果没有 URL，显示首字母头像
    return _buildInitialAvatar(theme);
  }

  Widget _buildInitialAvatar(ThemeData theme) {
    // 获取首字母
    final initial = _getInitial();

    // 根据姓名生成颜色
    final backgroundColor = _generateBackgroundColor(theme);

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        //borderRadius: borderRadius,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          color: Colors.white,
          fontSize: _getFontSize(),
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  String _getInitial() {
    if (name == null || name!.isEmpty) {
      return '?';
    }

    // 获取第一个字符
    final firstChar = name!.trim().characters.first.toUpperCase();
    return firstChar;
  }

  Color _generateBackgroundColor(ThemeData theme) {
    if (name == null || name!.isEmpty) {
      return theme.primaryColor.withOpacity(0.7);
    }

    // 基于姓名生成一致的颜色
    final hash = name!.hashCode;
    final colors = [
      theme.primaryColor,
      const Color(0xFF6A5AE0), // 紫色
      const Color(0xFF00EED1), // 青绿色
      const Color(0xFFFF6B9D), // 粉色
      const Color(0xFFFF9E7D), // 橙色
      const Color(0xFF4ADE80), // 绿色
      const Color(0xFFF59E0B), // 黄色
      const Color(0xFF60A5FA), // 蓝色
    ];

    return colors[hash.abs() % colors.length];
  }

  double _getFontSize() {
    // 根据头像大小调整字体大小
    final minSize = min(size.width, size.height);
    if (minSize <= 40) return 14;
    if (minSize <= 60) return 18;
    if (minSize <= 80) return 22;
    return 26;
  }
}

class UserAvatarImageProvider extends CachedNetworkImageProvider {
  const UserAvatarImageProvider(
    super.url,
    // Map<String, String>? headers
  ) : super(
        // headers: headers
        );
}
