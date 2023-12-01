import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/providers/liked_me.dart';
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
              if (likedMeUsers.where((u) => u.likeDate != null && DateTime.now().difference(u.likeDate!).inHours < 2).isNotEmpty) Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'New like (${likedMeUsers.where((u) => u.likeDate != null && DateTime.now().difference(u.likeDate!).inHours < 2).length})',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Container(
                height: 106,
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
                          height: 106,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
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
                    final newLike = u.likeDate != null && DateTime.now().difference(u.likeDate!).inHours < 2;
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => widget.onTap(u),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        foregroundDecoration: BoxDecoration(
                          border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(25)
                        ),
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            UserAvatar(
                              url: u.avatar!,
                              size: Size(84, 102),
                            ),
                            SizedBox(
                              width: 84,
                              height: 102,
                              child: Visibility(
                                visible: !ref.watch(myProfileProvider)!.isMember,
                                child: ClipOval(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                                    child: Container(
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Visibility(
                                    visible: newLike,
                                    child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Image.asset('assets/images/liked_me_new.png', width: 30))
                                )
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
              if (ref.read(myProfileProvider)!.isMember) Container(
                  margin: EdgeInsets.only(top: 18, left: 16, right: 16),
                  alignment: Alignment.center,
                  child: FilledButton.tonal(
                    onPressed: () {
                      SonaAnalytics.log('chatlist_gopay');
                      Navigator.push(context, MaterialPageRoute(builder: (_) => SubscribePage(fromTag: FromTag.pay_chatlist_likedme)));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(0xFF06FFE1))
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                          'Become Super SONA',
                          style: Theme.of(context).textTheme.titleSmall
                      ),
                    ),
                  )
              ),
              if (!ref.read(myProfileProvider)!.isMember) Container(
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Who like you?',
                      style: Theme.of(context).textTheme.titleSmall
                    ),
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