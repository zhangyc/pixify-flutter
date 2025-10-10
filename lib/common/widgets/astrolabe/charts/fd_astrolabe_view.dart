import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../models/astrolabe_data.dart';
import '../utils/astrolabe_utils.dart';

/// 法达盘 Widget，完全对应 FDAstrobaleView.java
class FDAstrolabeView extends StatelessWidget {
  final List<Houses> houses;
  final List<Planets> planets;
  final List<Phase> phases;
  final double currentAge;
  final Size size;
  final bool isSmall;
  final String style;
  final Map<String, Color> colors;

  const FDAstrolabeView({
    super.key,
    required this.houses,
    required this.planets,
    required this.phases,
    required this.currentAge,
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
      painter: _FDAstrolabePainter(
        houses: houses,
        planets: planets,
        phases: phases,
        currentAge: currentAge,
        isSmall: isSmall,
        style: style,
        colors: colors,
      ),
    );
  }
}

/// FDAstrolabeView 的私有 Painter
class _FDAstrolabePainter extends CustomPainter {
  final List<Houses> houses;
  final List<Planets> planets;
  final List<Phase> phases;
  final double currentAge;
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
      _linePaint,
      _firdariaPaint;
  late final TextPainter _starTextPainter;
  late final TextPainter _houseTextPainter;
  late final TextPainter _planetTextPainter;

  // Dimensions
  late double _radius;
  late double _ringWidth1;
  late double _ringWidth2;
  late double _ringWidth3;
  late double _starTextSize;
  late double _houseTextSize;
  late double _planetTextSize;

  // Calculated values
  final List<StarInfoBean> _starInfoList = [];
  final Map<String, double> _starAngleMap = {};
  final Map<String, Offset> _planetPointMap = {};

  _FDAstrolabePainter({
    required this.houses,
    required this.planets,
    required this.phases,
    required this.currentAge,
    required this.isSmall,
    required this.style,
    required this.colors,
  }) {
    // ... (Same as AstrolabePainter)
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
    _firdariaPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

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
    canvas.scale(1, -1);
    _calculateAllPoints();

    _drawFirdariaArcs(canvas); // Draw behind everything else
    _drawCircles(canvas);
    _drawScaleLines(canvas);
    _drawStarTexts(canvas);
    _drawHouses(canvas);
    _drawPlanets(canvas);
    _drawPhases(canvas);
  }

  void _initDimensions(Size size) {
    // ... (Same as AstrolabePainter)
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
    // ... (Same as AstrolabePainter)
    _starInfoList.clear();
    _starAngleMap.clear();

    final firstHouse = houses.first;
    final double firstStarAngle =
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
    // ... (Same as AstrolabePainter)
    final starTextRadius = _radius - (_ringWidth1 / 2);
    for (final starInfo in _starInfoList) {
      starInfo.starTextPoint = AstrolabeUtils.getPointByAngle(
        starInfo.statTextAngle,
        starTextRadius,
      );
    }
  }

  void _calculateHousesPoints() {
    // ... (Same as AstrolabePainter)
    final housesScaleLineRadius = _radius - (_ringWidth1 + _ringWidth2);
    final houseTextRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 / 2);

    for (int i = 0; i < houses.length; i++) {
      final house = houses[i];
      // 1. 解析角度
      final baseAngle = _starAngleMap[house.constellationCn] ?? 0;
      house.houseInitAngle =
          baseAngle +
          AstrolabeUtils.getAngle(
            int.tryParse(house.deg ?? '') ?? 0,
            int.tryParse(house.min ?? '') ?? 0,
            int.tryParse(house.sec ?? '') ?? 0,
          );

      // 跳过无效宫
      if (house.houseInitAngle == null) continue;

      // 根据宫位序号计算分割线起点，0/3/6/9 等轴宫使用最外圈半径，其余使用内圈半径
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

      // 2. 取下一宫角度
      double nextHouseAngle;
      if (i == houses.length - 1) {
        nextHouseAngle = houses.first.houseInitAngle ?? baseAngle;
      } else {
        nextHouseAngle = houses[i + 1].houseInitAngle ?? baseAngle;
      }

      // 3. 后续计算全部使用 ?. ?? 防御
      if (nextHouseAngle < house.houseInitAngle!) nextHouseAngle += 360;
      house.houseTextInitAngle =
          house.houseInitAngle! + (nextHouseAngle - house.houseInitAngle!) / 2;
      house.houseTextPoint = AstrolabeUtils.getPointByAngle(
        house.houseTextInitAngle!,
        houseTextRadius,
      );
    }
  }

  void _calculatePlanetPoints() {
    // ... (Same as AstrolabePainter)
    final planetRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + 50);
    final planetTextRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + 30);
    final planetTextLineEndRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + 38);
    final planetTextLineStartRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + 48);

    _planetPointMap.clear();

    for (final planet in planets) {
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
      _planetPointMap[planet.planetCn ?? ''] = planet.planetPoint!;
    }

    // Adjust text angle to avoid overlap
    planets.sort((a, b) => a.planetTextAngle!.compareTo(b.planetTextAngle!));
    _adjustPlanetTextAngle(planets);

    for (final planet in planets) {
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
    // ... (Same as AstrolabePainter)
    bool needsAdjustment;
    do {
      needsAdjustment = false;
      for (int i = 0; i < planetList.length - 1; i++) {
        for (int j = i + 1; j < planetList.length; j++) {
          final double angleDiff =
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

  void _drawFirdariaArcs(Canvas canvas) {
    if (planets.isEmpty) return;

    final sun = planets.firstWhere(
      (p) => p.planetCn == '太阳',
      orElse: () => planets.first,
    );
    final bool isNightChart = int.parse(sun.placeOn ?? '0') <= 6;

    final List<String> planetOrder = isNightChart
        ? ['月亮', '土星', '木星', '火星', '太阳', '金星', '水星', '北交', '南交']
        : ['太阳', '金星', '水星', '月亮', '土星', '木星', '火星', '北交', '南交'];

    final Map<String, int> planetYears = {
      '太阳': 10,
      '金星': 8,
      '水星': 13,
      '月亮': 9,
      '土星': 11,
      '木星': 12,
      '火星': 7,
      '北交': 3,
      '南交': 2,
    };

    const double totalYears = 75.0;
    double startAngle = -90.0;
    final double arcWidth = isSmall ? 8 : 12;
    final double arcRadius = _radius + arcWidth / 2 + 2;
    _firdariaPaint.strokeWidth = arcWidth;

    for (final planetName in planetOrder) {
      final years = planetYears[planetName] ?? 0;
      final sweepAngle = (years / totalYears) * 360.0;
      _firdariaPaint.color = AstrolabeUtils.getPlanetColorByName(planetName);

      canvas.drawArc(
        Rect.fromCircle(center: Offset.zero, radius: arcRadius),
        startAngle * (pi / 180),
        sweepAngle * (pi / 180),
        false,
        _firdariaPaint,
      );
      startAngle += sweepAngle;
    }

    // Draw current age indicator
    final double ageAngle = -90 + (currentAge / totalYears) * 360;
    final pStart = AstrolabeUtils.getPointByAngle(
      ageAngle,
      arcRadius - arcWidth / 2 - 2,
    );
    final pEnd = AstrolabeUtils.getPointByAngle(
      ageAngle,
      arcRadius + arcWidth / 2 + 2,
    );
    _linePaint.color = Colors.red;
    _linePaint.strokeWidth = 2;
    canvas.drawLine(pStart, pEnd, _linePaint);
  }

  void _drawCircles(Canvas canvas) {
    // ... (Same as AstrolabePainter)
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
    // ... (Same as AstrolabePainter)
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
    // ... (Same as AstrolabePainter)
    for (final starInfo in _starInfoList) {
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
    // ... (Same as AstrolabePainter)
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
    }
  }

  void _drawPlanets(Canvas canvas) {
    // ... (Same as AstrolabePainter)
    for (final planet in planets) {
      if (planet.planetPoint == null ||
          planet.planetTextPoint == null ||
          planet.planetTextLineStartPoint == null ||
          planet.planetTextLineEndPoint == null) {
        continue;
      }

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
    }
  }

  void _drawPhases(Canvas canvas) {
    // Phase logic for a single-planet chart
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
    // ... (Same as AstrolabePainter)
    painter.text = TextSpan(
      text: text,
      style: TextStyle(fontSize: size, color: color),
    );
    painter.layout();
    canvas.save();
    canvas.scale(1, -1);
    painter.paint(
      canvas,
      Offset(center.dx - painter.width / 2, -center.dy - painter.height / 2),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _FDAstrolabePainter oldDelegate) {
    return houses != oldDelegate.houses ||
        planets != oldDelegate.planets ||
        phases != oldDelegate.phases ||
        currentAge != oldDelegate.currentAge ||
        isSmall != oldDelegate.isSmall ||
        style != oldDelegate.style;
  }
}
