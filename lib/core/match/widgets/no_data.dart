import 'package:flutter/material.dart';
import 'package:sona/generated/l10n.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, required this.onTap});
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 圆形柔光占位图标
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          const Color(0xFF12121B),
                          const Color(0xFF0E0E14),
                        ]
                      : [
                          const Color(0xFFF3F3F6),
                          const Color(0xFFF8F8FA),
                        ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.primaryColor.withOpacity(isDark ? 0.20 : 0.10),
                    blurRadius: 20,
                  ),
                ],
                border: Border.all(
                  color: theme.primaryColor.withOpacity(isDark ? 0.30 : 0.15),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.inbox_rounded,
                color: theme.primaryColor,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).oopsNoDataRightNow,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color:
                    isDark ? const Color(0xFFEDEDF4) : const Color(0xFF2C2C2C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).pleaseCheckYourInternetOrTapToRefreshAndTryAgain,
              style: theme.textTheme.bodySmall?.copyWith(
                color:
                    isDark ? const Color(0xFFB5B6C8) : const Color(0xFF727272),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => onTap.call(),
              child: Text(S.of(context).buttonRefresh),
            ),
          ],
        ),
      ),
    );
  }
}
