import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/widgets/image/user_avatar.dart';
import 'package:sona/core/chat/providers/liked_me.dart';


class LikedMeListView extends StatefulHookConsumerWidget {
  const LikedMeListView({
    super.key,
    required this.onTap
  });
  final void Function(UserInfo) onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LikedMeListViewState();
}

class _LikedMeListViewState extends ConsumerState<LikedMeListView> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(asyncLikedMeProvider).when<Widget>(
      data: (likedMeUsers) {
        return likedMeUsers.isEmpty ? Container() : Container(
          margin: EdgeInsets.only(bottom: 38),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Liked You (${likedMeUsers.length})', textAlign: TextAlign.start),
              const SizedBox(height: 8),
              Container(
                height: 208,
                alignment: Alignment.centerLeft,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final u = likedMeUsers[index];
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => widget.onTap(u),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: true ? BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xFFE74E27), width: 2)
                              ) : null,
                              child: UserAvatar(
                                url: u.avatar!,
                                size: 68
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Visibility(
                              visible: true,
                              child: Image.asset('assets/images/liked_me_new.png', width: 27)
                            )
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemCount: likedMeUsers.length
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Container(),
      loading: () => Container()
    );
  }
}