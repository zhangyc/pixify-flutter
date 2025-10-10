import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../models/astrolabe_data.dart';
import '../utils/astrolabe_utils.dart';

/// 行运盘 Widget，完全对应 XYAstrobaleView.java
class XYAstrolabeView extends StatelessWidget {
  final List<Houses> houses;
  final List<Planets> planetsInner; // 内圈行星
  final List<Planets> planetsOuter; // 外圈行星
  final List<Phase> phases;
  final Size size;
  final bool isSmall;
  final String style;
  final Map<String, Color> colors;

  const XYAstrolabeView({
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
      painter: _XYAstrolabePainter(
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

/// XYAstrolabeView 的 Painter，严格按照 Java 版本实现
class _XYAstrolabePainter extends CustomPainter {
  final List<Houses> houses;
  final List<Planets> planetsInner;
  final List<Planets> planetsOuter;
  final List<Phase> phases;
  final bool isSmall;
  final String style;
  final Map<String, Color> colors;

  // 绘制参数 - 对应 Java 中的成员变量
  late double _radius;
  late double _ringWidth1, _ringWidth2, _ringWidth3;
  late double _starTextSize, _houseTextSize, _planetTextSize;

  // 绘制工具
  late Paint _circlePaint, _starScaleLinePaint, _scaleLinePaint;
  late Paint _housesScaleLinePaint, _planetPaint, _phasePaint;
  late TextPainter _starTextPainter, _houseTextPainter, _planetTextPainter;

  // 计算结果存储 - 对应 Java 中的成员变量
  final List<StarInfoBean> _starInfoList = [];
  final Map<String, double> _starAngleMap = {};
  final Map<String, Offset> _planetPointMap = {}; // 内圈行星坐标
  final Map<String, Offset> _planetPointMap1 = {}; // 外圈行星坐标

  double _firstStarAngle = 0;

  _XYAstrolabePainter({
    required this.houses,
    required this.planetsInner,
    required this.planetsOuter,
    required this.phases,
    required this.isSmall,
    required this.style,
    required this.colors,
  }) {
    _initPaints();
  }

  void _initPaints() {
    _circlePaint = Paint()..isAntiAlias = true;
    _starScaleLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;
    _scaleLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.2
      ..isAntiAlias = true;
    _housesScaleLinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;
    _planetPaint = Paint()..isAntiAlias = true;
    _phasePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..isAntiAlias = true;

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
    canvas.scale(1, -1); // 翻转Y轴以匹配Java的坐标系
    _initAllPoint();

    // 按照 Java 中 dispatchDraw 的顺序绘制
    _drawCircle1(canvas);
    _drawCircle2(canvas);
    _drawCircle3(canvas);
    _drawCircle4(canvas);
    _drawStarScaleLine(canvas);
    _drawScaleLine(canvas);
    _drawStarText(canvas);
    _drawHousesScaleLine(canvas);
    _drawHouseText(canvas);
    _drawPlanetAndPlanetText(canvas); // 内圈行星
    _drawPlanetAndPlanetText1(canvas); // 外圈行星
    _drawPhase(canvas);
  }

  /// 初始化尺寸参数 - 对应 Java 中的 onMeasure
  void _initDimensions(Size size) {
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

  /// 计算所有坐标点 - 对应 Java 中的 initAllPoint
  void _initAllPoint() {
    _initScaleLinePoint();
    _initStarAngle();
    _initStarTextPoint();
    _initHousesScaleLinePoint();
    _initHouseTextPoint();
    _initPlanetPoint();
    _initPlanetPoint1();
    _initPlanetTextPoint();
    _initPlanetTextPoint1();
  }

  /// 初始化第一宫所在星座的起始分割线坐标及角度 - 对应 Java 中的 initScaleLinePoint
  void _initScaleLinePoint() {
    if (houses.isNotEmpty) {
      _firstStarAngle = 180 -
          AstrolabeUtils.getAngle(
            int.parse(houses[0].deg ?? '0'),
            int.parse(houses[0].min ?? '0'),
            int.parse(houses[0].sec ?? '0'),
          );
    }
  }

  /// 初始化各个星座分区刻度的起始角度 - 对应 Java 中的 initStarAngle
  void _initStarAngle() {
    if (houses.isEmpty) return;

    _starAngleMap.clear();
    _starInfoList.clear();

    int firstStarIndex = 0;
    for (int i = 0; i < AstrolabeUtils.starText.length; i++) {
      if (houses[0].constellationCn == AstrolabeUtils.starText[i]) {
        firstStarIndex = i;
        break;
      }
    }

    for (int i = 0; i < AstrolabeUtils.starText.length; i++) {
      if (firstStarIndex >= AstrolabeUtils.starText.length) {
        firstStarIndex = firstStarIndex - AstrolabeUtils.starText.length;
      }
      final starName = AstrolabeUtils.starText[firstStarIndex];
      final angle = _firstStarAngle + i * 30;
      _starAngleMap[starName] = angle;
      _starInfoList.add(
        StarInfoBean(
          starName: starName,
          starAngle: angle,
          statTextAngle: angle + 15,
        ),
      );
      firstStarIndex++;
    }
  }

  /// 初始化星座文字坐标 - 对应 Java 中的 initStarTextPoint
  void _initStarTextPoint() {
    final starTextRadius = _radius - (_ringWidth1 / 2);
    for (var starInfo in _starInfoList) {
      starInfo.starTextPoint = AstrolabeUtils.getPointByAngle(
        starInfo.statTextAngle,
        starTextRadius,
      );
    }
  }

  /// 初始化宫位坐标点 - 对应 Java 中的 initHousesScaleLinePoint
  void _initHousesScaleLinePoint() {
    final housesScaleLineRadius = _radius - (_ringWidth1 + _ringWidth2);

    for (int i = 0; i < houses.length; i++) {
      final house = houses[i];
      house.houseInitAngle = (_starAngleMap[house.constellationCn] ?? 0) +
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
    }
  }

  /// 初始化宫位文字坐标点 - 对应 Java 中的 initHouseTextPoint
  void _initHouseTextPoint() {
    final houseTextRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 / 2);

    for (int i = 0; i < houses.length; i++) {
      final house = houses[i];
      double nextHouseAngle;

      if (i == houses.length - 1) {
        nextHouseAngle = houses[0].houseInitAngle ?? 0;
        if (nextHouseAngle <= house.houseInitAngle!) {
          nextHouseAngle += 360;
        }
      } else {
        nextHouseAngle = houses[i + 1].houseInitAngle ?? 0;
        if (nextHouseAngle <= house.houseInitAngle!) {
          nextHouseAngle += 360;
        }
      }

      house.houseTextInitAngle =
          house.houseInitAngle! + (nextHouseAngle - house.houseInitAngle!) / 2;
      house.houseTextPoint = AstrolabeUtils.getPointByAngle(
        house.houseTextInitAngle!,
        houseTextRadius,
      );
    }
  }

  /// 初始化内圈行星坐标点 - 对应 Java 中的 initPlanetPoint
  void _initPlanetPoint() {
    final planetRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + 50);
    _planetPointMap.clear();

    for (var planet in planetsInner) {
      planet.planetAngle = (_starAngleMap[planet.constellationCn] ?? 0) +
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
  }

  /// 初始化外圈行星坐标点 - 对应 Java 中的 initPlanetPoint1
  void _initPlanetPoint1() {
    final planetRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + 50);
    _planetPointMap1.clear();

    for (var planet in planetsOuter) {
      planet.planetAngle = (_starAngleMap[planet.constellationCn] ?? 0) +
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
      _planetPointMap1[planet.planetCn ?? ''] = planet.planetPoint!;
    }
  }

  /// 初始化内圈行星文字坐标点 - 对应 Java 中的 initPlanetTextPoint
  void _initPlanetTextPoint() {
    final planetTextRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + 30);
    final planetTextLineEndRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + 38);
    final planetTextLineStartRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + 48);

    planetsInner.sort(
      (a, b) => a.planetTextAngle!.compareTo(b.planetTextAngle!),
    );
    _calcPlanetTextAngle(planetsInner);

    for (var planet in planetsInner) {
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

  /// 初始化外圈行星文字坐标点 - 对应 Java 中的 initPlanetTextPoint1
  void _initPlanetTextPoint1() {
    final planetTextRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + 10);
    final planetTextLineEndRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + 18);
    final planetTextLineStartRadius =
        _radius - (_ringWidth1 + _ringWidth2 + _ringWidth3 + 48);

    planetsOuter.sort(
      (a, b) => a.planetTextAngle!.compareTo(b.planetTextAngle!),
    );
    _calcPlanetTextAngle(planetsOuter);

    for (var planet in planetsOuter) {
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

  /// 计算行星文字角度避让 - 对应 Java 中的 calcPlanetTextAngle
  void _calcPlanetTextAngle(List<Planets> planetList) {
    bool needAdjustment;
    do {
      needAdjustment = false;
      for (int i = 0; i < planetList.length - 1; i++) {
        for (int j = i + 1; j < planetList.length; j++) {
          double angleDiff =
              (planetList[i].planetTextAngle! - planetList[j].planetTextAngle!)
                  .abs();
          if (angleDiff < 10) {
            planetList[i].planetTextAngle = planetList[i].planetTextAngle! - 1;
            planetList[j].planetTextAngle = planetList[j].planetTextAngle! + 1;
            needAdjustment = true;
            break;
          }
        }
        if (needAdjustment) break;
      }
    } while (needAdjustment);
  }

  /// 画最外圈圆 - 对应 Java 中的 drawCircle1
  void _drawCircle1(Canvas canvas) {
    canvas.drawCircle(
      Offset.zero,
      _radius,
      _circlePaint..color = colors['circle1']!,
    );
  }

  /// 画第二个圆 - 对应 Java 中的 drawCircle2
  void _drawCircle2(Canvas canvas) {
    canvas.drawCircle(
      Offset.zero,
      _radius - _ringWidth1,
      _circlePaint..color = colors['circle2']!,
    );
  }

  /// 画第三个圆 - 对应 Java 中的 drawCircle3
  void _drawCircle3(Canvas canvas) {
    canvas.drawCircle(
      Offset.zero,
      _radius - _ringWidth1 - _ringWidth2,
      _circlePaint..color = colors['circle3']!,
    );
  }

  /// 画第四个圆 - 对应 Java 中的 drawCircle4
  void _drawCircle4(Canvas canvas) {
    canvas.drawCircle(
      Offset.zero,
      _radius - _ringWidth1 - _ringWidth2 - _ringWidth3,
      _circlePaint..color = colors['circle4']!,
    );
  }

  /// 画星座分区刻度线 - 对应 Java 中的 drawStarScaleLine
  void _drawStarScaleLine(Canvas canvas) {
    _starScaleLinePaint.color = colors['starScale']!;
    final startRadius = _radius;
    final endRadius = _radius - _ringWidth1 - _ringWidth2;

    for (int i = 0; i < 12; i++) {
      final angle = _firstStarAngle + i * 30;
      final startPoint = AstrolabeUtils.getPointByAngle(angle, startRadius);
      final endPoint = AstrolabeUtils.getPointByAngle(angle, endRadius);
      canvas.drawLine(startPoint, endPoint, _starScaleLinePaint);
    }
  }

  /// 画360度刻度线 - 对应 Java 中的 drawScaleLine
  void _drawScaleLine(Canvas canvas) {
    final startRadius = _radius - _ringWidth1 - _ringWidth2;
    final maxEndRadius = startRadius - 9;
    final minEndRadius = startRadius - 6;

    for (int i = 0; i < 360; i++) {
      final angle = _firstStarAngle + i;
      final startPoint = AstrolabeUtils.getPointByAngle(angle, startRadius);

      if (i % 5 == 0) {
        final endPoint = AstrolabeUtils.getPointByAngle(angle, maxEndRadius);
        canvas.drawLine(
          startPoint,
          endPoint,
          _scaleLinePaint..color = const Color(0xFF424F7A),
        );
      } else {
        final endPoint = AstrolabeUtils.getPointByAngle(angle, minEndRadius);
        canvas.drawLine(
          startPoint,
          endPoint,
          _scaleLinePaint..color = const Color(0xFF333C5D),
        );
      }
    }
  }

  /// 画星座文字 - 对应 Java 中的 drawStarText
  void _drawStarText(Canvas canvas) {
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

  /// 画宫位刻度线 - 对应 Java 中的 drawHousesScaleLine
  void _drawHousesScaleLine(Canvas canvas) {
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
    }
  }

  /// 画宫位文字 - 对应 Java 中的 drawHouseText
  void _drawHouseText(Canvas canvas) {
    for (int i = 0; i < houses.length; i++) {
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
        houses[i].houseTextPoint!,
      );
    }
  }

  /// 画内圈行星和行星文字 - 对应 Java 中的 drawPlanetAndPlanetText
  void _drawPlanetAndPlanetText(Canvas canvas) {
    for (var planet in planetsInner) {
      if (planet.planetPoint == null || planet.planetTextPoint == null)
        continue;

      final planetColor = AstrolabeUtils.getPlanetColorByName(
        planet.planetCn ?? '',
      );

      // 画行星点
      canvas.drawCircle(
        planet.planetPoint!,
        1.5,
        _planetPaint..color = planetColor,
      );

      // 画行星文字
      _drawText(
        canvas,
        _planetTextPainter,
        AstrolabeUtils.changeStr(planet.planetCn ?? ''),
        _planetTextSize,
        planetColor,
        planet.planetTextPoint!,
      );

      // 画连线
      if (planet.planetTextLineStartPoint != null &&
          planet.planetTextLineEndPoint != null) {
        canvas.drawLine(
          planet.planetTextLineStartPoint!,
          planet.planetTextLineEndPoint!,
          Paint()
            ..color = const Color(0xFF424F7A)
            ..strokeWidth = 1.0,
        );
      }
    }
  }

  /// 画外圈行星和行星文字 - 对应 Java 中的 drawPlanetAndPlanetText1
  void _drawPlanetAndPlanetText1(Canvas canvas) {
    for (var planet in planetsOuter) {
      if (planet.planetPoint == null || planet.planetTextPoint == null)
        continue;

      final planetColor = AstrolabeUtils.getPlanetColorByName(
        planet.planetCn ?? '',
      );

      // 画行星点
      canvas.drawCircle(
        planet.planetPoint!,
        1.5,
        _planetPaint..color = planetColor,
      );

      // 画行星文字
      _drawText(
        canvas,
        _planetTextPainter,
        AstrolabeUtils.changeStr(planet.planetCn ?? ''),
        _planetTextSize,
        planetColor,
        planet.planetTextPoint!,
      );

      // 画连线
      if (planet.planetTextLineStartPoint != null &&
          planet.planetTextLineEndPoint != null) {
        canvas.drawLine(
          planet.planetTextLineStartPoint!,
          planet.planetTextLineEndPoint!,
          Paint()
            ..color = const Color(0xFF424F7A)
            ..strokeWidth = 1.0,
        );
      }
    }
  }

  /// 画相位 - 严格对应 Java 中的 drawPhase
  void _drawPhase(Canvas canvas) {
    for (final phase in phases) {
      // Java 版本没有 isShow 判断，直接绘制所有相位
      final pOuter = _planetPointMap1[phase.planetName1]; // 外圈行星
      final pInner = _planetPointMap[phase.planetName2]; // 内圈行星

      if (pOuter == null || pInner == null) continue;

      _phasePaint.color = AstrolabeUtils.getPhaseColorByName(
        phase.aspectName ?? '',
      );
      canvas.drawLine(pOuter, pInner, _phasePaint);
    }
  }

  /// 绘制文字的通用方法
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
    canvas.save();
    canvas.scale(1, -1);
    painter.paint(
      canvas,
      Offset(center.dx - painter.width / 2, -center.dy - painter.height / 2),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _XYAstrolabePainter oldDelegate) {
    return houses != oldDelegate.houses ||
        planetsInner != oldDelegate.planetsInner ||
        planetsOuter != oldDelegate.planetsOuter ||
        phases != oldDelegate.phases ||
        isSmall != oldDelegate.isSmall ||
        style != oldDelegate.style;
  }
}

/// 星座信息Bean - 对应 Java 中的 StarInfoBean
class StarInfoBean {
  final String starName;
  final double starAngle;
  final double statTextAngle;
  Offset? starTextPoint;

  StarInfoBean({
    required this.starName,
    required this.starAngle,
    required this.statTextAngle,
  });
}
