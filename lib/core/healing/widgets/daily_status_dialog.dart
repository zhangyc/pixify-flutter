import 'package:flutter/material.dart';
import 'package:sona/core/healing/services/healing_database.dart';
import 'package:sona/generated/l10n.dart';

class DailyStatusDialog extends StatefulWidget {
  const DailyStatusDialog({super.key});

  @override
  State<DailyStatusDialog> createState() => _DailyStatusDialogState();
}

class _DailyStatusDialogState extends State<DailyStatusDialog> {
  double _moodScore = 5;
  double _energyLevel = 5;
  double _stressLevel = 5;
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A22), Color(0xFF12121B)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).record_daily_status,
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white54),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // 心情评分
            _buildSlider(
              label: S.of(context).mood_index,
              value: _moodScore,
              icon: Icons.mood,
              color: const Color(0xFFFFC107),
              onChanged: (val) => setState(() => _moodScore = val),
            ),

            const SizedBox(height: 20),

            // 能量水平
            _buildSlider(
              label: S.of(context).energy_level,
              value: _energyLevel,
              icon: Icons.bolt,
              color: const Color(0xFF4CAF50),
              onChanged: (val) => setState(() => _energyLevel = val),
            ),

            const SizedBox(height: 20),

            // 压力水平
            _buildSlider(
              label: S.of(context).stress_level,
              value: _stressLevel,
              icon: Icons.trending_up,
              color: const Color(0xFFF44336),
              onChanged: (val) => setState(() => _stressLevel = val),
            ),

            const SizedBox(height: 20),

            // 笔记
            TextField(
              controller: _noteController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: S.of(context).record_today_hint,
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: theme.primaryColor.withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: theme.primaryColor.withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.primaryColor),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 保存按钮
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveStatus,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  S.of(context).save,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required IconData icon,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              '${value.toInt()}/10',
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            inactiveTrackColor: color.withOpacity(0.3),
            thumbColor: color,
            overlayColor: color.withOpacity(0.2),
          ),
          child: Slider(
            value: value,
            min: 1,
            max: 10,
            divisions: 9,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Future<void> _saveStatus() async {
    final now = DateTime.now();
    final date =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final status = {
      'date': date,
      'mood_score': _moodScore.toInt(),
      'energy_level': _energyLevel.toInt(),
      'stress_level': _stressLevel.toInt(),
      'note': _noteController.text,
      'created_at': now.toIso8601String(),
    };

    try {
      await HealingDatabase.instance.insertDailyStatus(status);
      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).status_saved),
            backgroundColor: Theme.of(context).primaryColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).save_failed('请重试')),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
