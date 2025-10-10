// lib/core/match/widgets/match_user_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/astro/services/astro_analysis_service.dart';
import 'package:sona/core/match/widgets/components/match_tab_bar.dart';
import 'package:sona/core/match/widgets/components/match_photo_section.dart';
import 'package:sona/core/match/widgets/components/match_user_info.dart'
    as user_info_card;
import 'package:sona/core/match/widgets/components/match_astro_tab.dart';
import 'package:sona/core/match/widgets/components/match_analysis_bottom_sheet.dart';
import 'package:sona/core/match/widgets/components/match_analysis_full_page.dart';
import 'package:sona/core/diamond/services/diamond.dart';
import 'package:sona/core/diamond/diamond_store_page.dart';
import 'package:sona/account/providers/profile.dart';

import '../../../generated/l10n.dart';
import '../../../common/widgets/snackbar.dart';

class MatchUserCard extends ConsumerStatefulWidget {
  const MatchUserCard({super.key, required this.user});

  final MatchUserInfo user;

  @override
  ConsumerState<MatchUserCard> createState() => _MatchUserCardState();
}

class _MatchUserCardState extends ConsumerState<MatchUserCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLightAnalyzing = false;
  bool _isDeepAnalyzing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          const BoxShadow(
            color: Color(0x4012121B), // Colors.black.withOpacity(0.25)
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.12),
            blurRadius: 28,
            offset: Offset.zero,
          ),
        ],
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.18),
          width: 1,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A22), Color(0xFF12121B), Color(0xFF0E0E14)],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab 切换栏
          MatchTabBar(controller: _tabController),

          // Tab 内容区域
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                // 星盘 Tab
                MatchAstroTab(
                  user: widget.user,
                  isLightAnalyzing: _isLightAnalyzing,
                  isDeepAnalyzing: _isDeepAnalyzing,
                  onLightAnalysis: () => _performAIAnalysis(isDeep: false),
                  onDeepAnalysis: () => _performAIAnalysis(isDeep: true),
                ),
                // 照片 + 信息 Tab
                _buildPhotoInfoTab(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 照片 + 信息 Tab
  Widget _buildPhotoInfoTab(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 照片区域
        Expanded(flex: 7, child: MatchPhotoSection(user: widget.user)),

        // 用户信息区域
        Expanded(
          flex: 4,
          child: user_info_card.MatchUserInfoCard(user: widget.user),
        ),
      ],
    );
  }

  // 执行AI分析
  void _performAIAnalysis({required bool isDeep}) async {
    if (widget.user.birthday == null) {
      StyledSnackBar.showWarning(context, S.current.incompleteBirthdayInfo);
      return;
    }
    await EasyLoading.show();

    // 获取当前用户信息
    final currentProfile = ref.read(myProfileProvider);
    if (currentProfile == null || currentProfile.birthday == null) {
      StyledSnackBar.showWarning(context, S.current.incompleteBirthdayInfo);
      return;
    }

    // 检查钻石余额
    final requiredDiamonds = isDeep ? 250 : 100;
    try {
      final checkResult = await DiamondService.checkBalance(
        requiredDiamonds: requiredDiamonds,
      );

      // 如果API调用失败（success: false），说明钻石不足
      if ((checkResult.isSuccess) && (!checkResult.data["hasEnough"])) {
        // 检查是否是钻石余额不足的错误
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => const DiamondStorePage(),
          ),
        );
      } else {
        await EasyLoading.dismiss();
      }

      // 如果success为true，说明钻石充足，继续执行
    } catch (e) {
      await EasyLoading.dismiss();
      StyledSnackBar.showError(context, S.current.diamondConsumeFailed);
      return;
    }

    setState(() {
      if (isDeep) {
        _isDeepAnalyzing = true;
      } else {
        _isLightAnalyzing = true;
      }
    });

    try {
      // 先消费钻石
      final consumeResult = await DiamondService.consume(
        diamondCount: requiredDiamonds,
        remark: isDeep
            ? S.current.deepSynastryRemark
            : S.current.lightSynastryRemark,
      );

      if (!consumeResult.isSuccess) {
        await EasyLoading.dismiss();
        StyledSnackBar.showError(context, S.current.diamondConsumeFailed);
        return;
      }

      // 调用合盘分析API
      final analysisService = AstroAnalysisService();
      final result = await (isDeep
          ? analysisService.analyzeSynastryDeep(
              birthday1: currentProfile.birthday!,
              latitude1:
                  double.tryParse(currentProfile.birthLatitude ?? '39.9042') ??
                      39.9042,
              longitude1: double.tryParse(
                      currentProfile.birthLongitude ?? '116.4074') ??
                  116.4074,
              birthday2: widget.user.birthday!,
              latitude2:
                  double.tryParse(widget.user.birthLatitude ?? '39.9042') ??
                      39.9042,
              longitude2:
                  double.tryParse(widget.user.birthLongitude ?? '116.4074') ??
                      116.4074,
              name1: currentProfile.name,
              name2: widget.user.name,
            )
          : analysisService.analyzeSynastryLight(
              birthday1: currentProfile.birthday!,
              latitude1:
                  double.tryParse(currentProfile.birthLatitude ?? '39.9042') ??
                      39.9042,
              longitude1: double.tryParse(
                      currentProfile.birthLongitude ?? '116.4074') ??
                  116.4074,
              birthday2: widget.user.birthday!,
              latitude2:
                  double.tryParse(widget.user.birthLatitude ?? '39.9042') ??
                      39.9042,
              longitude2:
                  double.tryParse(widget.user.birthLongitude ?? '116.4074') ??
                      116.4074,
              name1: currentProfile.name,
              name2: widget.user.name,
            ));

      if (result.isSuccess && result.data != null) {
        final content = result.data;
        if (content != null && content.isNotEmpty) {
          // 根据分析类型选择显示方式
          if (isDeep) {
            // 深度分析：全屏页面
            _showDeepAnalysisPage(content);
          } else {
            // 轻度分析：底部弹窗
            _showLightAnalysisBottomSheet(content);
          }
        } else {
          await EasyLoading.dismiss();
          StyledSnackBar.showError(context, S.current.diamondConsumeFailed);
        }
      } else {
        await EasyLoading.dismiss();
        StyledSnackBar.showError(context, S.current.diamondConsumeFailed);
      }
    } catch (e) {
      await EasyLoading.dismiss();
      StyledSnackBar.showError(context, S.current.diamondConsumeFailed);
    } finally {
      await EasyLoading.dismiss();
      setState(() {
        if (isDeep) {
          _isDeepAnalyzing = false;
        } else {
          _isLightAnalyzing = false;
        }
      });
    }
  }

  // 显示轻度分析底部弹窗
  void _showLightAnalysisBottomSheet(String content) {
    MatchAnalysisBottomSheet.show(context, content);
  }

  // 显示深度分析全屏页面
  void _showDeepAnalysisPage(String content) {
    MatchAnalysisFullPage.show(context, content);
  }
}
