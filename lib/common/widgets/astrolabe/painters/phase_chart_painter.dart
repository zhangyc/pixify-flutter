import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../models/astrolabe_data.dart';
import '../utils/astrolabe_utils.dart';

class PhaseChartPainter extends CustomPainter {
  final List<Planets> planets;
  final List<Planets>? planets1; // For XYPhaseChartView
  final List<Phase> phases;

  late final Paint planetPaint;
  late final Paint phasePaint;
  late final TextPainter planetTextPainter;

  final Map<String, Offset> planetPointMap = {};
  final Map<String, Offset> planetPointMap1 = {};

  PhaseChartPainter({
    required this.planets,
    this.planets1,
    required this.phases,
  }) {
    planetPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0
      ..isAntiAlias = true;

    phasePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..isAntiAlias = true;

    planetTextPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20; // Margin

    canvas.translate(center.dx, center.dy);

    _calculatePlanetPoints(planets, radius, planetPointMap, 0);
    if (planets1 != null) {
      _calculatePlanetPoints(
        planets1!,
        radius * 0.7,
        planetPointMap1,
        360 / planets1!.length / 2,
      );
    }

    _drawPhases(canvas);
    _drawPlanets(canvas, planets, planetPointMap);
    if (planets1 != null) {
      _drawPlanets(canvas, planets1!, planetPointMap1);
    }

    canvas.translate(-center.dx, -center.dy);
  }

  void _calculatePlanetPoints(
    List<Planets> planetList,
    double r,
    Map<String, Offset> pointMap,
    double angleOffset,
  ) {
    if (planetList.isEmpty) return;
    final angleStep = 360 / planetList.length;
    for (int i = 0; i < planetList.length; i++) {
      final angle = (i * angleStep) + angleOffset;
      final point = AstrolabeUtils.getPointByAngle(angle, r);
      pointMap[planetList[i].planetCn ?? ''] = point;
    }
  }

  void _drawPlanets(
    Canvas canvas,
    List<Planets> planetList,
    Map<String, Offset> pointMap,
  ) {
    for (var planet in planetList) {
      final point = pointMap[planet.planetCn];
      if (point == null) continue;

      planetPaint.color = AstrolabeUtils.getPlanetColorByName(
        planet.planetCn ?? '',
      );
      canvas.drawCircle(point, 5, planetPaint);

      final textStyle = TextStyle(
        color: AstrolabeUtils.getPlanetColorByName(planet.planetCn ?? ''),
        fontSize: 12,
      );

      final textSpan = TextSpan(text: planet.shortPlanetCn, style: textStyle);
      planetTextPainter.text = textSpan;
      planetTextPainter.layout();

      final textOffset = Offset(
        point.dx - planetTextPainter.width / 2,
        point.dy - planetTextPainter.height / 2 - 15,
      );
      planetTextPainter.paint(canvas, textOffset);
    }
  }

  void _drawPhases(Canvas canvas) {
    if (phases.isEmpty) return;

    final bool isTransit = planets1 != null;

    for (var phase in phases) {
      phasePaint.color = AstrolabeUtils.getPhaseColorByName(
        phase.aspectName ?? '',
      );

      final point1 = isTransit
          ? planetPointMap[phase.planetName1]
          : planetPointMap[phase.planetName1];
      final point2 = isTransit
          ? planetPointMap1[phase.planetName2]
          : planetPointMap[phase.planetName2];

      if (point1 != null && point2 != null) {
        canvas.drawLine(point1, point2, phasePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
