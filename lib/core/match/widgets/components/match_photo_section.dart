// lib/core/match/widgets/components/match_photo_section.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/generated/l10n.dart';
import 'package:sona/utils/uuid.dart';

class MatchPhotoSection extends StatelessWidget {
  final MatchUserInfo user;

  const MatchPhotoSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Stack(children: [_buildPhotoContent(context)]),
    );
  }

  Widget _buildPhotoContent(BuildContext context) {
    // 当没有头像和照片时，显示占位符
    if (user.avatar == null && user.photos.isEmpty) {
      return _buildNoPhotoPlaceholder(context);
    }

    // 有照片时，显示主图和侧边网格
    return Row(
      children: [
        Expanded(
          flex: 6, // 主图比例（更大）
          child: _buildMainPhoto(context),
        ),
        if (user.photos.isNotEmpty) ...[
          const SizedBox(width: 8),
          Expanded(
            flex: 3, // 侧边网格比例（更窄）
            child: _buildGalleryGrid(context),
          ),
        ],
      ],
    );
  }

  Widget _buildGalleryGrid(BuildContext context) {
    final theme = Theme.of(context);
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

  Widget _buildMainPhoto(BuildContext context) {
    return Hero(
      tag: 'avatar_${user.id}',
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            height: 240,
            imageUrl: user.avatar ?? '',
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
    final maxPhotos = min(user.photos.length, 4);

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
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
    );
  }

  Widget _buildNoPhotoPlaceholder(BuildContext context) {
    final theme = Theme.of(context);
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
              user.id,
              S.current.remindUploadPhoto,
              uuid.v4(),
            ),
          ),
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
              colors: [const Color(0xFF1A1A1F), const Color(0xFF0E0E14)],
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
}
