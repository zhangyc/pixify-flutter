// import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/screens/profile.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
// import 'package:sona/core/persona/providers/profile_progress.dart';
// import 'package:sona/core/persona/widgets/profile_progress_indicator.dart';
// import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/setting/screens/setting.dart';

import '../../../generated/l10n.dart';
import '../../subscribe/model/member.dart';

class PersonaScreen extends StatefulHookConsumerWidget {
  const PersonaScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonaScreenState();
}

class _PersonaScreenState extends ConsumerState<PersonaScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final myProfile = ref.watch(myProfileProvider)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            stretch: true,
            elevation: 0,
            expandedHeight: 280,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (myProfile.photos.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: myProfile.photos.first.url,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0.30),
                            Theme.of(context).primaryColor.withOpacity(0.10),
                          ],
                        ),
                      ),
                    ),
                  // 顶部到底部的暗化渐变，保证前景可读性
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                      ),
                    ),
                  ),
                  // 底部内容：头像、名称、国家
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 头像 + 会员徽章
                        Stack(
                          children: [
                            UserAvatar(
                              url: myProfile.avatar,
                              // size: const Size.square(72),
                              name: myProfile.name,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: switch (
                                    ref.read(myProfileProvider)?.memberType) {
                                  MemberType.club => SonaIcon(
                                      icon: SonaIcons.club_mark, size: 14),
                                  MemberType.plus => SonaIcon(
                                      icon: SonaIcons.plus_mark, size: 14),
                                  _ => const SizedBox.shrink(),
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${myProfile.name}, ${myProfile.birthday?.toAge()}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (myProfile.countryFlag != null ||
                                  myProfile.countryCode != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.25),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (myProfile.countryFlag != null)
                                        Text(myProfile.countryFlag!,
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      if (myProfile.countryCode != null) ...[
                                        const SizedBox(width: 4),
                                        Text(
                                          myProfile.countryCode!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // 编辑
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.3), width: 1),
                          ),
                          child: IconButton(
                            iconSize: 20,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (_) => const ProfileScreen()),
                            ),
                            icon: const SonaIcon(
                                icon: SonaIcons.edit, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // 内容分组
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                // About 分组
                if (myProfile.bio != null && myProfile.bio!.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
                    child: Text(
                      S.of(context).bio,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF1C1C1E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.06)
                            : Colors.black.withOpacity(0.06),
                        width: 0.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        myProfile.bio!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ],
                if (myProfile.bio != null && myProfile.bio!.isNotEmpty)
                  const SizedBox(height: 12),
                // Interests 分组
                if (myProfile.interests.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
                    child: Text(
                      S.of(context).interests,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant
                                .withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF1C1C1E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.06)
                            : Colors.black.withOpacity(0.06),
                        width: 0.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 10,
                            children: myProfile.interests
                                .take(12)
                                .map((interest) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? const Color(0xFF2C2C2E)
                                            : const Color(0xFFF2F2F7),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        interest.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ))
                                .toList(),
                          ),
                          if (myProfile.interests.length > 12)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                '+${myProfile.interests.length - 12} more',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
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
                  ),
                ],
                const SizedBox(height: 12),
                // 设置
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1C1C1E)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.06)
                          : Colors.black.withOpacity(0.06),
                      width: 0.5,
                    ),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: SonaIcon(
                        icon: SonaIcons.settings,
                        color: Theme.of(context).primaryColor),
                    title: Text(S.of(context).settings),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: _goSetting,
                  ),
                ),
                const SizedBox(height: 16),
                // 运营点位
                _buildGrowthCards(context),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );

    // return Scaffold(
    //   resizeToAvoidBottomInset: true,
    //   body: Stack(
    //     children: [
    //       SingleChildScrollView(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: [
    //             // 头图背景区域
    //             Container(
    //               height: 300,
    //               margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(24),
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Theme.of(context).brightness == Brightness.dark
    //                         ? Colors.black.withOpacity(0.4)
    //                         : Colors.black.withOpacity(0.15),
    //                     blurRadius: 24,
    //                     offset: const Offset(0, 12),
    //                   ),
    //                 ],
    //               ),
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.circular(24),
    //                 child: Stack(
    //                   children: [
    //                     // 背景图片
    //                     if (myProfile.photos.isNotEmpty)
    //                       CachedNetworkImage(
    //                         imageUrl: myProfile.photos.first.url,
    //                         fit: BoxFit.cover,
    //                         width: double.infinity,
    //                         height: double.infinity,
    //                         placeholder: (context, url) => Container(
    //                           decoration: BoxDecoration(
    //                             gradient: LinearGradient(
    //                               begin: Alignment.topLeft,
    //                               end: Alignment.bottomRight,
    //                               colors: [
    //                                 Theme.of(context)
    //                                     .primaryColor
    //                                     .withOpacity(0.3),
    //                                 Theme.of(context)
    //                                     .primaryColor
    //                                     .withOpacity(0.1),
    //                               ],
    //                             ),
    //                           ),
    //                           child: Center(
    //                             child: CircularProgressIndicator(
    //                               color: Colors.white,
    //                             ),
    //                           ),
    //                         ),
    //                         errorWidget: (context, url, error) => Container(
    //                           decoration: BoxDecoration(
    //                             gradient: LinearGradient(
    //                               begin: Alignment.topLeft,
    //                               end: Alignment.bottomRight,
    //                               colors: [
    //                                 Theme.of(context)
    //                                     .primaryColor
    //                                     .withOpacity(0.3),
    //                                 Theme.of(context)
    //                                     .primaryColor
    //                                     .withOpacity(0.1),
    //                               ],
    //                             ),
    //                           ),
    //                           child: Center(
    //                             child: Icon(
    //                               Icons.image_not_supported_outlined,
    //                               color: Colors.white,
    //                               size: 48,
    //                             ),
    //                           ),
    //                         ),
    //                       )
    //                     else
    //                       Container(
    //                         decoration: BoxDecoration(
    //                           gradient: LinearGradient(
    //                             begin: Alignment.topLeft,
    //                             end: Alignment.bottomRight,
    //                             colors: [
    //                               Theme.of(context)
    //                                   .primaryColor
    //                                   .withOpacity(0.3),
    //                               Theme.of(context)
    //                                   .primaryColor
    //                                   .withOpacity(0.1),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     // 渐变遮罩
    //                     Container(
    //                       decoration: BoxDecoration(
    //                         gradient: LinearGradient(
    //                           begin: Alignment.topCenter,
    //                           end: Alignment.bottomCenter,
    //                           colors: [
    //                             Colors.black.withOpacity(0.1),
    //                             Colors.black.withOpacity(0.7),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                     // 内容
    //                     Positioned(
    //                       bottom: 0,
    //                       left: 0,
    //                       right: 0,
    //                       child: Container(
    //                         padding: const EdgeInsets.all(24),
    //                         child: Column(
    //                           mainAxisSize: MainAxisSize.min,
    //                           children: [
    //                             // 头像和编辑按钮
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 const SizedBox(width: 48),
    //                                 // 头像
    //                                 Stack(
    //                                   children: [
    //                                     Container(
    //                                       decoration: BoxDecoration(
    //                                         shape: BoxShape.circle,
    //                                         border: Border.all(
    //                                           color:
    //                                               Colors.white.withOpacity(0.3),
    //                                           width: 3,
    //                                         ),
    //                                         boxShadow: [
    //                                           BoxShadow(
    //                                             color: Colors.black
    //                                                 .withOpacity(0.3),
    //                                             blurRadius: 12,
    //                                             offset: const Offset(0, 4),
    //                                           ),
    //                                         ],
    //                                       ),
    //                                       padding: const EdgeInsets.all(4),
    //                                       child: UserAvatar(
    //                                         url: myProfile.avatar,
    //                                         size: const Size.square(80),
    //                                         name: myProfile.name,
    //                                       ),
    //                                     ),
    //                                     // 会员标识
    //                                     Positioned(
    //                                       bottom: 0,
    //                                       right: 0,
    //                                       child: Container(
    //                                         decoration: BoxDecoration(
    //                                           color: Theme.of(context)
    //                                               .colorScheme
    //                                               .surface,
    //                                           shape: BoxShape.circle,
    //                                           border: Border.all(
    //                                             color: Theme.of(context)
    //                                                 .primaryColor,
    //                                             width: 2,
    //                                           ),
    //                                         ),
    //                                         padding: const EdgeInsets.all(4),
    //                                         child: switch (ref
    //                                             .read(myProfileProvider)
    //                                             ?.memberType) {
    //                                           MemberType.club => SonaIcon(
    //                                               icon: SonaIcons.club_mark,
    //                                               size: 16,
    //                                             ),
    //                                           MemberType.plus => SonaIcon(
    //                                               icon: SonaIcons.plus_mark,
    //                                               size: 16,
    //                                             ),
    //                                           _ => const SizedBox.shrink(),
    //                                         },
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 // 编辑按钮
    //                                 Container(
    //                                   decoration: BoxDecoration(
    //                                     color: Colors.white.withOpacity(0.2),
    //                                     borderRadius: BorderRadius.circular(20),
    //                                     border: Border.all(
    //                                       color: Colors.white.withOpacity(0.3),
    //                                       width: 1,
    //                                     ),
    //                                   ),
    //                                   child: IconButton(
    //                                     iconSize: 20,
    //                                     onPressed: () => Navigator.push(
    //                                         context,
    //                                         MaterialPageRoute<void>(
    //                                             builder: (_) =>
    //                                                 const ProfileScreen())),
    //                                     icon: SonaIcon(
    //                                         icon: SonaIcons.edit,
    //                                         color: Colors.white),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                             const SizedBox(height: 16),
    //                             // 姓名和年龄
    //                             Text(
    //                               '${myProfile.name}, ${myProfile.birthday?.toAge()}',
    //                               style: Theme.of(context)
    //                                   .textTheme
    //                                   .headlineSmall
    //                                   ?.copyWith(
    //                                 fontWeight: FontWeight.w700,
    //                                 color: Colors.white,
    //                                 shadows: [
    //                                   Shadow(
    //                                     color: Colors.black.withOpacity(0.5),
    //                                     blurRadius: 8,
    //                                     offset: const Offset(0, 2),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             const SizedBox(height: 8),
    //                             // 位置信息
    //                             if (myProfile.countryFlag != null ||
    //                                 myProfile.countryCode != null)
    //                               Container(
    //                                 padding: const EdgeInsets.symmetric(
    //                                     horizontal: 12, vertical: 6),
    //                                 decoration: BoxDecoration(
    //                                   color: Colors.white.withOpacity(0.2),
    //                                   borderRadius: BorderRadius.circular(16),
    //                                 ),
    //                                 child: Row(
    //                                   mainAxisSize: MainAxisSize.min,
    //                                   children: [
    //                                     if (myProfile.countryFlag != null)
    //                                       Text(
    //                                         myProfile.countryFlag!,
    //                                         style:
    //                                             const TextStyle(fontSize: 16),
    //                                       ),
    //                                     if (myProfile.countryCode != null) ...[
    //                                       const SizedBox(width: 4),
    //                                       Text(
    //                                         myProfile.countryCode!,
    //                                         style: Theme.of(context)
    //                                             .textTheme
    //                                             .bodySmall
    //                                             ?.copyWith(
    //                                               color: Colors.white,
    //                                               fontWeight: FontWeight.w500,
    //                                             ),
    //                                       ),
    //                                     ],
    //                                   ],
    //                                 ),
    //                               ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             // 简介和兴趣标签卡片
    //             if (myProfile.bio != null && myProfile.bio!.isNotEmpty ||
    //                 myProfile.interests.isNotEmpty)
    //               Container(
    //                 margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
    //                 padding: const EdgeInsets.all(20),
    //                 decoration: BoxDecoration(
    //                   color: Theme.of(context).colorScheme.surface,
    //                   borderRadius: BorderRadius.circular(20),
    //                   border: Border.all(
    //                     color: Theme.of(context).primaryColor.withOpacity(0.1),
    //                     width: 1,
    //                   ),
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Theme.of(context).brightness == Brightness.dark
    //                           ? Colors.black.withOpacity(0.2)
    //                           : Colors.black.withOpacity(0.05),
    //                       blurRadius: 12,
    //                       offset: const Offset(0, 4),
    //                     ),
    //                   ],
    //                 ),
    //                 child: Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                       padding: EdgeInsets.all(12),
    //                       decoration: BoxDecoration(
    //                         color:
    //                             Theme.of(context).brightness == Brightness.dark
    //                                 ? const Color(0xFF12121B)
    //                                 : Colors.white,
    //                         borderRadius: BorderRadius.circular(24),
    //                         boxShadow: [
    //                           if (Theme.of(context).brightness ==
    //                               Brightness.dark)
    //                             BoxShadow(
    //                               color: Theme.of(context)
    //                                   .primaryColor
    //                                   .withOpacity(0.06),
    //                               blurRadius: 18,
    //                               offset: const Offset(0, 0),
    //                             ),
    //                         ],
    //                       ),
    //                       child: Column(
    //                         mainAxisSize: MainAxisSize.min,
    //                         children: [
    //                           // 顶部编辑按钮
    //                           Row(
    //                             mainAxisAlignment: MainAxisAlignment.end,
    //                             children: [
    //                               Container(
    //                                 decoration: BoxDecoration(
    //                                   color:
    //                                       Theme.of(context).colorScheme.surface,
    //                                   borderRadius: BorderRadius.circular(20),
    //                                   border: Border.all(
    //                                     color: Theme.of(context)
    //                                         .primaryColor
    //                                         .withOpacity(0.2),
    //                                     width: 1,
    //                                   ),
    //                                 ),
    //                                 child: IconButton(
    //                                   iconSize: 20,
    //                                   onPressed: () => Navigator.push(
    //                                       context,
    //                                       MaterialPageRoute<void>(
    //                                           builder: (_) =>
    //                                               const ProfileScreen())),
    //                                   icon: SonaIcon(
    //                                       icon: SonaIcons.edit,
    //                                       color:
    //                                           Theme.of(context).primaryColor),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(height: 16),
    //                           // 头像
    //                           Stack(
    //                             children: [
    //                               Container(
    //                                 decoration: BoxDecoration(
    //                                   shape: BoxShape.circle,
    //                                   gradient: LinearGradient(
    //                                     begin: Alignment.topLeft,
    //                                     end: Alignment.bottomRight,
    //                                     colors: [
    //                                       Theme.of(context)
    //                                           .primaryColor
    //                                           .withOpacity(0.3),
    //                                       Theme.of(context)
    //                                           .primaryColor
    //                                           .withOpacity(0.1),
    //                                     ],
    //                                   ),
    //                                   boxShadow: [
    //                                     BoxShadow(
    //                                       color: Theme.of(context)
    //                                           .primaryColor
    //                                           .withOpacity(0.2),
    //                                       blurRadius: 20,
    //                                       offset: const Offset(0, 8),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 padding: const EdgeInsets.all(4),
    //                                 child: UserAvatar(
    //                                   url: myProfile.avatar,
    //                                   size: const Size.square(80),
    //                                   name: myProfile.name,
    //                                 ),
    //                               ),
    //                               // 会员标识
    //                               Positioned(
    //                                 bottom: 0,
    //                                 right: 0,
    //                                 child: Container(
    //                                   decoration: BoxDecoration(
    //                                     color: Theme.of(context)
    //                                         .colorScheme
    //                                         .surface,
    //                                     shape: BoxShape.circle,
    //                                     border: Border.all(
    //                                       color: Theme.of(context).primaryColor,
    //                                       width: 2,
    //                                     ),
    //                                   ),
    //                                   padding: const EdgeInsets.all(4),
    //                                   child: switch (ref
    //                                       .read(myProfileProvider)
    //                                       ?.memberType) {
    //                                     MemberType.club => SonaIcon(
    //                                         icon: SonaIcons.club_mark,
    //                                         size: 16,
    //                                       ),
    //                                     MemberType.plus => SonaIcon(
    //                                         icon: SonaIcons.plus_mark,
    //                                         size: 16,
    //                                       ),
    //                                     _ => const SizedBox.shrink(),
    //                                   },
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           SizedBox(height: 20),
    //                           // 姓名和年龄
    //                           Text(
    //                             '${myProfile.name}, ${myProfile.birthday?.toAge()}',
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .headlineSmall
    //                                 ?.copyWith(
    //                                   fontWeight: FontWeight.w700,
    //                                   color: Theme.of(context)
    //                                       .colorScheme
    //                                       .onSurface,
    //                                 ),
    //                           ),
    //                           SizedBox(height: 8),
    //                           // 位置信息
    //                           if (myProfile.countryFlag != null ||
    //                               myProfile.countryCode != null)
    //                             Container(
    //                               padding: const EdgeInsets.symmetric(
    //                                   horizontal: 12, vertical: 6),
    //                               decoration: BoxDecoration(
    //                                 color: Theme.of(context)
    //                                     .colorScheme
    //                                     .surfaceVariant
    //                                     .withOpacity(0.6),
    //                                 borderRadius: BorderRadius.circular(16),
    //                               ),
    //                               child: Row(
    //                                 mainAxisSize: MainAxisSize.min,
    //                                 children: [
    //                                   if (myProfile.countryFlag != null)
    //                                     Text(
    //                                       myProfile.countryFlag!,
    //                                       style: const TextStyle(fontSize: 16),
    //                                     ),
    //                                   if (myProfile.countryCode != null) ...[
    //                                     const SizedBox(width: 4),
    //                                     Text(
    //                                       myProfile.countryCode!,
    //                                       style: Theme.of(context)
    //                                           .textTheme
    //                                           .bodySmall
    //                                           ?.copyWith(
    //                                             color: Theme.of(context)
    //                                                 .colorScheme
    //                                                 .onSurfaceVariant,
    //                                             fontWeight: FontWeight.w500,
    //                                           ),
    //                                     ),
    //                                   ],
    //                                 ],
    //                               ),
    //                             ),
    //                           SizedBox(height: 16),
    //                           // 个人简介
    //                           if (myProfile.bio != null &&
    //                               myProfile.bio!.isNotEmpty)
    //                             Container(
    //                               width: double.infinity,
    //                               padding: const EdgeInsets.all(16),
    //                               decoration: BoxDecoration(
    //                                 color: Theme.of(context)
    //                                     .colorScheme
    //                                     .surfaceVariant
    //                                     .withOpacity(0.4),
    //                                 borderRadius: BorderRadius.circular(16),
    //                                 border: Border.all(
    //                                   color: Theme.of(context)
    //                                       .primaryColor
    //                                       .withOpacity(0.1),
    //                                   width: 1,
    //                                 ),
    //                               ),
    //                               child: Text(
    //                                 myProfile.bio!,
    //                                 textAlign: TextAlign.center,
    //                                 style: Theme.of(context)
    //                                     .textTheme
    //                                     .bodyMedium
    //                                     ?.copyWith(
    //                                       color: Theme.of(context)
    //                                           .colorScheme
    //                                           .onSurfaceVariant,
    //                                       height: 1.4,
    //                                     ),
    //                               ),
    //                             ),
    //                           SizedBox(height: 16),
    //                           // 兴趣标签
    //                           if (myProfile.interests.isNotEmpty)
    //                             Wrap(
    //                               spacing: 8,
    //                               runSpacing: 8,
    //                               alignment: WrapAlignment.center,
    //                               children: myProfile.interests
    //                                   .take(4)
    //                                   .map((interest) => Container(
    //                                         padding: const EdgeInsets.symmetric(
    //                                             horizontal: 12, vertical: 6),
    //                                         decoration: BoxDecoration(
    //                                           gradient: LinearGradient(
    //                                             colors: [
    //                                               Theme.of(context)
    //                                                   .primaryColor
    //                                                   .withOpacity(0.1),
    //                                               Theme.of(context)
    //                                                   .primaryColor
    //                                                   .withOpacity(0.05),
    //                                             ],
    //                                           ),
    //                                           borderRadius:
    //                                               BorderRadius.circular(20),
    //                                           border: Border.all(
    //                                             color: Theme.of(context)
    //                                                 .primaryColor
    //                                                 .withOpacity(0.2),
    //                                             width: 1,
    //                                           ),
    //                                         ),
    //                                         child: Text(
    //                                           interest.name,
    //                                           style: Theme.of(context)
    //                                               .textTheme
    //                                               .bodySmall
    //                                               ?.copyWith(
    //                                                 color: Theme.of(context)
    //                                                     .primaryColor,
    //                                                 fontWeight: FontWeight.w600,
    //                                               ),
    //                                         ),
    //                                       ))
    //                                   .toList(),
    //                             ),
    //                           SizedBox(height: 20),
    //                           if (ref.watch(profileProgressProvider) < 1)
    //                             Container(
    //                                 margin: EdgeInsets.only(top: 8),
    //                                 child: ProfileProgressIndicator()),
    //                           SizedBox(height: 10),
    //                           if (!ref.watch(myProfileProvider)!.isMember)
    //                             OutlinedButton(
    //                                 onPressed: () => Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute<void>(
    //                                         builder: (_) => SubscribePage(
    //                                             fromTag:
    //                                                 FromTag.profile_myplan))),
    //                                 style: ButtonStyle(
    //                                   backgroundColor: MaterialStatePropertyAll(
    //                                     Theme.of(context).primaryColor,
    //                                   ),
    //                                   foregroundColor: MaterialStatePropertyAll(
    //                                     Theme.of(context).brightness ==
    //                                             Brightness.dark
    //                                         ? const Color(0xFF0E0E14)
    //                                         : const Color(0xFF2C2C2C),
    //                                   ),
    //                                   shape: MaterialStatePropertyAll(
    //                                     RoundedRectangleBorder(
    //                                       borderRadius:
    //                                           BorderRadius.circular(16),
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 child: Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.spaceBetween,
    //                                   children: [
    //                                     Row(
    //                                       children: [
    //                                         Image.asset(
    //                                             'assets/icons/emoji${Random().nextInt(5)}.png'),
    //                                         SizedBox(
    //                                           width: 6,
    //                                         ),
    //                                         Text(
    //                                             S
    //                                                 .of(context)
    //                                                 .buttonUnlockVipPerks,
    //                                             style: Theme.of(context)
    //                                                 .textTheme
    //                                                 .titleMedium
    //                                                 ?.copyWith(
    //                                                   color: Theme.of(context)
    //                                                               .brightness ==
    //                                                           Brightness.dark
    //                                                       ? const Color(
    //                                                           0xFF0E0E14)
    //                                                       : const Color(
    //                                                           0xFF2C2C2C),
    //                                                 )),
    //                                       ],
    //                                     ),
    //                                     Icon(
    //                                       Icons.arrow_forward_ios_rounded,
    //                                       color: Theme.of(context).brightness ==
    //                                               Brightness.dark
    //                                           ? const Color(0xFF0E0E14)
    //                                           : const Color(0xFF2C2C2C),
    //                                       size: 20,
    //                                     )
    //                                   ],
    //                                 )),
    //                           if (ref.watch(myProfileProvider)!.isMember)
    //                             FilledButton(
    //                                 onPressed: () => Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute<void>(
    //                                         builder: (_) => SubscribePage(
    //                                             fromTag:
    //                                                 FromTag.profile_myplan))),
    //                                 style: ButtonStyle(
    //                                   backgroundColor: MaterialStatePropertyAll(
    //                                     Theme.of(context)
    //                                         .primaryColor
    //                                         .withOpacity(
    //                                           Theme.of(context).brightness ==
    //                                                   Brightness.dark
    //                                               ? 0.14
    //                                               : 0.10,
    //                                         ),
    //                                   ),
    //                                 ),
    //                                 child: Align(
    //                                   alignment: Alignment.centerLeft,
    //                                   child: Text(
    //                                       switch (ref
    //                                           .watch(myProfileProvider)!
    //                                           .memberType) {
    //                                         MemberType.club =>
    //                                           S.current.youAreAClubMemberNow,
    //                                         MemberType.plus =>
    //                                           S.current.buttonAlreadyPlus,
    //                                         _ => ''
    //                                       },
    //                                       style: Theme.of(context)
    //                                           .textTheme
    //                                           .titleMedium
    //                                           ?.copyWith(
    //                                             color: Theme.of(context)
    //                                                 .primaryColor,
    //                                           )),
    //                                 )),
    //                           SizedBox(
    //                             height: 12,
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             // 设置按钮
    //             Container(
    //               margin:
    //                   const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.end,
    //                 children: [
    //                   Container(
    //                     decoration: BoxDecoration(
    //                       color: Theme.of(context).colorScheme.surface,
    //                       borderRadius: BorderRadius.circular(16),
    //                       border: Border.all(
    //                         color:
    //                             Theme.of(context).primaryColor.withOpacity(0.2),
    //                         width: 1,
    //                       ),
    //                       boxShadow: [
    //                         BoxShadow(
    //                           color: Theme.of(context).brightness ==
    //                                   Brightness.dark
    //                               ? Colors.black.withOpacity(0.2)
    //                               : Colors.black.withOpacity(0.05),
    //                           blurRadius: 8,
    //                           offset: const Offset(0, 2),
    //                         ),
    //                       ],
    //                     ),
    //                     child: Material(
    //                       color: Colors.transparent,
    //                       child: InkWell(
    //                         onTap: _goSetting,
    //                         borderRadius: BorderRadius.circular(16),
    //                         child: Padding(
    //                           padding: const EdgeInsets.symmetric(
    //                               horizontal: 16, vertical: 12),
    //                           child: Row(
    //                             mainAxisSize: MainAxisSize.min,
    //                             children: [
    //                               SonaIcon(
    //                                 icon: SonaIcons.settings,
    //                                 color: Theme.of(context).primaryColor,
    //                                 size: 18,
    //                               ),
    //                               const SizedBox(width: 8),
    //                               Text(
    //                                 S.of(context).settings,
    //                                 style: Theme.of(context)
    //                                     .textTheme
    //                                     .bodyMedium
    //                                     ?.copyWith(
    //                                       color: Theme.of(context).primaryColor,
    //                                       fontWeight: FontWeight.w600,
    //                                     ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             // 运营点位卡片区域
    //             _buildGrowthCards(context),
    //             SizedBox(
    //               height: 60,
    //             )
    //           ],
    //         ),
    //       ),
    //       // ProfileBanner()
    //     ],
    //   ),
    // );
  }

  void _goSetting() {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (_) => const SettingScreen()));
  }

  Widget _buildGrowthCards(BuildContext context) {
    final profile = ref.watch(myProfileProvider)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    List<_GrowthItem> items = [
      _GrowthItem(
        visible: !(profile.completed),
        title: S.of(context).personaCompleteProfile,
        desc: S.of(context).personaCompleteProfileDesc,
        icon: Icons.person_add_alt_1_rounded,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (_) => const ProfileScreen()),
        ),
      ),
      _GrowthItem(
        visible: profile.photos.isEmpty,
        title: S.of(context).personaUploadPhotos,
        desc: S.of(context).personaUploadPhotosDesc,
        icon: Icons.photo_library_rounded,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (_) => const ProfileScreen()),
        ),
      ),
      _GrowthItem(
        visible: !profile.pushEnabled,
        title: S.of(context).personaEnableNotifications,
        desc: S.of(context).personaEnableNotificationsDesc,
        icon: Icons.notifications_active_rounded,
        onTap: _goSetting,
      ),
      _GrowthItem(
        visible: !profile.cityVisibility,
        title: S.of(context).personaShowCity,
        desc: S.of(context).personaShowCityDesc,
        icon: Icons.location_city_rounded,
        onTap: _goSetting,
      ),
    ];

    items = items.where((e) => e.visible).toList();
    if (items.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Text(
              S.of(context).personaForYou,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isDark ? const Color(0xFFEDEDF4) : Colors.black,
                  ),
            ),
          ),
          ...items.map((e) => _GrowthCard(item: e)).toList(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _GrowthItem {
  _GrowthItem({
    required this.visible,
    required this.title,
    required this.desc,
    required this.icon,
    required this.onTap,
  });

  final bool visible;
  final String title;
  final String desc;
  final IconData icon;
  final VoidCallback onTap;
}

class _GrowthCard extends StatelessWidget {
  const _GrowthCard({required this.item});

  final _GrowthItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF12121B) : Colors.white,
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF12121B), Color(0xFF0E0E14)],
              )
            : null,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.primaryColor.withOpacity(isDark ? 0.22 : 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.28)
                : Colors.black.withOpacity(0.06),
            blurRadius: isDark ? 18 : 10,
            offset: const Offset(0, 6),
          ),
          if (isDark)
            BoxShadow(
              color: theme.primaryColor.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 0),
            ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(isDark ? 0.18 : 0.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.primaryColor.withOpacity(isDark ? 0.36 : 0.2),
                width: 1,
              ),
              boxShadow: isDark
                  ? [
                      BoxShadow(
                        color: theme.primaryColor.withOpacity(0.18),
                        blurRadius: 12,
                      )
                    ]
                  : null,
            ),
            child: Icon(
              item.icon,
              color: theme.primaryColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isDark ? const Color(0xFFEDEDF4) : Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.desc,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? const Color(0xFFB5B6C8) : theme.hintColor,
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(width: 8),
          // FilledButton(
          //
          //   onPressed: item.onTap,
          //   style: const ButtonStyle(
          //     padding: MaterialStatePropertyAll(
          //       EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //     ),
          //     minimumSize: MaterialStatePropertyAll(Size(100, 36)),
          //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //   ),
          //   child: const Text('去完成'),
          // ),
        ],
      ),
    );
  }
}
