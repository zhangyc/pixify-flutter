import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/screens/profile.dart';
import 'package:sona/common/widgets/button/icon.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/core/travel_wish/screens/travel_wish_creator.dart';
import 'package:sona/setting/screens/setting.dart';
import 'package:sona/utils/dialog/subsciption.dart';
import 'package:sona/utils/global/global.dart';

import '../../../generated/l10n.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Me', style: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 253,
              child: ref.watch(asyncMyTravelWishesProvider).when(
                data: (wishes) => ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  children: [
                    ...wishes.map((wish) => Container(
                      width: 295,
                      height: 221,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        image: wish.countryPhoto != null ? DecorationImage(
                          image: CachedNetworkImageProvider(
                            wish.countryPhoto!
                          ),
                          fit: BoxFit.cover
                        ) : null,
                        border: Border.all(width: 2),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          if (wish.countryFlag != null) Positioned(
                            bottom: 8,
                            left: 16,
                            right: 16,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black26
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          wish.countryName,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          wish.when,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        if (wish.cityNames.isNotEmpty) Text(
                                          wish.cityNames.join(','),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        if (wish.activityNames.isNotEmpty) Text(
                                          wish.activityNames.join(','),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(wish.countryFlag!, style: TextStyle(fontSize: 20),)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TravelWishCreator())),
                      child: Container(
                        width: 295,
                        height: 221,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        clipBehavior: Clip.antiAlias,
                        alignment: Alignment.center,
                        child: Icon(Icons.add),
                      ),
                    )
                  ]
                ),
                error: (_, __) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: const Center(
                    child: Text('Error to fetch travel-wish\nclick to try again'),
                  ),
                ),
                loading: () => const Center(
                  child: SizedBox(
                    width: 66,
                    height: 66,
                    child: CircularProgressIndicator()
                  )
                )
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                  )
                ]
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          // border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer, width: 1),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: UserAvatar(
                          url: myProfile.avatar!,
                          size: const Size.square(64),
                        ),
                      ),
                      Positioned(
                        bottom: -4,
                        right: -4,
                        child: Text(
                          findFlagByCountryCode(myProfile.countryCode),
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${myProfile.name}, ${myProfile.birthday!.toAge()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children:  [
                      Flexible(
                        child: FilledButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                              builder: (_) => const ProfileScreen()
                          )),
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Color(0xFF454545))
                          ),
                          child: Text(
                            S.current.editProfile,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white
                            ),
                          )
                        ),
                      ),
                      SizedBox(width: 16),
                      Flexible(
                        child: FilledButton(
                            onPressed: null,
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Color(0xFF454545))
                            ),
                            child: Text(
                              'Certify',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white
                              ),
                            )
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  FilledButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SubscribePage(fromTag: FromTag.profile_myplan))),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(0xFFFFE600))
                      ),
                      child: Text('Super SONA', style: Theme.of(context).textTheme.titleMedium)
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goSetting() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingScreen()));
  }

  @override
  bool get wantKeepAlive => true;
}