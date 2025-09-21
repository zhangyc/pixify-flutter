import 'dart:ui';
import 'package:flutter/material.dart';

// ========== 语义色彩系统 ==========
class AppColors {
  // 品牌色系 - 温暖浪漫紫
  static const Color primary = Color(0xFF6A5AE0); // 主色：温暖紫
  static const Color primaryVariant = Color(0xFF8B77E6); // 主色变体
  static const Color secondary = Color(0xFFFF6B9D); // 辅色：浪漫粉
  static const Color accent = Color(0xFFFF9E7D); // 强调色：珊瑚橙

  // 功能色系
  static const Color success = Color(0xFF4ADE80); // 成功绿
  static const Color warning = Color(0xFFF59E0B); // 警告黄
  static const Color danger = Color(0xFFEF4444); // 危险红
  static const Color info = Color(0xFF60A5FA); // 信息蓝

  // 中性色系
  static const Color background = Color(0xFFFAFAFA); // 浅背景
  static const Color surface = Color(0xFFFFFFFF); // 表面
  static const Color surfaceVariant = Color(0xFFF5F5F5); // 表面变体
  static const Color onSurface = Color(0xFF1A1A1A); // 表面文字
  static const Color onSurfaceVariant = Color(0xFF666666); // 次级文字

  // 边框与分割
  static const Color outline = Color(0xFFE0E0E0); // 描边
  static const Color outlineVariant = Color(0xFFF0F0F0); // 描边变体
  static const Color divider = Color(0xFFE8E8E8); // 分割线

  // 交互状态
  static const Color hover = Color(0xFFEBE9F7); // 悬停态
  static const Color pressed = Color(0xFFD4D0F0); // 按压态
  static const Color disabled = Color(0xFF9E9E9E); // 禁用态

  // 占星主题色彩
  static const Color astroPrimary = Color(0xFF8B5CF6); // 占星主题紫
  static const Color astroSecondary = Color(0xFFF472B6); // 占星主题粉
  static const Color fateBadge = Color(0xFFFF6B9D); // 缘分徽章
  static const Color harmonyBadge = Color(0xFF4ADE80); // 和谐徽章
  static const Color riskBadge = Color(0xFFF59E0B); // 风险徽章
}

// ========== 尺寸系统 ==========
class AppSizes {
  // 圆角半径 - 统一使用 20px 圆角
  static const double radiusSm = 8.0; // 小圆角
  static const double radiusMd = 12.0; // 中圆角
  static const double radiusLg = 16.0; // 大圆角
  static const double radiusXl = 20.0; // 主圆角
  static const double radiusFull = 100.0; // 圆形

  // 间距系统 (4的倍数)
  static const double spaceXs = 4.0; // 最小间距
  static const double spaceSm = 8.0; // 小间距
  static const double spaceMd = 12.0; // 中间距
  static const double spaceLg = 16.0; // 大间距
  static const double spaceXl = 20.0; // 超大间距
  static const double spaceXxl = 24.0; // 极大间距
  static const double spaceXxxl = 32.0; // 极大间距

  // 组件高度
  static const double buttonHeight = 56.0; // 按钮高度
  static const double inputHeight = 48.0; // 输入框高度
  static const double tabHeight = 44.0; // Tab高度

  // 描边宽度
  static const double borderWidth = 1.0; // 普通描边
  static const double borderWidthBold = 2.0; // 粗描边

  // 阴影系统
  static const double shadowSm = 2.0; // 小阴影
  static const double shadowMd = 4.0; // 中阴影
  static const double shadowLg = 8.0; // 大阴影
}

// ========== 兼容性定义 - 保持向后兼容 ==========
const Color primaryColor = AppColors.primary;
const Color scaffoldBackgroundColor = AppColors.background;
const Color fontColour = AppColors.onSurface;
const Color disabledColor = AppColors.disabled;
const Color dividerColor = AppColors.divider;
