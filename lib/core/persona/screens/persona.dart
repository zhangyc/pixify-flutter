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
            if (ref.watch(asyncMyTravelWishesProvider).value?.isNotEmpty == true) Container(
              margin: EdgeInsets.only(top: 18),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Wish List',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              height: 253,
              child: ref.watch(asyncMyTravelWishesProvider).when(
                data: (wishes) => ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            UserAvatar(
                              url: myProfile.avatar!,
                              size: const Size.square(64),
                            ),
                            SizedBox(width: 16),
                            Text(
                              '${myProfile.name}, ${myProfile.birthday!.toAge()}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: Theme.of(context).textTheme.titleLarge
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        FilledButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(
                                builder: (_) => const ProfileScreen()
                            )),
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Color(0xFFF6F3F3))
                            ),
                            child: Text(
                              S.current.editProfile,
                              style: Theme.of(context).textTheme.titleMedium
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  FilledButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SubscribePage(fromTag: FromTag.profile_myplan))),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(0xFFFFE600)),
                        side: MaterialStatePropertyAll(BorderSide(color: Theme.of(context).primaryColor, width: 2))
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