import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/providers/liked_me.dart';
import 'package:sona/utils/global/global.dart';


class LikedMeListView extends StatefulHookConsumerWidget {
  const LikedMeListView({
    super.key,
    required this.onTap
  });
  final void Function([UserInfo]) onTap;

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
          margin: EdgeInsets.only(bottom: 38),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  '${likedMeUsers.length} people liked you',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 68,
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
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFE74E27)
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
                      child: SizedBox(
                        width: 68,
                        height: 68,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: newLike ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Color(0xFFE74E27), width: 2),
                                ) : null,
                                child: Stack(
                                  children: [
                                    UserAvatar(
                                      url: u.avatar!,
                                      size: 68,
                                    ),
                                    SizedBox(
                                      width: 68,
                                      height: 68,
                                      child: Visibility(
                                        visible: !ref.watch(myProfileProvider)!.isMember,
                                        child:  ClipOval(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                            child: Container(
                                              color: Colors.white.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Positioned.fill(
                            //   child: Visibility(
                            //     visible: !ref.watch(myProfileProvider)!.isMember,
                            //     child:  BackdropFilter(
                            //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            //       child: Container(
                            //         color: Colors.white.withOpacity(0.5),
                            //         width: 68,
                            //         height: 68,
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
              SizedBox(height: 24),
              Center(
                child: FilledButton(
                  onPressed: () {
                    SonaAnalytics.log('chatlist_gopay');
                    widget.onTap();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Color(0xFF2969E9))
                  ),
                  child: Text(
                    'See who like you',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white
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