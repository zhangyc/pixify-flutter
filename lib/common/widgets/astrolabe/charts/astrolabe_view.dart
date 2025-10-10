import 'package:flutter/material.dart';
import '../models/astrolabe_data.dart';
import '../painters/astrolabe_painter.dart';

/// 基础盘/本命盘 Widget，完全对应 AstrobaleView.java
class AstrolabeView extends StatelessWidget {
  final List<Houses> houses;
  final List<Planets> planets;
  final List<Phase> phases;
  final Size size;
  final bool isSmall;
  final String style;
  final Map<String, Color> colors;

  const AstrolabeView({
    super.key,
    required this.houses,
    required this.planets,
    required this.phases,
    this.size = const Size(300, 300),
    this.isSmall = false,
    this.style = 'text',
    this.colors = const {
      'circle1': Color(0xFF121C4E),
      'circle2': Color(0xFF314876),
      'circle3': Color(0xFF141D54),
      'circle4': Color(0xFF1A2E5F),
      'starScale': Color(0xFF1B809E),
      'houseLine': Color(0xFF84BE6B),
      'innerHouseLine': Color(0xFF283C80),
    },
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: AstrolabePainter(
        houses: houses,
        planets: planets,
        phases: phases,
        isSmall: isSmall,
        style: style,
        colors: colors,
      ),
    );
  }
}
