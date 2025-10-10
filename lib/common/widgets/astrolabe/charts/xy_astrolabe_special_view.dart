import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../models/astrolabe_data.dart';
import '../utils/astrolabe_utils.dart';

/// 专业版行运盘 Widget，完全对应 XYAstrobaleSpecialView.java
class XYAstrolabeSpecialView extends StatelessWidget {
  final List<Houses> houses;
  final List<Planets> planetsInner; // 内圈行星
  final List<Planets> planetsOuter; // 外圈行星
  final List<Phase> phases;
  final Size size;
  final bool isSmall;
  final String style;
  final Map<String, Color> colors;

  const XYAstrolabeSpecialView({
    super.key,
    required this.houses,
    required this.planetsInner,
    required this.planetsOuter,
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
      painter: _XYAstrolabeSpecialPainter(
        houses: houses,
        planetsInner: planetsInner,
        planetsOuter: planetsOuter,
        phases: phases,
        isSmall: isSmall,
        style: style,
        colors: colors,
      ),
    );
  }
}

/// XYAstrolabeSpecialView 的私有 Painter
class _XYAstrolabeSpecialPainter extends CustomPainter {
  final List<Houses> houses;
  final List<Planets> planetsInner;
  final List<Planets> planetsOuter;
  final List<Phase> phases;
  final bool isSmall;
  final String style;
  final Map<String, Color> colors;

  // Paints
  late final Paint _circlePaint,
      _starScaleLinePaint,
      _scaleLinePaint,
      _housesScaleLinePaint,
      _planetPaint,
      _phasePaint,
      _linePaint;
  late final TextPainter _starTextPainter,
      _houseTextPainter,
      _planetTextPainter;

  // Dimensions
  late double _radius;
  late double _ringWidth1, _ringWidth2, _ringWidth3;
  late double _starTextSize, _houseTextSize, _planetTextSize;

  // Calculated values
  final List<StarInfoBean> _starInfoList = [];
  final Map<String, double> _starAngleMap = {};
  final Map<String, Offset> _planetPointMap = {};
  final Map<String, Offset> _planetPointMap1 = {};

  _XYAstrolabeSpecialPainter({
    required this.houses,
    required this.planetsInner,
    required this.planetsOuter,
    required this.phases,
    required this.isSmall,
    required this.style,
    required this.colors,
  }) {
    // ... (Same as _XYAstrolabePainter)
    _circlePaint = Paint()..isAntiAlias = true;
    _starScaleLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    _scaleLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.2;
    _housesScaleLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    _planetPaint = Paint()..isAntiAlias = true;
    _phasePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    _linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    _starTextPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );
    _houseTextPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );
    _planetTextPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    _initDimensions(size);

    canvas.translate(size.width / 2, size.height / 2);
    _calculateAllPoints();

    _drawCircles(canvas);
    _drawScaleLines(canvas);
    _drawStarTexts(canvas);
    _drawHouses(canvas);
    _drawPlanets(canvas);
    _drawPhases(canvas);
  }

  void _initDimensions(Size size) {
    // ... (Same as _XYAstrolabePainter)
    _radius = size.width / 2 - 2;
    if (isSmall) {
      _ringWidth1 = 15.0;
      _ringWidth2 = 6.0;
      _ringWidth3 = 11.0;
      _starTextSize = 8.0;
      _houseTextSize = 5.0;
      _planetTextSize = 7.0;
    } else {
      _ringWidth1 = 25.0;
      _ringWidth2 = 11.0;
      _ringWidth3 = 19.0;
      _starTextSize = 12.0;
      _houseTextSize = 8.0;
      _planetTextSize = 10.0;
    }
  }

  void _calculateAllPoints() {
    if (houses.isEmpty) return;
    _calculateStarAngles();
    _calculateStarTextPoints();
    _calculateHousesPoints();
    _calculatePlanetPoints();
  }

  void _calculateStarAngles() {
    // ... (Same as _XYAstrolabePainter)
    _starInfoList.clear();
    _starAngleMap.clear();

    final firstHouse = houses.first;
    double firstStarAngle =
        180 -
        AstrolabeUtils.getAngle(
          int.parse(firstHouse.deg ?? '0'),
          int.parse(firstHouse.min ?? '0'),
          int.parse(firstHouse.sec ?? '0'),
        );

    int firstStarIndex = AstrolabeUtils.starText.indexOf(
      firstHouse.constellationCn ?? '',
    );
    if (firstStarIndex == -1) firstStarIndex = 0;

    for (int i = 0; i < 12; i++) {
      final currentStarIndex = (firstStarIndex + i) % 12;
      final starName = AstrolabeUtils.starText[currentStarIndex];
      final angle = firstStarAngle + i * 30;
      _starAngleMap[starName] = angle;
      _starInfoList.add(
        StarInfoBean(
          starName: starName,
          starAngle: angle,
          statTextAngle: angle + 15,
        ),
      );
    }
  }

  void _calculateStarTextPoints() {
    // ... (Same as _XYAstrolabePainter)
    final starTextRadius = _radius - (_ringWidth1 / 2);
    for (var starInfo in _starInfoList) {
      starInfo.starTextPoint = AstrolabeUtils.getPointByAngle(
        starInfo.statTextAngle,
        starTextRadius,
      );
    }
  }

  void _calculateHousesPoints() {
    // ... (Same as _XYAstrolabePainter)
    final housesScaleLineRadius = _radius - (_ringWidth1 + _ringWidth2);
    final houseTextRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 / 2);

    for (int i = 0; i < houses.length; i++) {
      final house = houses[i];
      house.houseInitAngle =
          (_starAngleMap[house.constellationCn] ?? 0) +
          AstrolabeUtils.getAngle(
            int.parse(house.deg ?? '0'),
            int.parse(house.min ?? '0'),
            int.parse(house.sec ?? '0'),
          );

      if (i == 0 || i == 3 || i == 6 || i == 9) {
        house.houseStartPoint = AstrolabeUtils.getPointByAngle(
          house.houseInitAngle!,
          _radius,
        );
      } else {
        house.houseStartPoint = AstrolabeUtils.getPointByAngle(
          house.houseInitAngle!,
          housesScaleLineRadius,
        );
      }

      double nextHouseAngle;
      if (i == houses.length - 1) {
        nextHouseAngle = houses.first.houseInitAngle!;
      } else {
        nextHouseAngle = houses[i + 1].houseInitAngle!;
      }

      if (nextHouseAngle < house.houseInitAngle!) {
        nextHouseAngle += 360;
      }
      house.houseTextInitAngle =
          house.houseInitAngle! + (nextHouseAngle - house.houseInitAngle!) / 2;
      house.houseTextPoint = AstrolabeUtils.getPointByAngle(
        house.houseTextInitAngle!,
        houseTextRadius,
      );
    }
  }

  void _calculatePlanetPoints() {
    // ... (Same as _XYAstrolabePainter)
    _planetPointMap.clear();
    _planetPointMap1.clear();

    _calculateSpecificPlanetSet(planetsInner, false);
    _calculateSpecificPlanetSet(planetsOuter, true);
  }

  void _calculateSpecificPlanetSet(List<Planets> planetList, bool isOuterRing) {
    // ... (Same as _XYAstrolabePainter)
    final double radiusModifier = isOuterRing ? 70 : 50;
    final planetRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + radiusModifier);
    final planetTextRadius = planetRadius - 20;
    final planetTextLineEndRadius = planetRadius - 8;
    final planetTextLineStartRadius = planetRadius + 2;

    final pointMap = isOuterRing ? _planetPointMap1 : _planetPointMap;

    for (var planet in planetList) {
      planet.planetAngle =
          (_starAngleMap[planet.constellationCn] ?? 0) +
          AstrolabeUtils.getAngle(
            int.parse(planet.deg ?? '0'),
            int.parse(planet.min ?? '0'),
            int.parse(planet.sec ?? '0'),
          );
      planet.planetTextAngle = planet.planetAngle;
      planet.planetPoint = AstrolabeUtils.getPointByAngle(
        planet.planetAngle!,
        planetRadius,
      );
      pointMap[planet.planetCn ?? ''] = planet.planetPoint!;
    }

    planetList.sort((a, b) => a.planetTextAngle!.compareTo(b.planetTextAngle!));
    _adjustPlanetTextAngle(planetList);

    for (var planet in planetList) {
      planet.planetTextPoint = AstrolabeUtils.getPointByAngle(
        planet.planetTextAngle!,
        planetTextRadius,
      );
      planet.planetTextLineEndPoint = AstrolabeUtils.getPointByAngle(
        planet.planetTextAngle!,
        planetTextLineEndRadius,
      );
      planet.planetTextLineStartPoint = AstrolabeUtils.getPointByAngle(
        planet.planetAngle!,
        planetTextLineStartRadius,
      );
    }
  }

  void _adjustPlanetTextAngle(List<Planets> planetList) {
    // ... (Same as _XYAstrolabePainter)
    bool needsAdjustment;
    do {
      needsAdjustment = false;
      for (int i = 0; i < planetList.length - 1; i++) {
        for (int j = i + 1; j < planetList.length; j++) {
          double angleDiff =
              (planetList[i].planetTextAngle! - planetList[j].planetTextAngle!)
                  .abs();
          if (angleDiff < 10) {
            planetList[i].planetTextAngle = planetList[i].planetTextAngle! - 1;
            planetList[j].planetTextAngle = planetList[j].planetTextAngle! + 1;
            needsAdjustment = true;
            break;
          }
        }
        if (needsAdjustment) break;
      }
    } while (needsAdjustment);
  }

  void _drawCircles(Canvas canvas) {
    // ... (Same as _XYAstrolabePainter)
    canvas.drawCircle(
      Offset.zero,
      _radius,
      _circlePaint..color = colors['circle1']!,
    );
    canvas.drawCircle(
      Offset.zero,
      _radius - _ringWidth1,
      _circlePaint..color = colors['circle2']!,
    );
    canvas.drawCircle(
      Offset.zero,
      _radius - _ringWidth1 - _ringWidth2,
      _circlePaint..color = colors['circle3']!,
    );
    canvas.drawCircle(
      Offset.zero,
      _radius - _ringWidth1 - _ringWidth2 - _ringWidth3,
      _circlePaint..color = colors['circle4']!,
    );
  }

  void _drawScaleLines(Canvas canvas) {
    // ... (Same as _XYAstrolabePainter)
    final starLineStartRadius = _radius;
    final starLineEndRadius = _radius - _ringWidth1 - _ringWidth2;
    final scaleMaxEndRadius = starLineEndRadius - 9;
    final scaleMinEndRadius = starLineEndRadius - 6;

    _starScaleLinePaint.color = colors['starScale']!;

    for (int i = 0; i < 360; i++) {
      final angle = _starInfoList.first.starAngle + i;
      final startPoint = AstrolabeUtils.getPointByAngle(
        angle,
        starLineEndRadius,
      );

      if (i % 30 == 0) {
        // Star division line
        final starStart = AstrolabeUtils.getPointByAngle(
          angle,
          starLineStartRadius,
        );
        canvas.drawLine(starStart, startPoint, _starScaleLinePaint);
      } else if (i % 5 == 0) {
        // Max scale line
        final endPoint = AstrolabeUtils.getPointByAngle(
          angle,
          scaleMaxEndRadius,
        );
        canvas.drawLine(
          startPoint,
          endPoint,
          _starScaleLinePaint..color = const Color(0xFF424F7A),
        );
      } else {
        // Min scale line
        final endPoint = AstrolabeUtils.getPointByAngle(
          angle,
          scaleMinEndRadius,
        );
        canvas.drawLine(
          startPoint,
          endPoint,
          _starScaleLinePaint..color = const Color(0xFF333C5D),
        );
      }
    }
  }

  void _drawStarTexts(Canvas canvas) {
    // ... (Same as _XYAstrolabePainter)
    for (var starInfo in _starInfoList) {
      _drawText(
        canvas,
        _starTextPainter,
        AstrolabeUtils.easyText(starInfo.starName),
        _starTextSize,
        AstrolabeUtils.getStarColorByName(starInfo.starName),
        starInfo.starTextPoint!,
      );
    }
  }

  void _drawHouses(Canvas canvas) {
    for (int i = 0; i < houses.length; i++) {
      final house = houses[i];
      if (i == 0 || i == 3 || i == 6 || i == 9) {
        _housesScaleLinePaint.color = colors['houseLine']!;
      } else {
        _housesScaleLinePaint.color = colors['innerHouseLine']!;
      }
      canvas.drawLine(
        Offset.zero,
        house.houseStartPoint!,
        _housesScaleLinePaint,
      );

      Color textColor;
      switch (i % 4) {
        case 0:
          textColor = const Color(0xFFDC514C);
          break;
        case 1:
          textColor = const Color(0xFFE4A54A);
          break;
        case 2:
          textColor = const Color(0xFF45CA5D);
          break;
        default:
          textColor = const Color(0xFF333C5D);
      }

      _drawText(
        canvas,
        _houseTextPainter,
        '${i + 1}',
        _houseTextSize,
        textColor,
        house.houseTextPoint!,
      );

      // ADDED FOR SPECIAL VIEW
      final angleText = "${house.deg}°${house.min}'";
      final angleTextPoint = AstrolabeUtils.getPointByAngle(
        house.houseInitAngle! - 5,
        _radius - _ringWidth1 - _ringWidth2 - _ringWidth3 - 10,
      );
      _drawText(
        canvas,
        _houseTextPainter,
        angleText,
        _houseTextSize - 1,
        Colors.grey,
        angleTextPoint,
      );
    }
  }

  void _drawPlanets(Canvas canvas) {
    _drawSpecificPlanetSet(canvas, planetsInner);
    _drawSpecificPlanetSet(canvas, planetsOuter);
  }

  void _drawSpecificPlanetSet(Canvas canvas, List<Planets> planetList) {
    for (var planet in planetList) {
      if (planet.planetPoint == null ||
          planet.planetTextPoint == null ||
          planet.planetTextLineStartPoint == null ||
          planet.planetTextLineEndPoint == null)
        continue;

      final planetColor = AstrolabeUtils.getPlanetColorByName(
        planet.planetCn ?? '',
      );
      canvas.drawCircle(
        planet.planetPoint!,
        1.5,
        _planetPaint..color = planetColor,
      );

      _drawText(
        canvas,
        _planetTextPainter,
        AstrolabeUtils.changeStr(planet.planetCn ?? ''),
        _planetTextSize,
        planetColor,
        planet.planetTextPoint!,
      );

      canvas.drawLine(
        planet.planetTextLineStartPoint!,
        planet.planetTextLineEndPoint!,
        _linePaint..color = const Color(0xFF424F7A),
      );

      // ADDED FOR SPECIAL VIEW
      final angleText = "${planet.deg}°${planet.min}'";
      final angleTextPoint = AstrolabeUtils.getPointByAngle(
        planet.planetAngle! + 5,
        planet.planetPoint!.dy > 0
            ? planet.planetPoint!.dy + 15
            : planet.planetPoint!.dy - 15,
      );
      _drawText(
        canvas,
        _planetTextPainter,
        angleText,
        _planetTextSize - 2,
        Colors.grey,
        angleTextPoint,
      );
    }
  }

  void _drawPhases(Canvas canvas) {
    // ... (Same as _XYAstrolabePainter)
    for (final phase in phases) {
      // For transit chart, phase is between planets and planets1
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
    // ... (Same as _XYAstrolabePainter)
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
  bool shouldRepaint(covariant _XYAstrolabeSpecialPainter oldDelegate) {
    return houses != oldDelegate.houses ||
        planetsInner != oldDelegate.planetsInner ||
        planetsOuter != oldDelegate.planetsOuter ||
        phases != oldDelegate.phases ||
        isSmall != oldDelegate.isSmall ||
        style != oldDelegate.style;
  }
}
