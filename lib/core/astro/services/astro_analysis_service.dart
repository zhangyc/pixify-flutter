import 'package:dio/dio.dart';
import 'package:sona/common/widgets/astrolabe/models/astrolabe_data.dart';
import 'package:sona/common/widgets/astrolabe/manager/sweph_astrolabe_manager.dart';

import '../../../core/match/util/http_util.dart';
import '../../../utils/global/global.dart';

/// 星盘AI分析服务
class AstroAnalysisService {
  static final AstroAnalysisService _instance =
      AstroAnalysisService._internal();
  factory AstroAnalysisService() => _instance;
  AstroAnalysisService._internal();

  final SwephAstrolabeManager _astrolabeManager = SwephAstrolabeManager();

  /// 轻度分析单人星盘
  Future<HttpResult> analyzeNatalChartLight({
    required DateTime birthday,
    required double latitude,
    required double longitude,
    String? name,
    String? birthPlace,
    String? sex,
  }) async {
    try {
      // 生成星盘数据
      final astrolabeData = await _astrolabeManager.generateNatalChart(
        birthLocal: birthday,
        geoLat: latitude,
        geoLon: longitude,
        name: name,
        sex: sex,
        birthPlace: birthPlace,
      );

      if (astrolabeData == null) {
        return HttpResult.error('无法生成星盘数据');
      }

      // 调用后端API
      return await post(
        '/api/astro/natal-chart/analyze/light',
        data: astrolabeData.toJson(),
      );
    } catch (e) {
      print('轻度星盘分析失败: $e');
      return HttpResult.error(e);
    }
  }

  /// 深度分析单人星盘
  Future<HttpResult> analyzeNatalChartDeep({
    required DateTime birthday,
    required double latitude,
    required double longitude,
    String? name,
    String? birthPlace,
    String? sex,
  }) async {
    try {
      // 生成星盘数据
      final astrolabeData = await _astrolabeManager.generateNatalChart(
        birthLocal: birthday,
        geoLat: latitude,
        geoLon: longitude,
        name: name,
        sex: sex,
        birthPlace: birthPlace,
      );

      if (astrolabeData == null) {
        return HttpResult.error('无法生成星盘数据');
      }

      // 调用后端API
      return await post(
        '/api/astro/natal-chart/analyze/deep',
        data: astrolabeData.toJson(),
      );
    } catch (e) {
      print('深度星盘分析失败: $e');
      return HttpResult.error(e);
    }
  }

  /// 轻度合盘分析
  Future<HttpResult> analyzeSynastryLight({
    required DateTime birthday1,
    required double latitude1,
    required double longitude1,
    required DateTime birthday2,
    required double latitude2,
    required double longitude2,
    String? name1,
    String? name2,
  }) async {
    try {
      // 生成两个人的星盘数据
      final userAData = await _astrolabeManager.generateNatalChart(
        birthLocal: birthday1,
        geoLat: latitude1,
        geoLon: longitude1,
        name: name1,
      );

      final userBData = await _astrolabeManager.generateNatalChart(
        birthLocal: birthday2,
        geoLat: latitude2,
        geoLon: longitude2,
        name: name2,
      );

      if (userAData == null || userBData == null) {
        return HttpResult.error('无法生成星盘数据');
      }

      // 调用后端API
      return await post(
        '/api/astro/synastry/analyze/light',
        data: [userAData.toJson(), userBData.toJson()],
      );
    } catch (e) {
      print('轻度合盘分析失败: $e');
      return HttpResult.error(e);
    }
  }

  /// 深度合盘分析
  Future<HttpResult> analyzeSynastryDeep({
    required DateTime birthday1,
    required double latitude1,
    required double longitude1,
    required DateTime birthday2,
    required double latitude2,
    required double longitude2,
    String? name1,
    String? name2,
  }) async {
    try {
      // 生成两个人的星盘数据
      final userAData = await _astrolabeManager.generateNatalChart(
        birthLocal: birthday1,
        geoLat: latitude1,
        geoLon: longitude1,
        name: name1,
      );

      final userBData = await _astrolabeManager.generateNatalChart(
        birthLocal: birthday2,
        geoLat: latitude2,
        geoLon: longitude2,
        name: name2,
      );

      if (userAData == null || userBData == null) {
        return HttpResult.error('无法生成星盘数据');
      }

      // 调用后端API
      return await post(
        '/api/astro/synastry/analyze/deep',
        data: [userAData.toJson(), userBData.toJson()],
      );
    } catch (e) {
      print('深度合盘分析失败: $e');
      return HttpResult.error(e);
    }
  }
}
