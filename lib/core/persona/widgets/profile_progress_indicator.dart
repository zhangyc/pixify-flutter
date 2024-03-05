import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/persona/providers/profile_progress.dart';

class ProfileProgressIndicator extends ConsumerWidget {
  const ProfileProgressIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 24,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: ref.watch(profileProgressProvider),
              color: Theme.of(context).primaryColor,
              backgroundColor: Color(0xFFE8E6E6),
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: 12),
          Text(
              '${(ref.watch(profileProgressProvider) * 100).toInt()}%',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800
            )
          )
        ],
      ),
    );
  }
}