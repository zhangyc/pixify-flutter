/// 情绪记录
class MoodEntry {
  final int id;
  final int userId;
  final MoodType mood;
  final int intensity; // 1-10
  final String? note;
  final List<String> triggers; // 触发因素
  final DateTime timestamp;
  final List<String> activities; // 当天活动

  const MoodEntry({
    required this.id,
    required this.userId,
    required this.mood,
    required this.intensity,
    this.note,
    this.triggers = const [],
    required this.timestamp,
    this.activities = const [],
  });
}

/// 情绪类型
enum MoodType {
  veryHappy, // 非常开心
  happy, // 开心
  content, // 满足
  neutral, // 平静
  anxious, // 焦虑
  sad, // 难过
  angry, // 生气
  stressed, // 压力大
  tired, // 疲惫
  excited, // 兴奋
}

/// 情绪分析结果
class MoodAnalysis {
  final MoodType dominantMood;
  final double averageIntensity;
  final List<String> patterns; // 情绪模式
  final List<String> insights; // 洞察
  final List<String> recommendations; // 建议

  const MoodAnalysis({
    required this.dominantMood,
    required this.averageIntensity,
    required this.patterns,
    required this.insights,
    required this.recommendations,
  });
}
