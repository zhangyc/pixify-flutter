import 'package:flutter/material.dart';

class NeonWordmark extends StatelessWidget {
  const NeonWordmark({required this.text, this.fontSize = 40});
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 外发光层
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 6
              ..color = const Color(0x8000EED1),
          ),
        ),
        // 渐变填充层
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF00EED1), Color(0xFF7C3AED)],
            ).createShader(bounds);
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
