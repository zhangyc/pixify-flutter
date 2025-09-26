import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;
import 'package:sona/common/widgets/member/member.dart';
import 'package:sona/core/subscribe/model/member.dart';
import '../models/discover_user.dart';
import 'astro_badge.dart';

class DiscoverUserCard extends StatelessWidget {
  const DiscoverUserCard({
    super.key,
    required this.user,
    required this.onPhotoTap,
    required this.onAstroBadgeTap,
    required this.onLike,
    required this.onSkip,
    required this.onSendMessage,
  });

  final DiscoverUser user;
  final Function(int photoIndex) onPhotoTap;
  final VoidCallback onAstroBadgeTap;
  final VoidCallback onLike;
  final VoidCallback onSkip;
  final VoidCallback onSendMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? const Color(0xFF1A1A1F)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 照片网格区域
          Expanded(
            flex: 7,
            child: _buildPhotoSection(theme),
          ),

          // 用户信息区域
          Expanded(
            flex: 2,
            child: _buildUserInfo(theme),
          ),

          // 操作按钮区域
          _buildActionButtons(theme),
        ],
      ),
    );
  }

  Widget _buildPhotoSection(ThemeData theme) {
    return Stack(
      children: [
        // 照片网格或占位符
        if (user.photos.isNotEmpty)
          _buildPhotoGrid(theme)
        else
          _buildNoPhotoPlaceholder(theme),

        // 缘分徽章（右上角）
        if (user.astroScore != null)
          Positioned(
            top: 12,
            right: 12,
            child: AstroBadge(
              score: user.astroScore!,
              onTap: onAstroBadgeTap,
            ),
          ),

        // 在线状态指示器
        if (user.isOnline)
          Positioned(
            top: 12,
            left: 12,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF4ADE80),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPhotoGrid(ThemeData theme) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Row(
        children: [
          // 主图区域 (60% 宽度)
          Expanded(
            flex: 6,
            child: _buildMainPhoto(0),
          ),

          const SizedBox(width: 4),

          // 小图网格区域 (40% 宽度)
          Expanded(
            flex: 4,
            child: _buildSmallPhotosGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainPhoto(int index) {
    return Hero(
      tag: 'photo_${user.id}_$index',
      child: GestureDetector(
        onTap: () => onPhotoTap(index),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: CachedNetworkImage(
            imageUrl: user.photos[index],
            fit: BoxFit.cover,
            placeholder: (context, url) => _buildPhotoPlaceholder(),
            errorWidget: (context, url, error) => _buildPhotoError(),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallPhotosGrid() {
    final remainingPhotos = user.photos.length - 1;
    final maxSmallPhotos = math.min(remainingPhotos, 4);

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: maxSmallPhotos,
      itemBuilder: (context, index) {
        final photoIndex = index + 1;
        final isLastGrid = index == 3 && remainingPhotos > 4;

        return _buildSmallPhoto(photoIndex, isLastGrid, remainingPhotos);
      },
    );
  }

  Widget _buildSmallPhoto(int photoIndex, bool isLastGrid, int totalRemaining) {
    return Hero(
      tag: 'photo_${user.id}_$photoIndex',
      child: GestureDetector(
        onTap: () => onPhotoTap(photoIndex),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: user.photos[photoIndex],
                fit: BoxFit.cover,
                placeholder: (context, url) => _buildPhotoPlaceholder(),
                errorWidget: (context, url, error) => _buildPhotoError(),
              ),

              // 更多照片遮罩
              if (isLastGrid && totalRemaining > 4)
                Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Center(
                    child: Text(
                      '+${totalRemaining - 4}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.primaryColor.withOpacity(0.2),
              theme.primaryColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 48,
              color: theme.primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              '🌟 神秘面纱 🌟',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'TA还没有展示真容',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.primaryColor.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.primaryColor.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: Text(
                '💫 发送星语问候解锁相册',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildPhotoError() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.error_outline, color: Colors.grey),
      ),
    );
  }

  Widget _buildUserInfo(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 姓名和年龄
              Row(
                children: [
                  Text(
                    '${user.name}, ${user.age}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 会员标识
                  if (user.memberType == MemberType.plus)
                    const MemberIcon(size: 18),
                ],
              ),

              // 距离信息
              if (user.distance != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${user.distance!.toStringAsFixed(1)}km',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),

          // 个人简介或今日话题（二选一，节省空间）
          if (user.astroScore?.prompts.isNotEmpty == true)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 14,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      '今日话题：${user.astroScore!.prompts.first}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          else if (user.bio != null)
            Text(
              user.bio!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.hintColor,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          // 跳过按钮
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onSkip,
              icon: Icon(Icons.close_rounded, size: 18),
              label: const Text('跳过'),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.hintColor,
                side: BorderSide(color: theme.hintColor.withOpacity(0.3)),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // 喜欢/发消息按钮
          Expanded(
            flex: 2,
            child: FilledButton.icon(
              onPressed: user.photos.isEmpty ? onSendMessage : onLike,
              icon: Icon(
                user.photos.isEmpty ? Icons.message : Icons.favorite,
                size: 18,
              ),
              label: Text(user.photos.isEmpty ? '发送问候' : '喜欢'),
              style: FilledButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: theme.brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
