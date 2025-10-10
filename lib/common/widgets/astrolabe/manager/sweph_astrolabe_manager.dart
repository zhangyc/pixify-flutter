import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/astro/engine/astro_calc.dart';
import '../models/astrolabe_data.dart';

/// 基于Sweph的星盘数据管理器
/// 替代原有的网络请求方式，使用本地计算生成星盘数据
class SwephAstrolabeManager {
  // 单例模式
  static final SwephAstrolabeManager _instance =
      SwephAstrolabeManager._internal();
  factory SwephAstrolabeManager() => _instance;
  SwephAstrolabeManager._internal();

  /// 生成本命盘数据
  Future<AstrolabeData?> generateNatalChart({
    required DateTime birthLocal,
    required double geoLat,
    required double geoLon,
    double timeZoneOffsetHours = 0.0,
    String? name,
    String? sex,
    String? birthPlace,
  }) async {
    try {
      return AstroCalc.generateNatalChartData(
        birthLocal: birthLocal,
        geoLat: geoLat,
        geoLon: geoLon,
        timeZoneOffsetHours: timeZoneOffsetHours,
        name: name,
        sex: sex,
        birthPlace: birthPlace,
      );
    } catch (e) {
      print('生成本命盘数据失败: $e');
      return null;
    }
  }

  /// 生成合盘数据
  Future<AstrolabeData?> generateSynastryChart({
    required DateTime birthLocal1,
    required double geoLat1,
    required double geoLon1,
    required DateTime birthLocal2,
    required double geoLat2,
    required double geoLon2,
    double timeZoneOffsetHours1 = 0.0,
    double timeZoneOffsetHours2 = 0.0,
    String? name1,
    String? name2,
  }) async {
    try {
      return AstroCalc.generateSynastryChartData(
        birthLocal1: birthLocal1,
        geoLat1: geoLat1,
        geoLon1: geoLon1,
        birthLocal2: birthLocal2,
        geoLat2: geoLat2,
        geoLon2: geoLon2,
        timeZoneOffsetHours1: timeZoneOffsetHours1,
        timeZoneOffsetHours2: timeZoneOffsetHours2,
        name1: name1,
        name2: name2,
      );
    } catch (e) {
      print('生成合盘数据失败: $e');
      return null;
    }
  }

  /// 生成行运盘数据（当前时间）
  Future<AstrolabeData?> generateTransitChart({
    required DateTime birthLocal,
    required double geoLat,
    required double geoLon,
    double timeZoneOffsetHours = 0.0,
    DateTime? transitTime, // 默认为当前时间
    String? name,
    String? sex,
    String? birthPlace,
  }) async {
    try {
      // 使用当前时间作为行运时间
      final transit = transitTime ?? DateTime.now();

      // 生成本命盘
      final natalData = await generateNatalChart(
        birthLocal: birthLocal,
        geoLat: geoLat,
        geoLon: geoLon,
        timeZoneOffsetHours: timeZoneOffsetHours,
        name: name,
        sex: sex,
        birthPlace: birthPlace,
      );

      if (natalData == null) return null;

      // 生成行运盘（当前时间）
      final transitData = AstroCalc.generateNatalChartData(
        birthLocal: transit,
        geoLat: geoLat,
        geoLon: geoLon,
        timeZoneOffsetHours: timeZoneOffsetHours,
        name: '行运',
      );

      // transitData 不会为 null，因为 AstroCalc.generateNatalChartData 返回的是非空对象

      // 创建行运盘数据（内圈为本命盘，外圈为行运盘）
      final result = AstrolabeData(
        houses: natalData.houses,
        info: natalData.info,
      );

      result.planetsInner = natalData.planets;
      result.planetsOuter = transitData.planets;

      // 计算本命盘与行运盘的相位
      result.phase = _calculateTransitPhases(natalData, transitData);

      return result;
    } catch (e) {
      print('生成行运盘数据失败: $e');
      return null;
    }
  }

  /// 计算行运相位
  List<Phase> _calculateTransitPhases(
      AstrolabeData natalData, AstrolabeData transitData) {
    final phases = <Phase>[];

    if (natalData.planets == null || transitData.planets == null) {
      return phases;
    }

    // 遍历本命盘和行运盘的行星，计算相位
    for (final natalPlanet in natalData.planets!) {
      for (final transitPlanet in transitData.planets!) {
        final aspect = _calculateAspect(natalPlanet, transitPlanet);
        if (aspect != null) {
          phases.add(Phase(
            planetName1: natalPlanet.planetCn,
            planetName2: transitPlanet.planetCn,
            aspectName: aspect['name'],
            orb: aspect['orb'].toStringAsFixed(2),
            isShow: 1,
            bgColor: _getAspectColor(aspect['name']),
          ));
        }
      }
    }

    return phases;
  }

  /// 计算两个行星之间的相位
  Map<String, dynamic>? _calculateAspect(Planets planet1, Planets planet2) {
    final lon1 = _getLongitude(planet1);
    final lon2 = _getLongitude(planet2);

    if (lon1 == null || lon2 == null) return null;

    final diff = _angleDiff180(lon1, lon2);

    // 定义相位角度和容许度
    final aspects = [
      {'angle': 0.0, 'name': '合', 'orb': 8.0},
      {'angle': 60.0, 'name': '六合', 'orb': 6.0},
      {'angle': 90.0, 'name': '刑', 'orb': 8.0},
      {'angle': 120.0, 'name': '拱', 'orb': 8.0},
      {'angle': 180.0, 'name': '冲', 'orb': 8.0},
    ];

    for (final aspect in aspects) {
      final angle = aspect['angle'] as double;
      final orb = aspect['orb'] as double;
      final actualOrb = (diff - angle).abs();

      if (actualOrb <= orb) {
        return {
          'name': aspect['name'],
          'orb': actualOrb,
        };
      }
    }

    return null;
  }

  /// 从Planets对象获取经度
  double? _getLongitude(Planets planet) {
    try {
      final deg = int.tryParse(planet.deg ?? '0') ?? 0;
      final min = int.tryParse(planet.min ?? '0') ?? 0;
      final sec = int.tryParse(planet.sec ?? '0') ?? 0;

      // 根据星座计算总经度
      final signIndex = _getSignIndex(planet.constellationCn ?? '');
      return signIndex * 30.0 + deg + min / 60.0 + sec / 3600.0;
    } catch (e) {
      return null;
    }
  }

  /// 获取星座索引
  int _getSignIndex(String constellation) {
    const signs = [
      '白羊',
      '金牛',
      '双子',
      '巨蟹',
      '狮子',
      '处女',
      '天秤',
      '天蝎',
      '射手',
      '摩羯',
      '水瓶',
      '双鱼',
    ];
    return signs.indexOf(constellation);
  }

  /// 计算两个角度之间的最小差值（0-180度）
  double _angleDiff180(double a, double b) {
    final diff = (a - b).abs() % 360.0;
    return diff > 180.0 ? 360.0 - diff : diff;
  }

  /// 获取相位颜色
  String _getAspectColor(String aspectName) {
    switch (aspectName) {
      case '合':
        return '#734406';
      case '六合':
        return '#2421BD';
      case '刑':
        return '#C83D26';
      case '拱':
        return '#52BB9F';
      case '冲':
        return '#5435DA';
      default:
        return '#2421BD';
    }
  }

  /// 生成日返盘数据
  Future<AstrolabeData?> generateSolarReturnChart({
    required DateTime birthLocal,
    required double geoLat,
    required double geoLon,
    double timeZoneOffsetHours = 0.0,
    int? returnYear, // 默认为明年
    String? name,
    String? sex,
    String? birthPlace,
  }) async {
    try {
      // 计算日返时间（太阳回到出生位置的时间）
      final year = returnYear ?? DateTime.now().year + 1;
      final returnDate = DateTime(year, birthLocal.month, birthLocal.day,
          birthLocal.hour, birthLocal.minute);

      return AstroCalc.generateNatalChartData(
        birthLocal: returnDate,
        geoLat: geoLat,
        geoLon: geoLon,
        timeZoneOffsetHours: timeZoneOffsetHours,
        name: name ?? '日返',
        sex: sex,
        birthPlace: birthPlace,
      );
    } catch (e) {
      print('生成日返盘数据失败: $e');
      return null;
    }
  }

  /// 生成月返盘数据
  Future<AstrolabeData?> generateLunarReturnChart({
    required DateTime birthLocal,
    required double geoLat,
    required double geoLon,
    double timeZoneOffsetHours = 0.0,
    DateTime? returnTime, // 默认为当前时间
    String? name,
    String? sex,
    String? birthPlace,
  }) async {
    try {
      // 简化处理：使用当前时间作为月返时间
      final transit = returnTime ?? DateTime.now();

      return AstroCalc.generateNatalChartData(
        birthLocal: transit,
        geoLat: geoLat,
        geoLon: geoLon,
        timeZoneOffsetHours: timeZoneOffsetHours,
        name: name ?? '月返',
        sex: sex,
        birthPlace: birthPlace,
      );
    } catch (e) {
      print('生成月返盘数据失败: $e');
      return null;
    }
  }
}

/// Sweph星盘数据管理器提供者
final swephAstrolabeManagerProvider = Provider<SwephAstrolabeManager>((ref) {
  return SwephAstrolabeManager();
});

/// 本命盘数据提供者
final natalChartProvider =
    FutureProvider.family<AstrolabeData?, Map<String, dynamic>>(
        (ref, params) async {
  final manager = ref.read(swephAstrolabeManagerProvider);
  return manager.generateNatalChart(
    birthLocal: params['birthLocal'] as DateTime,
    geoLat: params['geoLat'] as double,
    geoLon: params['geoLon'] as double,
    timeZoneOffsetHours: params['timeZoneOffsetHours'] as double? ?? 0.0,
    name: params['name'] as String?,
    sex: params['sex'] as String?,
    birthPlace: params['birthPlace'] as String?,
  );
});

/// 合盘数据提供者
final synastryChartProvider =
    FutureProvider.family<AstrolabeData?, Map<String, dynamic>>(
        (ref, params) async {
  final manager = ref.read(swephAstrolabeManagerProvider);
  return manager.generateSynastryChart(
    birthLocal1: params['birthLocal1'] as DateTime,
    geoLat1: params['geoLat1'] as double,
    geoLon1: params['geoLon1'] as double,
    birthLocal2: params['birthLocal2'] as DateTime,
    geoLat2: params['geoLat2'] as double,
    geoLon2: params['geoLon2'] as double,
    timeZoneOffsetHours1: params['timeZoneOffsetHours1'] as double? ?? 0.0,
    timeZoneOffsetHours2: params['timeZoneOffsetHours2'] as double? ?? 0.0,
    name1: params['name1'] as String?,
    name2: params['name2'] as String?,
  );
});

/// 行运盘数据提供者
final transitChartProvider =
    FutureProvider.family<AstrolabeData?, Map<String, dynamic>>(
        (ref, params) async {
  final manager = ref.read(swephAstrolabeManagerProvider);
  return manager.generateTransitChart(
    birthLocal: params['birthLocal'] as DateTime,
    geoLat: params['geoLat'] as double,
    geoLon: params['geoLon'] as double,
    timeZoneOffsetHours: params['timeZoneOffsetHours'] as double? ?? 0.0,
    transitTime: params['transitTime'] as DateTime?,
    name: params['name'] as String?,
    sex: params['sex'] as String?,
    birthPlace: params['birthPlace'] as String?,
  );
});
