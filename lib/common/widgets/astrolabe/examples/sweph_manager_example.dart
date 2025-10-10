import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../charts/xy_astrolabe_view.dart';
import '../models/astrolabe_data.dart';
import '../manager/sweph_astrolabe_manager.dart';

/// 使用SwephAstrolabeManager的示例
class SwephManagerExample extends ConsumerStatefulWidget {
  const SwephManagerExample({super.key});

  @override
  ConsumerState<SwephManagerExample> createState() =>
      _SwephManagerExampleState();
}

class _SwephManagerExampleState extends ConsumerState<SwephManagerExample> {
  DateTime _birthTime = DateTime(1990, 1, 1, 12, 0);
  double _latitude = 39.9042; // 北京
  double _longitude = 116.4074;
  double _timeZoneOffset = 8.0;
  String _name = '示例用户';
  String _sex = '男';
  String _birthPlace = '北京';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sweph Manager 示例'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettings,
          ),
        ],
      ),
      body: Column(
        children: [
          // 用户信息卡片
          _buildUserInfoCard(),

          // 星盘类型选择
          _buildChartTypeSelector(),

          // 星盘显示区域
          Expanded(
            child: _buildChartDisplay(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '用户信息',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('姓名: $_name'),
            Text('性别: $_sex'),
            Text('出生地: $_birthPlace'),
            Text('出生时间: ${_formatDateTime(_birthTime)}'),
            Text(
                '经纬度: ${_latitude.toStringAsFixed(4)}, ${_longitude.toStringAsFixed(4)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildChartTypeSelector() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildChartTypeButton('本命盘', 'natal'),
          _buildChartTypeButton('合盘', 'synastry'),
          _buildChartTypeButton('行运盘', 'transit'),
          _buildChartTypeButton('日返盘', 'solar_return'),
          _buildChartTypeButton('月返盘', 'lunar_return'),
        ],
      ),
    );
  }

  Widget _buildChartTypeButton(String title, String type) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: () => _generateChart(type),
        child: Text(title),
      ),
    );
  }

  Widget _buildChartDisplay() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: FutureBuilder<AstrolabeData?>(
        future: _getChartData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('计算错误: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => setState(() {}),
                    child: const Text('重试'),
                  ),
                ],
              ),
            );
          }

          final data = snapshot.data;
          if (data == null) {
            return const Center(
              child: Text('暂无星盘数据，请点击上方按钮生成'),
            );
          }

          return Column(
            children: [
              // 星盘信息
              _buildChartInfo(data),
              const SizedBox(height: 16),

              // 星盘绘制
              Expanded(
                child: Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(150),
                    ),
                    child: XYAstrolabeView(
                      houses: data.houses ?? [],
                      planetsInner: data.planets ?? data.planetsInner ?? [],
                      planetsOuter: data.planetsOuter ?? [],
                      phases: data.phase ?? [],
                      size: const Size(300, 300),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChartInfo(AstrolabeData data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '星盘信息',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (data.info?.name != null) Text('名称: ${data.info!.name}'),
            if (data.info?.sex != null) Text('性别: ${data.info!.sex}'),
            if (data.info?.birthPlace != null)
              Text('出生地: ${data.info!.birthPlace}'),
            if (data.info?.birthday != null) Text('时间: ${data.info!.birthday}'),
            Text(
                '行星数量: ${(data.planets?.length ?? 0) + (data.planetsInner?.length ?? 0)}'),
            Text('相位数量: ${data.phase?.length ?? 0}'),
          ],
        ),
      ),
    );
  }

  Future<AstrolabeData?> _getChartData() async {
    // 这里可以根据需要返回不同类型的数据
    // 为了演示，我们返回本命盘数据
    final manager = ref.read(swephAstrolabeManagerProvider);
    return manager.generateNatalChart(
      birthLocal: _birthTime,
      geoLat: _latitude,
      geoLon: _longitude,
      timeZoneOffsetHours: _timeZoneOffset,
      name: _name,
      sex: _sex,
      birthPlace: _birthPlace,
    );
  }

  void _generateChart(String type) async {
    final manager = ref.read(swephAstrolabeManagerProvider);

    switch (type) {
      case 'natal':
        // 本命盘已在 _getChartData 中处理
        setState(() {});
        break;
      case 'synastry':
        // 生成合盘（使用两个不同的出生时间）
        final synastryData = await manager.generateSynastryChart(
          birthLocal1: _birthTime,
          geoLat1: _latitude,
          geoLon1: _longitude,
          birthLocal2: DateTime(1992, 6, 15, 18, 30),
          geoLat2: 31.2304, // 上海
          geoLon2: 121.4737,
          timeZoneOffsetHours1: _timeZoneOffset,
          timeZoneOffsetHours2: _timeZoneOffset,
          name1: _name,
          name2: '用户B',
        );
        _showChartResult('合盘', synastryData);
        break;
      case 'transit':
        // 生成行运盘
        final transitData = await manager.generateTransitChart(
          birthLocal: _birthTime,
          geoLat: _latitude,
          geoLon: _longitude,
          timeZoneOffsetHours: _timeZoneOffset,
          name: _name,
          sex: _sex,
          birthPlace: _birthPlace,
        );
        _showChartResult('行运盘', transitData);
        break;
      case 'solar_return':
        // 生成日返盘
        final solarReturnData = await manager.generateSolarReturnChart(
          birthLocal: _birthTime,
          geoLat: _latitude,
          geoLon: _longitude,
          timeZoneOffsetHours: _timeZoneOffset,
          name: _name,
          sex: _sex,
          birthPlace: _birthPlace,
        );
        _showChartResult('日返盘', solarReturnData);
        break;
      case 'lunar_return':
        // 生成月返盘
        final lunarReturnData = await manager.generateLunarReturnChart(
          birthLocal: _birthTime,
          geoLat: _latitude,
          geoLon: _longitude,
          timeZoneOffsetHours: _timeZoneOffset,
          name: _name,
          sex: _sex,
          birthPlace: _birthPlace,
        );
        _showChartResult('月返盘', lunarReturnData);
        break;
    }
  }

  void _showChartResult(String title, AstrolabeData? data) {
    if (data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('生成$title失败')),
      );
      return;
    }

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                '行星数量: ${(data.planets?.length ?? 0) + (data.planetsInner?.length ?? 0)}'),
            Text('相位数量: ${data.phase?.length ?? 0}'),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              height: 200,
              child: XYAstrolabeView(
                houses: data.houses ?? [],
                planetsInner: data.planets ?? data.planetsInner ?? [],
                planetsOuter: data.planetsOuter ?? [],
                phases: data.phase ?? [],
                size: const Size(200, 200),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _showSettings() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('设置'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('出生时间'),
              subtitle: Text(_formatDateTime(_birthTime)),
              onTap: () => _selectBirthTime(),
            ),
            ListTile(
              title: const Text('姓名'),
              subtitle: Text(_name),
              onTap: () => _editName(),
            ),
            ListTile(
              title: const Text('出生地'),
              subtitle: Text(_birthPlace),
              onTap: () => _editBirthPlace(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  void _selectBirthTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _birthTime,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_birthTime),
      );

      if (time != null) {
        setState(() {
          _birthTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _editName() {
    showDialog<void>(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: _name);
        return AlertDialog(
          title: const Text('编辑姓名'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: '请输入姓名'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _name = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  void _editBirthPlace() {
    showDialog<void>(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: _birthPlace);
        return AlertDialog(
          title: const Text('编辑出生地'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: '请输入出生地'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _birthPlace = controller.text;
                });
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
