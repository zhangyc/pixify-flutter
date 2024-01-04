import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/chat/models/message.dart';

class MessageTime extends ConsumerWidget {
  const MessageTime({super.key, required this.time});
  final DateTime time;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              time.toMessageTime(ref.read(localeProvider).toLanguageTag()),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Color(0xFFB7B7B7),
                fontWeight: FontWeight.w400,
                fontSize: 14
              )
            ),
          ),
        ],
      )
    );
  }
}