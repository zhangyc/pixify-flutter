import 'package:flutter/material.dart';
import 'package:rive/rive.dart' hide LinearGradient;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sona/core/healing/services/healing_database.dart';
import 'package:sona/core/healing/widgets/daily_status_dialog.dart';
import 'package:sona/core/healing/widgets/meditation_page.dart';
import 'package:sona/core/healing/widgets/emotion_diary_page.dart';
import 'package:sona/core/healing/widgets/daily_quotes_page.dart';
import 'package:sona/core/healing/widgets/healing_music_page.dart';
import 'package:sona/generated/l10n.dart';

/// 心理疗愈页面
class HealingScreen extends StatefulWidget {
  const HealingScreen({super.key});

  @override
  State<HealingScreen> createState() => _HealingScreenState();
}

class _HealingScreenState extends State<HealingScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _flutterTts = FlutterTts();
  bool _isMusicPlaying = true;
  bool _isSpeaking = false;
  String _todayQuote = S.current.loading;
  bool _isLoadingQuote = true;

  // Rive 动画控制器
  StateMachineController? _riveController;
  SMIBool? _isTalkingInput;
  SMINumber? _visemeIdInput;

  @override
  void initState() {
    super.initState();
    _initBackgroundMusic();
    _initTts();
    _loadTodayQuote();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _flutterTts.stop();
    _riveController?.dispose();
    super.dispose();
  }

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine', // 你的状态机名称
    );

    if (controller != null) {
      artboard.addController(controller);
      _riveController = controller;

      // 获取输入
      _isTalkingInput = controller.findInput<bool>('isTalking') as SMIBool?;
      _visemeIdInput = controller.findInput<double>('VisemeID') as SMINumber?;
    }
  }

  void _triggerRiveAnimation() {
    // 让角色开始说话
    _isTalkingInput?.value = true;

    // 1秒后停止说话
    Future.delayed(const Duration(seconds: 1), () {
      _isTalkingInput?.value = false;
    });
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("zh-CN");
    await _flutterTts.setSpeechRate(0.5); // 语速：0.5慢，1.0正常
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
        _riveController?.findInput<bool>('isTalking')?.value = false;
      });
    });
  }

  Future<void> _toggleSpeech() async {
    if (_isSpeaking) {
      await _flutterTts.stop();
      setState(() {
        _isSpeaking = false;
        _riveController?.findInput<bool>('isTalking')?.value = false;
      });
    } else {
      setState(() {
        _isSpeaking = true;
        _riveController?.findInput<bool>('isTalking')?.value = true;
      });
      await _flutterTts.speak(_todayQuote);
    }
  }

  Future<void> _initBackgroundMusic() async {
    // TODO: 添加实际的背景音乐文件
    await _audioPlayer.setSource(AssetSource('mp3/music1.mp3'));
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.resume();
  }

  Future<void> _toggleMusic() async {
    setState(() {
      _isMusicPlaying = !_isMusicPlaying;
    });

    if (_isMusicPlaying) {
      await _audioPlayer.resume();
    } else {
      await _audioPlayer.pause();
    }
  }

  Future<void> _loadTodayQuote() async {
    try {
      final quote = await HealingDatabase.instance.getTodayQuote();
      if (quote != null) {
        setState(() {
          _todayQuote = quote['content'] as String;
          _isLoadingQuote = false;
        });
        // 标记为已读
        await HealingDatabase.instance.markQuoteAsRead(quote['id'] as int);
      }
    } catch (e) {
      setState(() {
        _todayQuote = S.current.quote_1;
        _isLoadingQuote = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 顶部标题 + 音乐控制
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).psychological_healing,
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // 音乐控制按钮
                  Container(
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: theme.primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isMusicPlaying ? Icons.music_note : Icons.music_off,
                        color: theme.primaryColor,
                      ),
                      onPressed: _toggleMusic,
                      tooltip: S.of(context).toggle_background_music,
                    ),
                  ),
                ],
              ),
            ),

            // Rive动画区域
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  // 触发 Rive 动画
                  _triggerRiveAnimation();

                  // 点击Rive角色显示鼓励语
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).great_keep_going),
                      backgroundColor: theme.primaryColor,
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  _flutterTts.speak(S.of(context).great_keep_going);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        theme.primaryColor.withOpacity(0.1),
                        theme.primaryColor.withOpacity(0.05),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      RiveAnimation.asset(
                        'assets/rive/girl.riv',
                        fit: BoxFit.contain,
                        onInit: _onRiveInit,
                      ),
                      // 点击提示
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              S.of(context).click_for_encouragement,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 每日心语（可点击记录状态）
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InkWell(
                onTap: () async {
                  await showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) => const DailyStatusDialog(),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.primaryColor.withOpacity(0.15),
                        theme.primaryColor.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: theme.primaryColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 40), // 占位，保持居中
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  color: theme.primaryColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  S.of(context).daily_quote,
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.edit,
                                  color: theme.primaryColor.withOpacity(0.6),
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                          // TTS按钮
                          IconButton(
                            onPressed: _toggleSpeech,
                            icon: Icon(
                              _isSpeaking ? Icons.stop_circle : Icons.volume_up,
                              color:
                                  _isSpeaking ? Colors.red : theme.primaryColor,
                              size: 24,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _isLoadingQuote
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              _todayQuote,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                                height: 1.6,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      const SizedBox(height: 8),
                      Text(
                        S.current.record_daily_status,
                        style: TextStyle(
                          color: theme.primaryColor.withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // 功能卡片区域
            Expanded(
              flex: 2,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildHealingCard(
                    theme,
                    icon: Icons.self_improvement,
                    title: S.of(context).meditation_practice_title,
                    subtitle: S.of(context).meditation_subtitle,
                    color: const Color(0xFF9B59B6),
                  ),
                  const SizedBox(height: 12),
                  _buildHealingCard(
                    theme,
                    icon: Icons.favorite,
                    title: S.of(context).emotion_management_title,
                    subtitle: S.of(context).emotion_subtitle,
                    color: const Color(0xFFE74C3C),
                  ),
                  const SizedBox(height: 12),
                  _buildHealingCard(
                    theme,
                    icon: Icons.auto_awesome,
                    title: S.of(context).daily_quotes_title,
                    subtitle: S.of(context).quotes_subtitle,
                    color: const Color(0xFFF39C12),
                  ),
                  const SizedBox(height: 12),
                  _buildHealingCard(
                    theme,
                    icon: Icons.music_note,
                    title: S.of(context).healing_music_title,
                    subtitle: S.of(context).music_subtitle,
                    color: const Color(0xFF3498DB),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealingCard(
    ThemeData theme, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        _navigateToFeature(title);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A22),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color.withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToFeature(String title) {
    Widget? page;

    if (title == S.of(context).meditation_practice_title) {
      page = const MeditationPage();
    } else if (title == S.of(context).emotion_management_title) {
      page = const EmotionDiaryPage();
    } else if (title == S.of(context).daily_quotes_title) {
      page = const DailyQuotesPage();
    } else if (title == S.of(context).healing_music_title) {
      page = const HealingMusicPage();
    }

    if (page != null) {
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(builder: (context) => page!),
      );
    }
  }
}
