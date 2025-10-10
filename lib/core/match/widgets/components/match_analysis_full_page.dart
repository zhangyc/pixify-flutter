// lib/core/match/widgets/components/match_analysis_full_page.dart
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import 'package:sona/generated/l10n.dart';

class MatchAnalysisFullPage extends StatelessWidget {
  final String content;

  const MatchAnalysisFullPage({super.key, required this.content});

  static void show(BuildContext context, String content) {
    final theme = Theme.of(context);

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => Scaffold(
          backgroundColor: const Color(0xFF0E0E14),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1A1A22),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Row(
              children: [
                Icon(Icons.psychology, color: theme.primaryColor, size: 24),
                const SizedBox(width: 12),
                Text(
                  S.of(context).deepAnalysisReportTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: GptMarkdown(
                  content,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    height: 1.8,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: GptMarkdown(
            content,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
              height: 1.8,
            ),
          ),
        ),
      ),
    );
  }
}
