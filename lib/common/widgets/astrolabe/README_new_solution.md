# 新的Sweph星盘解决方案

## 概述

我们已经成功创建了一个基于`sweph`库的完整星盘解决方案，完全替代了原有的网络请求方式。新方案具有以下优势：

- ✅ **离线计算** - 不依赖网络接口
- ✅ **实时生成** - 可以动态计算任意时间点的星盘
- ✅ **数据一致** - 与现有的星盘绘制系统完全兼容
- ✅ **性能优化** - 本地计算，响应更快
- ✅ **功能完整** - 支持本命盘、合盘、行运盘、日返盘、月返盘等

## 核心组件

### 1. AstroCalc 增强
**文件**: `lib/core/astro/engine/astro_calc.dart`

新增了两个便捷方法：
- `generateNatalChartData()` - 直接生成本命盘绘制数据
- `generateSynastryChartData()` - 直接生成合盘绘制数据

### 2. SwephToAstrolabeDataConverter
**文件**: `lib/common/widgets/astrolabe/utils/sweph_to_astrolabe_converter.dart`

数据转换器，将`sweph`的计算结果转换为星盘绘制组件所需的数据格式。

### 3. SwephAstrolabeManager
**文件**: `lib/common/widgets/astrolabe/manager/sweph_astrolabe_manager.dart`

新的管理器，提供完整的星盘数据生成功能：
- 本命盘生成
- 合盘生成
- 行运盘生成
- 日返盘生成
- 月返盘生成

### 4. Riverpod Providers
内置的Riverpod提供者，支持响应式数据管理：
- `swephAstrolabeManagerProvider`
- `natalChartProvider`
- `synastryChartProvider`
- `transitChartProvider`

## 使用方式

### 方式一：直接使用AstroCalc（最简单）

```dart
import 'package:sona/core/astro/engine/astro_calc.dart';
import 'package:sona/common/widgets/astrolabe/charts/xy_astrolabe_view.dart';

// 生成本命盘数据
final astrolabeData = AstroCalc.generateNatalChartData(
  birthLocal: DateTime(1990, 1, 1, 12, 0),
  geoLat: 39.9042,
  geoLon: 116.4074,
  timeZoneOffsetHours: 8.0,
  name: '用户姓名',
  sex: '男',
  birthPlace: '北京',
);

// 直接绘制
XYAstrolabeView(
  houses: astrolabeData.houses ?? [],
  planetsInner: astrolabeData.planets ?? [],
  phases: astrolabeData.phase ?? [],
  size: Size(300, 300),
)
```

### 方式二：使用SwephAstrolabeManager（功能完整）

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sona/common/widgets/astrolabe/manager/sweph_astrolabe_manager.dart';

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final manager = ref.read(swephAstrolabeManagerProvider);
    
    return FutureBuilder<AstrolabeData?>(
      future: manager.generateNatalChart(
        birthLocal: DateTime(1990, 1, 1, 12, 0),
        geoLat: 39.9042,
        geoLon: 116.4074,
        timeZoneOffsetHours: 8.0,
        name: '用户姓名',
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return XYAstrolabeView(
            houses: snapshot.data!.houses ?? [],
            planetsInner: snapshot.data!.planets ?? [],
            phases: snapshot.data!.phase ?? [],
            size: Size(300, 300),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
```

### 方式三：使用Riverpod Providers（响应式）

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final natalChartAsync = ref.watch(natalChartProvider({
      'birthLocal': DateTime(1990, 1, 1, 12, 0),
      'geoLat': 39.9042,
      'geoLon': 116.4074,
      'timeZoneOffsetHours': 8.0,
      'name': '用户姓名',
    }));

    return natalChartAsync.when(
      data: (data) => XYAstrolabeView(
        houses: data?.houses ?? [],
        planetsInner: data?.planets ?? [],
        phases: data?.phase ?? [],
        size: Size(300, 300),
      ),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('错误: $error'),
    );
  }
}
```

## 示例应用

### 1. SwephAstrolabeExample
**文件**: `lib/common/widgets/astrolabe/examples/sweph_astrolabe_example.dart`

基础的星盘生成示例，展示如何使用AstroCalc直接生成数据。

### 2. SwephManagerExample
**文件**: `lib/common/widgets/astrolabe/examples/sweph_manager_example.dart`

完整的管理器示例，包含：
- 用户信息设置
- 多种星盘类型生成
- 交互式界面
- 错误处理

## 迁移指南

### 从旧方案迁移

1. **替换数据获取方式**：
   ```dart
   // 旧方式
   final data = await AstrolabeDataManager().getAstrolabeData(
     archivesId: 'xxx',
     astrolabeType: AstrolabeDataType.ASTROLABE,
     paramType: AstrolabeParamType.MODERN,
   );
   
   // 新方式
   final data = AstroCalc.generateNatalChartData(
     birthLocal: DateTime(1990, 1, 1, 12, 0),
     geoLat: 39.9042,
     geoLon: 116.4074,
   );
   ```

2. **更新导入**：
   ```dart
   // 移除旧的导入
   // 旧的网络请求方式已删除，现在使用Sweph本地计算
   
   // 添加新的导入
   import 'package:sona/core/astro/engine/astro_calc.dart';
   ```

3. **数据格式兼容**：
   新方案生成的数据格式与原有系统完全兼容，无需修改绘制组件。

## 注意事项

1. **sweph初始化**：确保在应用启动时正确初始化sweph库
2. **星历文件**：需要确保ephe文件夹中的星历文件完整
3. **时区设置**：时区设置要准确，影响计算精度
4. **经纬度精度**：经纬度精度影响计算准确性

## 扩展功能

基于这个新方案，可以轻松扩展更多功能：

- 推运盘计算
- 流年盘生成
- 特殊点计算（如北交点、凯龙星等）
- 自定义相位容许度
- 不同宫位制支持
- 批量星盘计算
- 星盘数据缓存

## 总结

新的Sweph方案完全解决了原有网络请求方式的局限性，提供了更强大、更灵活的星盘计算能力。通过本地计算，我们可以实现：

- 更快的响应速度
- 更好的用户体验
- 更强的功能扩展性
- 更低的服务器成本

这个方案为星盘应用的发展奠定了坚实的技术基础。
