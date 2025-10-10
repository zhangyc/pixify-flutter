# Sweph星盘数据生成器

这个模块允许你使用`sweph`库直接生成星盘绘制所需的数据，而不需要依赖后端接口。

## 核心组件

### 1. SwephToAstrolabeDataConverter

数据转换器，将`sweph`的计算结果转换为星盘绘制组件所需的数据格式。

**主要方法：**

- `convertNatalChart()` - 转换本命盘数据
- `convertSynastryChart()` - 转换合盘数据

### 2. 使用示例

#### 基本用法（推荐）

```dart
import 'package:sona/core/astro/engine/astro_calc.dart';
import 'package:sona/common/widgets/astrolabe/charts/xy_astrolabe_view.dart';

// 一步到位：直接生成星盘绘制数据
final astrolabeData = AstroCalc.generateNatalChartData(
  birthLocal: DateTime(1990, 1, 1, 12, 0),
  geoLat: 39.9042, // 北京纬度
  geoLon: 116.4074, // 北京经度
  timeZoneOffsetHours: 8.0,
  name: '用户姓名',
  sex: '男',
  birthPlace: '北京',
);

// 直接绘制星盘
XYAstrolabeView(
  houses: astrolabeData.houses ?? [],
  planetsInner: astrolabeData.planets ?? [],
  planetsOuter: astrolabeData.planetsOuter ?? [],
  phases: astrolabeData.phase ?? [],
  size: Size(300, 300),
)
```

#### 传统用法（分步进行）

```dart
import 'package:sona/core/astro/engine/astro_calc.dart';
import 'package:sona/common/widgets/astrolabe/utils/sweph_to_astrolabe_converter.dart';
import 'package:sona/common/widgets/astrolabe/charts/xy_astrolabe_view.dart';

// 1. 计算本命盘
final natalChart = AstroCalc.computeNatalChart(
  birthLocal: DateTime(1990, 1, 1, 12, 0),
  geoLat: 39.9042, // 北京纬度
  geoLon: 116.4074, // 北京经度
  timeZoneOffsetHours: 8.0,
);

// 2. 转换为星盘数据
final astrolabeData = SwephToAstrolabeDataConverter.convertNatalChart(
  natalChart: natalChart,
  name: '用户姓名',
  sex: '男',
  birthPlace: '北京',
);

// 3. 绘制星盘
XYAstrolabeView(
  houses: astrolabeData.houses ?? [],
  planetsInner: astrolabeData.planets ?? [],
  planetsOuter: astrolabeData.planetsOuter ?? [],
  phases: astrolabeData.phase ?? [],
  size: Size(300, 300),
)
```

#### 合盘用法（推荐）

```dart
// 一步到位：直接生成合盘绘制数据
final synastryData = AstroCalc.generateSynastryChartData(
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

// 直接绘制合盘
XYAstrolabeView(
  houses: synastryData.houses ?? [],
  planetsInner: synastryData.planetsInner ?? [],
  planetsOuter: synastryData.planetsOuter ?? [],
  phases: synastryData.phase ?? [],
  size: Size(300, 300),
)
```

#### 合盘用法（传统方式）

```dart
// 计算两个人的本命盘
final natalChart1 = AstroCalc.computeNatalChart(/* 第一个人的数据 */);
final natalChart2 = AstroCalc.computeNatalChart(/* 第二个人的数据 */);

// 转换为合盘数据
final synastryData = SwephToAstrolabeDataConverter.convertSynastryChart(
  natalChart1: natalChart1,
  natalChart2: natalChart2,
  name1: '用户A',
  name2: '用户B',
);

// 绘制合盘
XYAstrolabeView(
  houses: synastryData.houses ?? [],
  planetsInner: synastryData.planetsInner ?? [],
  planetsOuter: synastryData.planetsOuter ?? [],
  phases: synastryData.phase ?? [],
  size: Size(300, 300),
)
```

#### 简化组件

```dart
// 使用预制的简化组件
SimpleSwephAstrolabe(
  birthTime: DateTime(1990, 1, 1, 12, 0),
  latitude: 39.9042,
  longitude: 116.4074,
  timeZoneOffset: 8.0,
)
```

## 数据转换说明

### 行星数据转换

- `HeavenlyBody` → `Planets`对象
- 包含：中文名称、星座位置、宫位信息、度数等

### 宫位数据转换

- `houseCusps` → `Houses`对象列表
- 包含：12个宫位的起点位置、所属星座等

### 相位数据转换

- 自动计算行星间的相位关系
- 支持：合相、六合、刑、拱、冲等主要相位
- 包含：容许度、相位类型、颜色等

## 优势

1. **离线计算** - 不依赖网络接口
2. **实时生成** - 可以动态计算任意时间点的星盘
3. **数据一致** - 与现有的星盘绘制系统完全兼容
4. **性能优化** - 本地计算，响应更快

## 注意事项

1. 确保`sweph`库已正确初始化
2. 需要星历文件支持（ephe文件夹）
3. 时区设置要准确
4. 经纬度精度影响计算准确性

## 扩展功能

可以基于这个转换器扩展更多功能：

- 推运盘计算
- 流年盘生成
- 特殊点计算（如北交点、凯龙星等）
- 自定义相位容许度
- 不同宫位制支持
