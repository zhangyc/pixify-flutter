import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/match/widgets/match_user_card.dart';
import 'package:sona/core/match/widgets/luna_avatar.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/utils/global/global.dart';

class UserDetailPage extends ConsumerStatefulWidget {
  final MatchUserInfo user;

  const UserDetailPage({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends ConsumerState<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 主要内容区域 - 使用Hero动画
          Hero(
            tag: 'user_${widget.user.id}',
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 60,
              ),
              child: MatchUserCard(user: widget.user),
            ),
          ),

          // 顶部返回按钮
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),

          // 底部操作按钮
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 16,
            left: 16,
            right: 16,
            child: _buildActionButtons(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Luna讲解提示
        LunaTeachingCard(
          title: '星盘分析案例',
          content:
              '这是一个${widget.user.allScore != null ? "匹配度${widget.user.allScore}的" : ""}学习案例，你可以收藏它用于深入学习占星知识。',
          actionLabel: '💎 深度解读',
          onAction: () {
            // TODO: 触发AI深度解读
          },
        ),

        const SizedBox(height: 12),

        // 操作按钮区
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A22),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.primaryColor.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 跳过按钮 → 下一个案例
              _buildCircleButton(
                icon: Icons.skip_next,
                color: const Color(0xFFFF6B6B),
                size: 48,
                onTap: () {
                  MatchApi.skip(widget.user.id);
                  SonaAnalytics.log('user_detail_skip_case');
                  Navigator.of(context).pop({'action': 'skip'});
                },
              ),

              // 喜欢按钮 → 收藏案例
              _buildCircleButton(
                icon: Icons.bookmark,
                color: theme.primaryColor,
                size: 64,
                isMain: true,
                onTap: () {
                  MatchApi.like(widget.user.id);
                  SonaAnalytics.log('user_detail_save_case');
                  Navigator.of(context).pop({'action': 'like'});
                },
              ),

              // 发消息按钮 → 学习讨论
              _buildCircleButton(
                icon: Icons.chat_bubble_outline,
                color: const Color(0xFFFFD700),
                size: 48,
                onTap: () {
                  MatchApi.like(widget.user.id);
                  SonaAnalytics.log('user_detail_discuss');
                  Navigator.of(context)
                      .pop({'action': 'message', 'user': widget.user});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required Color color,
    required double size,
    required VoidCallback onTap,
    bool isMain = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.15),
          border: Border.all(
            color: color,
            width: isMain ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
            if (isMain)
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 0),
              ),
          ],
        ),
        child: Icon(
          icon,
          color: color,
          size: size * 0.45,
        ),
      ),
    );
  }
}
