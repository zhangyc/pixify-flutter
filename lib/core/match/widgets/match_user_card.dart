// lib/core/match/widgets/match_user_card.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/astro/widgets/astro_preview.dart';
import 'package:sona/generated/l10n.dart';

class MatchUserCard extends StatefulWidget {
  const MatchUserCard({
    super.key,
    required this.user,
  });

  final MatchUserInfo user;

  @override
  State<MatchUserCard> createState() => _MatchUserCardState();
}

class _MatchUserCardState extends State<MatchUserCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
          colors: [
            Color(0xFF1A1A22),
            Color(0xFF12121B),
            Color(0xFF0E0E14),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab 切换栏 (移到顶部)
          Container(
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.05),
              border: Border(
                bottom: BorderSide(
                  color: theme.primaryColor.withOpacity(0.1),
                  width: 0.5,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: theme.primaryColor,
              labelColor: theme.primaryColor,
              unselectedLabelColor: theme.primaryColor.withOpacity(0.6),
              tabs: [
                Tab(
                  icon: Icon(Icons.photo),
                  text: S.current.profileInfoTab,
                ),
                Tab(
                  icon: Icon(Icons.auto_awesome),
                  text: S.current.astroChartTab,
                ),
              ],
            ),
          ),

          // Tab 内容区域
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                // 照片 + 信息 Tab
                _buildPhotoInfoTab(theme),
                // 星盘 Tab
                _buildAstroTab(theme),
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
        Expanded(
          flex: 7,
          child: _buildPhotoSection(theme),
        ),

        // 用户信息区域
        Expanded(
          flex: 4,
          child: _buildUserInfo(theme),
        ),
      ],
    );
  }

  // 星盘 Tab - 检查信息完整性
  Widget _buildAstroTabWithCheck(ThemeData theme) {
    // 检查匹配用户是否有足够的出生地信息
    final hasEnoughInfo = widget.user.birthday != null &&
        (widget.user.birthLatitude != null &&
            widget.user.birthLongitude != null);

    if (!hasEnoughInfo) {
      // 显示信息不完整的提示
      return _buildIncompleteInfoPrompt(theme);
    }

    // 有足够信息，显示星盘
    return _buildAstroTab(theme);
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

  // 星盘 Tab
  Widget _buildAstroTab(ThemeData theme) {
    /// 检查是否有足够的信息来绘制星盘
    final hasEnoughInfo = widget.user.birthday != null &&
        (widget.user.birthCity != null ||
            widget.user.birthLatitude != null ||
            widget.user.birthLongitude != null);

    if (!hasEnoughInfo) {
      // 显示补充信息提示
      return _buildAstroTabWithCheck(theme);
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RepaintBoundary(
          child: AstroPreview(
            birthday: widget.user.birthday,
            birthLatitude:
                double.tryParse(widget.user.birthLatitude ?? '39.9042') ??
                    39.9042,
            birthLongitude:
                double.tryParse(widget.user.birthLongitude ?? '116.4074') ??
                    116.4074,
            birthTime: null, // TODO: 可以添加出生时间字段
            isBackground: false,
          ),
        ),
      ),
    );
  }

  // 星盘信息不足提示

  Widget _buildPhotoSection(ThemeData theme) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Stack(
        children: [
          _buildPhotoContent(theme),
        ],
      ),
    );
  }

  Widget _buildPhotoContent(ThemeData theme) {
    // 当没有头像和照片时，显示占位符
    if (widget.user.avatar == null && widget.user.photos.isEmpty) {
      return _buildNoPhotoPlaceholder(theme);
    }

    // 有照片时，显示主图和侧边网格
    return Row(
      children: [
        Expanded(
          flex: 6, // 主图比例（更大）
          child: _buildMainPhoto(theme),
        ),
        if (widget.user.photos.isNotEmpty) ...[
          const SizedBox(width: 8),
          Expanded(
            flex: 3, // 侧边网格比例（更窄）
            child: _buildGalleryGrid(theme),
          ),
        ],
      ],
    );
  }

  // 右侧网格（用于 Row 布局）
  Widget _buildGalleryGrid(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.20),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset.zero,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildSmallPhotosGrid(),
    );
  }

  Widget _buildMainPhoto(ThemeData theme) {
    return Hero(
      tag: 'avatar_${widget.user.id}',
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            height: 240,
            imageUrl: widget.user.avatar ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => _buildPhotoPlaceholder(),
            errorWidget: (context, url, error) => _buildPhotoError(),
          ),
          // 底部渐变覆盖，提升信息可读性
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 120,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.55),
                      Colors.black.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallPhotosGrid() {
    final maxPhotos = min(widget.user.photos.length, 4);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: maxPhotos,
      itemBuilder: (context, index) {
        final isLastPhoto = index == 3 && widget.user.photos.length > 4;
        return _buildSmallPhoto(index, isLastPhoto);
      },
    );
  }

  Widget _buildSmallPhoto(int index, bool isLastPhoto) {
    return Hero(
      tag: 'photo_${widget.user.id}_$index',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: widget.user.photos[index],
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildPhotoPlaceholder(),
              errorWidget: (context, url, error) => _buildPhotoError(),
            ),

            // 更多照片遮罩 - 使用主题色
            if (isLastPhoto && widget.user.photos.length > 4)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    '+${widget.user.photos.length - 4}',
                    style: const TextStyle(
                      color: Color(0xFF00EED1), // 直接使用霓虹青绿色
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Color(0x8000EED1), // 50% 透明度的霓虹青绿色
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoPhotoPlaceholder(ThemeData theme) {
    // 暂时先不展示星盘了，只是文案提醒上传照片
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xE60E0E14), // 0.9 opacity
            Color(0xB312121B), // 0.7 opacity
            Color(0x1A00EED1), // theme.primaryColor.withOpacity(0.1) - 霓虹青绿色
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 星盘图标 - 添加霓虹光晕效果
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset.zero,
                ),
              ],
            ),
            child: Icon(
              Icons.auto_awesome,
              size: 56,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            S.current.remindUploadPhoto,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          _buildNeonButton(
            theme: theme,
            text: S.current.sendStarGreetingToUnlockAlbum,
            onTap: () => MatchApi.customSend(
                widget.user.id, S.current.remindUploadPhoto),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE0E0E0), Color(0xFFEEEEEE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF00EED1), // 直接使用霓虹青绿色
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildPhotoError() {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF1A1A1F),
                const Color(0xFF0E0E14),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.error_outline,
              color: theme.primaryColor.withOpacity(0.6),
              size: 28,
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInfo(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x0012121B),
            Color(0xCC0E0E14),
          ],
        ),
        border: Border(
          top: BorderSide(color: Color(0x3300EED1), width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${widget.user.name}, ${widget.user.age}',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 22,
                    color: const Color(0xFFEDEDF4),
                    letterSpacing: 0.3,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              if (widget.user.distance != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: theme.primaryColor.withOpacity(0.38), width: 1),
                  ),
                  child: Text(
                    '${widget.user.distance!.toStringAsFixed(1)}km',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          if (widget.user.bio != null) ...[
            const SizedBox(height: 6),
            Text(
              widget.user.bio!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFB5B6C8),
                fontSize: 14,
                height: 1.35,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNeonButton({
    required ThemeData theme,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: theme.primaryColor.withOpacity(0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withOpacity(0.2),
              blurRadius: 12,
              offset: Offset.zero,
            ),
          ],
        ),
        child: Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
