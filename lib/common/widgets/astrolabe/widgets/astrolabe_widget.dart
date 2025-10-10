import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../charts/astrolabe_view.dart';
import '../manager/sweph_astrolabe_manager.dart';
import '../models/astrolabe_data.dart';

/// 基于Sweph的星盘Widget
/// 替代原有的网络请求方式，使用本地计算生成星盘数据
class AstrolabeWidget extends ConsumerStatefulWidget {
  final DateTime birthLocal;
  final double geoLat;
  final double geoLon;
  final double timeZoneOffsetHours;
  final double width;
  final String? name;
  final String? sex;
  final String? birthPlace;
  final AstrolabeChartType chartType;

  const AstrolabeWidget({
    super.key,
    required this.birthLocal,
    required this.geoLat,
    required this.geoLon,
    this.timeZoneOffsetHours = 0.0,
    required this.width,
    this.name,
    this.sex,
    this.birthPlace,
    this.chartType = AstrolabeChartType.natal,
  });

  @override
  ConsumerState<AstrolabeWidget> createState() => _AstrolabeWidgetState();
}

class _AstrolabeWidgetState extends ConsumerState<AstrolabeWidget> {
  @override
  Widget build(BuildContext context) {
    final size = Size(widget.width, widget.width);
    final manager = ref.read(swephAstrolabeManagerProvider);

    return FutureBuilder<AstrolabeData?>(
      future: _generateChartData(manager),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: widget.width,
            height: widget.width,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Container(
            width: widget.width,
            height: widget.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red),
                  const SizedBox(height: 8),
                  Text(
                    '生成星盘失败',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        }

        final data = snapshot.data;
        if (data == null) {
          return Container(
            width: widget.width,
            height: widget.width,
            child: const Center(
              child: Text('无数据'),
            ),
          );
        }

        return AstrolabeView(
          size: size,
          houses: data.houses ?? [],
          planets: data.planets ?? data.planetsInner ?? [],
          phases: data.phase ?? [],
        );
      },
    );
  }

  Future<AstrolabeData?> _generateChartData(
      SwephAstrolabeManager manager) async {
    switch (widget.chartType) {
      case AstrolabeChartType.natal:
        return manager.generateNatalChart(
          birthLocal: widget.birthLocal,
          geoLat: widget.geoLat,
          geoLon: widget.geoLon,
          timeZoneOffsetHours: widget.timeZoneOffsetHours,
          name: widget.name,
          sex: widget.sex,
          birthPlace: widget.birthPlace,
        );
      case AstrolabeChartType.transit:
        return manager.generateTransitChart(
          birthLocal: widget.birthLocal,
          geoLat: widget.geoLat,
          geoLon: widget.geoLon,
          timeZoneOffsetHours: widget.timeZoneOffsetHours,
          name: widget.name,
          sex: widget.sex,
          birthPlace: widget.birthPlace,
        );
      case AstrolabeChartType.solarReturn:
        return manager.generateSolarReturnChart(
          birthLocal: widget.birthLocal,
          geoLat: widget.geoLat,
          geoLon: widget.geoLon,
          timeZoneOffsetHours: widget.timeZoneOffsetHours,
          name: widget.name,
          sex: widget.sex,
          birthPlace: widget.birthPlace,
        );
      case AstrolabeChartType.lunarReturn:
        return manager.generateLunarReturnChart(
          birthLocal: widget.birthLocal,
          geoLat: widget.geoLat,
          geoLon: widget.geoLon,
          timeZoneOffsetHours: widget.timeZoneOffsetHours,
          name: widget.name,
          sex: widget.sex,
          birthPlace: widget.birthPlace,
        );
    }
  }
}

/// 星盘类型枚举
enum AstrolabeChartType {
  natal, // 本命盘
  transit, // 行运盘
  solarReturn, // 日返盘
  lunarReturn, // 月返盘
}
