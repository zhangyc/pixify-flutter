import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientColoredText extends StatelessWidget {
  const GradientColoredText({
    super.key,
    required this.text,
    required this.style
  });
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(context).primaryColor,
          Colors.white
        ]
      ).createShader(rect),
      blendMode: BlendMode.srcATop,
      child: Text(text, style: GoogleFonts.inder(
        textStyle: style
      )),
    );
  }
}