import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sona/core/healing/services/healing_database.dart';
import 'package:sona/generated/l10n.dart';

/// 疗愈音乐页面
class HealingMusicPage extends StatefulWidget {
  const HealingMusicPage({super.key});

  @override
  State<HealingMusicPage> createState() => _HealingMusicPageState();
}

class _HealingMusicPageState extends State<HealingMusicPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Map<String, dynamic>> _audios = [];
  bool _isLoading = true;
  int? _playingIndex;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _loadAudios();
    _setupAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
        _playingIndex = null;
      });
    });
  }

  Future<void> _loadAudios() async {
    final audios = await HealingDatabase.instance.getHealingAudios();
    setState(() {
      _audios = audios;
      _isLoading = false;
    });
  }

  Future<void> _playAudio(int index) async {
    final audio = _audios[index];

    if (_playingIndex == index && _isPlaying) {
      // 暂停当前音频
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      // 播放音频
      if (_playingIndex != index) {
        await _audioPlayer.stop();
      }

      // 这里使用assets中的音频，实际应该根据audio['file_path']加载
      await _audioPlayer.play(AssetSource('mp3/music1.mp3'));

      // 增加播放次数
      await HealingDatabase.instance.incrementAudioPlayCount(audio['id']);

      setState(() {
        _playingIndex = index;
        _isPlaying = true;
      });
    }
  }

  Color _getCategoryColor(String? category) {
    if (category == '冥想' || category == 'Meditation') {
      return const Color(0xFF9B59B6);
    } else if (category == '放松' || category == 'Relaxation') {
      return const Color(0xFF3498DB);
    } else if (category == '睡眠' || category == 'Sleep') {
      return const Color(0xFF2ECC71);
    } else if (category == '能量' || category == 'Energy') {
      return const Color(0xFFE74C3C);
    } else {
      return const Color(0xFFF39C12);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(S.of(context).healing_music_title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _audios.isEmpty
              ? Center(
                  child: Text(
                    S.of(context).no_audio,
                    style: TextStyle(color: Colors.white54),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _audios.length,
                  itemBuilder: (context, index) {
                    final audio = _audios[index];
                    final isPlaying = _playingIndex == index && _isPlaying;
                    final color = _getCategoryColor(audio['category']);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.15),
                            color.withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: color.withOpacity(0.3),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: color,
                            size: 28,
                          ),
                        ),
                        title: Text(
                          audio['title'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              audio['description'] ?? '',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: color.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    audio['category'] ??
                                        S.of(context).healing_music_title,
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${audio['duration'] ?? 0} 分钟',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.headphones,
                                  size: 14,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${audio['play_count'] ?? 0}',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onTap: () => _playAudio(index),
                      ),
                    );
                  },
                ),
    );
  }
}
