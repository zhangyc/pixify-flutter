import 'package:flutter/material.dart';
import '../../../../core/astro/engine/astro_calc.dart';
import '../charts/xy_astrolabe_view.dart';
import '../models/astrolabe_data.dart';

/// 使用Sweph直接生成星盘数据的示例
class SwephAstrolabeExample extends StatefulWidget {
  const SwephAstrolabeExample({super.key});

  @override
  State<SwephAstrolabeExample> createState() => _SwephAstrolabeExampleState();
}

class _SwephAstrolabeExampleState extends State<SwephAstrolabeExample> {
  AstrolabeData? _astrolabeData;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _generateAstrolabe();
  }

  /// 生成星盘数据
  Future<void> _generateAstrolabe() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // 示例：1990年1月1日 12:00 北京
      final birthTime = DateTime(1990, 1, 1, 12, 0);
      final latitude = 39.9042; // 北京纬度
      final longitude = 116.4074; // 北京经度
      final timeZoneOffset = 8.0; // 北京时间

      // 使用新的便捷方法直接生成星盘绘制数据
      final astrolabeData = AstroCalc.generateNatalChartData(
        birthLocal: birthTime,
        geoLat: latitude,
        geoLon: longitude,
        timeZoneOffsetHours: timeZoneOffset,
        name: '示例用户',
        sex: '男',
        birthPlace: '北京',
      );

      setState(() {
        _astrolabeData = astrolabeData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  /// 生成合盘数据示例
  Future<void> _generateSynastryChart() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // 使用新的便捷方法直接生成合盘绘制数据
      final astrolabeData = AstroCalc.generateSynastryChartData(
        birthLocal1: DateTime(1990, 1, 1, 12, 0),
        geoLat1: 39.9042, // 北京
        geoLon1: 116.4074,
        birthLocal2: DateTime(1992, 6, 15, 18, 30),
        geoLat2: 31.2304, // 上海
        geoLon2: 121.4737,
        timeZoneOffsetHours1: 8.0,
        timeZoneOffsetHours2: 8.0,
        name1: '用户A',
        name2: '用户B',
      );

      setState(() {
        _astrolabeData = astrolabeData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sweph星盘示例'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _generateAstrolabe,
          ),
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: _generateSynastryChart,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('正在计算星盘数据...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('计算错误: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _generateAstrolabe,
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_astrolabeData == null) {
      return const Center(
        child: Text('暂无星盘数据'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 星盘信息
          _buildChartInfo(),
          const SizedBox(height: 16),

          // 星盘绘制
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(150),
            ),
            child: XYAstrolabeView(
              houses: _astrolabeData!.houses ?? [],
              planetsInner: _astrolabeData!.planets ?? [],
              planetsOuter: _astrolabeData!.planetsOuter ?? [],
              phases: _astrolabeData!.phase ?? [],
              size: const Size(300, 300),
            ),
          ),
          const SizedBox(height: 16),

          // 行星列表
          _buildPlanetsList(),
          const SizedBox(height: 16),

          // 相位列表
          _buildPhasesList(),
        ],
      ),
    );
  }

  Widget _buildChartInfo() {
    final info = _astrolabeData!.info;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '星盘信息',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (info?.name != null) Text('姓名: ${info!.name}'),
            if (info?.sex != null) Text('性别: ${info!.sex}'),
            if (info?.birthPlace != null) Text('出生地: ${info!.birthPlace}'),
            if (info?.birthday != null) Text('出生时间: ${info!.birthday}'),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanetsList() {
    final planets = _astrolabeData!.planets ?? [];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '行星位置',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...planets.map((Planets planet) => ListTile(
                  title: Text(planet.planetCn ?? ''),
                  subtitle: Text(
                    '${planet.constellationCn} ${planet.deg}°${planet.min}′${planet.sec}″',
                  ),
                  trailing: planet.placeOn != null
                      ? Text('第${planet.placeOn}宫')
                      : null,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildPhasesList() {
    final phases = _astrolabeData!.phase ?? [];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '主要相位',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...phases.take(10).map((Phase phase) => ListTile(
                  title: Text(
                    '${phase.planetName1} ${phase.aspectName} ${phase.planetName2}',
                  ),
                  subtitle: Text('容许度: ${phase.orb}°'),
                  leading: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(int.parse(
                          phase.bgColor?.replaceAll('#', '0xFF') ??
                              '0xFF2421BD')),
                      shape: BoxShape.circle,
                    ),
                  ),
                )),
            if (phases.length > 10) Text('... 还有${phases.length - 10}个相位'),
          ],
        ),
      ),
    );
  }
}

/// 简化的使用示例
class SimpleSwephAstrolabe extends StatelessWidget {
  final DateTime birthTime;
  final double latitude;
  final double longitude;
  final double timeZoneOffset;

  const SimpleSwephAstrolabe({
    super.key,
    required this.birthTime,
    required this.latitude,
    required this.longitude,
    this.timeZoneOffset = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AstrolabeData>(
      future: _generateAstrolabeData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('错误: ${snapshot.error}'),
          );
        }

        final data = snapshot.data;
        if (data == null) {
          return const Center(child: Text('无数据'));
        }

        return XYAstrolabeView(
          houses: data.houses ?? [],
          planetsInner: data.planets ?? [],
          planetsOuter: data.planetsOuter ?? [],
          phases: data.phase ?? [],
          size: const Size(300, 300),
        );
      },
    );
  }

  Future<AstrolabeData> _generateAstrolabeData() async {
    // 使用新的便捷方法直接生成星盘数据
    return AstroCalc.generateNatalChartData(
      birthLocal: birthTime,
      geoLat: latitude,
      geoLon: longitude,
      timeZoneOffsetHours: timeZoneOffset,
    );
  }
}
