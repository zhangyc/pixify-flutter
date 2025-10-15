import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sona/core/healing/services/healing_database.dart';
import 'package:sona/generated/l10n.dart';

/// 星盘疗愈日历页面
class AstroCalendarPage extends StatefulWidget {
  const AstroCalendarPage({super.key});

  @override
  State<AstroCalendarPage> createState() => _AstroCalendarPageState();
}

class _AstroCalendarPageState extends State<AstroCalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<HealingActivity>> _healingActivities = {};
  Map<DateTime, MoonPhase> _moonPhases = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadMonthData(_focusedDay);
  }

  Future<void> _loadMonthData(DateTime month) async {
    final startDate = DateTime(month.year, month.month, 1);
    final endDate = DateTime(month.year, month.month + 1, 0);

    // 加载疗愈活动
    await _loadHealingActivities(startDate, endDate);

    // 计算月相
    _calculateMoonPhases(startDate, endDate);
  }

  Future<void> _loadHealingActivities(DateTime start, DateTime end) async {
    final db = HealingDatabase.instance;
    final activities = <DateTime, List<HealingActivity>>{};

    // 加载冥想记录
    final meditations = await db.getMeditationRecords(
      start.toIso8601String().split('T')[0],
      end.toIso8601String().split('T')[0],
    );

    // 加载情绪日记
    final emotions = await db.getEmotionDiary();

    // 加载每日状态
    final dailyStatus = await db.getDailyStatusByRange(
      start.toIso8601String().split('T')[0],
      end.toIso8601String().split('T')[0],
    );

    // 按日期组织数据
    for (var meditation in meditations) {
      final date = DateTime.parse(meditation['date']);
      final normalizedDate = DateTime(date.year, date.month, date.day);

      activities.putIfAbsent(normalizedDate, () => []);
      activities[normalizedDate]!.add(HealingActivity(
        type: ActivityType.meditation,
        data: meditation,
      ));
    }

    for (var emotion in emotions) {
      final date = DateTime.parse(emotion['date']);
      final normalizedDate = DateTime(date.year, date.month, date.day);

      activities.putIfAbsent(normalizedDate, () => []);
      activities[normalizedDate]!.add(HealingActivity(
        type: ActivityType.emotion,
        data: emotion,
      ));
    }

    for (var status in dailyStatus) {
      final date = DateTime.parse(status['date']);
      final normalizedDate = DateTime(date.year, date.month, date.day);

      activities.putIfAbsent(normalizedDate, () => []);
      activities[normalizedDate]!.add(HealingActivity(
        type: ActivityType.dailyStatus,
        data: status,
      ));
    }

    _healingActivities = activities;
  }

  void _calculateMoonPhases(DateTime start, DateTime end) {
    final phases = <DateTime, MoonPhase>{};

    for (var day = start;
        day.isBefore(end) || day.isAtSameMomentAs(end);
        day = day.add(const Duration(days: 1))) {
      final normalizedDate = DateTime(day.year, day.month, day.day);
      phases[normalizedDate] = _getMoonPhase(day);
    }

    _moonPhases = phases;
  }

  MoonPhase _getMoonPhase(DateTime date) {
    // 简化的月相计算（基于新月周期29.53天）
    final newMoonDate = DateTime(2000, 1, 6); // 参考新月日期
    final daysSinceNewMoon = date.difference(newMoonDate).inDays % 29.53;

    if (daysSinceNewMoon < 1.84) return MoonPhase.newMoon;
    if (daysSinceNewMoon < 7.38) return MoonPhase.waxingCrescent;
    if (daysSinceNewMoon < 9.23) return MoonPhase.firstQuarter;
    if (daysSinceNewMoon < 14.77) return MoonPhase.waxingGibbous;
    if (daysSinceNewMoon < 16.61) return MoonPhase.fullMoon;
    if (daysSinceNewMoon < 22.15) return MoonPhase.waningGibbous;
    if (daysSinceNewMoon < 23.99) return MoonPhase.lastQuarter;
    return MoonPhase.waningCrescent;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(S.of(context).astro_calendar_title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 月度统计卡片
          _buildMonthlyStats(theme),

          // 日历
          Expanded(
            child: TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,

              // 样式配置
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                weekendTextStyle: const TextStyle(color: Colors.white70),
                defaultTextStyle: const TextStyle(color: Colors.white),
                selectedDecoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),

              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon:
                    const Icon(Icons.chevron_left, color: Colors.white),
                rightChevronIcon:
                    const Icon(Icons.chevron_right, color: Colors.white),
              ),

              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.white70),
                weekendStyle: TextStyle(color: Colors.white70),
              ),

              // 事件标记
              eventLoader: (day) {
                final normalizedDay = DateTime(day.year, day.month, day.day);
                return _healingActivities[normalizedDay] ?? [];
              },

              // 自定义日历格子
              calendarBuilders: CalendarBuilders<HealingActivity>(
                defaultBuilder: (context, day, focusedDay) {
                  return _buildCalendarCell(day, false, false);
                },
                selectedBuilder: (context, day, focusedDay) {
                  return _buildCalendarCell(day, true, false);
                },
                todayBuilder: (context, day, focusedDay) {
                  return _buildCalendarCell(day, false, true);
                },
              ),

              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _showDayDetails(selectedDay);
              },

              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
                _loadMonthData(focusedDay);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyStats(ThemeData theme) {
    final daysWithActivities = _healingActivities.keys
        .where((date) => date.month == _focusedDay.month)
        .length;

    final totalActivities = _healingActivities.values
        .where((activities) => activities.isNotEmpty)
        .fold<int>(0, (sum, activities) => sum + activities.length);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.primaryColor.withOpacity(0.2),
            theme.primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            icon: Icons.calendar_today,
            value: daysWithActivities.toString(),
            label: S.of(context).active_days,
            color: theme.primaryColor,
          ),
          _buildStatItem(
            icon: Icons.stars,
            value: totalActivities.toString(),
            label: S.of(context).healing_sessions,
            color: const Color(0xFFF39C12),
          ),
          _buildStatItem(
            icon: Icons.local_fire_department,
            value: daysWithActivities.toString(),
            label: S.of(context).streak_days,
            color: const Color(0xFFE74C3C),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
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
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarCell(DateTime day, bool isSelected, bool isToday) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    final activities = _healingActivities[normalizedDay] ?? [];
    final moonPhase = _moonPhases[normalizedDay] ?? MoonPhase.newMoon;

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).primaryColor
            : _getMoonPhaseColor(moonPhase).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isToday
              ? Theme.of(context).primaryColor
              : Colors.white.withOpacity(0.1),
          width: isToday ? 2 : 1,
        ),
      ),
      child: Stack(
        children: [
          // 月相图标
          Positioned(
            top: 2,
            right: 2,
            child: Text(
              _getMoonPhaseIcon(moonPhase),
              style: const TextStyle(fontSize: 10),
            ),
          ),

          // 日期
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${day.day}',
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.9),
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 2),
                // 活动图标
                if (activities.isNotEmpty)
                  Wrap(
                    spacing: 2,
                    children: activities.take(3).map((activity) {
                      return Text(
                        _getActivityIcon(activity.type),
                        style: const TextStyle(fontSize: 10),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getMoonPhaseColor(MoonPhase phase) {
    switch (phase) {
      case MoonPhase.newMoon:
        return const Color(0xFF2C3E50);
      case MoonPhase.waxingCrescent:
      case MoonPhase.waxingGibbous:
        return const Color(0xFF3498DB);
      case MoonPhase.firstQuarter:
        return const Color(0xFF9B59B6);
      case MoonPhase.fullMoon:
        return const Color(0xFFF39C12);
      case MoonPhase.waningGibbous:
      case MoonPhase.waningCrescent:
        return const Color(0xFFE74C3C);
      case MoonPhase.lastQuarter:
        return const Color(0xFF16A085);
    }
  }

  String _getMoonPhaseIcon(MoonPhase phase) {
    switch (phase) {
      case MoonPhase.newMoon:
        return '🌑';
      case MoonPhase.waxingCrescent:
        return '🌒';
      case MoonPhase.firstQuarter:
        return '🌓';
      case MoonPhase.waxingGibbous:
        return '🌔';
      case MoonPhase.fullMoon:
        return '🌕';
      case MoonPhase.waningGibbous:
        return '🌖';
      case MoonPhase.lastQuarter:
        return '🌗';
      case MoonPhase.waningCrescent:
        return '🌘';
    }
  }

  String _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.meditation:
        return '🧘';
      case ActivityType.emotion:
        return '💭';
      case ActivityType.dailyStatus:
        return '✍️';
      case ActivityType.music:
        return '🎵';
    }
  }

  void _showDayDetails(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    final activities = _healingActivities[normalizedDay] ?? [];
    final moonPhase = _moonPhases[normalizedDay] ?? MoonPhase.newMoon;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Color(0xFF1A1A22),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // 标题栏
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    '${day.month} ${day.day}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _getMoonPhaseIcon(moonPhase),
                    style: const TextStyle(fontSize: 24),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // 星象解读
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getMoonPhaseColor(moonPhase).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome,
                      color: Color(0xFFF39C12), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _getMoonPhaseInsight(moonPhase),
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 活动列表
            Expanded(
              child: activities.isEmpty
                  ? Center(
                      child: Text(
                        S.of(context).no_records_today,
                        style: TextStyle(color: Colors.white54),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        final activity = activities[index];
                        return _buildActivityItem(activity);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(HealingActivity activity) {
    IconData icon;
    Color color;
    String title;
    String subtitle;

    switch (activity.type) {
      case ActivityType.meditation:
        icon = Icons.self_improvement;
        color = const Color(0xFF9B59B6);
        title = S.of(context).meditation_practice_title;
        subtitle = '${activity.data['duration'] ~/ 60} m';
        break;
      case ActivityType.emotion:
        icon = Icons.favorite;
        color = const Color(0xFFE74C3C);
        title = S.of(context).emotion_diary;
        subtitle = activity.data['emotion_type'] ?? '';
        break;
      case ActivityType.dailyStatus:
        icon = Icons.edit_note;
        color = const Color(0xFF3498DB);
        title = S.of(context).daily_status;
        subtitle = '${activity.data['mood_score']}/10';
        break;
      case ActivityType.music:
        icon = Icons.music_note;
        color = const Color(0xFFF39C12);
        title = S.of(context).healing_music_title;
        subtitle = '';
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getMoonPhaseInsight(MoonPhase phase) {
    switch (phase) {
      case MoonPhase.newMoon:
        return S.of(context).new_moon_insight;
      case MoonPhase.waxingCrescent:
        return S.of(context).waxing_crescent_insight;
      case MoonPhase.firstQuarter:
        return S.of(context).first_quarter_insight;
      case MoonPhase.waxingGibbous:
        return S.of(context).waxing_gibbous_insight;
      case MoonPhase.fullMoon:
        return S.of(context).full_moon_insight;
      case MoonPhase.waningGibbous:
        return S.of(context).waning_gibbous_insight;
      case MoonPhase.lastQuarter:
        return S.of(context).last_quarter_insight;
      case MoonPhase.waningCrescent:
        return S.of(context).waning_crescent_insight;
    }
  }
}

// 数据模型
enum MoonPhase {
  newMoon,
  waxingCrescent,
  firstQuarter,
  waxingGibbous,
  fullMoon,
  waningGibbous,
  lastQuarter,
  waningCrescent,
}

enum ActivityType {
  meditation,
  emotion,
  dailyStatus,
  music,
}

class HealingActivity {
  final ActivityType type;
  final Map<String, dynamic> data;

  HealingActivity({required this.type, required this.data});
}
