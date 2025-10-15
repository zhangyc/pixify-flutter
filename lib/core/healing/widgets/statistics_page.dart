import 'package:flutter/material.dart';
import 'package:sona/core/healing/services/healing_database.dart';
import 'package:sona/generated/l10n.dart';

/// 疗愈数据统计页面
class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  Map<String, dynamic> _stats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  Future<void> _loadStatistics() async {
    final stats = await HealingDatabase.instance.getStatistics(
      DateTime.now().subtract(Duration(days: 30)).toIso8601String(),
      DateTime.now().toIso8601String(),
    );
    setState(() {
      _stats = stats;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(S.of(context).my_statistics),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadStatistics,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 冥想统计
                    _buildSectionTitle(S.of(context).meditation_practice_title,
                        Icons.self_improvement, const Color(0xFF9B59B6)),
                    const SizedBox(height: 12),
                    _buildMeditationStats(),
                    const SizedBox(height: 24),

                    // 情绪统计
                    _buildSectionTitle(S.of(context).emotion_analysis,
                        Icons.favorite, const Color(0xFFE74C3C)),
                    const SizedBox(height: 12),
                    _buildEmotionStats(),
                    const SizedBox(height: 24),

                    // 每日状态
                    _buildSectionTitle(S.of(context).daily_status,
                        Icons.trending_up, const Color(0xFF3498DB)),
                    const SizedBox(height: 12),
                    _buildDailyStats(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMeditationStats() {
    final meditationMinutes = _stats['meditation_minutes'] ?? 0;
    final meditationCount = _stats['meditation_count'] ?? 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF9B59B6).withOpacity(0.15),
            const Color(0xFF9B59B6).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF9B59B6).withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  S.of(context).total_duration,
                  '${(meditationMinutes / 60).toStringAsFixed(1)} 小时',
                  Icons.access_time,
                  const Color(0xFF9B59B6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  S.of(context).practice_count,
                  '$meditationCount',
                  Icons.repeat,
                  const Color(0xFF9B59B6),
                ),
              ),
            ],
          ),
          if (meditationCount > 0) ...[
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: (meditationCount % 30) / 30,
              backgroundColor: const Color(0xFF9B59B6).withOpacity(0.2),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF9B59B6)),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).days_to_30_goal(30 - (meditationCount % 30)),
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmotionStats() {
    final emotionDist = _stats['emotion_distribution'] as Map? ?? {};
    final avgMood = _stats['avg_mood'] ?? 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFE74C3C).withOpacity(0.15),
            const Color(0xFFE74C3C).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE74C3C).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  S.of(context).average_mood,
                  avgMood.toStringAsFixed(1),
                  Icons.sentiment_satisfied,
                  const Color(0xFFE74C3C),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  S.of(context).recorded_days,
                  '${emotionDist.length}',
                  Icons.calendar_today,
                  const Color(0xFFE74C3C),
                ),
              ),
            ],
          ),
          if (emotionDist.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              S.of(context).emotion_distribution,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...emotionDist.entries.map((entry) {
              final total = emotionDist.values
                  .fold<int>(0, (sum, count) => sum + (count as int));
              final percentage = (entry.value / total * 100).toInt();
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE74C3C).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: percentage / 100,
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE74C3C),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 40,
                      child: Text(
                        '$percentage%',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildDailyStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3498DB).withOpacity(0.15),
            const Color(0xFF3498DB).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF3498DB).withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  S.of(context).energy_index,
                  '75',
                  Icons.battery_charging_full,
                  const Color(0xFF3498DB),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  S.of(context).stress_index,
                  '32',
                  Icons.trending_down,
                  const Color(0xFF3498DB),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF3498DB).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.emoji_events,
                  color: const Color(0xFFF39C12),
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).streak_x_days(7.toString()),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        S.of(context).keep_it_up,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
