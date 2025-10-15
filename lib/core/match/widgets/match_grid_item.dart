import 'package:flutter/material.dart';
import 'package:sona/core/match/bean/match_user.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MatchGridItem extends StatelessWidget {
  final MatchUserInfo user;
  final VoidCallback onTap;

  const MatchGridItem({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 为瀑布流Item设置随机高度，营造瀑布流效果
    final heights = [180.0, 200.0, 220.0, 240.0];
    final itemHeight = heights[user.id % heights.length];

    return Hero(
      tag: 'user_${user.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: itemHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.primaryColor.withOpacity(0.15),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // 背景图片
                  Positioned.fill(
                    child: user.avatar != null
                        ? CachedNetworkImage(
                            imageUrl: user.avatar!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: theme.primaryColor.withOpacity(0.1),
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: theme.primaryColor.withOpacity(0.1),
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: theme.primaryColor.withOpacity(0.5),
                              ),
                            ),
                          )
                        : Container(
                            color: theme.primaryColor.withOpacity(0.1),
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: theme.primaryColor.withOpacity(0.5),
                            ),
                          ),
                  ),

                  // 渐变遮罩
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          stops: const [0.5, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // 用户信息
                  Positioned(
                    left: 8,
                    right: 8,
                    bottom: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 名字 + 年龄
                        Text(
                          '${user.name ?? 'Unknown'}, ${user.age}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),

                        // 星座标签
                        if (user.allScore != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '⭐ ${user.allScore}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // 喜欢我标识
                  if (user.likeMe == 1)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.pink.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
