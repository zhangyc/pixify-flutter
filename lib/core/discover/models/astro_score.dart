// 星盘合盘分数
import '../enums/astro_badge_type.dart';

class AstroScore {
  final int fate; // 缘分指数 0-100
  final int harmony; // 和谐指数 0-100
  final int risk; // 风险指数 0-100
  final List<String> tags;
  final List<String> prompts;
  final String version;

  AstroScore({
    required this.fate,
    required this.harmony,
    required this.risk,
    this.tags = const [],
    this.prompts = const [],
    this.version = '1.0.0',
  });

  factory AstroScore.fromJson(Map<String, dynamic> json) {
    return AstroScore(
      fate: json['fate'] ?? 0,
      harmony: json['harmony'] ?? 0,
      risk: json['risk'] ?? 0,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      prompts: (json['prompts'] as List<dynamic>?)?.cast<String>() ?? [],
      version: json['version'] ?? '1.0.0',
    );
  }

  // 获取主要徽章类型
  AstroBadgeType get primaryBadgeType {
    if (fate >= 80) return AstroBadgeType.fate;
    if (harmony >= 80) return AstroBadgeType.harmony;
    if (risk >= 60) return AstroBadgeType.risk;
    return AstroBadgeType.fate; // 默认显示缘分
  }

  // 获取主要分数
  int get primaryScore {
    switch (primaryBadgeType) {
      case AstroBadgeType.fate:
        return fate;
      case AstroBadgeType.harmony:
        return harmony;
      case AstroBadgeType.risk:
        return risk;
    }
  }
}