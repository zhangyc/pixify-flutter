// lib/core/match/widgets/components/match_user_info.dart
import 'package:flutter/material.dart';

import 'package:sona/core/match/bean/match_user.dart';

class MatchUserInfoCard extends StatelessWidget {
  final MatchUserInfo user;

  const MatchUserInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x0012121B), Color(0xCC0E0E14)],
        ),
        border: Border(top: BorderSide(color: Color(0x3300EED1), width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${user.name}, ${user.age}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    color: const Color(0xFFEDEDF4),
                    letterSpacing: 0.3,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              if (user.distance != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: theme.primaryColor.withOpacity(0.38),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${user.distance!.toStringAsFixed(1)}km',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          if (user.bio != null) ...[
            const SizedBox(height: 6),
            Text(
              user.bio!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFB5B6C8),
                fontSize: 14,
                height: 1.35,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
