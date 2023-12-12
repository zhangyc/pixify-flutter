import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/screens/profile.dart';
import 'package:sona/core/like_me/providers/liked_me.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/utils/dialog/subsciption.dart';

import '../../../common/widgets/image/user_avatar.dart';
import '../models/social_user.dart';

class LikeMeScreen extends StatefulHookConsumerWidget {
  const LikeMeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LikeMeScreenState();
}

class _LikeMeScreenState extends ConsumerState<LikeMeScreen> with AutomaticKeepAliveClientMixin {

  late bool isMember;
  late double itemWidth;
  late double itemHeight;

  @override
  void didChangeDependencies() {
    itemHeight = (MediaQuery.of(context).size.width - 16 * 3) / 2 * 220 / 165;
    itemWidth =  itemHeight * 165 / 220;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    isMember = ref.watch(myProfileProvider)!.isMember;
    return Scaffold(
      appBar: AppBar(
        title: Text('Who liked you', style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w900
        )),
        centerTitle: false,
      ),
      body: ref.watch(asyncLikedMeProvider).when(
        data: (data) => data.isNotEmpty ? GridView.builder(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 132),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 165.5/288
          ),
          itemBuilder: (BuildContext context, int index) => _itemBuilder(data[index]),
          itemCount: data.length
        ) : Center(child: Text('No data')),
        error: (_, __) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => ref.read(asyncLikedMeProvider.notifier).refresh(false),
          child: Center(child: Text('Failed to fetch data\nClick to retry'))
        ),
        loading: () => Center(child: SizedBox(width: 32, height: 32, child: CircularProgressIndicator()))
      ),
      floatingActionButton: !ref.read(myProfileProvider)!.isMember ? Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 50),
        child: OutlinedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SubscribePage(fromTag: FromTag.pay_chatlist_likedme))),
          style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
            backgroundColor: MaterialStatePropertyAll(Color(0xFFFFE806)),
          ),
          child: Text('Become Super SoNA', style: Theme.of(context).textTheme.titleMedium),
        ),
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _itemBuilder(SocialUser u) {
    return Container(
      key: ValueKey(u.id),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: itemHeight,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    height: itemHeight,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    foregroundDecoration: BoxDecoration(
                        border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAlias,
                    child: isMember ? GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfileScreen(userId: u.id,relation: Relation.likeMe,))),
                      child: UserAvatar(
                        url: u.avatar!,
                        size: Size(itemWidth, itemHeight),
                      ),
                    ) : GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => showSubscription(FromTag.pay_chatlist_likedme),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaY: 18, sigmaX: 18),
                        child: UserAvatar(
                          url: u.avatar!,
                          size: Size(itemWidth, itemHeight),
                        ),
                      ),
                    ),
                  )
                ),
                if (u.displayTag != null) Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF888888)
                    ),
                    clipBehavior: Clip.antiAlias,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      u.displayTag!,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  )
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Text(u.countryFlag ?? '')
                )
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(
            u.hang,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            u.name!,
            style: Theme.of(context).textTheme.labelSmall,
            maxLines: 1,
            overflow: TextOverflow.clip,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}