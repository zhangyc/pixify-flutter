import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sweph/sweph.dart';
import '../engine/astro_calc.dart';

// 城市坐标数据库
const Map<String, Map<String, double>> cityCoordinates = {
  '北京市': {'lat': 39.9042, 'lng': 116.4074},
  '上海市': {'lat': 31.2304, 'lng': 121.4737},
  '广州市': {'lat': 23.1291, 'lng': 113.2644},
  '深圳市': {'lat': 22.5431, 'lng': 114.0579},
  '杭州市': {'lat': 30.2741, 'lng': 120.1551},
  '南京市': {'lat': 32.0603, 'lng': 118.7969},
  '武汉市': {'lat': 30.5928, 'lng': 114.3055},
  '成都市': {'lat': 30.5728, 'lng': 104.0668},
  '重庆市': {'lat': 29.5647, 'lng': 106.5507},
  '西安市': {'lat': 34.3416, 'lng': 108.9398},
  '天津市': {'lat': 39.3434, 'lng': 117.3616},
  '苏州市': {'lat': 31.2989, 'lng': 120.5853},
  '长沙市': {'lat': 28.2282, 'lng': 112.9388},
  '郑州市': {'lat': 34.7466, 'lng': 113.6253},
  '青岛市': {'lat': 36.0986, 'lng': 120.3719},
  '大连市': {'lat': 38.9140, 'lng': 121.6147},
  '宁波市': {'lat': 29.8683, 'lng': 121.5440},
  '厦门市': {'lat': 24.4798, 'lng': 118.0819},
  '福州市': {'lat': 26.0745, 'lng': 119.2965},
  '哈尔滨市': {'lat': 45.8038, 'lng': 126.5349},
  '济南市': {'lat': 36.6512, 'lng': 117.1201},
  '石家庄市': {'lat': 38.0428, 'lng': 114.5149},
  '长春市': {'lat': 43.8171, 'lng': 125.3235},
  '沈阳市': {'lat': 41.8057, 'lng': 123.4315},
  '太原市': {'lat': 37.8706, 'lng': 112.5489},
  '合肥市': {'lat': 31.8206, 'lng': 117.2272},
  '昆明市': {'lat': 25.0389, 'lng': 102.7183},
  '南宁市': {'lat': 22.8170, 'lng': 108.3669},
  '海口市': {'lat': 20.0444, 'lng': 110.1999},
  '贵阳市': {'lat': 26.6470, 'lng': 106.6302},
  '兰州市': {'lat': 36.0611, 'lng': 103.8343},
  '银川市': {'lat': 38.4872, 'lng': 106.2309},
  '西宁市': {'lat': 36.6171, 'lng': 101.7782},
  '乌鲁木齐市': {'lat': 43.8256, 'lng': 87.6168},
  '拉萨市': {'lat': 29.6520, 'lng': 91.1721},
  '呼和浩特市': {'lat': 40.8414, 'lng': 111.7519},
};

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
const List<String> zodiacNames = [
  '白羊座',
  '金牛座',
  '双子座',
  '巨蟹座',
  '狮子座',
  '处女座',
  '天秤座',
  '天蝎座',
  '射手座',
  '摩羯座',
  '水瓶座',
  '双鱼座'
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
    required this.country,
    this.birthTime,
    this.birthCity,
    this.isBackground = false,
  });

  final DateTime? birthday;
  final SonaCountry country;
  final String? birthTime; // 格式 "HH:mm"
  final String? birthCity; // 出生城市
  final bool isBackground; // 是否作为背景显示

  @override
  State<AstroPreview> createState() => _AstroPreviewState();
}

class _AstroPreviewState extends State<AstroPreview> {
  Future<AstroChartData?>? _chartDataFuture;

  @override
  void initState() {
    super.initState();
    if (widget.birthday != null) {
      _chartDataFuture = _calculateAstroData();
    }
  }

  @override
  void didUpdateWidget(covariant AstroPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.birthday != oldWidget.birthday ||
        widget.birthTime != oldWidget.birthTime ||
        widget.birthCity != oldWidget.birthCity ||
        widget.country != oldWidget.country) {
      if (widget.birthday != null) {
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

    // 获取城市坐标
    double latitude = 39.9042; // 默认北京
    double longitude = 116.4074;

    if (widget.birthCity != null) {
      final coords = cityCoordinates[widget.birthCity!];
      if (coords != null) {
        latitude = coords['lat']!;
        longitude = coords['lng']!;
      }
    }

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

  String _getZodiacSign(double longitude) {
    // 确保经度在 0-360 之间
    final normalizedLongitude = longitude % 360;
    return zodiacNames[(normalizedLongitude / 30).floor()];
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
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
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
      ),
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

          return Column(
            children: [
              _buildHeader(theme),
              const SizedBox(height: 16),
              _buildAstroChart(theme, chartData),
              const SizedBox(height: 16),
              _buildAstroInfo(theme, chartData),
            ],
          );
        },
      ),
    );
  }

  Row _buildHeader(ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.auto_awesome,
          color: theme.primaryColor,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          '您的星盘预览',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
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
                '星盘预览',
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
            '请选择出生日期查看您的星盘',
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
    final size = isBackground ? 250.0 : 180.0;

    return Container(
      width: size,
      height: size,
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
      child: CustomPaint(
        painter: AstroChartPainter(
          chartData: chartData,
          primaryColor: theme.primaryColor,
          labelColor: theme.hintColor,
          backgroundColor: theme.scaffoldBackgroundColor,
          textColor: theme.textTheme.bodyMedium?.color ?? Colors.black,
          isBackground: isBackground,
        ),
        size: Size(size, size),
      ),
    );
  }

  Widget _buildAstroInfo(ThemeData theme, AstroChartData chartData) {
    // 使用太阳的 ID (0) 来获取太阳经度
    final sunLongitude = chartData.planetPositions[0]!;
    final sunSign = _getZodiacSign(sunLongitude);
    final ascendantSign = _getZodiacSign(chartData.ascendant);
    final birthTimeText = widget.birthTime ?? '12:00 (默认)';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoItem(
              theme,
              '太阳星座',
              sunSign,
              Icons.wb_sunny,
            ),
            _buildInfoItem(
              theme,
              '上升星座',
              ascendantSign,
              Icons.trending_up,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoItem(
              theme,
              '出生城市',
              widget.birthCity ?? '未选择',
              Icons.location_city,
            ),
            _buildInfoItem(
              theme,
              '出生时间',
              birthTimeText,
              Icons.access_time,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoItem(
      ThemeData theme, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: theme.primaryColor,
          size: 16,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.hintColor,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
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

  AstroChartPainter({
    required this.chartData,
    required this.primaryColor,
    required this.labelColor,
    required this.backgroundColor,
    required this.textColor,
    this.isBackground = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
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

    if (isBackground) {
      // 背景模式：只绘制简化的星盘轮廓
      _drawZodiacRing(canvas, center, zodiacRadius, toCanvasAngle);
      _drawPlanetRing(canvas, center, planetRadius, toCanvasAngle);
      _drawRingBorders(
          canvas, center, outerRadius, zodiacRadius, planetRadius, houseRadius);
    } else {
      // 完整模式：绘制所有细节
      _drawAspects(canvas, center, planetRadius, toCanvasAngle); // 先绘制相位线
      _drawDegreeScale(canvas, center, outerRadius);
      _drawZodiacRing(canvas, center, zodiacRadius, toCanvasAngle);
      _drawPlanetRing(canvas, center, planetRadius, toCanvasAngle);
      _drawHouseRing(canvas, center, houseRadius, toCanvasAngle);
      _drawRingBorders(
          canvas, center, outerRadius, zodiacRadius, planetRadius, houseRadius);
      _drawMainAxes(canvas, center, outerRadius, toCanvasAngle);
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
    print('开始绘制 ${chartData.aspects.length} 个相位');

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
        oldDelegate.isBackground != isBackground;
  }
}
