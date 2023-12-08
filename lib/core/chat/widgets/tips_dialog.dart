import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/providers/tips.dart';

import '../../../utils/global/global.dart';
import '../models/message.dart';
import '../services/chat.dart';

class SonaTipsDialog extends ConsumerWidget {
  const SonaTipsDialog({
    super.key,
    required this.userId
  });
  final int userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(asyncSonaTipsProvider(userId)).when(
        data: (data) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (data.tips != null) Container(
              margin: EdgeInsets.only(bottom: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                data.tips!,
                style: Theme.of(context).textTheme.bodyMedium
              ),
            ),
            ...data.options.map((opt) => Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.pop(context);
                  callSona(
                      userId: userId,
                      type: CallSonaType.SUGGEST_FUNC,
                      input: opt
                  );
                  SonaAnalytics.log('chat_sendsuggest');
                },
                child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: Color(0xFF2C2C2C)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0xFF2C2C2C),
                          blurRadius: 0,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Text(opt)
                )
              ),
            ))
          ],
        ),
        error: (_, __) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => ref.refresh(asyncSonaTipsProvider(userId).notifier),
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: const Text(
                'Cannot connect to server, tap to retry',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.none
                )
            ),
          ),
        ),
        loading: () => Container(
          alignment: Alignment.center,
          child: const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator()),
        )
    );
  }
}