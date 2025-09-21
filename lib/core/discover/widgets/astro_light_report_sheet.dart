import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/astro_score.dart';
import '../models/discover_user.dart';
import '../services/discover_service.dart';

class AstroLightReportSheet extends StatefulWidget {
  const AstroLightReportSheet({
    super.key,
    required this.user,
  });

  final DiscoverUser user;

  @override
  State<AstroLightReportSheet> createState() => _AstroLightReportSheetState();
}

class _AstroLightReportSheetState extends State<AstroLightReportSheet> {
  AstroLightReport? _report;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReport();
  }

  Future<void> _loadReport() async {
    try {
      final report = await DiscoverService.getLightReport(widget.user.id);
      if (mounted) {
        setState(() {
          _report = report;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final astroScore = widget.user.astroScore;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // 拖拽指示器
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 20),

          // 标题区域
          _buildHeader(theme, astroScore),

          const SizedBox(height: 20),

          // 内容区域
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildContent(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, AstroScore? astroScore) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '你们的缘分',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (astroScore != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildScoreChip(
                        theme, '缘分', astroScore.fate, const Color(0xFFFF6B9D)),
                    const SizedBox(width: 8),
                    _buildScoreChip(theme, '契合', astroScore.harmony,
                        const Color(0xFF4ADE80)),
                    const SizedBox(width: 8),
                    _buildScoreChip(
                        theme, '雷区', astroScore.risk, const Color(0xFFF59E0B)),
                  ],
                ),
              ],
            ],
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close_rounded,
              color: theme.textTheme.bodyMedium?.color,
            ),
            style: IconButton.styleFrom(
              backgroundColor: theme.primaryColor.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreChip(
      ThemeData theme, String label, int score, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        '$label $score',
        style: theme.textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildContent(ThemeData theme) {
    if (_report == null) {
      return const Center(
        child: Text('加载失败，请重试'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 洞察部分
          _buildInsightsSection(theme),

          const SizedBox(height: 24),

          // 今日话题
          _buildTopicsSection(theme),

          const SizedBox(height: 24),

          // 开场白建议
          _buildOpenersSection(theme),

          const SizedBox(height: 24),

          // 深度报告入口
          _buildDeepReportCTA(theme),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildInsightsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '✨ 缘分洞察',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        ..._report!.insights
            .map((insight) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          insight,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildTopicsSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '💬 今日宜聊',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _report!.todayTopics
              .map((topic) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '#$topic',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildOpenersSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '🌟 开场白建议',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        ..._report!.openers
            .map((opener) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark
                        ? const Color(0xFF1A1A1F)
                        : const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.primaryColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          opener,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () => _copyOpener(opener),
                        icon: Icon(
                          Icons.copy_rounded,
                          color: theme.primaryColor,
                          size: 20,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: theme.primaryColor.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildDeepReportCTA(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.primaryColor.withOpacity(0.1),
            theme.primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.auto_awesome,
            color: theme.primaryColor,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            '深度合盘报告',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '解锁详细相位分析、最佳时机提醒',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _navigateToSubscribe,
            child: const Text('查看深度报告'),
          ),
        ],
      ),
    );
  }

  void _copyOpener(String opener) {
    Clipboard.setData(ClipboardData(text: opener));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('开场白已复制'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );

    // 埋点
    // SonaAnalytics.log('astro_openers_copy');
  }

  void _navigateToSubscribe() {
    Navigator.pop(context);
    // TODO: 导航到订阅页面
    print('Navigate to subscribe page');

    // 埋点
    // SonaAnalytics.log('astro_paywall_view');
  }
}
