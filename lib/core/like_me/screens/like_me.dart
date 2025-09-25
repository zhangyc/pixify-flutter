import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/screens/other_user_profile.dart';
import 'package:sona/core/like_me/providers/liked_me.dart';
import 'package:sona/core/subscribe/model/member.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/utils/dialog/subsciption.dart';

import '../../../common/widgets/image/user_avatar.dart';
import '../../../generated/l10n.dart';
import '../models/social_user.dart';

class LikeMeScreen extends StatefulHookConsumerWidget {
  const LikeMeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LikeMeScreenState();
}

class _LikeMeScreenState extends ConsumerState<LikeMeScreen>
    with AutomaticKeepAliveClientMixin {
  late bool isPlus;
  late double itemWidth;
  late double itemHeight;

  @override
  void didChangeDependencies() {
    itemWidth = (MediaQuery.of(context).size.width - 16 * 6 - 12) / 2;
    itemHeight = itemWidth * 4 / 3;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    isPlus = ref.watch(myProfileProvider)!.memberType == MemberType.plus;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).whoLikesU,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(fontSize: 28, fontWeight: FontWeight.w900)),
        centerTitle: false,
      ),
      body: ref.watch(likeMeStreamProvider).when(
          data: (data) => data.isNotEmpty
              ? MasonryGridView.builder(
                  padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: MediaQuery.of(context).padding.bottom + 130),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 12,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    // 埋点：卡片曝光
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _trackCardImpression(data[index], index);
                    });
                    return _itemBuilder(data[index], index);
                  },
                  itemCount: data.length)
              : _dataEmpty(),
          error: (_, __) => _dataEmpty(),
          loading: () => Center(
              child: SizedBox(
                  width: 32, height: 32, child: CircularProgressIndicator()))),
      floatingActionButton: _buildSmartCTA(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _itemBuilder(SocialUser u, int index) {
    // 渐进式展示逻辑：前3个清晰，后续模糊
    bool shouldBlur = !isPlus && index >= 0;
    // 模拟星盘匹配度（后续从API获取）
    int? astroScore = u.hang.isNotEmpty ? (80 + (u.id % 20)) : null;
    bool isHighMatch = astroScore != null && astroScore > 85;

    return Container(
      key: ValueKey(u.id),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighMatch ? Color(0xFFF8F4FF) : Color(0xFFF6F3F3),
        borderRadius: BorderRadius.circular(20),
        border: isHighMatch
            ? Border.all(color: Colors.purple.withOpacity(0.3), width: 1)
            : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: itemHeight,
            width: itemWidth,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Container(
                  height: itemHeight,
                  width: itemWidth,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  child: (!shouldBlur)
                      ? GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            _trackCardClick(u, index);
                            Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (_) => OtherUserProfileScreen(
                                          userId: u.id,
                                          relation: Relation.likeMe,
                                        )));
                          },
                          child: AspectRatio(
                            aspectRatio: 0.75,
                            child: UserAvatar(
                              url: u.avatar,
                              size: Size(itemWidth, itemHeight),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        )
                      : GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            _trackPaywallView('like_me_card');
                            showSubscription(FromTag.pay_chatlist_likedme);
                          },
                          child: ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaY: 18, sigmaX: 18),
                            child: AspectRatio(
                              aspectRatio: 0.75,
                              child: UserAvatar(
                                url: u.avatar,
                                size: Size(itemWidth, itemHeight),
                              ),
                            ),
                          ),
                        ),
                )),
                // 星盘匹配度徽章
                if (astroScore != null && !shouldBlur)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: isHighMatch
                            ? LinearGradient(
                                colors: [Colors.purple, Colors.pink])
                            : LinearGradient(colors: [
                                Colors.blue.shade400,
                                Colors.cyan.shade300
                              ]),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: (isHighMatch ? Colors.purple : Colors.blue)
                                .withOpacity(0.3),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome,
                              color: Colors.white, size: 12),
                          SizedBox(width: 4),
                          Text('${astroScore}%',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                // 命定标识
                if (isHighMatch && !shouldBlur)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.4),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Text(
                        '⭐${S.of(context).destinyMatch}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                // 原有标签（调整位置避免冲突）
                if (u.displayTag != null && !isHighMatch)
                  Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1),
                              color: Colors.black.withOpacity(0.45)),
                          clipBehavior: Clip.antiAlias,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          child: Text(
                            u.displayTag!,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                          ))),
                // 国家旗帜
                Positioned(
                    bottom: 12, right: 12, child: Text(u.countryFlag ?? ''))
              ],
            ),
          ),
          if (isPlus)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                u.name!,
                style: Theme.of(context).textTheme.labelSmall,
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          if (u.hang.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text.rich(
                TextSpan(children: [
                  // TextSpan(text: '"', style: Theme.of(context).textTheme.headlineMedium),
                  TextSpan(
                      text: S.of(context).imInterestedSomething("'${u.hang}'")),
                  // TextSpan(text: '"', style: Theme.of(context).textTheme.headlineMedium)
                ]),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w500),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                S.of(context).likedYou,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          // 快速操作按钮
          if (!shouldBlur)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _actionButton(
                    icon: Icons.favorite_outline,
                    label: S.of(context).likeBack,
                    onTap: () => _handleLikeBack(u, index),
                  ),
                  _actionButton(
                    icon: Icons.chat_bubble_outline,
                    label: S.of(context).startChat,
                    onTap: () => _handleStartChat(u, index),
                  ),
                  if (isPlus && astroScore != null)
                    _actionButton(
                      icon: Icons.auto_awesome,
                      label: S.of(context).astroReport,
                      onTap: () => _handleAstroReport(u, index),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _dataEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 添加动画效果的空状态图片
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(seconds: 2),
            builder: (context, double value, child) {
              return Transform.rotate(
                angle: value * 0.1,
                child: Opacity(
                  opacity: 0.7 + (value * 0.3),
                  child: Image.asset('assets/images/empty_yin_yang.png',
                      width: 115),
                ),
              );
            },
          ),
          SizedBox(height: 24),
          Text(
            "✨ ${S.of(context).noOneFoundYourCharm}",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              S.of(context).completeAstroProfile,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24),
          // ElevatedButton.icon(
          //   onPressed: () => _navigateToAstroOnboarding(),
          //   icon: Icon(Icons.auto_awesome, size: 18),
          //   label: Text(S.of(context).completeAstroProfileButton),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Theme.of(context).primaryColor,
          //     foregroundColor: Colors.white,
          //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //   ),
          // ),
          SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => _showTipsDialog(),
            icon: Icon(Icons.lightbulb_outline, size: 16),
            label: Text(S.of(context).charmTips),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // 跳转到星盘资料完善页面
  void _navigateToAstroOnboarding() {
    // TODO: 实现跳转到星盘资料页面
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text(S.of(context).navigateToAstroProfile)),
    // );
  }

  // 显示提升魅力小贴士弹窗
  void _showTipsDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.amber),
            SizedBox(width: 8),
            Text(S.of(context).charmTips),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tipItem('📸', S.of(context).uploadQualityPhotos),
            _tipItem('✍️', S.of(context).writeInterestingBio),
            _tipItem('⭐', S.of(context).completeAstroInfo),
            _tipItem('💬', S.of(context).chatWithMatches),
            _tipItem('🎯', S.of(context).setInterestTags),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).gotIt),
          ),
        ],
      ),
    );
  }

  Widget _tipItem(String emoji, String tip) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: TextStyle(fontSize: 16)),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // 快速操作按钮组件
  Widget _actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300, width: 0.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: Theme.of(context).primaryColor),
              SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 处理回赞
  void _handleLikeBack(SocialUser user, int index) {
    print('like_back: user_id=${user.id}');
    // TODO: 实现回赞逻辑
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${S.of(context).likedBack} ${user.name}')),
    );
  }

  // 处理开聊
  void _handleStartChat(SocialUser user, int index) {
    print('start_chat: user_id=${user.id}');
    // TODO: 跳转到聊天页面
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${S.of(context).startedChat} ${user.name}')),
    );
  }

  // 处理星盘合盘
  void _handleAstroReport(SocialUser user, int index) {
    print('astro_report: user_id=${user.id}');
    // TODO: 显示星盘合盘报告
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${S.of(context).viewAstroReport} ${user.name}')),
    );
  }

  // 智能CTA按钮
  Widget? _buildSmartCTA(BuildContext context) {
    final data = ref.watch(likeMeStreamProvider).value;
    if (data == null || data.isEmpty) return null;

    final visibleCount = isPlus ? data.length : 3;
    final hiddenCount =
        data.length > visibleCount ? data.length - visibleCount : 0;
    final highMatchCount =
        data.where((u) => u.hang.isNotEmpty && (80 + (u.id % 20)) > 85).length;

    if (!isPlus && hiddenCount > 0) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _trackPaywallView('like_me_smart_cta');
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (_) =>
                        SubscribePage(fromTag: FromTag.pay_chatlist_likedme)));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFBEFF06),
            foregroundColor: Colors.black,
            minimumSize: Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 4,
            shadowColor: Color(0xFFBEFF06).withOpacity(0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome, size: 20),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  highMatchCount > 0
                      ? S
                          .of(context)
                          .unlockUsersWithDestiny(hiddenCount, highMatchCount)
                      : S.of(context).unlockHighMatchUsers(hiddenCount),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return null;
  }

  // 埋点方法
  void _trackCardImpression(SocialUser user, int index) {
    // TODO: 替换为实际的埋点SDK调用
    print(
        'astro_card_impression: user_id=${user.id}, position=$index, is_plus=$isPlus');
  }

  void _trackCardClick(SocialUser user, int index) {
    print('astro_card_click: user_id=${user.id}, position=$index');
  }

  void _trackPaywallView(String trigger) {
    print('astro_paywall_view: trigger=$trigger, source=like_me');
  }

  @override
  bool get wantKeepAlive => true;
}
