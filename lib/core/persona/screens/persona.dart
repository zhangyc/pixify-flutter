import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/screens/profile.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
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
            child: IconButton(
              onPressed: _goSetting,
              padding: EdgeInsets.all(14),
              iconSize: 48,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xFFF6F3F3)),
                shape: MaterialStatePropertyAll(ContinuousRectangleBorder(borderRadius: BorderRadius.circular(32)))
              ),
              icon: SonaIcon(icon: SonaIcons.settings)
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
                            child: Row(
                              children: [
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      wish.activityNames.join(','),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                )),
                                Text(wish.countryFlag!, style: TextStyle(fontSize: 20),)
                              ],
                            ),
                          ),
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
              height: 212,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                  )
                ]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                        builder: (_) => const ProfileScreen()
                    )),
                    child: Container(
                      decoration: BoxDecoration(
                          // border: Border.all(color: Theme.of(context).colorScheme.tertiaryContainer, width: 1),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                          imageUrl: ref.watch(myProfileProvider)!.avatar!,
                          width: 112,
                          height: 168,
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 168,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Visibility(
                            visible: ref.watch(myProfileProvider)!.impression != null,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 4),
                                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Color(0xFFE880F1),
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Text(
                                  ref.watch(myProfileProvider)!.impression ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            ref.watch(myProfileProvider)!.name ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: 3),
                          Text(
                            '${ref.watch(myProfileProvider)!.birthday!.toAge()} | ${ref.watch(myProfileProvider)!.gender!.name}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Expanded(child: Container()),
                          ElevatedButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(
                                builder: (_) => const ProfileScreen()
                            )),
                            child: Text(
                              S.current.editProfile,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Color(0xFF555555)
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                ref.read(myProfileProvider)!.isMember
                    ? 'YOU’RE SUPER SONA'
                    : 'BECOMING SUPER SONA',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ref.read(myProfileProvider)!.isMember ? Colors.black : Color(0xFFE880F1),
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 258,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/super_sona_bg.png'),
                  fit: BoxFit.fill
                )
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 12,
                    left: 0,
                    child: Text(
                      '❤️ Unlimited Likes\n👀 See who liked you\n🤖 100 AI SONA messages / day\nand more…',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        height: 2
                      ),
                    ),
                  ),
                  Positioned(
                    left: 60,
                    right: 60,
                    bottom: 0,
                    child: Visibility(
                      visible: !ref.watch(myProfileProvider)!.isMember,
                      child: OutlinedButton(
                        onPressed: () {
                          if (ref.read(myProfileProvider)!.isMember) {
                            return;
                          } else {
                            showSubscription(FromTag.pay_profile);
                            SonaAnalytics.log('profile_golock');
                          }
                        },
                        child: Text(
                          'UPGRADE',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Visibility(
                      visible: ref.watch(myProfileProvider)!.isMember,
                      child: TextButton(
                        onPressed: () {
                          showSubscription(FromTag.profile_myplan);
                          SonaAnalytics.log('profile_myplan');
                        },
                        child: Text(
                          'My Subscription Plan',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
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