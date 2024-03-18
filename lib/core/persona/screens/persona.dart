import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/screens/profile.dart';
import 'package:sona/common/widgets/button/icon.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/ai_dress/ai_dress_event.dart';
import 'package:sona/core/ai_dress/ai_dress_page.dart';
import 'package:sona/core/persona/providers/profile_progress.dart';
import 'package:sona/core/persona/widgets/profile_progress_indicator.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/core/travel_wish/screens/travel_wish_creator.dart';
import 'package:sona/core/travel_wish/services/travel_wish.dart';
import 'package:sona/core/widgets/generate_banner.dart';
import 'package:sona/setting/screens/setting.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/dialog/subsciption.dart';
import 'package:sona/utils/global/global.dart';

import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../subscribe/model/member.dart';
import '../../travel_wish/providers/my_wish.dart';

class PersonaScreen extends StatefulHookConsumerWidget {
  const PersonaScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonaScreenState();
}

class _PersonaScreenState extends ConsumerState<PersonaScreen> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final myProfile = ref.watch(myProfileProvider)!;
    final asyncMyTravelWishes = ref.watch(asyncMyTravelWishesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).me, style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w900
        )),
        centerTitle: false,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: SIconButton(
              onTap: _goSetting,
              icon: SonaIcons.settings
            ),
          )
        ],
        elevation: 0,
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 18, bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    S.of(context).wishList,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18
                    ),
                  ),
                ),
                Container(
                  height: 253,
                  child: asyncMyTravelWishes.when(
                    data: (wishes) => ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      children: [
                        ...wishes.map((wish) => GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            final action = await showActionButtons(
                                context: context,
                                options: {
                                  S.of(context).buttonEdit: 'edit',
                                  S.of(context).buttonDelete: 'delete'
                                }
                            );
                            if (action == 'delete') {
                              final resp = await deleteMyWishe(wish.id);
                              if (resp.statusCode == 0) {
                                ref.read(asyncMyTravelWishesProvider.notifier).refresh();
                              } else {
                                Fluttertoast.showToast(msg: 'Failed to delete, please try again later.');
                              }
                            } else if (action == 'edit') {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => TravelWishCreator(wish: wish)));
                            }
                          },
                          child: Container(
                            width: 295,
                            height: 221,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black.withOpacity(0), Colors.black.withOpacity(0.75)],
                              ),
                              image: wish.countryPhoto != null ? DecorationImage(
                                image: CachedNetworkImageProvider(
                                  wish.countryPhoto!
                                ),
                                fit: BoxFit.cover,
                              ) : null,
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            clipBehavior: Clip.antiAlias,
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.01, -1.00),
                                  end: Alignment(-0.01, 1),
                                  colors: [Colors.black.withOpacity(0), Colors.black.withOpacity(0.75)],
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          wish.countryName,
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: Colors.white
                                          ),
                                        ),
                                        if (wish.cityNames.isNotEmpty) Text(
                                          wish.cityNames.join(','),
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Colors.white
                                          ),
                                        ),
                                        if (wish.activityNames.isNotEmpty) Text(
                                          wish.activityNames.join(','),
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Colors.white
                                          ),
                                        ),
                                        Text(
                                          wish.timeframeName,
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                              color: Color(0xFFCCCCCC)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.26),
                                          border: Border.all(color: Colors.white.withOpacity(0.26), width: 1),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: SonaIcon(icon: SonaIcons.edit)
                                      ),
                                      Text(wish.countryFlag ?? '', style: TextStyle(fontSize: 20),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                        if (asyncMyTravelWishes.hasValue && asyncMyTravelWishes.value!.length < 3) GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            if (asyncMyTravelWishes.value!.isEmpty || myProfile.isMember) {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => TravelWishCreator()));
                            } else {
                              showSubscription(FromTag.travel_wish);
                            }
                          },
                          child: Container(
                            width: 295,
                            height: 221,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Color(0xFFB7B7B7)),
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFF6F3F3)
                            ),
                            clipBehavior: Clip.antiAlias,
                            alignment: Alignment.center,
                            child: Icon(Icons.add, size: 32, color: Color(0xFFB7B7B7)),
                          ),
                        )
                      ]
                    ),
                    error: (_, __) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => ref.read(asyncMyTravelWishesProvider.notifier).refresh(),
                      child: const Center(
                        child: Text('Error to fetch travel-wish\nclick to try again'),
                      ),
                    ),
                    loading: () => const Center(
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator()
                      )
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F3F3),
                    borderRadius: BorderRadius.circular(24),
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: Offset(0, 2),
                    //     color: Colors.black.withOpacity(0.15),
                    //     blurRadius: 20,
                    //   )
                    // ]
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 48, height: 48),
                                UserAvatar(
                                  url: myProfile.avatar!,
                                  size: const Size.square(64),
                                ),
                                IconButton(
                                  iconSize: 48,
                                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                                      builder: (_) => const ProfileScreen()
                                  )),
                                  icon: SonaIcon(icon: SonaIcons.edit, color: Theme.of(context).primaryColor)
                                )
                              ],
                            ),
                            SizedBox(height: 12),
                            Text(
                                '${myProfile.name}, ${myProfile.birthday!.toAge()}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: Theme.of(context).textTheme.titleMedium
                            ),
                            SizedBox(height: 12),
                            Center(
                              child: switch(ref.read(myProfileProvider)?.memberType) {
                                MemberType.club => SonaIcon(icon: SonaIcons.club_mark),
                                MemberType.plus => SonaIcon(icon: SonaIcons.plus_mark),
                                _ => Container()
                              },
                            ),
                            if (ref.watch(profileProgressProvider) < 1) Container(
                                margin: EdgeInsets.only(top: 8),
                                child: ProfileProgressIndicator()
                            ),
                            SizedBox(height: 10),
                            if (!ref.watch(myProfileProvider)!.isMember) OutlinedButton(
                                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SubscribePage(fromTag: FromTag.profile_myplan))),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Color(0xFFBEFF06)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset('assets/icons/emoji${Random().nextInt(5)}.png'),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(S.of(context).buttonUnlockVipPerks, style: Theme.of(context).textTheme.titleMedium),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward_ios_rounded,color: Color(0xff2c2c2c),size: 20,)
                                  ],
                                )
                            ),
                            if (ref.watch(myProfileProvider)!.isMember) FilledButton(
                                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SubscribePage(fromTag: FromTag.profile_myplan))),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Color(0xFFF6F3F3)),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      switch(ref.watch(myProfileProvider)!.memberType) {
                                        MemberType.club => S.current.youAreAClubMemberNow,
                                        MemberType.plus => S.current.buttonAlreadyPlus,
                                        _ => ''
                                      },
                                      style: Theme.of(context).textTheme.titleMedium
                                  ),
                                )
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            FilledButton(
                                onPressed: () {
                                  SonaAnalytics.log(AiDressEvent.Me_AIdress.name);
                                  Navigator.push(context, MaterialPageRoute(builder: (b){
                                    return AiDressPage();
                                  }));
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Color(0xFFF6F3F3)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(Assets.svgAiDress,width: 20,height: 20,),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                            S.current.aiDressUpLabel,
                                            style: Theme.of(context).textTheme.titleMedium
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: 43,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Color(0xff2c2c2c),
                                            borderRadius: BorderRadius.circular(8)
                                          ),
                                          // padding: EdgeInsets.symmetric(
                                          //   vertical: 2,
                                          //   horizontal: 6
                                          // ),
                                          child: Text(S.current.freeLabel,),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Icon(Icons.arrow_forward_ios_rounded,color: Color(0xff2c2c2c),size: 20,)
                                      ],
                                    )
                                  ],
                                )
                            ),
                            SizedBox(
                              height: 12,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
          GenerateBanner()
        ],
      ),
    );
  }

  void _goSetting() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingScreen()));
  }

  @override
  bool get wantKeepAlive => true;
}