import 'package:flutter/material.dart';

class MatchInitAnimation extends StatelessWidget {
  const MatchInitAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF0E0E14), Color(0xFF12121B)]
              : const [Color(0xFFF6F7FB), Color(0xFFFFFFFF)],
        ),
      ),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? const Color(0xFF12121B) : Colors.white,
          border: Border.all(
            color: theme.primaryColor.withOpacity(isDark ? 0.35 : 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withOpacity(isDark ? 0.25 : 0.15),
              blurRadius: 24,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
          ),
        ),
      ),
    );
  }
}
