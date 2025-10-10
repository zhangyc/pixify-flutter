import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../models/astrolabe_data.dart';
import '../utils/astrolabe_utils.dart';

/// 行运纯相位图 Widget，完全对应 XYPhaseChartView.java
class XYPhaseChartView extends StatelessWidget {
  final List<Planets> planetsInner;
  final List<Planets> planetsOuter;
  final List<Phase> phases;
  final Size size;
  final bool isSmall;
  final String style;

  const XYPhaseChartView({
    super.key,
    required this.planetsInner,
    required this.planetsOuter,
    required this.phases,
    this.size = const Size(300, 300),
    this.isSmall = false,
    this.style = 'text',
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: _XYPhaseChartPainter(
        planetsInner: planetsInner,
        planetsOuter: planetsOuter,
        phases: phases,
        isSmall: isSmall,
        style: style,
      ),
    );
  }
}

/// XYPhaseChartView 的私有 Painter
class _XYPhaseChartPainter extends CustomPainter {
  final List<Planets> planetsInner;
  final List<Planets> planetsOuter;
  final List<Phase> phases;
  final bool isSmall;
  final String style;

  late final Paint _planetPaint, _phasePaint;
  late final TextPainter _planetTextPainter;
  late double _radius;
  late double _planetTextSize;

  final Map<String, Offset> _planetPointMap = {};
  final Map<String, Offset> _planetPointMap1 = {};

  _XYPhaseChartPainter({
    required this.planetsInner,
    required this.planetsOuter,
    required this.phases,
    required this.isSmall,
    required this.style,
  }) {
    _planetPaint = Paint()..isAntiAlias = true;
    _phasePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
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
    _planetPointMap.clear();
    _planetPointMap1.clear();

    // Draw inner ring (planets)
    _drawPlanetRing(canvas, planetsInner, _radius * 0.8, _planetPointMap);
    // Draw outer ring (planets1)
    _drawPlanetRing(canvas, planetsOuter, _radius * 0.5, _planetPointMap1);
  }

  void _drawPlanetRing(
    Canvas canvas,
    List<Planets> planetList,
    double radius,
    Map<String, Offset> pointMap,
  ) {
    if (planetList.isEmpty) return;

    final double angleStep = 360.0 / planetList.length;
    for (int i = 0; i < planetList.length; i++) {
      final planet = planetList[i];
      final angle = i * angleStep;
      final point = AstrolabeUtils.getPointByAngle(angle, radius);
      pointMap[planet.planetCn ?? ''] = point;

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
        AstrolabeUtils.getPointByAngle(angle, radius + 20),
      );
    }
  }

  void _drawPhases(Canvas canvas) {
    for (final phase in phases) {
      final p1 = _planetPointMap[phase.planetName1];
      final p2 = _planetPointMap1[phase.planetName2];

      final p1_rev = _planetPointMap[phase.planetName2];
      final p2_rev = _planetPointMap1[phase.planetName1];

      if (p1 != null && p2 != null) {
        _phasePaint.color = AstrolabeUtils.getPhaseColorByName(
          phase.aspectName ?? '',
        );
        canvas.drawLine(p1, p2, _phasePaint);
      } else if (p1_rev != null && p2_rev != null) {
        _phasePaint.color = AstrolabeUtils.getPhaseColorByName(
          phase.aspectName ?? '',
        );
        canvas.drawLine(p1_rev, p2_rev, _phasePaint);
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
  bool shouldRepaint(covariant _XYPhaseChartPainter oldDelegate) {
    return planetsInner != oldDelegate.planetsInner ||
        planetsOuter != oldDelegate.planetsOuter ||
        phases != oldDelegate.phases;
  }
}
