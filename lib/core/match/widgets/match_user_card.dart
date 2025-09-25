// lib/core/match/widgets/match_user_card.dart
import 'dart:math' as SonaAnalytics;

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;

import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/astro/widgets/astro_preview.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/match/util/event.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/generated/l10n.dart';

class MatchUserCard extends StatelessWidget {
  const MatchUserCard({
    super.key,
    required this.user,
  });

  final MatchUserInfo user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.12),
            blurRadius: 28,
            offset: const Offset(0, 0),
          ),
        ],
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.18),
          width: 1,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A22),
            const Color(0xFF12121B),
            const Color(0xFF0E0E14),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Column(
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
      ),
    );
  }

  Widget _buildPhotoSection(ThemeData theme) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Stack(
        children: [
          // 只有当 avatar 和 photos 都为空时才显示星盘占位符
          if (user.avatar == null && user.photos.isEmpty)
            _buildNoPhotoPlaceholder(theme)
          else
            Row(
              children: [
                Expanded(
                  flex: 6, // 主图比例（更大）
                  child: _buildMainPhoto(theme),
                ),
                if (user.photos.isNotEmpty) const SizedBox(width: 8),
                if (user.photos.isNotEmpty)
                  Expanded(
                    flex: 3, // 侧边网格比例（更窄）
                    child: _buildGalleryGrid(theme),
                  ),
              ],
            )

          // 如果有 photos，显示 gallery 区域

          // 缘分徽章（右上角）
          // if (user.astroScore != null)
          //   Positioned(
          //     top: 16,
          //     right: 16,
          //     child: AstroBadge(
          //       score: user.astroScore!,
          //       onTap: onAstroBadgeTap,
          //     ),
          //   ),

          // 在线状态指示器 - 使用主题色
          // if (user.isOnline)
          //   Positioned(
          //     top: 16,
          //     left: 16,
          //     child: Container(
          //       width: 12,
          //       height: 12,
          //       decoration: BoxDecoration(
          //         color: theme.primaryColor, // 使用主题霓虹青绿色
          //         shape: BoxShape.circle,
          //         border: Border.all(
          //           color: isDark ? const Color(0xFF12121B) : Colors.white,
          //           width: 2
          //         ),
          //         boxShadow: [
          //           BoxShadow(
          //             color: theme.primaryColor.withOpacity(0.6),
          //             blurRadius: 8,
          //             offset: const Offset(0, 0),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
        ],
      ),
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
            offset: const Offset(0, 0),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: _buildSmallPhotosGrid(),
    );
  }

  Widget _buildMainPhoto(ThemeData theme) {
    return Hero(
      tag: 'avatar_${user.id}',
      child: GestureDetector(
        onTap: () => () {},
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              height: 240,
              imageUrl: user.avatar??'',
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
      ),
    );
  }

  Widget _buildGalleryOverlay(ThemeData theme) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: Container(
        width: 120,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
            // 暗色主题添加霓虹边框光晕

            BoxShadow(
              color: theme.primaryColor.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 0),
            ),
          ],
          // 添加边框
          border: Border.all(
            color: theme.primaryColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: _buildSmallPhotosGrid(),
        ),
      ),
    );
  }

  Widget _buildSmallPhotosGrid() {
    final maxPhotos = math.min(user.photos.length, 4);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: maxPhotos,
      itemBuilder: (context, index) {
        final isLastPhoto = index == 3 && user.photos.length > 4;

        return _buildSmallPhoto(index, isLastPhoto);
      },
    );
  }

  Widget _buildSmallPhoto(int index, bool isLastPhoto) {
    return Hero(
      tag: 'photo_${user.id}_$index',
      child: GestureDetector(
        onTap: () => () {}, // 点击 gallery 中的照片
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: user.photos[index],
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildPhotoPlaceholder(),
                errorWidget: (context, url, error) => _buildPhotoError(),
              ),

              // 更多照片遮罩 - 使用主题色
              if (isLastPhoto && user.photos.length > 4)
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
                      '+${user.photos.length - 4}',
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
      ),
    );
  }

  Widget _buildNoPhotoPlaceholder(ThemeData theme) {
    /// 暂时先不展示星盘了。只是文案。"📸 提醒TA上传照片，让彼此更了解"
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // 暗色主题：深色渐变 + 霓虹青绿色点缀
              const Color(0xFF0E0E14).withOpacity(0.9),
              const Color(0xFF12121B).withOpacity(0.7),
              theme.primaryColor.withOpacity(0.1),
            ]),
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
                  offset: const Offset(0, 0),
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
          GestureDetector(
            onTap: () {
              MatchApi.customSend(user.id, S.current.remindUploadPhoto);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: theme.primaryColor.withOpacity(0.5),
                  width: 1.5,
                ),
                // 暗色主题添加霓虹光晕
                boxShadow: [
                  BoxShadow(
                    color: theme.primaryColor.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Text(
                S.current.sendStarGreetingToUnlockAlbum,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    ///
    ///
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              // 暗色主题：深色渐变 + 霓虹青绿色点缀
              const Color(0xFF0E0E14).withOpacity(0.9),
              const Color(0xFF12121B).withOpacity(0.7),
              theme.primaryColor.withOpacity(0.1),
            ]),
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
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Icon(
              Icons.auto_awesome,
              size: 56,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 10),

          /// 这里展示星盘
          RepaintBoundary(
            child: AstroPreview(
              birthday: user.birthday,
              country: SonaCountry.fromCode(user.countryCode ?? 'US'),
              isBackground: true,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            S.current.profileNotShown,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: theme.primaryColor.withOpacity(0.5),
                width: 1.5,
              ),
              // 暗色主题添加霓虹光晕
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Text(
              S.current.sendStarGreetingToUnlockAlbum,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
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
                  '${user.name}, ${user.age}',
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
              if (user.distance != null)
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
                    '${user.distance!.toStringAsFixed(1)}km',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          if (user.bio != null) ...[
            const SizedBox(height: 6),
            Text(
              user.bio!,
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
}
