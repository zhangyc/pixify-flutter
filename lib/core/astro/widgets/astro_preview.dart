import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sweph/sweph.dart';
import '../../../generated/l10n.dart';
import '../engine/astro_calc.dart';

// 使用整数 ID 作为 Key，映射到行星符号
const Map<int, String> planetSymbols = {
  0: '☉', // Sun
  1: '☽', // Moon
  2: '☿', // Mercury
  3: '♀', // Venus
  4: '♂', // Mars
  5: '♃', // Jupiter
  6: '♄', // Saturn
  7: '♅', // Uranus
  8: '♆', // Neptune
  9: '♇', // Pluto
};

// 星座符号
const List<String> zodiacSymbols = [
  '♈',
  '♉',
  '♊',
  '♋',
  '♌',
  '♍',
  '♎',
  '♏',
  '♐',
  '♑',
  '♒',
  '♓'
];

// 相位符号映射
const Map<AspectType, String> aspectSymbols = {
  AspectType.conjunction: '☌', // 合相 0°
  AspectType.opposition: '☍', // 对分 180°
  AspectType.trine: '△', // 三分 120°
  AspectType.square: '□', // 四分 90°
  AspectType.sextile: '⚹', // 六分 60°
};

// 存储星盘计算结果的数据模型
class AstroChartData {
  final NatalChartData natalChart; // 使用已有的本命盘数据
  final List<AspectHit> aspects; // 使用已有的相位数据

  AstroChartData({
    required this.natalChart,
    required this.aspects,
  });

  // 兼容性方法，保持原有接口
  Map<int, double> get planetPositions {
    final positions = <int, double>{};
    final bodies = [
      HeavenlyBody.SE_SUN,
      HeavenlyBody.SE_MOON,
      HeavenlyBody.SE_MERCURY,
      HeavenlyBody.SE_VENUS,
      HeavenlyBody.SE_MARS,
      HeavenlyBody.SE_JUPITER,
      HeavenlyBody.SE_SATURN,
      HeavenlyBody.SE_URANUS,
      HeavenlyBody.SE_NEPTUNE,
      HeavenlyBody.SE_PLUTO,
    ];

    for (int i = 0; i < bodies.length; i++) {
      final planet = natalChart.planets[bodies[i]];
      if (planet != null) {
        positions[i] = planet.longitude;
      }
    }
    return positions;
  }

  List<double> get houseCusps => natalChart.houseCusps;
  double get ascendant => natalChart.ascendant;
  double get midheaven => natalChart.midheaven;
}

class AstroPreview extends StatefulWidget {
  const AstroPreview({
    super.key,
    required this.birthday,
    required this.birthLatitude,
    required this.birthLongitude,
    this.birthTime,
    this.isBackground = false,
    this.showBorder = true, // 新增：是否显示边框
  });

  final DateTime? birthday;
  final double? birthLatitude; // 出生纬度
  final double? birthLongitude; // 出生经度
  final String? birthTime; // 格式 "HH:mm"
  final bool isBackground; // 是否作为背景显示
  final bool showBorder; // 是否显示边框

  @override
  State<AstroPreview> createState() => _AstroPreviewState();
}

class _AstroPreviewState extends State<AstroPreview>
    with SingleTickerProviderStateMixin {
  Future<AstroChartData?>? _chartDataFuture;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // 初始化旋转动画控制器 - 使用平滑循环避免跳跃
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 120), // 120秒，让动画更慢更平滑
    )..repeat(); // 无限循环

    // 创建平滑的角度动画，使用TweenSequence避免跳跃
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi, // 360度
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear, // 线性变化
    ));

    if (widget.birthday != null) {
      _chartDataFuture = _calculateAstroData();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AstroPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.birthday != oldWidget.birthday ||
        widget.birthLatitude != oldWidget.birthLatitude ||
        widget.birthLongitude != oldWidget.birthLongitude ||
        widget.birthTime != oldWidget.birthTime ||
        widget.isBackground != oldWidget.isBackground) {
      if (widget.birthday != null &&
          widget.birthLatitude != null &&
          widget.birthLongitude != null) {
        setState(() {
          _chartDataFuture = _calculateAstroData();
        });
      }
    }
  }

  Future<AstroChartData> _calculateAstroData() async {
    return await _calculateRealAstroData();
  }

  Future<AstroChartData> _calculateRealAstroData() async {
    DateTime birthDateTime = widget.birthday!;
    if (widget.birthTime != null && widget.birthTime!.contains(':')) {
      final parts = widget.birthTime!.split(':');
      final hour = int.tryParse(parts[0]) ?? 12;
      final minute = int.tryParse(parts[1]) ?? 0;
      birthDateTime = DateTime(birthDateTime.year, birthDateTime.month,
          birthDateTime.day, hour, minute);
    } else {
      birthDateTime = DateTime(
          birthDateTime.year, birthDateTime.month, birthDateTime.day, 12, 0);
    }

    // 直接使用传入的经纬度参数
    final latitude = widget.birthLatitude!;
    final longitude = widget.birthLongitude!;

    // 使用已有的 AstroCalc 计算本命盘
    final natalChart = AstroCalc.computeNatalChart(
      birthLocal: birthDateTime,
      geoLat: latitude,
      geoLon: longitude,
      timeZoneOffsetHours: 8.0, // 中国时区 UTC+8
    );

    // 计算本命盘内部相位（行星与行星之间的角度关系）
    final aspects = _calculateNatalAspects(natalChart);

    // 调试信息
    print('计算出 ${aspects.length} 个相位:');
    for (final aspect in aspects) {
      print(
          '${aspect.bodyA.value} ${aspectSymbols[aspect.type]} ${aspect.bodyB.value} - ${aspect.delta.toStringAsFixed(1)}°');
    }

    return AstroChartData(
      natalChart: natalChart,
      aspects: aspects, // 使用计算出的相位列表
    );
  }

  // 计算本命盘内部相位
  List<AspectHit> _calculateNatalAspects(NatalChartData chart) {
    final aspects = <AspectHit>[];
    final planets = chart.planets;
    final planetBodies = planets.keys.toList();

    // 相位角度定义
    const aspectAngles = {
      AspectType.conjunction: 0.0,
      AspectType.sextile: 60.0,
      AspectType.square: 90.0,
      AspectType.trine: 120.0,
      AspectType.opposition: 180.0,
    };

    // 容许度
    double getOrbLimit(HeavenlyBody a, HeavenlyBody b) {
      final isSunMoon =
          (a == HeavenlyBody.SE_SUN || a == HeavenlyBody.SE_MOON) ||
              (b == HeavenlyBody.SE_SUN || b == HeavenlyBody.SE_MOON);
      return isSunMoon ? 8.0 : 6.0;
    }

    // 检查每对行星
    for (int i = 0; i < planetBodies.length; i++) {
      for (int j = i + 1; j < planetBodies.length; j++) {
        final bodyA = planetBodies[i];
        final bodyB = planetBodies[j];
        final posA = planets[bodyA];
        final posB = planets[bodyB];

        if (posA == null || posB == null) continue;

        // 计算角度差
        double angleDiff = (posB.longitude - posA.longitude).abs();
        if (angleDiff > 180) angleDiff = 360 - angleDiff;

        final orbLimit = getOrbLimit(bodyA, bodyB);

        // 检查每种相位
        AspectType? matchedType;
        double? bestOrb;

        for (final entry in aspectAngles.entries) {
          final aspectType = entry.key;
          final targetAngle = entry.value;
          final orb = (angleDiff - targetAngle).abs();

          if (orb <= orbLimit) {
            if (bestOrb == null || orb < bestOrb) {
              bestOrb = orb;
              matchedType = aspectType;
            }
          }
        }

        if (matchedType != null && bestOrb != null) {
          aspects.add(AspectHit(
            bodyA: bodyA,
            bodyB: bodyB,
            type: matchedType,
            delta: angleDiff,
            orb: bestOrb,
          ));
        }
      }
    }

    return aspects;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.birthday == null) {
      return widget.isBackground
          ? const SizedBox.shrink()
          : _buildPlaceholder(theme);
    }

    if (widget.isBackground) {
      // 背景模式：只显示星盘图，无容器装饰
      return FutureBuilder<AstroChartData?>(
        future: _chartDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data == null) {
            return const SizedBox.shrink();
          }

          final chartData = snapshot.data!;
          return _buildAstroChart(theme, chartData, isBackground: true);
        },
      );
    }

    // 正常模式：完整的星盘预览卡片
    return Container(
      margin: widget.showBorder
          ? const EdgeInsets.symmetric(vertical: 16)
          : EdgeInsets.zero,
      padding: widget.showBorder ? const EdgeInsets.all(20) : EdgeInsets.zero,
      decoration: widget.showBorder
          ? BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.primaryColor.withOpacity(0.1),
                  theme.primaryColor.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: theme.primaryColor.withOpacity(0.3),
                width: 1,
              ),
            )
          : null,
      child: FutureBuilder<AstroChartData?>(
        future: _chartDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return Center(
                child: Text('星盘计算失败: ${snapshot.error}',
                    style: TextStyle(color: theme.colorScheme.error)));
          }

          final chartData = snapshot.data!;

          // 只返回星盘部分，布局由父组件管理
          return _buildAstroChart(theme, chartData);
        },
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? const Color(0xFF1A1A1F)
            : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome_outlined,
                color: theme.hintColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                S.current.chartPreview,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.hintColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.hintColor.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.auto_awesome_outlined,
                color: theme.hintColor.withOpacity(0.5),
                size: 40,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            S.current.selectBirthdayHint,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.hintColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAstroChart(ThemeData theme, AstroChartData chartData,
      {bool isBackground = false}) {
    final size = isBackground ? 250.0 : double.infinity; // 使用全部可用空间

    return Container(
      width: size == double.infinity ? null : size,
      height: size == double.infinity ? null : size,
      decoration: isBackground
          ? null
          : BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  theme.scaffoldBackgroundColor,
                  theme.primaryColor.withOpacity(0.05),
                ],
              ),
            ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final chartSize = size == double.infinity
              ? constraints.maxWidth < constraints.maxHeight
                  ? constraints.maxWidth
                  : constraints.maxHeight
              : size;

          return AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              // 简单的调试信息，确认动画在运行
              final angle = _rotationAnimation.value;
              return CustomPaint(
                painter: AstroChartPainter(
                  chartData: chartData,
                  primaryColor: theme.primaryColor,
                  labelColor: theme.hintColor,
                  backgroundColor: theme.scaffoldBackgroundColor,
                  textColor: theme.textTheme.bodyMedium?.color ?? Colors.black,
                  isBackground: isBackground,
                  rotationAngle: angle,
                ),
                size: Size(chartSize, chartSize),
              );
            },
          );
        },
      ),
    );
  }
}

class AstroChartPainter extends CustomPainter {
  final AstroChartData chartData;
  final Color primaryColor;
  final Color labelColor;
  final Color backgroundColor;
  final Color textColor;
  final bool isBackground;
  final double rotationAngle; // 旋转角度，用于动画

  AstroChartPainter({
    required this.chartData,
    required this.primaryColor,
    required this.labelColor,
    required this.backgroundColor,
    required this.textColor,
    this.isBackground = false,
    this.rotationAngle = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    try {
      final center = Offset(size.width / 2, size.height / 2);
      final radius = size.width / 2 - 5;
      final ascendant = chartData.ascendant;

      double toCanvasAngle(double longitude) {
        double relativeAngle = longitude - ascendant;
        return (relativeAngle * math.pi / 180) - math.pi / 2; // 调整起始角度
      }

      // 定义4个环的半径
      final outerRadius = radius; // 最外环 - 度数刻度
      final zodiacRadius = radius * 0.85; // 第3环 - 星座符号
      final planetRadius = radius * 0.65; // 第2环 - 行星符号
      final houseRadius = radius * 0.45; // 最内环 - 宫位编号

      // 计算每个环的旋转角度（不同的倍数创造不同的旋转速度）
      final degreeRotation = rotationAngle * 0.5; // 度数刻度环 - 中等速度
      final zodiacRotation = rotationAngle * 1.0; // 星座环 - 标准速度
      final planetRotation = rotationAngle * 1.5; // 行星环 - 较快速度
      final houseRotation = rotationAngle * 0.3; // 宫位环 - 较慢速度

      if (isBackground) {
        // 背景模式：只绘制简化的星盘轮廓
        canvas.save();
        canvas.translate(center.dx, center.dy);
        canvas.rotate(zodiacRotation);
        canvas.translate(-center.dx, -center.dy);
        _drawZodiacRing(canvas, center, zodiacRadius, toCanvasAngle);

        canvas.save();
        canvas.translate(center.dx, center.dy);
        canvas.rotate(planetRotation);
        canvas.translate(-center.dx, -center.dy);
        _drawPlanetRing(canvas, center, planetRadius, toCanvasAngle);
        canvas.restore();

        _drawRingBorders(canvas, center, outerRadius, zodiacRadius,
            planetRadius, houseRadius);
        canvas.restore();
      } else {
        // 完整模式：绘制所有细节
        _drawAspects(canvas, center, planetRadius, toCanvasAngle); // 先绘制相位线

        // 度数刻度环旋转
        canvas.save();
        canvas.translate(center.dx, center.dy);
        canvas.rotate(degreeRotation);
        canvas.translate(-center.dx, -center.dy);
        _drawDegreeScale(canvas, center, outerRadius);
        canvas.restore();

        // 星座环旋转
        canvas.save();
        canvas.translate(center.dx, center.dy);
        canvas.rotate(zodiacRotation);
        canvas.translate(-center.dx, -center.dy);
        _drawZodiacRing(canvas, center, zodiacRadius, toCanvasAngle);
        canvas.restore();

        // 行星环旋转
        canvas.save();
        canvas.translate(center.dx, center.dy);
        canvas.rotate(planetRotation);
        canvas.translate(-center.dx, -center.dy);
        _drawPlanetRing(canvas, center, planetRadius, toCanvasAngle);
        canvas.restore();

        // 宫位环旋转
        canvas.save();
        canvas.translate(center.dx, center.dy);
        canvas.rotate(houseRotation);
        canvas.translate(-center.dx, -center.dy);
        _drawHouseRing(canvas, center, houseRadius, toCanvasAngle);
        canvas.restore();

        _drawRingBorders(canvas, center, outerRadius, zodiacRadius,
            planetRadius, houseRadius);
        _drawMainAxes(canvas, center, outerRadius, toCanvasAngle);
      }
    } catch (e, stackTrace) {
      print('星盘绘制错误: $e');
      print('StackTrace: $stackTrace');
      // 如果绘制失败，至少绘制一个简单的圆圈
      final errorPaint = Paint()
        ..color = Colors.red.withOpacity(0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), size.width / 4, errorPaint);
    }
  }

  // 绘制度数刻度（最外环）
  void _drawDegreeScale(Canvas canvas, Offset center, double radius) {
    final scalePaint = Paint()
      ..color = labelColor.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    // 绘制主刻度（每30度）
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * math.pi / 180 - math.pi / 2;
      final startPoint =
          center + Offset(math.cos(angle), math.sin(angle)) * (radius - 8);
      final endPoint =
          center + Offset(math.cos(angle), math.sin(angle)) * radius;
      canvas.drawLine(startPoint, endPoint, scalePaint);

      // 度数标签
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${i * 30}°',
          style: TextStyle(
              color: labelColor, fontSize: 8, fontWeight: FontWeight.w500),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final textOffset = Offset(
        center.dx + (radius - 15) * math.cos(angle) - textPainter.width / 2,
        center.dy + (radius - 15) * math.sin(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }

    // 绘制次刻度（每10度）
    final minorScalePaint = Paint()
      ..color = labelColor.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (int i = 0; i < 36; i++) {
      if (i % 3 != 0) {
        // 跳过主刻度位置
        final angle = (i * 10) * math.pi / 180 - math.pi / 2;
        final startPoint =
            center + Offset(math.cos(angle), math.sin(angle)) * (radius - 4);
        final endPoint =
            center + Offset(math.cos(angle), math.sin(angle)) * radius;
        canvas.drawLine(startPoint, endPoint, minorScalePaint);
      }
    }
  }

  // 绘制星座符号环（第3环）
  void _drawZodiacRing(
      Canvas canvas, Offset center, double radius, Function toCanvasAngle) {
    for (int i = 0; i < 12; i++) {
      final longitude = i * 30.0;
      final canvasAngle = toCanvasAngle(longitude);

      // 星座符号
      final textPainter = TextPainter(
        text: TextSpan(
          text: zodiacSymbols[i],
          style: TextStyle(
              color: primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final textOffset = Offset(
        center.dx + radius * math.cos(canvasAngle) - textPainter.width / 2,
        center.dy + radius * math.sin(canvasAngle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }
  }

  // 绘制行星符号环（第2环）
  void _drawPlanetRing(
      Canvas canvas, Offset center, double radius, Function toCanvasAngle) {
    chartData.planetPositions.forEach((planetId, longitude) {
      final symbol = planetSymbols[planetId] ?? '?';
      final angle = toCanvasAngle(longitude);

      // 行星背景圆
      final planetBgPaint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
          center + Offset(radius * math.cos(angle), radius * math.sin(angle)),
          12,
          planetBgPaint);

      // 行星边框
      final planetBorderPaint = Paint()
        ..color = primaryColor.withOpacity(0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      canvas.drawCircle(
          center + Offset(radius * math.cos(angle), radius * math.sin(angle)),
          12,
          planetBorderPaint);

      // 行星符号
      final textPainter = TextPainter(
        text: TextSpan(
            text: symbol,
            style: TextStyle(
                color: primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final textOffset = Offset(
        center.dx + radius * math.cos(angle) - textPainter.width / 2,
        center.dy + radius * math.sin(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    });
  }

  // 绘制宫位环（最内环）
  void _drawHouseRing(
      Canvas canvas, Offset center, double radius, Function toCanvasAngle) {
    for (int i = 0; i < chartData.houseCusps.length; i++) {
      final cusp = chartData.houseCusps[i];
      final nextCusp =
          chartData.houseCusps[(i + 1) % chartData.houseCusps.length];

      // 计算宫位中点
      double midPoint = (cusp + nextCusp) / 2;
      if (nextCusp < cusp) midPoint += 180; // 处理跨越0度的情况
      midPoint = midPoint % 360;

      final angle = toCanvasAngle(midPoint);

      // 宫位编号
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: TextStyle(
              color: textColor, fontSize: 12, fontWeight: FontWeight.w600),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final textOffset = Offset(
        center.dx + radius * math.cos(angle) - textPainter.width / 2,
        center.dy + radius * math.sin(angle) - textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }
  }

  // 绘制环形分界线
  void _drawRingBorders(Canvas canvas, Offset center, double outerRadius,
      double zodiacRadius, double planetRadius, double houseRadius) {
    final borderPaint = Paint()
      ..color = primaryColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // 外圆
    canvas.drawCircle(center, outerRadius, borderPaint);
    // 星座环边界
    canvas.drawCircle(center, zodiacRadius + 15, borderPaint);
    // 行星环边界
    canvas.drawCircle(center, planetRadius + 15, borderPaint);
    // 宫位环边界
    canvas.drawCircle(center, houseRadius + 15, borderPaint);
  }

  // 绘制宫位分割线和主轴
  void _drawMainAxes(
      Canvas canvas, Offset center, double radius, Function toCanvasAngle) {
    // 宫位分割线
    final housePaint = Paint()
      ..color = primaryColor.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    for (var cusp in chartData.houseCusps) {
      final angle = toCanvasAngle(cusp);
      canvas.drawLine(
          center + Offset(math.cos(angle), math.sin(angle)) * (radius * 0.3),
          center + Offset(math.cos(angle), math.sin(angle)) * (radius * 0.95),
          housePaint);
    }

    // 主轴线（ASC-DSC 和 MC-IC）
    final axisPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // ASC-DSC 轴
    final ascAngle = toCanvasAngle(chartData.ascendant);
    canvas.drawLine(
        center + Offset(math.cos(ascAngle), math.sin(ascAngle)) * radius,
        center +
            Offset(math.cos(ascAngle + math.pi), math.sin(ascAngle + math.pi)) *
                radius,
        axisPaint);

    // MC-IC 轴
    final mcAngle = toCanvasAngle(chartData.midheaven);
    canvas.drawLine(
        center + Offset(math.cos(mcAngle), math.sin(mcAngle)) * radius,
        center +
            Offset(math.cos(mcAngle + math.pi), math.sin(mcAngle + math.pi)) *
                radius,
        axisPaint);
  }

  // 绘制相位线条
  void _drawAspects(Canvas canvas, Offset center, double planetRadius,
      Function toCanvasAngle) {
    for (final aspect in chartData.aspects) {
      // 获取行星位置
      final planet1Pos = chartData.natalChart.planets[aspect.bodyA]?.longitude;
      final planet2Pos = chartData.natalChart.planets[aspect.bodyB]?.longitude;

      if (planet1Pos == null || planet2Pos == null) continue;

      final angle1 = toCanvasAngle(planet1Pos);
      final angle2 = toCanvasAngle(planet2Pos);

      final point1 = center +
          Offset(
            planetRadius * math.cos(angle1),
            planetRadius * math.sin(angle1),
          );
      final point2 = center +
          Offset(
            planetRadius * math.cos(angle2),
            planetRadius * math.sin(angle2),
          );

      // 根据相位类型设置颜色和样式
      final aspectPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = _getAspectStrokeWidth(aspect.type);

      final isHarmonious = aspect.type == AspectType.trine ||
          aspect.type == AspectType.sextile ||
          aspect.type == AspectType.conjunction;

      if (isHarmonious) {
        // 和谐相位：蓝色/绿色系
        aspectPaint.color = aspect.type == AspectType.trine
            ? Colors.blue.withOpacity(0.6)
            : Colors.green.withOpacity(0.6);
      } else {
        // 紧张相位：红色/橙色系
        aspectPaint.color = aspect.type == AspectType.square
            ? Colors.red.withOpacity(0.6)
            : Colors.orange.withOpacity(0.6);
      }

      // 绘制相位线
      canvas.drawLine(point1, point2, aspectPaint);

      // 在线条中点绘制相位符号和角度（可选）
      if (!isBackground) {
        final midPoint = Offset(
          (point1.dx + point2.dx) / 2,
          (point1.dy + point2.dy) / 2,
        );
        _drawAspectSymbolWithAngle(canvas, midPoint, aspect);
      }
    }
  }

  // 获取相位线条粗细
  double _getAspectStrokeWidth(AspectType type) {
    switch (type) {
      case AspectType.conjunction:
      case AspectType.opposition:
        return 2.0;
      case AspectType.trine:
      case AspectType.square:
        return 1.5;
      case AspectType.sextile:
        return 1.0;
    }
  }

  // 绘制相位符号和角度
  void _drawAspectSymbolWithAngle(
      Canvas canvas, Offset position, AspectHit aspect) {
    final symbol = aspectSymbols[aspect.type] ?? '?';
    final angleText = '${aspect.delta.toStringAsFixed(1)}°';

    // 创建背景圆，稍大一些以容纳角度文本
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(position, 12, bgPaint);

    // 绘制边框
    final borderPaint = Paint()
      ..color = primaryColor.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawCircle(position, 12, borderPaint);

    // 绘制相位符号
    final symbolPainter = TextPainter(
      text: TextSpan(
        text: symbol,
        style: TextStyle(
          color: primaryColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    symbolPainter.layout();

    // 绘制角度文本
    final anglePainter = TextPainter(
      text: TextSpan(
        text: angleText,
        style: TextStyle(
          color: textColor,
          fontSize: 7,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    anglePainter.layout();

    // 计算位置：符号在上，角度在下
    final symbolOffset = Offset(
      position.dx - symbolPainter.width / 2,
      position.dy - symbolPainter.height / 2 - 3,
    );
    final angleOffset = Offset(
      position.dx - anglePainter.width / 2,
      position.dy - anglePainter.height / 2 + 4,
    );

    symbolPainter.paint(canvas, symbolOffset);
    anglePainter.paint(canvas, angleOffset);
  }

  @override
  bool shouldRepaint(covariant AstroChartPainter oldDelegate) {
    return oldDelegate.chartData != chartData ||
        oldDelegate.isBackground != isBackground ||
        oldDelegate.rotationAngle != rotationAngle;
  }
}
