import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/like_me/providers/liked_me.dart';
import 'package:sona/utils/global/global.dart';

import '../../../generated/l10n.dart';

class LikedMeListView extends StatefulHookConsumerWidget {
  const LikedMeListView(
      {super.key, required this.onTap, required this.onShowAll});
  final void Function([UserInfo]) onTap;
  final void Function() onShowAll;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LikedMeListViewState();
}

class _LikedMeListViewState extends ConsumerState<LikedMeListView>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();

    // 脉冲动画 - 用于新用户标识
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // 微光动画 - 用于模糊头像
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOutSine,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMember = ref.watch(myProfileProvider)?.isMember ?? false;
    return ref.watch(likeMeStreamProvider).when<Widget>(
        data: (likedMeUsers) {
          return likedMeUsers.isEmpty
              ? Container()
              : Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (likedMeUsers.where((u) => u.isNew).isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            '${S.of(context).whoLikesU} (${likedMeUsers.length})',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 18),
                          ),
                        ),
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            if (index >= 16) {
                              return AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _pulseAnimation.value,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () => widget.onTap(),
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF00EED1),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF00EED1)
                                                  .withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '+${likedMeUsers.length - 16}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            final u = likedMeUsers[index];
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () => widget.onTap(u.toUserInfo()),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // 圆形头像容器
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 3,
                                          color: isMember
                                              ? const Color(0xFF00EED1)
                                              : Colors.grey.withOpacity(0.3)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          // 头像 - 根据会员状态显示不同效果
                                          if (isMember)
                                            UserAvatar(
                                              url: u.avatar,
                                              size: const Size(80, 80),
                                              borderSide: BorderSide.none,
                                            )
                                          else
                                            // 方案1: 马赛克效果
                                            Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                UserAvatar(
                                                  url: u.avatar,
                                                  size: const Size(80, 80),
                                                  borderSide: BorderSide.none,
                                                ),
                                                // 半透明遮罩 + 锁图标
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                  ),
                                                  child: AnimatedBuilder(
                                                    animation:
                                                        _shimmerAnimation,
                                                    builder: (context, child) {
                                                      return Stack(
                                                        children: [
                                                          // 微光扫过效果
                                                          Positioned(
                                                            left: _shimmerAnimation
                                                                        .value *
                                                                    80 -
                                                                20,
                                                            top: 0,
                                                            child: Container(
                                                              width: 20,
                                                              height: 80,
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Colors
                                                                        .transparent,
                                                                    const Color(
                                                                            0xFF00EED1)
                                                                        .withOpacity(
                                                                            0.6),
                                                                    Colors
                                                                        .transparent,
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          // 锁图标
                                                          Center(
                                                            child: Icon(
                                                              Icons
                                                                  .lock_outline,
                                                              color:
                                                                  Colors.white,
                                                              size: 24,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // New 标签 - 脉冲动画
                                  if (u.isNew)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: AnimatedBuilder(
                                        animation: _pulseAnimation,
                                        builder: (context, child) {
                                          return Transform.scale(
                                            scale: _pulseAnimation.value,
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: const Color(0xFF00EED1),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xFF00EED1)
                                                            .withOpacity(0.5),
                                                    blurRadius: 4,
                                                    offset: const Offset(0, 1),
                                                  ),
                                                ],
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'N',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  // 国旗标识
                                  if (u.countryFlag?.isNotEmpty == true)
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.3)),
                                        ),
                                        child: Center(
                                          child: Text(
                                            u.countryFlag!,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemCount: likedMeUsers.length > 16
                              ? 17
                              : likedMeUsers.length,
                        ),
                      ),
                      // 分割线
                      Container(
                        margin:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.grey.withOpacity(0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      // if (isMember)
                      //   Container(
                      //       margin:
                      //           EdgeInsets.only(top: 0, left: 16, right: 16),
                      //       alignment: Alignment.center,
                      //       child: FilledButton.tonal(
                      //         onPressed: () {
                      //           SonaAnalytics.log('chatlist_gopay');
                      //           widget.onShowAll();
                      //         },
                      //         style: ButtonStyle(
                      //             backgroundColor: MaterialStatePropertyAll(
                      //                 Color(0xFFF6F3F3))),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Text(S.of(context).seeWhoLikeU,
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .titleSmall),
                      //             SonaIcon(icon: SonaIcons.forward)
                      //           ],
                      //         ),
                      //       ))
                    ],
                  ),
                );
        },
        error: (error, stackTrace) => Container(),
        loading: () => Container());
  }
}
