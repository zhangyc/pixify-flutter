import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sona/core/healing/services/healing_database.dart';
import 'package:sona/generated/l10n.dart';

/// Meditation Practice Page
class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  int _duration = 5; // 默认5分钟
  int _remainingSeconds = 0;
  String? _currentAudio;

  late final List<Map<String, dynamic>> _durations;

  @override
  void initState() {
    super.initState();
    _durations = [
      {'label': '5 min', 'value': 5},
      {'label': '10 min', 'value': 10},
      {'label': '15 min', 'value': 15},
      {'label': '20 min', 'value': 20},
    ];
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _startMeditation() async {
    setState(() {
      _isPlaying = true;
      _remainingSeconds = _duration * 60;
    });

    // 播放冥想音频
    if (_currentAudio != null) {
      await _audioPlayer.play(AssetSource(_currentAudio!));
    }

    // 倒计时
    _countDown();
  }

  void _countDown() {
    if (_remainingSeconds > 0 && _isPlaying) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _remainingSeconds--;
          });
          _countDown();
        }
      });
    } else if (_remainingSeconds == 0 && _isPlaying) {
      _stopMeditation();
      _saveMeditationRecord();
    }
  }

  Future<void> _stopMeditation() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _remainingSeconds = 0;
    });
  }

  Future<void> _saveMeditationRecord() async {
    final actualDuration = _duration * 60 - _remainingSeconds;
    await HealingDatabase.instance.insertMeditationRecord({
      'date': DateTime.now().toIso8601String().split('T')[0],
      'title': S.of(context).meditation_practice_title,
      'content': '${S.of(context).x_times(_duration)} ${_duration} min',
      'duration': actualDuration,
      'completed_at': DateTime.now().toIso8601String(),
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).meditation_saved)),
      );
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(S.of(context).meditation_practice_title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // 星空动画区域
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF9B59B6).withOpacity(0.3),
                        const Color(0xFF0F0F14),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isPlaying) ...[
                          Text(
                            _formatTime(_remainingSeconds),
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            S.of(context).breathe_relax,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ] else ...[
                          Icon(
                            Icons.self_improvement,
                            size: 80,
                            color: theme.primaryColor,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            S.of(context).select_duration_start,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 时长选择
              if (!_isPlaying) ...[
                Text(
                  S.of(context).select_meditation_duration,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  children: _durations.map((d) {
                    final isSelected = _duration == d['value'];
                    return ChoiceChip(
                      label: Text(d['label']),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _duration = d['value'];
                          });
                        }
                      },
                      selectedColor: theme.primaryColor,
                      backgroundColor: const Color(0xFF1A1A22),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.white70,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
              ],

              // 开始/停止按钮
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isPlaying ? _stopMeditation : _startMeditation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isPlaying ? Colors.red : const Color(0xFF9B59B6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
                      const SizedBox(width: 8),
                      Text(
                        _isPlaying
                            ? S.of(context).stop_meditation
                            : S.of(context).start_meditation,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
