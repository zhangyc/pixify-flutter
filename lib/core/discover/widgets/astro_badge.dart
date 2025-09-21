import 'package:flutter/material.dart';
import '../enums/astro_badge_type.dart';
import '../models/astro_score.dart';
import '../models/discover_user.dart';

class AstroBadge extends StatelessWidget {
  const AstroBadge({
    super.key,
    required this.score,
    required this.onTap,
  });

  final AstroScore score;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeType = score.primaryBadgeType;
    final primaryScore = score.primaryScore;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _getBadgeColor(badgeType).withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _getBadgeColor(badgeType).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _getBadgeIcon(badgeType),
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              _getBadgeText(badgeType),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '$primaryScore',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBadgeColor(AstroBadgeType type) {
    switch (type) {
      case AstroBadgeType.fate:
        return const Color(0xFFFF6B9D); // 浪漫粉 - 缘分
      case AstroBadgeType.harmony:
        return const Color(0xFF4ADE80); // 成功绿 - 和谐
      case AstroBadgeType.risk:
        return const Color(0xFFF59E0B); // 警告黄 - 风险
    }
  }

  IconData _getBadgeIcon(AstroBadgeType type) {
    switch (type) {
      case AstroBadgeType.fate:
        return Icons.favorite;
      case AstroBadgeType.harmony:
        return Icons.balance;
      case AstroBadgeType.risk:
        return Icons.warning_rounded;
    }
  }

  String _getBadgeText(AstroBadgeType type) {
    switch (type) {
      case AstroBadgeType.fate:
        return '缘分';
      case AstroBadgeType.harmony:
        return '契合';
      case AstroBadgeType.risk:
        return '雷区';
    }
  }
}
