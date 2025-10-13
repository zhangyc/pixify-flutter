// lib/core/match/widgets/components/match_astro_tab.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/astro/widgets/astro_preview.dart';
import 'package:sona/generated/l10n.dart';
import 'package:sona/core/match/widgets/components/match_ai_analysis_buttons.dart';
import 'package:sona/core/astro/engine/astro_calc.dart';
import 'package:sweph/sweph.dart';

class MatchAstroTab extends StatefulWidget {
  final MatchUserInfo user;
  final bool isLightAnalyzing;
  final bool isDeepAnalyzing;
  final VoidCallback? onLightAnalysis;
  final VoidCallback? onDeepAnalysis;

  const MatchAstroTab({
    super.key,
    required this.user,
    required this.isLightAnalyzing,
    required this.isDeepAnalyzing,
    this.onLightAnalysis,
    this.onDeepAnalysis,
  });

  @override
  State<MatchAstroTab> createState() => _MatchAstroTabState();
}

class _MatchAstroTabState extends State<MatchAstroTab> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    /// 检查是否有足够的信息来绘制星盘
    final hasEnoughInfo = widget.user.birthday != null &&
        (widget.user.birthCity != null ||
            widget.user.birthLatitude != null ||
            widget.user.birthLongitude != null);

    if (!hasEnoughInfo) {
      // 显示信息不完整的提示
      return _buildIncompleteInfoPrompt(theme);
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1A1A22),
            const Color(0xFF12121B),
            const Color(0xFF0E0E14),
          ],
        ),
      ),
      child: Column(
        children: [
          // 星盘预览区域
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.width * 0.65,
              child: RepaintBoundary(
                child: AstroPreview(
                  birthday: widget.user.birthday,
                  birthLatitude:
                      double.tryParse(widget.user.birthLatitude ?? '39.9042') ??
                          39.9042,
                  birthLongitude: double.tryParse(
                          widget.user.birthLongitude ?? '116.4074') ??
                      116.4074,
                  birthTime: null,
                  isBackground: false,
                  showBorder: false, // 去掉边框
                ),
              ),
            ),
          ),

          // 雷达图和星盘信息区域
          Container(
            height: 260,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // 雷达图和星盘信息并排
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 120),
                            child: _buildAstroInfo(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 120),
                            child: _buildCompatibilityRadar(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // AI分析按钮
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: MatchAiAnalysisButtons(
                      isLightAnalyzing: widget.isLightAnalyzing,
                      isDeepAnalyzing: widget.isDeepAnalyzing,
                      onLightAnalysis: widget.onLightAnalysis,
                      onDeepAnalysis: widget.onDeepAnalysis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 星盘信息显示
  Widget _buildAstroInfo() {
    final theme = Theme.of(context);

    // 只有当有足够信息时才显示
    if (widget.user.birthday == null) {
      return const SizedBox.shrink();
    }

    // 简化的星盘信息显示
    final sunSign = S.current.leoSign; // 这里应该从实际星盘数据计算
    final ascendantSign = S.current.libraSign; // 这里应该从实际星盘数据计算
    final locationText = widget.user.birthCity ?? S.current.unknownLocation;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem(
                theme,
                S.of(context).sunSignLabel,
                sunSign,
                Icons.wb_sunny,
              ),
              _buildInfoItem(
                theme,
                S.of(context).ascendantSignLabel,
                ascendantSign,
                Icons.trending_up,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem(
                theme,
                S.of(context).birthPlaceLabel,
                locationText,
                Icons.location_on,
              ),
              _buildInfoItem(
                theme,
                S.of(context).birthTimeLabel,
                S.of(context).defaultBirthTime,
                Icons.access_time,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
      ThemeData theme, String label, String value, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: theme.primaryColor,
          size: 14,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.hintColor,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // 信息不完整的提示
  Widget _buildIncompleteInfoPrompt(ThemeData theme) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1A1A22),
            const Color(0xFF12121B),
            const Color(0xFF0E0E14),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 星盘图标 - 灰色表示不可用
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withOpacity(0.2),
                  blurRadius: 20,
                  offset: Offset.zero,
                ),
              ],
            ),
            child: Icon(
              Icons.auto_awesome,
              size: 64,
              color: theme.hintColor.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 16),

          // 标题
          Text(
            S.current.infoIncompleteTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.hintColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          // 说明文字
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              S.current.astroInfoIncompleteMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor.withOpacity(0.7),
                fontSize: 16,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // 计算真实的契合度分数
  CompatibilityData _calculateCompatibilityScores() {
    try {
      // 获取匹配用户的星盘数据
      final matchUserChart = _getUserNatalChart(widget.user);

      // TODO: 这里需要获取当前用户的数据
      // 暂时使用示例数据作为当前用户
      final currentUserBirthday = DateTime(1990, 6, 15, 14, 30); // 示例生日
      final currentUserLat = 39.9042; // 北京纬度
      final currentUserLon = 116.4074; // 北京经度

      final currentUserChart = AstroCalc.computeNatalChart(
        birthLocal: currentUserBirthday,
        geoLat: currentUserLat,
        geoLon: currentUserLon,
      );

      // 计算合盘相位
      final synastryData = AstroCalc.computeSynastry(
        chartA: currentUserChart,
        chartB: matchUserChart,
      );

      // 基于相位关系计算各维度分数
      final scores = <double>[];

      // 情感契合度 (金星-月亮, 金星-金星, 月亮-月亮相位)
      scores.add(_calculateEmotionalCompatibility(synastryData));

      // 智力默契度 (水星-木星, 水星-水星相位)
      scores.add(_calculateIntellectualCompatibility(synastryData));

      // 生活节奏匹配 (火星-土星, 火星-火星相位)
      scores.add(_calculateLifestyleCompatibility(synastryData));

      // 价值观一致性 (木星-土星, 木星-木星相位)
      scores.add(_calculateValuesCompatibility(synastryData));

      // 沟通和谐度 (水星-月亮相位)
      scores.add(_calculateCommunicationCompatibility(synastryData));

      // 未来发展潜力 (太阳-木星, 太阳-太阳相位)
      scores.add(_calculateFutureCompatibility(synastryData));

      // 计算总体分数 (加权平均)
      final overallScore = scores.reduce((a, b) => a + b) / scores.length;

      return CompatibilityData(
        scores: scores,
        overallScore: overallScore,
      );
    } catch (e) {
      // 如果计算失败，返回默认分数
      return CompatibilityData(
        scores: [0.5, 0.5, 0.5, 0.5, 0.5, 0.5],
        overallScore: 0.5,
      );
    }
  }

  // 获取用户的本命盘数据
  NatalChartData _getUserNatalChart(MatchUserInfo user) {
    final birthday = user.birthday;
    final latitude = user.birthLatitude != null
        ? double.tryParse(user.birthLatitude!)
        : 39.9042;
    final longitude = user.birthLongitude != null
        ? double.tryParse(user.birthLongitude!)
        : 116.4074;

    if (birthday == null) {
      throw Exception(S.current.incompleteBirthdayInfo);
    }

    return AstroCalc.computeNatalChart(
      birthLocal: birthday,
      geoLat: latitude ?? 39.9042,
      geoLon: longitude ?? 116.4074,
    );
  }

  // 情感契合度计算 (基于金星-月亮, 金星-金星, 月亮-月亮相位)
  double _calculateEmotionalCompatibility(SynastryData synastryData) {
    double score = 0.5; // 基础分数
    int relevantAspects = 0;

    // 情感相关的相位：金星(Venus)和月亮(Moon)
    for (final aspect in synastryData.aspects) {
      bool isEmotionalAspect = false;
      double aspectScore = 0.0;

      // 金星-月亮相位 (最重要)
      if ((aspect.bodyA == HeavenlyBody.SE_VENUS &&
              aspect.bodyB == HeavenlyBody.SE_MOON) ||
          (aspect.bodyA == HeavenlyBody.SE_MOON &&
              aspect.bodyB == HeavenlyBody.SE_VENUS)) {
        isEmotionalAspect = true;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.9;
            break; // 三分相：和谐
          case AspectType.sextile:
            aspectScore = 0.8;
            break; // 六分相：良好
          case AspectType.conjunction:
            aspectScore = 0.85;
            break; // 合相：强烈
          case AspectType.square:
            aspectScore = 0.4;
            break; // 四分相：挑战
          case AspectType.opposition:
            aspectScore = 0.6;
            break; // 对分相：复杂
        }
      }

      // 金星-金星相位
      else if (aspect.bodyA == HeavenlyBody.SE_VENUS &&
          aspect.bodyB == HeavenlyBody.SE_VENUS) {
        isEmotionalAspect = true;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.85;
            break;
          case AspectType.sextile:
            aspectScore = 0.8;
            break;
          case AspectType.conjunction:
            aspectScore = 0.9;
            break;
          case AspectType.square:
            aspectScore = 0.5;
            break;
          case AspectType.opposition:
            aspectScore = 0.7;
            break;
        }
      }

      // 月亮-月亮相位
      else if (aspect.bodyA == HeavenlyBody.SE_MOON &&
          aspect.bodyB == HeavenlyBody.SE_MOON) {
        isEmotionalAspect = true;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.8;
            break;
          case AspectType.sextile:
            aspectScore = 0.75;
            break;
          case AspectType.conjunction:
            aspectScore = 0.85;
            break;
          case AspectType.square:
            aspectScore = 0.45;
            break;
          case AspectType.opposition:
            aspectScore = 0.65;
            break;
        }
      }

      if (isEmotionalAspect) {
        // 根据相位准确度调整分数 (orb越小分数越高)
        final orbFactor = (1.0 - aspect.orb / 8.0).clamp(0.0, 1.0); // 8度为最大容许误差
        score = (score + aspectScore * orbFactor) / 2.0;
        relevantAspects++;
      }
    }

    // 如果没有相关相位，返回基础分数；否则返回计算的分数
    return relevantAspects > 0 ? score : 0.5;
  }

  // 智力默契度计算 (基于水星-木星, 水星-水星, 水星-土星相位)
  double _calculateIntellectualCompatibility(SynastryData synastryData) {
    double score = 0.5;
    int relevantAspects = 0;

    for (final aspect in synastryData.aspects) {
      bool isIntellectualAspect = false;
      double aspectScore = 0.0;

      // 水星-木星相位 (思维扩展)
      if ((aspect.bodyA == HeavenlyBody.SE_MERCURY &&
              aspect.bodyB == HeavenlyBody.SE_JUPITER) ||
          (aspect.bodyA == HeavenlyBody.SE_JUPITER &&
              aspect.bodyB == HeavenlyBody.SE_MERCURY)) {
        isIntellectualAspect = true;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.9;
            break;
          case AspectType.sextile:
            aspectScore = 0.85;
            break;
          case AspectType.conjunction:
            aspectScore = 0.8;
            break;
          case AspectType.square:
            aspectScore = 0.5;
            break;
          case AspectType.opposition:
            aspectScore = 0.7;
            break;
        }
      }

      // 水星-水星相位 (沟通默契)
      else if (aspect.bodyA == HeavenlyBody.SE_MERCURY &&
          aspect.bodyB == HeavenlyBody.SE_MERCURY) {
        isIntellectualAspect = true;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.85;
            break;
          case AspectType.sextile:
            aspectScore = 0.8;
            break;
          case AspectType.conjunction:
            aspectScore = 0.9;
            break;
          case AspectType.square:
            aspectScore = 0.55;
            break;
          case AspectType.opposition:
            aspectScore = 0.75;
            break;
        }
      }

      // 水星-土星相位 (思维深度)
      else if ((aspect.bodyA == HeavenlyBody.SE_MERCURY &&
              aspect.bodyB == HeavenlyBody.SE_SATURN) ||
          (aspect.bodyA == HeavenlyBody.SE_SATURN &&
              aspect.bodyB == HeavenlyBody.SE_MERCURY)) {
        isIntellectualAspect = true;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.8;
            break;
          case AspectType.sextile:
            aspectScore = 0.75;
            break;
          case AspectType.conjunction:
            aspectScore = 0.7;
            break;
          case AspectType.square:
            aspectScore = 0.4;
            break;
          case AspectType.opposition:
            aspectScore = 0.6;
            break;
        }
      }

      if (isIntellectualAspect) {
        final orbFactor = (1.0 - aspect.orb / 8.0).clamp(0.0, 1.0);
        score = (score + aspectScore * orbFactor) / 2.0;
        relevantAspects++;
      }
    }

    return relevantAspects > 0 ? score : 0.5;
  }

  // 生活节奏匹配 (基于火星-土星, 火星-火星相位)
  double _calculateLifestyleCompatibility(SynastryData synastryData) {
    double score = 0.5;
    int relevantAspects = 0;

    for (final aspect in synastryData.aspects) {
      bool isLifestyleAspect = false;
      double aspectScore = 0.0;

      // 火星-土星相位 (行动与稳定)
      if ((aspect.bodyA == HeavenlyBody.SE_MARS &&
              aspect.bodyB == HeavenlyBody.SE_SATURN) ||
          (aspect.bodyA == HeavenlyBody.SE_SATURN &&
              aspect.bodyB == HeavenlyBody.SE_MARS)) {
        isLifestyleAspect = true;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.85;
            break;
          case AspectType.sextile:
            aspectScore = 0.8;
            break;
          case AspectType.conjunction:
            aspectScore = 0.7;
            break;
          case AspectType.square:
            aspectScore = 0.4;
            break;
          case AspectType.opposition:
            aspectScore = 0.6;
            break;
        }
      }

      // 火星-火星相位 (能量匹配)
      else if (aspect.bodyA == HeavenlyBody.SE_MARS &&
          aspect.bodyB == HeavenlyBody.SE_MARS) {
        isLifestyleAspect = true;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.8;
            break;
          case AspectType.sextile:
            aspectScore = 0.75;
            break;
          case AspectType.conjunction:
            aspectScore = 0.9;
            break;
          case AspectType.square:
            aspectScore = 0.5;
            break;
          case AspectType.opposition:
            aspectScore = 0.7;
            break;
        }
      }

      if (isLifestyleAspect) {
        final orbFactor = (1.0 - aspect.orb / 8.0).clamp(0.0, 1.0);
        score = (score + aspectScore * orbFactor) / 2.0;
        relevantAspects++;
      }
    }

    return relevantAspects > 0 ? score : 0.5;
  }

  // 价值观一致性 (基于木星-土星, 木星-木星相位)
  double _calculateValuesCompatibility(SynastryData synastryData) {
    double score = 0.5;
    int relevantAspects = 0;

    for (final aspect in synastryData.aspects) {
      bool isValuesAspect = false;
      double aspectScore = 0.0;

      // 木星-土星相位 (信念与责任)
      if ((aspect.bodyA == HeavenlyBody.SE_JUPITER &&
              aspect.bodyB == HeavenlyBody.SE_SATURN) ||
          (aspect.bodyA == HeavenlyBody.SE_SATURN &&
              aspect.bodyB == HeavenlyBody.SE_JUPITER)) {
        isValuesAspect = true;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.9;
            break;
          case AspectType.sextile:
            aspectScore = 0.85;
            break;
          case AspectType.conjunction:
            aspectScore = 0.8;
            break;
          case AspectType.square:
            aspectScore = 0.4;
            break;
          case AspectType.opposition:
            aspectScore = 0.6;
            break;
        }
      }

      // 木星-木星相位 (世界观)
      else if (aspect.bodyA == HeavenlyBody.SE_JUPITER &&
          aspect.bodyB == HeavenlyBody.SE_JUPITER) {
        isValuesAspect = true;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.85;
            break;
          case AspectType.sextile:
            aspectScore = 0.8;
            break;
          case AspectType.conjunction:
            aspectScore = 0.9;
            break;
          case AspectType.square:
            aspectScore = 0.5;
            break;
          case AspectType.opposition:
            aspectScore = 0.7;
            break;
        }
      }

      if (isValuesAspect) {
        final orbFactor = (1.0 - aspect.orb / 8.0).clamp(0.0, 1.0);
        score = (score + aspectScore * orbFactor) / 2.0;
        relevantAspects++;
      }
    }

    return relevantAspects > 0 ? score : 0.5;
  }

  // 沟通和谐度 (基于水星-月亮相位)
  double _calculateCommunicationCompatibility(SynastryData synastryData) {
    double score = 0.5;
    int relevantAspects = 0;

    for (final aspect in synastryData.aspects) {
      // 水星-月亮相位 (思维与情感的沟通)
      if ((aspect.bodyA == HeavenlyBody.SE_MERCURY &&
              aspect.bodyB == HeavenlyBody.SE_MOON) ||
          (aspect.bodyA == HeavenlyBody.SE_MOON &&
              aspect.bodyB == HeavenlyBody.SE_MERCURY)) {
        double aspectScore;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.9;
            break;
          case AspectType.sextile:
            aspectScore = 0.85;
            break;
          case AspectType.conjunction:
            aspectScore = 0.8;
            break;
          case AspectType.square:
            aspectScore = 0.5;
            break;
          case AspectType.opposition:
            aspectScore = 0.7;
            break;
        }

        final orbFactor = (1.0 - aspect.orb / 8.0).clamp(0.0, 1.0);
        score = (score + aspectScore * orbFactor) / 2.0;
        relevantAspects++;
      }
    }

    return relevantAspects > 0 ? score : 0.5;
  }

  // 未来发展潜力 (基于太阳-木星, 太阳-太阳相位)
  double _calculateFutureCompatibility(SynastryData synastryData) {
    double score = 0.5;
    int relevantAspects = 0;

    for (final aspect in synastryData.aspects) {
      bool isFutureAspect = false;
      double aspectScore = 0.0;

      // 太阳-木星相位 (自我与成长)
      if ((aspect.bodyA == HeavenlyBody.SE_SUN &&
              aspect.bodyB == HeavenlyBody.SE_JUPITER) ||
          (aspect.bodyA == HeavenlyBody.SE_JUPITER &&
              aspect.bodyB == HeavenlyBody.SE_SUN)) {
        isFutureAspect = true;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.9;
            break;
          case AspectType.sextile:
            aspectScore = 0.85;
            break;
          case AspectType.conjunction:
            aspectScore = 0.8;
            break;
          case AspectType.square:
            aspectScore = 0.5;
            break;
          case AspectType.opposition:
            aspectScore = 0.7;
            break;
        }
      }

      // 太阳-太阳相位 (自我认同)
      else if (aspect.bodyA == HeavenlyBody.SE_SUN &&
          aspect.bodyB == HeavenlyBody.SE_SUN) {
        isFutureAspect = true;
        switch (aspect.type) {
          case AspectType.trine:
            aspectScore = 0.8;
            break;
          case AspectType.sextile:
            aspectScore = 0.75;
            break;
          case AspectType.conjunction:
            aspectScore = 0.9;
            break;
          case AspectType.square:
            aspectScore = 0.55;
            break;
          case AspectType.opposition:
            aspectScore = 0.75;
            break;
        }
      }

      if (isFutureAspect) {
        final orbFactor = (1.0 - aspect.orb / 8.0).clamp(0.0, 1.0);
        score = (score + aspectScore * orbFactor) / 2.0;
        relevantAspects++;
      }
    }

    return relevantAspects > 0 ? score : 0.5;
  }

  // 契合度雷达图
  Widget _buildCompatibilityRadar() {
    // 计算真实的契合度数据
    final compatibilityData = _calculateCompatibilityScores();

    return Container(
      // 去掉外部边框和装饰，完全透明
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 雷达图容器 - 适应小尺寸
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1, // 保证正方形
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 雷达图背景
                    CustomPaint(
                      size: const Size(120, 120), // 设置固定尺寸
                      painter:
                          CompatibilityRadarPainter(compatibilityData.scores),
                    ),
                    // 契合度分数显示在中间
                    // Container(
                    //   padding: const EdgeInsets.all(8),
                    //   decoration: BoxDecoration(
                    //     color: Colors.black.withOpacity(0.6),
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Text(
                    //         S.of(context).compatibilityScore,
                    //         style: const TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 10,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //       const SizedBox(height: 2),
                    //       Text(
                    //         '${(compatibilityData.overallScore * 100).toStringAsFixed(2)}%',
                    //         style: const TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 雷达图绘制器
class CompatibilityRadarPainter extends CustomPainter {
  final List<double> compatibilityScores;
  final List<String> dimensions = [
    S.current.emotionalCompatibility,
    S.current.intellectualCompatibility,
    S.current.lifestyleCompatibility,
    S.current.valuesCompatibility,
    S.current.communicationCompatibility,
    S.current.futureCompatibility,
  ];

  CompatibilityRadarPainter(this.compatibilityScores);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 * 0.85; // 适应更大尺寸

    // 绘制完整的六边形网格背景 (5个层级，从中心到边缘)
    final gridPaint = Paint()
      ..color = const Color(0xFF9C88FF).withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    // 绘制5个同心六边形网格 (0.2, 0.4, 0.6, 0.8, 1.0)
    for (int level = 1; level <= 5; level++) {
      final hexPath = Path();
      final levelRadius = radius * level / 5;

      for (int i = 0; i < 6; i++) {
        final angle = (i * 60 - 90) * math.pi / 180;
        final x = center.dx + levelRadius * math.cos(angle);
        final y = center.dy + levelRadius * math.sin(angle);

        if (i == 0) {
          hexPath.moveTo(x, y);
        } else {
          hexPath.lineTo(x, y);
        }
      }
      hexPath.close();

      // 根据层级调整透明度，越外层越透明
      final levelPaint = Paint()
        ..color = const Color(0xFF9C88FF).withOpacity(0.15 * (6 - level) / 5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      canvas.drawPath(hexPath, levelPaint);
    }

    // 绘制从中心到顶点的放射线 (6条)
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 90) * math.pi / 180;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), gridPaint);
    }

    // 绘制数据多边形 (炫酷渐变填充)
    if (compatibilityScores.isNotEmpty) {
      final dataPath = Path();

      for (int i = 0; i < compatibilityScores.length; i++) {
        final angle = (i * 60 - 90) * math.pi / 180;
        final score = compatibilityScores[i];
        final x = center.dx + radius * score * math.cos(angle);
        final y = center.dy + radius * score * math.sin(angle);

        if (i == 0) {
          dataPath.moveTo(x, y);
        } else {
          dataPath.lineTo(x, y);
        }
      }
      dataPath.close();

      // 渐变填充
      final gradientPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFF00D4FF).withOpacity(0.8),
            const Color(0xFF6C5CE7).withOpacity(0.6),
            const Color(0xFFA855F7).withOpacity(0.4),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 0.8, 1.0],
        ).createShader(dataPath.getBounds())
        ..style = PaintingStyle.fill;

      canvas.drawPath(dataPath, gradientPaint);

      // 发光边框
      final glowPaint = Paint()
        ..color = const Color(0xFF00D4FF).withOpacity(0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 2);

      canvas.drawPath(dataPath, glowPaint);

      // 主边框
      final borderPaint = Paint()
        ..color = const Color(0xFF00D4FF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(dataPath, borderPaint);
    }

    // 绘制数据点 (炫酷的发光效果)
    for (int i = 0; i < compatibilityScores.length; i++) {
      final angle = (i * 60 - 90) * math.pi / 180;
      final score = compatibilityScores[i];
      final x = center.dx + radius * score * math.cos(angle);
      final y = center.dy + radius * score * math.sin(angle);

      // 外发光圈
      final glowPaint = Paint()
        ..color = const Color(0xFF00D4FF).withOpacity(0.5)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

      canvas.drawCircle(Offset(x, y), 8, glowPaint);

      // 内发光圈
      final innerGlowPaint = Paint()
        ..color = const Color(0xFF00D4FF).withOpacity(0.8)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

      canvas.drawCircle(Offset(x, y), 6, innerGlowPaint);

      // 主数据点
      final pointPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white,
            const Color(0xFF00D4FF),
            const Color(0xFF6C5CE7),
          ],
          stops: const [0.0, 0.6, 1.0],
        ).createShader(Rect.fromCircle(center: Offset(x, y), radius: 5))
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), 5, pointPaint);

      // 外边框
      final pointBorderPaint = Paint()
        ..color = Colors.white.withOpacity(0.9)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(Offset(x, y), 5, pointBorderPaint);
    }

    // 绘制维度标签 (可选，在雷达图外侧)
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (int i = 0; i < dimensions.length; i++) {
      final angle = (i * 60 - 90) * math.pi / 180;
      final labelRadius = radius * 1.15;
      final x = center.dx + labelRadius * math.cos(angle);
      final y = center.dy + labelRadius * math.sin(angle);

      textPainter.text = TextSpan(
        text: dimensions[i],
        style: const TextStyle(
          color: Color(0xFFB794F6),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout();

      final labelOffset = Offset(
        x - textPainter.width / 2,
        y - textPainter.height / 2,
      );

      textPainter.paint(canvas, labelOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// 契合度数据类
class CompatibilityData {
  final List<double> scores; // 6个维度的分数 (0.0-1.0)
  final double overallScore; // 总体分数 (0.0-1.0)

  const CompatibilityData({
    required this.scores,
    required this.overallScore,
  });
}
