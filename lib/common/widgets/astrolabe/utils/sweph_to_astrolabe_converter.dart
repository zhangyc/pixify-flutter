import 'package:sweph/sweph.dart';
import '../models/astrolabe_data.dart';
import '../../../../core/astro/engine/astro_calc.dart';

/// Sweph计算结果转换为星盘绘制数据的转换器
class SwephToAstrolabeDataConverter {
  /// 将NatalChartData转换为AstrolabeData
  static AstrolabeData convertNatalChart({
    required NatalChartData natalChart,
    String? name,
    String? sex,
    String? birthPlace,
  }) {
    // 转换行星数据
    final planets = _convertPlanets(natalChart.planets);

    // 转换宫位数据
    final houses = _convertHouses(natalChart.houseCusps, natalChart.ascendant);

    // 计算相位数据
    final phases = _calculatePhases(natalChart.planets);

    // 创建信息对象
    final info = Info(
      name: name,
      sex: sex,
      birthPlace: birthPlace,
      birthday: _formatDateTime(natalChart.julianDayUT),
    );

    return AstrolabeData(
      houses: houses,
      planets: planets,
      phase: phases,
      info: info,
    );
  }

  /// 将合盘数据转换为行运盘数据格式
  static AstrolabeData convertSynastryChart({
    required NatalChartData natalChart1, // 内圈
    required NatalChartData natalChart2, // 外圈
    String? name1,
    String? name2,
  }) {
    // 转换内圈行星数据
    final planetsInner = _convertPlanets(natalChart1.planets);

    // 转换外圈行星数据
    final planetsOuter = _convertPlanets(natalChart2.planets);

    // 使用第一个星盘的宫位
    final houses =
        _convertHouses(natalChart1.houseCusps, natalChart1.ascendant);

    // 计算合盘相位
    final phases =
        _calculateSynastryPhases(natalChart1.planets, natalChart2.planets);

    // 创建信息对象
    final info = Info(
      name: name1,
      birthday: _formatDateTime(natalChart1.julianDayUT),
    );

    final astrolabeData = AstrolabeData(
      houses: houses,
      phase: phases,
      info: info,
    );

    // 手动设置planetsInner和planetsOuter
    astrolabeData.planetsInner = planetsInner;
    astrolabeData.planetsOuter = planetsOuter;

    return astrolabeData;
  }

  /// 转换行星数据
  static List<Planets> _convertPlanets(
      Map<HeavenlyBody, PlanetPosition> planetMap) {
    final planets = <Planets>[];

    for (final entry in planetMap.entries) {
      final body = entry.key;
      final position = entry.value;

      final planet = Planets(
        planetCn: _getPlanetChineseName(body),
        shortPlanetCn: _getPlanetShortName(body),
        constellationCn: _getConstellationChineseName(position.signIndex),
        deg: position.longitude.floor().toString(),
        min: ((position.longitude % 1) * 60).floor().toString(),
        sec: (((position.longitude % 1) * 60) % 1 * 60).floor().toString(),
        degrees: position.longitude.toStringAsFixed(2),
        placeOn: position.houseIndex?.toString(),
        isShow: 1,
        reversion: 0,
      );

      planets.add(planet);
    }

    return planets;
  }

  /// 转换宫位数据
  static List<Houses> _convertHouses(
      List<double> houseCusps, double ascendant) {
    final houses = <Houses>[];

    for (int i = 0; i < 12; i++) {
      final cusp = houseCusps[i];
      final signIndex = (cusp / 30).floor() % 12;

      final house = Houses(
        houseName: '${i + 1}',
        constellationCn: _getConstellationChineseName(signIndex),
        deg: cusp.floor().toString(),
        min: ((cusp % 1) * 60).floor().toString(),
        sec: (((cusp % 1) * 60) % 1 * 60).floor().toString(),
        degrees: cusp.toStringAsFixed(2),
      );

      houses.add(house);
    }

    return houses;
  }

  /// 计算本命盘相位
  static List<Phase> _calculatePhases(
      Map<HeavenlyBody, PlanetPosition> planetMap) {
    final phases = <Phase>[];
    final bodies = planetMap.keys.toList();

    for (int i = 0; i < bodies.length; i++) {
      for (int j = i + 1; j < bodies.length; j++) {
        final body1 = bodies[i];
        final body2 = bodies[j];
        final pos1 = planetMap[body1]!;
        final pos2 = planetMap[body2]!;

        final aspect = _calculateAspect(pos1.longitude, pos2.longitude);
        if (aspect != null) {
          final phase = Phase(
            planetName1: _getPlanetChineseName(body1),
            planetName2: _getPlanetChineseName(body2),
            aspectName: aspect['name'],
            orb: aspect['orb'].toStringAsFixed(2),
            isShow: 1,
            bgColor: _getAspectColor(aspect['name']),
          );
          phases.add(phase);
        }
      }
    }

    return phases;
  }

  /// 计算合盘相位
  static List<Phase> _calculateSynastryPhases(
    Map<HeavenlyBody, PlanetPosition> planets1,
    Map<HeavenlyBody, PlanetPosition> planets2,
  ) {
    final phases = <Phase>[];

    for (final entry1 in planets1.entries) {
      for (final entry2 in planets2.entries) {
        final body1 = entry1.key;
        final body2 = entry2.key;
        final pos1 = entry1.value;
        final pos2 = entry2.value;

        final aspect = _calculateAspect(pos1.longitude, pos2.longitude);
        if (aspect != null) {
          final phase = Phase(
            planetName1: _getPlanetChineseName(body1),
            planetName2: _getPlanetChineseName(body2),
            aspectName: aspect['name'],
            orb: aspect['orb'].toStringAsFixed(2),
            isShow: 1,
            bgColor: _getAspectColor(aspect['name']),
          );
          phases.add(phase);
        }
      }
    }

    return phases;
  }

  /// 计算两个经度之间的相位
  static Map<String, dynamic>? _calculateAspect(double lon1, double lon2) {
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

  /// 计算两个角度之间的最小差值（0-180度）
  static double _angleDiff180(double a, double b) {
    final diff = (a - b).abs() % 360.0;
    return diff > 180.0 ? 360.0 - diff : diff;
  }

  /// 获取行星中文名称
  static String _getPlanetChineseName(HeavenlyBody body) {
    switch (body) {
      case HeavenlyBody.SE_SUN:
        return '太阳';
      case HeavenlyBody.SE_MOON:
        return '月亮';
      case HeavenlyBody.SE_MERCURY:
        return '水星';
      case HeavenlyBody.SE_VENUS:
        return '金星';
      case HeavenlyBody.SE_MARS:
        return '火星';
      case HeavenlyBody.SE_JUPITER:
        return '木星';
      case HeavenlyBody.SE_SATURN:
        return '土星';
      case HeavenlyBody.SE_URANUS:
        return '天王';
      case HeavenlyBody.SE_NEPTUNE:
        return '海王';
      case HeavenlyBody.SE_PLUTO:
        return '冥王';
      default:
        return '未知';
    }
  }

  /// 获取行星简称
  static String _getPlanetShortName(HeavenlyBody body) {
    switch (body) {
      case HeavenlyBody.SE_SUN:
        return '日';
      case HeavenlyBody.SE_MOON:
        return '月';
      case HeavenlyBody.SE_MERCURY:
        return '水';
      case HeavenlyBody.SE_VENUS:
        return '金';
      case HeavenlyBody.SE_MARS:
        return '火';
      case HeavenlyBody.SE_JUPITER:
        return '木';
      case HeavenlyBody.SE_SATURN:
        return '土';
      case HeavenlyBody.SE_URANUS:
        return '天';
      case HeavenlyBody.SE_NEPTUNE:
        return '海';
      case HeavenlyBody.SE_PLUTO:
        return '冥';
      default:
        return '?';
    }
  }

  /// 获取星座中文名称
  static String _getConstellationChineseName(int signIndex) {
    const names = [
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
    return names[signIndex % 12];
  }

  /// 获取相位颜色
  static String _getAspectColor(String aspectName) {
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

  /// 格式化日期时间
  static String _formatDateTime(double julianDay) {
    // 这里可以添加更复杂的日期格式化逻辑
    // 暂时返回简单的字符串
    return 'JD: ${julianDay.toStringAsFixed(2)}';
  }
}
