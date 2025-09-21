import 'package:sona/account/models/gender.dart';
import 'package:sona/core/match/util/http_util.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../utils/global/global.dart';
import '../models/astro_score.dart';
import '../models/discover_user.dart';

class DiscoverService {
  /// 获取天选用户列表（少量精挑）
  static Future<List<DiscoverUser>> getDestinyUsers({
    int page = 1,
    int pageSize = 10, // 天选用户数量较少
  }) async {
    try {
      // 获取用户位置信息
      final longitude = profile?.position?.longitude;
      final latitude = profile?.position?.latitude;

      final resp = await post('/user/match-v2', data: {
        'gender': null, // 天选不限制性别
        'minAge': 18,
        'maxAge': 50,
        'longitude': longitude,
        'latitude': latitude,
        'page': page,
        'pageSize': pageSize,
        'recommendMode': 'destiny', // 天选模式
      });

      if (resp.isSuccess) {
        List list = resp.data;
        return list.map((e) => DiscoverUser.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load destiny users: ${resp.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// 获取附近用户列表（实时供给）
  static Future<List<DiscoverUser>> getNearbyUsers({
    WidgetRef? ref,
    int page = 1,
    int pageSize = 30,
    int? gender,
    int? minAge,
    int? maxAge,
  }) async {
    try {
      // 获取用户位置信息
      final profile = ref?.read(myProfileProvider);
      final longitude = profile?.position?.longitude;
      final latitude = profile?.position?.latitude;

      final resp = await post('/user/match-v2', data: {
        'gender': gender,
        'minAge': minAge ?? 18,
        'maxAge': maxAge ?? 50,
        'longitude': longitude,
        'latitude': latitude,
        'page': page,
        'pageSize': pageSize,
        'recommendMode': 'nearby', // 附近模式
      });

      if (resp.isSuccess) {
        List list = resp.data;
        return list.map((e) => DiscoverUser.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load nearby users: ${resp.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// 发送喜欢
  static Future<bool> likeUser(int userId) async {
    try {
      final resp = await post('/user/like', data: {'userId': userId});
      return resp.isSuccess;
    } catch (e) {
      return false;
    }
  }

  /// 跳过用户
  static Future<bool> skipUser(int userId) async {
    try {
      final resp = await post('/user/skip', data: {'userId': userId});
      return resp.isSuccess;
    } catch (e) {
      return false;
    }
  }

  /// 发送消息解锁相册
  static Future<bool> sendMessageToUnlock(int userId, String message) async {
    try {
      final resp = await post('/chat/send', data: {
        'targetUserId': userId,
        'message': message,
        'type': 'unlock_photos',
      });
      return resp.isSuccess;
    } catch (e) {
      return false;
    }
  }

  /// 获取轻报告详情
  static Future<AstroLightReport> getLightReport(int userId) async {
    try {
      final resp = await post('/astro/light-report', data: {'userId': userId});

      if (resp.isSuccess) {
        final data = resp.data;
        return AstroLightReport(
          insights: (data['insights'] as List<dynamic>?)?.cast<String>() ?? [],
          todayTopics:
              (data['todayTopics'] as List<dynamic>?)?.cast<String>() ?? [],
          openers: (data['openers'] as List<dynamic>?)?.cast<String>() ?? [],
        );
      } else {
        throw Exception('Failed to load light report');
      }
    } catch (e) {
      // 降级到默认内容
      return AstroLightReport(
        insights: [
          '你们在创意和艺术方面天然投缘',
          '沟通节奏相近，适合深度交流',
          '价值观契合度很高，容易产生共鸣',
        ],
        todayTopics: ['最近想去的城市', '这周最想做的一件事', '最喜欢的电影类型'],
        openers: [
          '看到你写的兴趣，我也正好对这个很感兴趣...',
          '如果周末只选一个好去处，你会选哪里？',
          '第一眼你给我的感觉很特别，像是...',
        ],
      );
    }
  }

  /// 计算年龄
  static int _calculateAge(String? birthday) {
    if (birthday == null) return 25; // 默认年龄

    try {
      final birthDate = DateTime.parse(birthday);
      final now = DateTime.now();
      int age = now.year - birthDate.year;
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 25; // 解析失败时的默认年龄
    }
  }

  /// 判断是否为高质量用户（A档）
  static bool _isHighQualityUser(Map<String, dynamic> userData) {
    // 根据用户数据判断是否为A档用户
    final hasPhotos =
        (userData['images'] as List<dynamic>?)?.isNotEmpty ?? false;
    final hasBio = userData['description'] != null &&
        userData['description'].toString().isNotEmpty;
    final isOnline = userData['isOnline'] ?? false;
    final distance = userData['distance']?.toDouble() ?? 999.0;

    // A档标准：有照片 + 有简介 + 在线 + 距离近
    return hasPhotos && hasBio && isOnline && distance < 5.0;
  }

  /// 计算星盘合盘分数
  static Future<AstroScore> _calculateAstroScore(int userId) async {
    try {
      final resp =
          await post('/astro/synastry', data: {'targetUserId': userId});

      if (resp.isSuccess) {
        final data = resp.data;
        return AstroScore(
          fate: data['fate'] ?? 60,
          harmony: data['harmony'] ?? 60,
          risk: data['risk'] ?? 40,
          tags: (data['tags'] as List<dynamic>?)?.cast<String>() ?? [],
          prompts: (data['prompts'] as List<dynamic>?)?.cast<String>() ?? [],
          version: data['version'] ?? '1.0.0',
        );
      } else {
        // API失败时生成基于用户ID的一致分数
        return _generateFallbackScore(userId);
      }
    } catch (e) {
      // 网络错误时生成基于用户ID的一致分数
      return _generateFallbackScore(userId);
    }
  }

  /// 生成降级的星盘分数（基于用户ID保持一致性）
  static AstroScore _generateFallbackScore(int userId) {
    final random = userId * 37; // 使用用户ID生成一致的随机数

    return AstroScore(
      fate: 60 + (random % 40), // 60-99
      harmony: 50 + (random * 7 % 50), // 50-99
      risk: 10 + (random * 11 % 40), // 10-49
      tags: ['天然投缘', '节奏相近', '需要磨合'],
      prompts: ['最近想去的地方', '这周最想做的事', '最喜欢的美食'],
      version: '1.0.0',
    );
  }
}

// 轻报告数据模型
class AstroLightReport {
  final List<String> insights; // 3-5条洞察
  final List<String> todayTopics; // 今日宜聊话题
  final List<String> openers; // 开场白建议

  AstroLightReport({
    required this.insights,
    required this.todayTopics,
    required this.openers,
  });
}
