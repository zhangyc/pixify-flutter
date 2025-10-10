import 'package:flutter/material.dart';

/// 美观的SnackBar工具类
class StyledSnackBar {
  /// 显示成功消息的SnackBar
  static SnackBar success({
    required BuildContext context,
    required String message,
  }) {
    return _createSnackBar(
      message: message,
      icon: Icons.check_circle_outline,
      backgroundColor: Colors.green.shade600,
    );
  }

  /// 显示错误消息的SnackBar
  static SnackBar error({
    required BuildContext context,
    required String message,
  }) {
    return _createSnackBar(
      message: message,
      icon: Icons.error_outline,
      backgroundColor: Colors.red.shade600,
    );
  }

  /// 显示警告消息的SnackBar
  static SnackBar warning({
    required BuildContext context,
    required String message,
  }) {
    return _createSnackBar(
      message: message,
      icon: Icons.warning_amber_rounded,
      backgroundColor: Colors.orange.shade600,
    );
  }

  /// 显示信息消息的SnackBar
  static SnackBar info({
    required BuildContext context,
    required String message,
  }) {
    return _createSnackBar(
      message: message,
      icon: Icons.info_outline,
      backgroundColor: Colors.blue.shade600,
    );
  }

  /// 创建美观的SnackBar
  static SnackBar _createSnackBar({
    required String message,
    required IconData icon,
    required Color backgroundColor,
  }) {
    return SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }

  /// 显示SnackBar的便捷方法
  static void show({
    required BuildContext context,
    required String message,
    required IconData icon,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      _createSnackBar(
        message: message,
        icon: icon,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// 显示成功消息
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(success(context: context, message: message));
  }

  /// 显示错误消息
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(error(context: context, message: message));
  }

  /// 显示警告消息
  static void showWarning(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(warning(context: context, message: message));
  }

  /// 显示信息消息
  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(info(context: context, message: message));
  }
}
