// lib/core/match/widgets/components/match_analysis_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:sona/generated/l10n.dart';

class MatchAnalysisBottomSheet extends StatelessWidget {
  final String content;

  const MatchAnalysisBottomSheet({super.key, required this.content});

  static void show(BuildContext context, String content) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF0E0E14),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: MatchAnalysisBottomSheet(content: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 顶部拖拽条
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        // 标题
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: theme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                S.of(context).lightAnalysisTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // 内容区域
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GptMarkdown(
              content,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.9),
                height: 1.6,
              ),
            ),
          ),
        ),
        // 底部按钮
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(S.of(context).closeButtonText),
          ),
        ),
      ],
    );
  }
}
