import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../models/astrolabe_data.dart';
import '../utils/astrolabe_utils.dart';

/// 纯相位图 Widget，完全对应 PhaseChartView.java
class PhaseChartView extends StatelessWidget {
  final List<Planets> planets;
  final List<Phase> phases;
  final Size size;
  final bool isSmall;
  final String style;

  const PhaseChartView({
    super.key,
    required this.planets,
    required this.phases,
    this.size = const Size(300, 300),
    this.isSmall = false,
    this.style = 'text',
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: _PhaseChartPainter(
        planets: planets,
        phases: phases,
        isSmall: isSmall,
        style: style,
      ),
    );
  }
}

/// PhaseChartView 的私有 Painter
class _PhaseChartPainter extends CustomPainter {
  final List<Planets> planets;
  final List<Phase> phases;
  final bool isSmall;
  final String style;

  late final Paint _planetPaint;
  late final Paint _phasePaint;
  late final Paint _linePaint;
  late final TextPainter _planetTextPainter;
  late double _radius;
  late double _planetTextSize;

  final Map<String, Offset> _planetPointMap = {};

  _PhaseChartPainter({
    required this.planets,
    required this.phases,
    required this.isSmall,
    required this.style,
  }) {
    _planetPaint = Paint()..isAntiAlias = true;
    _phasePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    _linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    _planetTextPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    _radius = size.width / 2;
    _planetTextSize = isSmall ? 7.0 : 10.0;

    canvas.translate(_radius, _radius);
    _calculateAndDrawPlanets(canvas);
    _drawPhases(canvas);
  }

  void _calculateAndDrawPlanets(Canvas canvas) {
    if (planets.isEmpty) return;

    _planetPointMap.clear();
    final double pointRadius = _radius * 0.8;

    // Distribute planets evenly on the circle
    final double angleStep = 360.0 / planets.length;
    for (int i = 0; i < planets.length; i++) {
      final planet = planets[i];
      final angle = i * angleStep;
      final point = AstrolabeUtils.getPointByAngle(angle, pointRadius);
      _planetPointMap[planet.planetCn ?? ''] = point;

      final planetColor = AstrolabeUtils.getPlanetColorByName(
        planet.planetCn ?? '',
      );
      canvas.drawCircle(point, 1.5, _planetPaint..color = planetColor);

      _drawText(
        canvas,
        _planetTextPainter,
        AstrolabeUtils.changeStr(planet.planetCn ?? ''),
        _planetTextSize,
        planetColor,
        AstrolabeUtils.getPointByAngle(angle, pointRadius + 20),
      );
    }
  }

  void _drawPhases(Canvas canvas) {
    for (final phase in phases) {
      final p1 = _planetPointMap[phase.planetName1];
      final p2 = _planetPointMap[phase.planetName2];

      if (p1 != null && p2 != null) {
        _phasePaint.color = AstrolabeUtils.getPhaseColorByName(
          phase.aspectName ?? '',
        );
        canvas.drawLine(p1, p2, _phasePaint);
      }
    }
  }

  void _drawText(
    Canvas canvas,
    TextPainter painter,
    String text,
    double size,
    Color color,
    Offset center,
  ) {
    painter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: size, color: color),
    );
    painter.layout();
    painter.paint(
      canvas,
      center - Offset(painter.width / 2, painter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _PhaseChartPainter oldDelegate) {
    return planets != oldDelegate.planets || phases != oldDelegate.phases;
  }
}
