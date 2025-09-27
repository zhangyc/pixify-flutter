// import 'dart:math';

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/screens/profile.dart';
import 'package:sona/common/services/common.dart';
import 'package:sona/common/services/global_notification_service.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/match/widgets/location_selector.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/image_compress_util.dart';
import 'package:sona/utils/toast/flutter_toast.dart';
// import 'package:sona/core/persona/providers/profile_progress.dart';
// import 'package:sona/core/persona/widgets/profile_progress_indicator.dart';
// import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/setting/screens/setting.dart';

import '../../../generated/l10n.dart';
import '../../subscribe/model/member.dart';

class PersonaScreen extends ConsumerStatefulWidget {
  const PersonaScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonaScreenState();
}

class _PersonaScreenState extends ConsumerState<PersonaScreen>
    with AutomaticKeepAliveClientMixin {
  Future<void> _onChangeAvatar(BuildContext context, WidgetRef ref) async {
    try {
      // 选择图片来源
      final source = await showActionButtons(context: context, options: {
        S.of(context).photoFromGallery: ImageSource.gallery,
        S.of(context).photoFromCamera: ImageSource.camera
      });

      if (source == null) return;

      final picker = ImagePicker();
      final file = await picker.pickImage(source: source);

      if (file == null) return;

      // 检查文件格式
      if (file.name.toLowerCase().endsWith('.gif')) {
        Fluttertoast.showToast(msg: 'GIF is not allowed');
        return;
      }

      // 压缩图片
      File? fileResult = await ImageCompressUtil.compressImage(File(file.path));
      Uint8List? bytes = await fileResult?.readAsBytes();

      if (bytes == null) return;

      final avatar = await uploadImage(bytes: bytes);

      // 上传头像
      final success = await ref.read(myProfileProvider.notifier).updateFields(
            avatar: avatar,
          );

      if (success) {
        Fluttertoast.showToast(msg: S.of(context).userAvatarUploadedLabel);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: S.of(context).avatarUpdateFailed);
    }
  }

  @override
  void initState() {
    super.initState();
    if (ref.read(myProfileProvider)?.birthLongitude == null) {
      /// 使用全局提示框提示用户去完善出生地信息
      Future.delayed(const Duration(seconds: 2), () {
        GlobalNotifications.showAstroNotification(
          title: S.current.infoIncompleteTitle,
          content: S.current.completeBirthLocationInfo,
          onTap: () {
            LocationSelectorBottomSheet.show(context,
                onLocationSelected: (city, lat, lng) {
              ref.read(myProfileProvider.notifier).updateFields(
                  birthCity: city,
                  birthLatitude: lat.toString(),
                  birthLongitude: lng.toString());

              /// 关闭通知
              GlobalNotifications.hide();
            });
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final myProfile = ref.watch(myProfileProvider)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // appBar: AppBar(
      //   title: Text(
      //     '',
      //     style: Theme.of(context).textTheme.titleLarge?.copyWith(
      //           fontWeight: FontWeight.w700,
      //         ),
      //   ),
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   elevation: 0,
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            // 用户信息卡片
            _buildUserCard(context, myProfile),
            const SizedBox(height: 24),
            // 信息卡片组
            _buildInfoCards(context, myProfile),
            // 快捷操作网格
            _buildQuickActions(context),

            SizedBox(height: 32 + MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  // 用户信息卡片
  Widget _buildUserCard(BuildContext context, MyProfile myProfile) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1C1C1E)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white.withOpacity(0.06)
              : Colors.black.withOpacity(0.06),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 头像 + 编辑图标
          Stack(
            children: [
              UserAvatar(
                url: myProfile.avatar,
                name: myProfile.name,
                memberType:
                    myProfile.isMember ? MemberType.plus : MemberType.none,
                size: const Size.square(80),
              ),
              // 编辑头像图标
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () => _onChangeAvatar(context, ref),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).primaryColor,
                      size: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // 用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 姓名和年龄
                Row(
                  children: [
                    Text(
                      '${myProfile.name}, ${myProfile.birthday?.toAge()}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // 位置信息
                if (myProfile.countryFlag != null ||
                    myProfile.countryCode != null)
                  Row(
                    children: [
                      if (myProfile.countryFlag != null)
                        Text(
                          myProfile.countryFlag!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      if (myProfile.countryCode != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          myProfile.countryCode!,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ],
                  ),
                const SizedBox(height: 8),
                // 会员状态
                if (myProfile.isMember)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9370DB).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF9370DB).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFF9370DB),
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          S.of(context).plusMember,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFF9370DB),
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 快捷操作网格
  Widget _buildQuickActions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 16),
            child: Text(
              S.of(context).quickActions,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.1,
            children: [
              _buildQuickActionItem(
                context,
                icon: Icons.edit,
                title: S.of(context).editProfile,
                color: Theme.of(context).primaryColor,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const ProfileScreen(),
                  ),
                ),
              ),
              _buildQuickActionItem(
                context,
                icon: Icons.star,
                title: S.of(context).memberCenter,
                color: const Color(0xFF9370DB),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        const SubscribePage(fromTag: FromTag.profile_myplan),
                  ),
                ),
              ),
              _buildQuickActionItem(
                context,
                icon: Icons.settings,
                title: S.of(context).settings,
                color: Theme.of(context).colorScheme.secondary,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const SettingScreen(),
                  ),
                ),
              ),
              // _buildQuickActionItem(
              //   context,
              //   icon: Icons.bar_chart,
              //   title: '数据统计',
              //   color: const Color(0xFF4CAF50),
              //   onTap: () {
              //     // TODO: 跳转到数据统计页面
              //   },
              // ),
            ],
          ),
        ],
      ),
    );
  }

  // 单个快捷操作项
  Widget _buildQuickActionItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF1C1C1E)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.06)
                : Colors.black.withOpacity(0.06),
            width: 0.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // 信息卡片组
  Widget _buildInfoCards(BuildContext context, MyProfile myProfile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 个人简介卡片
        if (myProfile.bio != null && myProfile.bio!.isNotEmpty) ...[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF1C1C1E)
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.06)
                    : Colors.black.withOpacity(0.06),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      S.of(context).bio,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  myProfile.bio!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        // 兴趣标签卡片
        if (myProfile.interests.isNotEmpty) ...[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF1C1C1E)
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.06)
                    : Colors.black.withOpacity(0.06),
                width: 0.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.favorite_outline,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      S.of(context).interests,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: myProfile.interests
                      .take(12)
                      .map((dynamic interest) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? const Color(0xFF2C2C2E)
                                  : const Color(0xFFF2F2F7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              interest.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ))
                      .toList(),
                ),
                if (myProfile.interests.length > 12)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      '+${myProfile.interests.length - 12} more',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withOpacity(0.7),
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        // // 数据统计卡片
        // Container(
        //   margin: const EdgeInsets.symmetric(horizontal: 16),
        //   padding: const EdgeInsets.all(20),
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).brightness == Brightness.dark
        //         ? const Color(0xFF1C1C1E)
        //         : Colors.white,
        //     borderRadius: BorderRadius.circular(16),
        //     border: Border.all(
        //       color: Theme.of(context).brightness == Brightness.dark
        //           ? Colors.white.withOpacity(0.06)
        //           : Colors.black.withOpacity(0.06),
        //       width: 0.5,
        //     ),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Theme.of(context).brightness == Brightness.dark
        //             ? Colors.black.withOpacity(0.2)
        //             : Colors.black.withOpacity(0.04),
        //         blurRadius: 12,
        //         offset: const Offset(0, 3),
        //       ),
        //     ],
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Row(
        //         children: [
        //           Icon(
        //             Icons.bar_chart,
        //             color: Theme.of(context).primaryColor,
        //             size: 20,
        //           ),
        //           const SizedBox(width: 8),
        //           Text(
        //             '数据统计',
        //             style: Theme.of(context).textTheme.titleMedium?.copyWith(
        //                   fontWeight: FontWeight.w700,
        //                   color: Theme.of(context).colorScheme.onSurface,
        //                 ),
        //           ),
        //         ],
        //       ),
        //       const SizedBox(height: 16),
        //       Row(
        //         children: [
        //           Expanded(
        //             child: _buildStatItem(
        //               context,
        //               icon: Icons.favorite,
        //               value: '0', // TODO: 从API获取真实数据
        //               label: '喜欢',
        //               color: const Color(0xFFE91E63),
        //             ),
        //           ),
        //           Expanded(
        //             child: _buildStatItem(
        //               context,
        //               icon: Icons.message,
        //               value: '0', // TODO: 从API获取真实数据
        //               label: '消息',
        //               color: const Color(0xFF2196F3),
        //             ),
        //           ),
        //           Expanded(
        //             child: _buildStatItem(
        //               context,
        //               icon: Icons.visibility,
        //               value: '0', // TODO: 从API获取真实数据
        //               label: '浏览',
        //               color: const Color(0xFF4CAF50),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  // 统计数据项
  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
