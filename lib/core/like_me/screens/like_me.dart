import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/screens/profile.dart';
import 'package:sona/core/like_me/providers/liked_me.dart';
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

class _LikeMeScreenState extends ConsumerState<LikeMeScreen> with AutomaticKeepAliveClientMixin {

  late bool isMember;
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
    isMember = ref.watch(myProfileProvider)!.isMember;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).whoLikesU, style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w900
        )),
        centerTitle: false,
      ),
      body: ref.watch(asyncLikedMeProvider).when(
        data: (data) => data.isNotEmpty ? MasonryGridView.builder(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).padding.bottom + 130),
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
          ),
          itemBuilder: (BuildContext context, int index) => _itemBuilder(data[index]),
          itemCount: data.length
        ) : _dataEmpty(),
        error: (_, __) => _dataEmpty(),
        loading: () => Center(child: SizedBox(width: 32, height: 32, child: CircularProgressIndicator()))
      ),
      floatingActionButton: !ref.read(myProfileProvider)!.isMember && ref.watch(asyncLikedMeProvider).hasValue && ref.watch(asyncLikedMeProvider).value!.isNotEmpty ? Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: MediaQuery.of(context).padding.bottom),
        child: OutlinedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SubscribePage(SubscribeShowType.unlockWhoLikeMe(),fromTag: FromTag.pay_chatlist_likedme))),
          style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
            backgroundColor: MaterialStatePropertyAll(Color(0xFFBEFF06)),
          ),
          child: Text(S.of(context).checkOutTheirProfiles, style: Theme.of(context).textTheme.titleMedium),
        ),
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _itemBuilder(SocialUser u) {
    return Container(
      key: ValueKey(u.id),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF6F3F3),
        borderRadius: BorderRadius.circular(20)
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    // foregroundDecoration: BoxDecoration(
                    //     border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                    //     borderRadius: BorderRadius.circular(20)
                    // ),
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAlias,
                    child: isMember ? GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfileScreen(userId: u.id,relation: Relation.likeMe,))),
                      child: AspectRatio(
                        aspectRatio: 0.75,
                        child: UserAvatar(
                          url: u.avatar!,
                          size: Size(itemWidth, itemHeight),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ) : GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => showSubscription(SubscribeShowType.unlockWhoLikeMe(),FromTag.pay_chatlist_likedme),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaY: 18, sigmaX: 18),
                        child: AspectRatio(
                          aspectRatio: 0.75,
                          child: UserAvatar(
                            url: u.avatar!,
                            size: Size(itemWidth, itemHeight),
                          ),
                        ),
                      ),
                    ),
                  )
                ),
                if (u.displayTag != null) Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
                      color: Colors.black.withOpacity(0.45)
                    ),
                    clipBehavior: Clip.antiAlias,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      u.displayTag!,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
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
          if (isMember) Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              u.name!,
              style: Theme.of(context).textTheme.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          if (u.hang.isNotEmpty) Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text.rich(
              TextSpan(
                children: [
                  // TextSpan(text: '”', style: Theme.of(context).textTheme.headlineMedium),
                  TextSpan(
                    text: S.of(context).imInterestedSomething("'${u.hang}'")
                  ),
                  // TextSpan(text: '”', style: Theme.of(context).textTheme.headlineMedium)
                ]
              ),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ) else Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              S.of(context).likedYou,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
            Image.asset('assets/images/empty_yin_yang.png', width: 115),
            SizedBox(height: 32),
            Text(
                S.of(context).likedPageNoData,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500
                )
            ),
            SizedBox(height: 36),
          ],
        )
    );
  }

  @override
  bool get wantKeepAlive => true;
}