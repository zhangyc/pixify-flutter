import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../enums/astrolabe_enums.dart';

class AstrolabeUtils {
  static const List<String> starText = [
    "白羊",
    "金牛",
    "双子",
    "巨蟹",
    "狮子",
    "处女",
    "天秤",
    "天蝎",
    "射手",
    "摩羯",
    "水瓶",
    "双鱼",
  ];

  static Color getPlanetColorByName(String planetName) {
    const colors = {
      "太阳": Color(0xFFDC514C),
      "月亮": Color(0xFFE4A54A),
      "水星": Color(0xFF45CA5D),
      "金星": Color(0xFF1B809E),
      "火星": Color(0xFFDC514C),
      "木星": Color(0xFFE4A54A),
      "土星": Color(0xFF45CA5D),
      "天王": Color(0xFF1B809E),
      "海王": Color(0xFFDC514C),
      "冥王": Color(0xFFE4A54A),
    };
    return colors[planetName] ?? const Color(0xFF333C5D);
  }

  static Color getStarColorByName(String starName) {
    const colors = {
      "白羊": Color(0xFFDC514C),
      "金牛": Color(0xFFE4A54A),
      "双子": Color(0xFF45CA5D),
      "巨蟹": Color(0xFF1B809E),
      "狮子": Color(0xFFDC514C),
      "处女": Color(0xFFE4A54A),
      "天秤": Color(0xFF45CA5D),
      "天蝎": Color(0xFF1B809E),
      "射手": Color(0xFFDC514C),
      "摩羯": Color(0xFFE4A54A),
      "水瓶": Color(0xFF45CA5D),
      "双鱼": Color(0xFF1B809E),
    };
    return colors[starName] ?? const Color(0xFF333C5D);
  }

  static Color getPhaseColorByName(String phaseName) {
    const colors = {
      "合": Color(0xFF734406), // Java: #734406
      "半合": Color(0xFF2421BD), // Java: #2421bd
      "六合": Color(0xFF2421BD), // Java: #2421bd
      "刑": Color(0xFFC83D26), // Java: #c83d26
      "拱": Color(0xFF52BB9F), // Java: #52bb9f
      "冲": Color(0xFF5435DA), // Java: #5435da
      "十二分": Color(0xFFD69328), // Java: #d69328
      "八分": Color(0xFFDD931F), // Java: #dd931f
      "五分": Color(0xFFDDBC1F), // Java: #ddbc1f
      "补八分": Color(0xFFE9C417), // Java: #e9c417
      "倍五分": Color(0xFF2F6B2C), // Java: #2f6b2c
      "梅花": Color(0xFF2E996B), // Java: #2e996b
    };
    return colors[phaseName] ?? const Color(0xFF2421BD); // Java默认: #2421bd
  }

  static double getAngle(int deg, int min, int sec) {
    return deg + min / 60.0 + sec / 3600.0;
  }

  static Offset getPointByAngle(double angle, double radius) {
    final radian = angle * pi / 180;
    return Offset(radius * cos(radian), radius * sin(radian));
  }

  static String changeStr(String planetName) {
    const map = {
      "太阳": "日",
      "月亮": "月",
      "水星": "水",
      "金星": "金",
      "火星": "火",
      "木星": "木",
      "土星": "土",
      "天王": "天",
      "海王": "海",
      "冥王": "冥",
    };
    return map[planetName] ?? planetName;
  }

  static String easyText(String starName) {
    return starName;
  }

  // 星座图片缓存
  static final Map<String, ui.Image?> _starImageCache = {};

  // 获取星座图片
  static Future<ui.Image?> getStarImage(String starName) async {
    if (_starImageCache.containsKey(starName)) {
      return _starImageCache[starName];
    }

    final assetName = _getStarImageAssetName(starName);
    if (assetName == null) return null;

    try {
      final data = await rootBundle.load(assetName);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      _starImageCache[starName] = frame.image;
      return frame.image;
    } catch (e) {
      print('Error loading star image: $e');
      return null;
    }
  }

  // 获取星座图片资源名称
  static String? _getStarImageAssetName(String starName) {
    final map = {
      "白羊": "assets/astrolabe/aries.png",
      "金牛": "assets/astrolabe/taurus.png",
      "双子": "assets/astrolabe/gemini.png",
      "巨蟹": "assets/astrolabe/cancer.png",
      "狮子": "assets/astrolabe/leo.png",
      "处女": "assets/astrolabe/virgo.png",
      "天秤": "assets/astrolabe/libra.png",
      "天蝎": "assets/astrolabe/scorpio.png",
      "射手": "assets/astrolabe/sagittarius.png",
      "摩羯": "assets/astrolabe/capricorn.png",
      "水瓶": "assets/astrolabe/aquarius.png",
      "双鱼": "assets/astrolabe/pisces.png",
    };
    return map[starName];
  }

  static Map<String, Color> getColorsByType(AstrolabeColorType colorType) {
    switch (colorType) {
      case AstrolabeColorType.ASTRO_NIGHT_SKY:
        return {
          'circle1': const Color(0xFF121C4E),
          'circle2': const Color(0xFF314876),
          'circle3': const Color(0xFF141D54),
          'circle4': const Color(0xFF1A2E5F),
          'starScale': const Color(0xFF1B809E),
          'houseLine': const Color(0xFF84BE6B),
          'innerHouseLine': const Color(0xFF283C80),
        };
      case AstrolabeColorType.ASTRO_DEEP_BLUE:
        // Define colors for DEEP_BLUE
        return {};
      case AstrolabeColorType.ASTRO_LIGHT_BLUE:
        // Define colors for LIGHT_BLUE
        return {};
      case AstrolabeColorType.ASTRO_PINK:
        // Define colors for PINK
        return {};
      case AstrolabeColorType.ASTRO_BLUE_WHITE:
        // Define colors for BLUE_WHITE
        return {};
      case AstrolabeColorType.ASTRO_GRAY:
        // Define colors for GRAY
        return {};
      default:
        return {};
    }
  }
}
