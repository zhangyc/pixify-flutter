import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/like_me/providers/liked_me.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/utils/global/global.dart';

import '../../../generated/l10n.dart';

class LikedMeListView extends StatefulHookConsumerWidget {
  const LikedMeListView({
    super.key,
    required this.onTap,
    required this.onShowAll
  });
  final void Function([UserInfo]) onTap;
  final void Function() onShowAll;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LikedMeListViewState();
}

class _LikedMeListViewState extends ConsumerState<LikedMeListView> {

  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) ref.read(asyncLikedMeProvider.notifier).refresh();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(asyncLikedMeProvider).when<Widget>(
      data: (likedMeUsers) {
        return likedMeUsers.isEmpty ? Container() : Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (likedMeUsers.where((u) => u.isNew).isNotEmpty) Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  '${S.of(context).whoLikesU} (${likedMeUsers.length})',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Container(
                height: 117,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    if (index >= 16) {
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => widget.onTap(),
                        child: Container(
                          width: 88,
                          height: 117,
                          decoration: BoxDecoration(
                            color: Color(0xFFE74E27),
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          clipBehavior: Clip.antiAlias,
                          alignment: Alignment.center,
                          child: Text(
                            '+${likedMeUsers.length - 16}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white
                            ),
                          ),
                        ),
                      );
                    }
                    final u = likedMeUsers[index];
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => widget.onTap(u.toUserInfo()),
                      child: Container(
                        width: 84,
                        height: 113,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        foregroundDecoration: BoxDecoration(
                          border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(25)
                        ),
                        alignment: Alignment.center,
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (!ref.watch(myProfileProvider)!.isMember) Positioned.fill(
                              child: ImageFiltered(
                                imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                                child: UserAvatar(
                                  url: u.avatar!,
                                  size: Size(84, 113),
                                )
                              ),
                            ),
                            if (ref.watch(myProfileProvider)!.isMember) Positioned.fill(
                              child: UserAvatar(
                                url: u.avatar!,
                                size: Size(84, 113),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            if (u.isNew) Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFF888888)
                                ),
                                clipBehavior: Clip.antiAlias,
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                child: Text(
                                  'New',
                                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              )
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Text(u.countryFlag ?? '')
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemCount: likedMeUsers.length > 16 ? 17 : likedMeUsers.length,
                ),
              ),
              if (!ref.read(myProfileProvider)!.isMember) Container(
                  margin: EdgeInsets.only(top: 18, left: 16, right: 16),
                  alignment: Alignment.center,
                  child: OutlinedButton(
                    onPressed: () {
                      SonaAnalytics.log('chatlist_gopay');
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SubscribePage(SubscribeShowType.unLockSona(),fromTag: FromTag.pay_chatlist_likedme)));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(0xFFFFE806))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            S.of(context).checkOutTheirProfiles,
                            style: Theme.of(context).textTheme.titleSmall
                        ),
                        SonaIcon(icon: SonaIcons.forward)
                      ],
                    ),
                  )
              ),
              if (ref.read(myProfileProvider)!.isMember) Container(
                margin: EdgeInsets.only(top: 18, left: 16, right: 16),
                alignment: Alignment.center,
                child: FilledButton.tonal(
                  onPressed: () {
                    SonaAnalytics.log('chatlist_gopay');
                    widget.onShowAll();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Color(0xFFF6F3F3))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          S.of(context).seeWhoLikeU,
                          style: Theme.of(context).textTheme.titleSmall
                      ),
                      SonaIcon(icon: SonaIcons.forward)
                    ],
                  ),
                )
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) => Container(),
      loading: () => Container()
    );
  }
}