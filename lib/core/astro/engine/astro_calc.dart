import 'package:sweph/sweph.dart';
import 'package:sona/core/discover/models/astro_score.dart';

// 星座名称（0-11）
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
  '双鱼座',
];

/// 支持的主要相位
enum AspectType { conjunction, sextile, square, trine, opposition }

/// 行星位置（简化结构）
class PlanetPosition {
  final double longitude; // 0-360
  final int signIndex; // 0-11
  final String signName; // 中文星座名
  final int? houseIndex; // 1-12（未知出生时可为空）

  PlanetPosition({
    required this.longitude,
    required this.signIndex,
    required this.signName,
    this.houseIndex,
  });

  Map<String, dynamic> toJson() => {
        'longitude': longitude,
        'signIndex': signIndex,
        'signName': signName,
        'houseIndex': houseIndex,
      };
}

/// 本命盘结构化数据
class NatalChartData {
  final double julianDayUT;
  final double latitude; // 地理纬度
  final double longitude; // 地理经度
  final Map<HeavenlyBody, PlanetPosition> planets;
  final List<double> houseCusps; // 12宫起点（度）
  final double ascendant; // ASC
  final double midheaven; // MC

  NatalChartData({
    required this.julianDayUT,
    required this.latitude,
    required this.longitude,
    required this.planets,
    required this.houseCusps,
    required this.ascendant,
    required this.midheaven,
  });

  Map<String, dynamic> toJson() => {
        'jdUT': julianDayUT,
        'lat': latitude,
        'lon': longitude,
        'planets': planets
            .map((k, v) => MapEntry(AstroCalc.heavenlyBodyKey(k), v.toJson())),
        'houseCusps': houseCusps,
        'ascendant': ascendant,
        'midheaven': midheaven,
      };
}

/// 合盘相位命中
class AspectHit {
  final HeavenlyBody bodyA;
  final HeavenlyBody bodyB;
  final AspectType type;
  final double delta; // 实际夹角（0-180）
  final double orb; // 偏离角

  AspectHit({
    required this.bodyA,
    required this.bodyB,
    required this.type,
    required this.delta,
    required this.orb,
  });

  Map<String, dynamic> toJson() => {
        'a': AstroCalc.heavenlyBodyKey(bodyA),
        'b': AstroCalc.heavenlyBodyKey(bodyB),
        'type': type.name,
        'delta': delta,
        'orb': orb,
      };
}

/// 宫位覆盖（A 的行星落入 B 的第几宫）
class HouseOverlay {
  final HeavenlyBody bodyA;
  final int bHouse; // 1-12

  HouseOverlay({required this.bodyA, required this.bHouse});

  Map<String, dynamic> toJson() => {
        'a': AstroCalc.heavenlyBodyKey(bodyA),
        'bHouse': bHouse,
      };
}

/// 合盘结果结构
class SynastryData {
  final List<AspectHit> aspects;
  final List<HouseOverlay> houseOverlays;

  SynastryData({required this.aspects, required this.houseOverlays});

  Map<String, dynamic> toJson() => {
        'aspects': aspects.map((e) => e.toJson()).toList(),
        'houseOverlays': houseOverlays.map((e) => e.toJson()).toList(),
      };
}

/// Sweph 计算器：输出结构化本命盘与合盘
class AstroCalc {
  /// 计算本命盘
  static NatalChartData computeNatalChart({
    required DateTime birthLocal,
    required double geoLat,
    required double geoLon,
    double timeZoneOffsetHours = 0.0,
  }) {
    // 本地时间 → UTC（含 DST 偏移）
    final birthUT = birthLocal.subtract(
      Duration(minutes: (timeZoneOffsetHours * 60).round()),
    );

    // JD (UT)
    final jdUT = Sweph.swe_julday(
      birthUT.year,
      birthUT.month,
      birthUT.day,
      birthUT.hour + birthUT.minute / 60.0 + birthUT.second / 3600.0,
      CalendarType.SE_GREG_CAL,
    );

    // 行星经度
    final bodies = <HeavenlyBody>[
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

    final Map<HeavenlyBody, PlanetPosition> planetMap = {};
    for (final body in bodies) {
      final r = Sweph.swe_calc_ut(jdUT, body, SwephFlag.SEFLG_SPEED);
      final lon = _normalize360(r.longitude);
      final signIdx = (lon / 30).floor().clamp(0, 11);
      planetMap[body] = PlanetPosition(
        longitude: lon,
        signIndex: signIdx,
        signName: zodiacNames[signIdx],
      );
    }

    // 宫位与角度（Placidus）
    final houses = Sweph.swe_houses(jdUT, geoLat, geoLon, Hsys.P);
    final asc = _normalize360(houses.ascmc[0]);
    final mc = _normalize360(houses.ascmc[1]);
    final cusps = houses.cusps.map(_normalize360).toList();

    // 计算落宫
    for (final entry in planetMap.entries) {
      final h = _houseOfLongitude(entry.value.longitude, cusps);
      planetMap[entry.key] = PlanetPosition(
        longitude: entry.value.longitude,
        signIndex: entry.value.signIndex,
        signName: entry.value.signName,
        houseIndex: h,
      );
    }

    return NatalChartData(
      julianDayUT: jdUT,
      latitude: geoLat,
      longitude: geoLon,
      planets: planetMap,
      houseCusps: cusps,
      ascendant: asc,
      midheaven: mc,
    );
  }

  /// 计算合盘（相位 + 宫位覆盖）
  static SynastryData computeSynastry({
    required NatalChartData chartA,
    required NatalChartData chartB,
    Set<HeavenlyBody>? bodies,
  }) {
    final useBodies = bodies ??
        {
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
        };

    final aspects = <AspectHit>[];
    for (final a in useBodies) {
      for (final b in useBodies) {
        final lonA = chartA.planets[a]?.longitude;
        final lonB = chartB.planets[b]?.longitude;
        if (lonA == null || lonB == null) continue;

        final d = _angleDiff180(lonA, lonB);
        final hit = _matchAspect(d, a, b);
        if (hit != null) aspects.add(hit);
      }
    }

    final overlays = <HouseOverlay>[];
    for (final a in useBodies) {
      final posA = chartA.planets[a];
      if (posA == null) continue;
      final houseInB = _houseOfLongitude(posA.longitude, chartB.houseCusps);
      if (houseInB != null)
        overlays.add(HouseOverlay(bodyA: a, bHouse: houseInB));
    }

    return SynastryData(aspects: aspects, houseOverlays: overlays);
  }

  /// 从 A/B 本命盘直接计算合盘分数（fate/harmony/risk）
  static AstroScore computeScoreFromCharts({
    required NatalChartData chartA,
    required NatalChartData chartB,
  }) {
    final synAB = computeSynastry(chartA: chartA, chartB: chartB);
    final synBA = computeSynastry(chartA: chartB, chartB: chartA);
    return computeScore(
      synastry: synAB,
      houseOverlaysBoth: [...synAB.houseOverlays, ...synBA.houseOverlays],
    );
  }

  /// 基于合盘结构化数据计算分数
  static AstroScore computeScore({
    required SynastryData synastry,
    List<HouseOverlay>? houseOverlaysBoth,
  }) {
    double fate = 0;
    double harmony = 0;
    double risk = 0;

    // 相位打分
    for (final a in synastry.aspects) {
      final orbLimit = _orbForPair(a.bodyA, a.bodyB);
      final orbFactor = (1.0 - (a.orb / orbLimit)).clamp(0.0, 1.0);

      final wFate = _baseWeightFate(a.bodyA, a.bodyB, a.type);
      final wHarmony = _baseWeightHarmony(a.bodyA, a.bodyB, a.type);
      final wRisk = _baseWeightRisk(a.bodyA, a.bodyB, a.type);

      fate += wFate * orbFactor;
      harmony += wHarmony * orbFactor;
      risk += wRisk * orbFactor;
    }

    // 落宫加权（双向）
    final overlays = houseOverlaysBoth ?? synastry.houseOverlays;
    for (final h in overlays) {
      final addFate = _houseFateWeight(h.bodyA, h.bHouse);
      final addRisk = _houseRiskWeight(h.bodyA, h.bHouse);
      fate += addFate;
      risk += addRisk;
    }

    // 归一化（经验阈值）
    int norm(double v, double denom) =>
        (v * (100.0 / denom)).clamp(0.0, 100.0).round();
    final fateScore = norm(fate, 80);
    final harmonyScore = norm(harmony, 80);
    final riskScore = norm(risk, 90);

    // 简要标签
    final tags = <String>[];
    if (fateScore >= 75) tags.add('强吸引');
    if (harmonyScore >= 70) tags.add('节奏契合');
    if (riskScore >= 65) tags.add('高风险');

    // 简要开场白建议
    final prompts = <String>[
      '聊聊彼此最有灵感的时刻',
      '这周最想做的一件事是什么？',
    ];

    return AstroScore(
      fate: fateScore,
      harmony: harmonyScore,
      risk: riskScore,
      tags: tags,
      prompts: prompts,
      version: '1.0.0',
    );
  }

  // ===== 权重定义 =====

  static bool _isPersonal(HeavenlyBody x) =>
      x == HeavenlyBody.SE_SUN ||
      x == HeavenlyBody.SE_MOON ||
      x == HeavenlyBody.SE_MERCURY ||
      x == HeavenlyBody.SE_VENUS ||
      x == HeavenlyBody.SE_MARS;

  // 预留：如需区分行星层级可扩展使用

  static bool _isPair(
      HeavenlyBody a, HeavenlyBody b, HeavenlyBody x, HeavenlyBody y) {
    return (a == x && b == y) || (a == y && b == x);
  }

  static double _baseWeightFate(HeavenlyBody a, HeavenlyBody b, AspectType t) {
    // VENUS–MARS：强吸引
    if (_isPair(a, b, HeavenlyBody.SE_VENUS, HeavenlyBody.SE_MARS)) {
      switch (t) {
        case AspectType.conjunction:
          return 12;
        case AspectType.trine:
          return 9;
        case AspectType.sextile:
          return 8;
        case AspectType.square:
        case AspectType.opposition:
          return 6; // 吸引+张力
      }
    }

    // SUN–MOON：核心吸引
    if (_isPair(a, b, HeavenlyBody.SE_SUN, HeavenlyBody.SE_MOON)) {
      switch (t) {
        case AspectType.conjunction:
          return 12;
        case AspectType.trine:
          return 10;
        case AspectType.sextile:
          return 8;
        case AspectType.square:
        case AspectType.opposition:
          return 6;
      }
    }

    // SUN–SUN、VENUS–VENUS：同频
    if (_isPair(a, b, HeavenlyBody.SE_SUN, HeavenlyBody.SE_SUN) ||
        _isPair(a, b, HeavenlyBody.SE_VENUS, HeavenlyBody.SE_VENUS)) {
      switch (t) {
        case AspectType.conjunction:
        case AspectType.trine:
        case AspectType.sextile:
          return 6;
        case AspectType.square:
        case AspectType.opposition:
          return 2;
      }
    }

    // PLUTO–SUN 拱/合：深度吸引
    if (_isPair(a, b, HeavenlyBody.SE_PLUTO, HeavenlyBody.SE_SUN)) {
      switch (t) {
        case AspectType.conjunction:
        case AspectType.trine:
          return 8;
        case AspectType.sextile:
          return 5;
        case AspectType.square:
        case AspectType.opposition:
          return 3;
      }
    }

    return 0;
  }

  static double _baseWeightHarmony(
      HeavenlyBody a, HeavenlyBody b, AspectType t) {
    // 情绪与沟通
    if (_isPair(a, b, HeavenlyBody.SE_MOON, HeavenlyBody.SE_MERCURY)) {
      switch (t) {
        case AspectType.trine:
        case AspectType.sextile:
          return 8;
        case AspectType.conjunction:
          return 6;
        case AspectType.square:
        case AspectType.opposition:
          return 0;
      }
    }

    if (_isPair(a, b, HeavenlyBody.SE_MERCURY, HeavenlyBody.SE_MERCURY)) {
      switch (t) {
        case AspectType.trine:
        case AspectType.sextile:
          return 8;
        case AspectType.conjunction:
          return 6;
        default:
          return 0;
      }
    }

    if (_isPair(a, b, HeavenlyBody.SE_VENUS, HeavenlyBody.SE_VENUS)) {
      switch (t) {
        case AspectType.trine:
        case AspectType.sextile:
          return 6;
        case AspectType.conjunction:
          return 5;
        default:
          return 0;
      }
    }

    // 木星加持个人星
    if ((a == HeavenlyBody.SE_JUPITER && _isPersonal(b)) ||
        (b == HeavenlyBody.SE_JUPITER && _isPersonal(a))) {
      switch (t) {
        case AspectType.trine:
        case AspectType.sextile:
          return 5;
        case AspectType.conjunction:
          return 4;
        default:
          return 0;
      }
    }

    // SUN–MOON 拱/六合：也计入和谐
    if (_isPair(a, b, HeavenlyBody.SE_SUN, HeavenlyBody.SE_MOON)) {
      switch (t) {
        case AspectType.trine:
          return 6;
        case AspectType.sextile:
          return 5;
        case AspectType.conjunction:
          return 3;
        default:
          return 0;
      }
    }
    return 0;
  }

  static double _baseWeightRisk(HeavenlyBody a, HeavenlyBody b, AspectType t) {
    bool hard(AspectType t) =>
        t == AspectType.square || t == AspectType.opposition;

    // 土星 ↔ 个人星：冷感/限制
    if ((a == HeavenlyBody.SE_SATURN && _isPersonal(b)) ||
        (b == HeavenlyBody.SE_SATURN && _isPersonal(a))) {
      if (hard(t)) return 12;
      if (t == AspectType.conjunction) return 10;
      return 0;
    }

    // 火星 ↔ 月/水/金：争执
    if (_isPair(a, b, HeavenlyBody.SE_MARS, HeavenlyBody.SE_MOON) ||
        _isPair(a, b, HeavenlyBody.SE_MARS, HeavenlyBody.SE_MERCURY) ||
        _isPair(a, b, HeavenlyBody.SE_MARS, HeavenlyBody.SE_VENUS)) {
      if (hard(t)) return 10;
      return 0;
    }

    // 天王 ↔ 个人星：不稳定
    if (((a == HeavenlyBody.SE_URANUS) && _isPersonal(b)) ||
        ((b == HeavenlyBody.SE_URANUS) && _isPersonal(a))) {
      if (hard(t) || t == AspectType.conjunction) return 10;
      return 0;
    }

    // 海王 ↔ 太阳/月亮/金/水：理想化
    if (((a == HeavenlyBody.SE_NEPTUNE) &&
            (b == HeavenlyBody.SE_SUN ||
                b == HeavenlyBody.SE_MOON ||
                b == HeavenlyBody.SE_VENUS ||
                b == HeavenlyBody.SE_MERCURY)) ||
        ((b == HeavenlyBody.SE_NEPTUNE) &&
            (a == HeavenlyBody.SE_SUN ||
                a == HeavenlyBody.SE_MOON ||
                a == HeavenlyBody.SE_VENUS ||
                a == HeavenlyBody.SE_MERCURY))) {
      if (hard(t) || t == AspectType.conjunction) return 10;
      return 0;
    }

    // 冥王 ↔ 太阳/月亮/金/水：控制/强迫
    if (((a == HeavenlyBody.SE_PLUTO) &&
            (_isPersonal(b) || b == HeavenlyBody.SE_SUN)) ||
        ((b == HeavenlyBody.SE_PLUTO) &&
            (_isPersonal(a) || a == HeavenlyBody.SE_SUN))) {
      if (hard(t)) return 12;
      if (t == AspectType.conjunction) return 10;
      return 0;
    }

    // VENUS–MARS 的刑冲也计风险（张力）
    if (_isPair(a, b, HeavenlyBody.SE_VENUS, HeavenlyBody.SE_MARS) && hard(t)) {
      return 6;
    }

    // SUN–MOON 的刑冲也计风险（磨合）
    if (_isPair(a, b, HeavenlyBody.SE_SUN, HeavenlyBody.SE_MOON) && hard(t)) {
      return 6;
    }

    return 0;
  }

  static double _houseFateWeight(HeavenlyBody body, int house) {
    if ((body == HeavenlyBody.SE_VENUS || body == HeavenlyBody.SE_MARS) &&
        (house == 5 || house == 7 || house == 8)) return 6;
    if ((body == HeavenlyBody.SE_SUN || body == HeavenlyBody.SE_MOON) &&
        (house == 1 || house == 7)) return 6;
    return 0;
  }

  static double _houseRiskWeight(HeavenlyBody body, int house) {
    if (body == HeavenlyBody.SE_MARS && (house == 1 || house == 7)) return 6;
    if (body == HeavenlyBody.SE_SATURN && house == 1) return 4;
    if (body == HeavenlyBody.SE_PLUTO && house == 7) return 6;
    return 0;
  }

  // ===== 工具函数 =====

  static double _normalize360(double v) {
    var x = v % 360.0;
    if (x < 0) x += 360.0;
    return x;
  }

  static double _angleDiff180(double a, double b) {
    final diff = (_normalize360(a) - _normalize360(b)).abs() % 360.0;
    return diff > 180.0 ? 360.0 - diff : diff;
  }

  static int? _houseOfLongitude(double lon, List<double> cusps) {
    if (cusps.length < 12) return null;
    final x = _normalize360(lon);
    for (int i = 0; i < 12; i++) {
      final start = _normalize360(cusps[i]);
      var end = _normalize360(cusps[(i + 1) % 12]);
      var xx = x;
      var s = start;
      var e = end;
      if (e <= s) e += 360.0;
      if (xx < s) xx += 360.0;
      if (xx >= s && xx < e) return i + 1;
    }
    return 12;
  }

  static AspectHit? _matchAspect(double delta, HeavenlyBody a, HeavenlyBody b) {
    final candidates = <AspectType, double>{
      AspectType.conjunction: 0.0,
      AspectType.sextile: 60.0,
      AspectType.square: 90.0,
      AspectType.trine: 120.0,
      AspectType.opposition: 180.0,
    };

    final orbLimit = _orbForPair(a, b);
    AspectType? type;
    double? bestOrb;
    candidates.forEach((t, angle) {
      final o = (delta - angle).abs();
      if (o <= orbLimit) {
        if (bestOrb == null || o < bestOrb!) {
          bestOrb = o;
          type = t;
        }
      }
    });

    if (type == null) return null;
    return AspectHit(
        bodyA: a, bodyB: b, type: type!, delta: delta, orb: bestOrb!);
  }

  static double _orbForPair(HeavenlyBody a, HeavenlyBody b) {
    bool isSunMoon(HeavenlyBody x) =>
        x == HeavenlyBody.SE_SUN || x == HeavenlyBody.SE_MOON;
    bool isPersonal(HeavenlyBody x) =>
        x == HeavenlyBody.SE_MERCURY ||
        x == HeavenlyBody.SE_VENUS ||
        x == HeavenlyBody.SE_MARS;
    bool isSocial(HeavenlyBody x) =>
        x == HeavenlyBody.SE_JUPITER || x == HeavenlyBody.SE_SATURN;

    final pair = [a, b];
    if (pair.any(isSunMoon)) return 8.0;
    if (pair.any(isPersonal)) return 6.0;
    if (pair.any(isSocial)) return 5.0;
    return 4.0;
  }

  /// HeavenlyBody -> 稳定键
  static String heavenlyBodyKey(HeavenlyBody b) {
    switch (b) {
      case HeavenlyBody.SE_SUN:
        return 'SUN';
      case HeavenlyBody.SE_MOON:
        return 'MOON';
      case HeavenlyBody.SE_MERCURY:
        return 'MERCURY';
      case HeavenlyBody.SE_VENUS:
        return 'VENUS';
      case HeavenlyBody.SE_MARS:
        return 'MARS';
      case HeavenlyBody.SE_JUPITER:
        return 'JUPITER';
      case HeavenlyBody.SE_SATURN:
        return 'SATURN';
      case HeavenlyBody.SE_URANUS:
        return 'URANUS';
      case HeavenlyBody.SE_NEPTUNE:
        return 'NEPTUNE';
      case HeavenlyBody.SE_PLUTO:
        return 'PLUTO';
      default:
        return 'UNKNOWN';
    }
  }
}
