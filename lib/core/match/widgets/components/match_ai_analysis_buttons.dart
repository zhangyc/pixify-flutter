// lib/core/match/widgets/components/match_ai_analysis_buttons.dart
import 'package:flutter/material.dart';
import 'package:sona/generated/l10n.dart';

enum ButtonType { light, deep }

/// 单个AI分析按钮组件
class MatchAIAnalysisButton extends StatelessWidget {
  final String text;
  final String subtitle;
  final IconData icon;
  final ButtonType buttonType;
  final bool isLoading;
  final VoidCallback? onTap;

  const MatchAIAnalysisButton({
    super.key,
    required this.text,
    required this.subtitle,
    required this.icon,
    required this.buttonType,
    required this.isLoading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 调试信息
    print('MatchAIAnalysisButton building: $text, isLoading: $isLoading');

    final theme = Theme.of(context);
    final isDeep = buttonType == ButtonType.deep;

    // 根据按钮类型设置不同的颜色和样式
    final buttonColor = isDeep
        ? const Color(0xFF8B5CF6) // 紫色 - 深度分析
        : const Color(0xFFEC4899); // 粉色 - 基础分析

    final buttonOpacity = isLoading ? 0.05 : 0.1;
    final borderOpacity = isLoading ? 0.2 : 0.3;
    final shadowOpacity = isDeep ? 0.25 : 0.15; // 深度分析阴影更强
    final shadowBlur = isDeep ? 12.0 : 8.0; // 深度分析阴影更大

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isDeep ? 20 : 16, // 深度分析内边距更大
          vertical: isDeep ? 16 : 12, // 深度分析垂直内边距更大
        ),
        decoration: BoxDecoration(
          color: isLoading
              ? buttonColor.withOpacity(buttonOpacity)
              : buttonColor.withOpacity(buttonOpacity),
          borderRadius: BorderRadius.circular(isDeep ? 20 : 16), // 深度分析圆角更大
          border: Border.all(
            color: buttonColor.withOpacity(borderOpacity),
            width: isDeep ? 2 : 1, // 深度分析边框更粗
          ),
          boxShadow: [
            BoxShadow(
              color: buttonColor.withOpacity(shadowOpacity),
              blurRadius: shadowBlur,
              offset: Offset.zero,
            ),
          ],
          // 深度分析添加渐变背景
          gradient: isDeep && !isLoading
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    buttonColor.withOpacity(0.15),
                    buttonColor.withOpacity(0.08),
                  ],
                )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 第一行：图标和钻石消耗
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(buttonColor),
                    ),
                  )
                else
                  Icon(icon, size: 18, color: buttonColor),
                const SizedBox(width: 6),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: buttonColor.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // 第二行：标题文本
            Text(
              isLoading ? S.current.analyzingText : text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: buttonColor,
                fontWeight: FontWeight.w600,
                fontSize: isDeep ? 15 : 14, // 深度分析字体稍大
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// AI分析按钮组（兼容旧代码）
class MatchAiAnalysisButtons extends StatelessWidget {
  final bool isLightAnalyzing;
  final bool isDeepAnalyzing;
  final VoidCallback? onLightAnalysis;
  final VoidCallback? onDeepAnalysis;

  const MatchAiAnalysisButtons({
    super.key,
    required this.isLightAnalyzing,
    required this.isDeepAnalyzing,
    this.onLightAnalysis,
    this.onDeepAnalysis,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 合盘分析按钮 (基础版)
        Expanded(
          flex: 2,
          child: MatchAIAnalysisButton(
            text: S.of(context).synastryAnalysis,
            subtitle: '100钻石',
            icon: Icons.favorite,
            buttonType: ButtonType.light,
            isLoading: isLightAnalyzing,
            onTap: isLightAnalyzing ? null : onLightAnalysis,
          ),
        ),
        const SizedBox(width: 16),
        // 深度合盘按钮 (高级版)
        Expanded(
          flex: 3,
          child: MatchAIAnalysisButton(
            text: S.of(context).deepSynastryAnalysis,
            subtitle: '250钻石',
            icon: Icons.psychology,
            buttonType: ButtonType.deep,
            isLoading: isDeepAnalyzing,
            onTap: isDeepAnalyzing ? null : onDeepAnalysis,
          ),
        ),
      ],
    );
  }
}
