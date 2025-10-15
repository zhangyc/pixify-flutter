import 'package:flutter/material.dart';
import 'package:sona/core/healing/services/healing_database.dart';
import 'package:sona/generated/l10n.dart';

/// 情绪管理/日记页面
class EmotionDiaryPage extends StatefulWidget {
  const EmotionDiaryPage({super.key});

  @override
  State<EmotionDiaryPage> createState() => _EmotionDiaryPageState();
}

class _EmotionDiaryPageState extends State<EmotionDiaryPage> {
  final TextEditingController _contentController = TextEditingController();
  String _selectedEmotion = '😌 ${S.current.emotion_calm}';
  late final List<String> _emotions;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _emotions = [
      '😊 ${S.current.emotion_happy}',
      '😢 ${S.current.emotion_sad}',
      '😠 ${S.current.emotion_angry}',
      '😰 ${S.current.emotion_anxious}',
      '😌 ${S.current.emotion_calm}',
      '😴 ${S.current.emotion_tired}'
    ];
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveDiary() async {
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).please_write_feelings)),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      await HealingDatabase.instance.insertEmotionDiary({
        'date': DateTime.now().toIso8601String().split('T')[0],
        'emotion_type': _selectedEmotion,
        'content': _contentController.text.trim(),
        'intensity': 5,
        'created_at': DateTime.now().toIso8601String(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.of(context).emotion_diary_saved),
            backgroundColor: Color(0xFFE74C3C),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint('保存情绪日记失败: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).save_failed(""))),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(S.of(context).emotion_diary),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          _isSaving
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : TextButton(
                  onPressed: _saveDiary,
                  child: Text(S.of(context).save,
                      style: const TextStyle(fontSize: 16)),
                ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 日期
              Text(
                DateTime.now().toString().split(' ')[0],
                style: TextStyle(
                  fontSize: 14,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 24),

              // 情绪选择
              Text(
                S.of(context).current_emotion,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _emotions.map((emotion) {
                  final isSelected = _selectedEmotion == emotion;
                  return ChoiceChip(
                    label: Text(emotion),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedEmotion = emotion;
                        });
                      }
                    },
                    selectedColor: const Color(0xFFE74C3C),
                    backgroundColor: const Color(0xFF1A1A22),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 32),

              // 内容输入
              Text(
                S.of(context).record_your_feelings,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A22),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE74C3C).withOpacity(0.3),
                  ),
                ),
                child: TextField(
                  controller: _contentController,
                  maxLines: 12,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.6,
                  ),
                  decoration: InputDecoration(
                    hintText:
                        '${S.of(context).write_feelings_hint}\n\n${S.of(context).every_emotion_matters}',
                    hintStyle: TextStyle(
                      color: Colors.white38,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 提示文字
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE74C3C).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Color(0xFFE74C3C),
                      size: 20,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        S.of(context).emotion_tip,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
