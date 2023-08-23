import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/chat/providers/liked_me.dart';


class LikedMeListView extends StatefulHookConsumerWidget {
  const LikedMeListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LikedMeListViewState();
}

class _LikedMeListViewState extends ConsumerState<LikedMeListView> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(asyncLikedMeUsers).when<Widget>(
      data: (likedMeUsers) {
        return likedMeUsers.isEmpty ? Container() : Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Liked You (${likedMeUsers.length})', textAlign: TextAlign.start),
              const SizedBox(height: 8),
              Container(
                height: 202,
                alignment: Alignment.centerLeft,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final u = likedMeUsers[index];
                    print('in like me: ${likedMeUsers.length}');
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 120,
                          height: 170,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(u.avatar ?? ''),
                              fit: BoxFit.cover
                            ),
                            borderRadius: BorderRadius.circular(12)
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(u.name!, maxLines: 1)
                      ],
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