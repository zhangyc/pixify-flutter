import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sona/core/healing/services/healing_database.dart';
import 'package:sona/generated/l10n.dart';
import 'package:sona/core/diamond/services/diamond.dart';
import 'package:sona/core/diamond/diamond_store_page.dart';
import 'package:sona/core/match/util/http_util.dart';
import 'package:sona/account/providers/profile.dart';

/// 星盘疗愈日历页面
class AstroCalendarPage extends ConsumerStatefulWidget {
  const AstroCalendarPage({super.key});

  @override
  ConsumerState<AstroCalendarPage> createState() => _AstroCalendarPageState();
}

class _AstroCalendarPageState extends ConsumerState<AstroCalendarPage> {
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

          // 钻石消耗功能区
          _buildDiamondFeatures(theme),

          // 日历
          Expanded(
            child: SingleChildScrollView(
              child: TableCalendar(
                daysOfWeekHeight: 40,
                firstDay: DateTime.utc(2024, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.monday,

                // 样式配置
                calendarStyle: CalendarStyle(
                  cellMargin: EdgeInsets.zero,
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

  /// 钻石消耗功能区
  Widget _buildDiamondFeatures(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6366F1).withOpacity(0.2),
            const Color(0xFF8B5CF6).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF6366F1).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Row(
            children: [
              const Icon(Icons.auto_awesome,
                  color: Color(0xFF6366F1), size: 20),
              const SizedBox(width: 8),
              Text(
                '星座能量解读',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 功能按钮
          Row(
            children: [
              // 月相能量解读
              Expanded(
                child: _buildDiamondFeatureButton(
                  title: S.current.moonPhaseEnergy,
                  subtitle: S.current.unlockMoonPhaseInsight,
                  cost: 20,
                  icon: Icons.nightlight_round,
                  onTap: _unlockMoonPhaseInsight,
                ),
              ),
              const SizedBox(width: 12),
              // 每日运势
              Expanded(
                child: _buildDiamondFeatureButton(
                  title: S.current.dailyHoroscope,
                  subtitle: S.current.unlockDailyHoroscope,
                  cost: 30,
                  icon: Icons.wb_sunny,
                  onTap: _unlockDailyHoroscope,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 钻石功能按钮
  Widget _buildDiamondFeatureButton({
    required String title,
    required String subtitle,
    required int cost,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 图标和钻石消耗提示
            Row(
              children: [
                Icon(icon, color: const Color(0xFF00EED1), size: 16),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00EED1).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.diamond,
                          size: 10, color: Color(0xFF00EED1)),
                      const SizedBox(width: 2),
                      Text(
                        '$cost',
                        style: const TextStyle(
                          color: Color(0xFF00EED1),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 标题
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            // 副标题
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 10,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  /// 解锁月相能量解读
  Future<void> _unlockMoonPhaseInsight() async {
    // 检查钻石余额
    final checkResult = await DiamondService.checkBalance(requiredDiamonds: 20);

    if (!checkResult.isSuccess || !checkResult.data["hasEnough"]) {
      // 钻石不足，跳转到商店
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const DiamondStorePage(),
          ),
        );
      }
      return;
    }

    // 获取当前选中的日期的月相
    final selectedDate = _selectedDay ?? _focusedDay;
    final moonPhase = _moonPhases[selectedDate] ?? MoonPhase.newMoon;

    // 调用API获取月相解读
    try {
      // 显示loading
      await EasyLoading.show(
        status: S.current.analyzingMoonPhase,
        maskType: EasyLoadingMaskType.black,
      );

      final moonPhaseResult =
          await _fetchMoonPhaseInsight(moonPhase, selectedDate);

      // 消耗钻石
      final consumeResult = await DiamondService.consume(
        diamondCount: 20,
        remark: S.current.moonPhaseRemark,
      );

      // 隐藏loading
      await EasyLoading.dismiss();

      if (consumeResult.isSuccess) {
        // 显示月相能量解读内容
        _showMoonPhaseInsightDialog(moonPhaseResult);
      }
    } catch (e) {
      // 隐藏loading
      await EasyLoading.dismiss();
    }
  }

  /// 解锁每日运势
  Future<void> _unlockDailyHoroscope() async {
    // 显示loading
    await EasyLoading.show(
      status: S.current.analyzingDailyHoroscope,
      maskType: EasyLoadingMaskType.black,
    );
    // 检查钻石余额
    final checkResult = await DiamondService.checkBalance(requiredDiamonds: 30);

    if (!checkResult.isSuccess || !checkResult.data["hasEnough"]) {
      // 钻石不足，跳转到商店
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const DiamondStorePage(),
          ),
        );
      }
      return;
    }

    // 获取用户生日信息
    final myProfile = ref.read(myProfileProvider);
    if (myProfile?.birthday == null) {
      // 没有生日信息，无法获取运势
      return;
    }

    // 调用API获取每日运势
    try {
      final horoscopeResult = await _fetchDailyHoroscope(myProfile!.birthday!);

      // 消耗钻石
      final consumeResult = await DiamondService.consume(
        diamondCount: 30,
        remark: S.current.horoscopeRemark,
      );

      // 隐藏loading
      await EasyLoading.dismiss();

      if (consumeResult.isSuccess) {
        // 显示真实的运势内容
        _showDailyHoroscopeDialog(horoscopeResult);
      }
    } catch (e) {
      // 隐藏loading
      await EasyLoading.dismiss();
    }
  }

  /// 显示月相能量解读对话框
  void _showMoonPhaseInsightDialog(String moonPhaseContent) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(S.current.moonPhaseAnalysisTitle,
            style: const TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Text(
            // 直接显示后端返回的字符串内容
            moonPhaseContent,
            style: const TextStyle(color: Colors.white70, height: 1.6),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.current.buttonConfirm),
          ),
        ],
      ),
    );
  }

  /// 显示每日运势对话框
  void _showDailyHoroscopeDialog(String horoscopeContent) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(S.current.dailyHoroscopeTitle,
            style: const TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Text(
            // 直接显示后端返回的字符串内容
            horoscopeContent,
            style: const TextStyle(color: Colors.white70, height: 1.6),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 获取每日运势API
  Future<String> _fetchDailyHoroscope(DateTime birthday) async {
    // 显示loading
    await EasyLoading.show(
      status: S.current.analyzingDailyHoroscope,
      maskType: EasyLoadingMaskType.black,
    );
    // 根据生日计算星座
    final zodiacSign = _getZodiacSign(birthday);

    // 调用后端API - 返回字符串内容
    final result = await post('/astro/horoscope/daily', data: {
      'zodiacSign': zodiacSign,
      'date': DateTime.now().toIso8601String().split('T')[0],
    });

    if (result.isSuccess) {
      // 后端返回的是字符串内容
      return result.data as String;
    } else {
      throw Exception(S.current.horoscopeFetchFailed);
    }
  }

  /// 获取月相能量解读API
  Future<String> _fetchMoonPhaseInsight(
      MoonPhase moonPhase, DateTime date) async {
    // 将MoonPhase枚举转换为字符串
    final moonPhaseStr = _moonPhaseToString(moonPhase);

    // 调用后端API - 返回字符串内容
    final result = await post('/astro/moon-phase/analyze', data: {
      'moonPhase': moonPhaseStr,
      'date': date.toIso8601String().split('T')[0],
    });

    if (result.isSuccess) {
      // 后端返回的是字符串内容
      return result.data as String;
    } else {
      throw Exception(S.current.moonPhaseFetchFailed);
    }
  }

  /// 将MoonPhase枚举转换为字符串
  String _moonPhaseToString(MoonPhase phase) {
    switch (phase) {
      case MoonPhase.newMoon:
        return 'newMoon';
      case MoonPhase.waxingCrescent:
        return 'waxingCrescent';
      case MoonPhase.firstQuarter:
        return 'firstQuarter';
      case MoonPhase.waxingGibbous:
        return 'waxingGibbous';
      case MoonPhase.fullMoon:
        return 'fullMoon';
      case MoonPhase.waningGibbous:
        return 'waningGibbous';
      case MoonPhase.lastQuarter:
        return 'lastQuarter';
      case MoonPhase.waningCrescent:
        return 'waningCrescent';
    }
  }

  /// 根据生日获取星座
  String _getZodiacSign(DateTime birthday) {
    final month = birthday.month;
    final day = birthday.day;

    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      return 'aquarius'; // 水瓶座
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      return 'pisces'; // 双鱼座
    } else if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      return 'aries'; // 白羊座
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      return 'taurus'; // 金牛座
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      return 'gemini'; // 双子座
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      return 'cancer'; // 巨蟹座
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      return 'leo'; // 狮子座
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      return 'virgo'; // 处女座
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      return 'libra'; // 天秤座
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      return 'scorpio'; // 天蝎座
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      return 'sagittarius'; // 射手座
    } else {
      return 'capricorn'; // 摩羯座
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
