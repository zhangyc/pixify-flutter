import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/chat/providers/liked_me.dart';

import '../../../common/models/user.dart';
import '../../../common/widgets/image/user_avatar.dart';

class LikeMeScreen extends StatefulHookConsumerWidget {
  const LikeMeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LikeMeScreenState();
}

class _LikeMeScreenState extends ConsumerState<LikeMeScreen> {

  late bool isMember;

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 165.5/288
              ),
              itemBuilder: (BuildContext context, int index) => _itemBuilder(data[index]),
              itemCount: data.length
          ) : Center(child: Text('No data')),
          error: (_, __) => Center(child: Text('error')),
          loading: () => Center(child: CircularProgressIndicator())
      ),
    );
  }

  Widget _itemBuilder(UserInfo u) {
    final newLike = u.likeDate != null && DateTime.now().difference(u.likeDate!).inHours < 2;

    return Container(
      key: ValueKey(u.id),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 220,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    height: 220,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    foregroundDecoration: BoxDecoration(
                        border: Border.all(width: 2, color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAlias,
                    child: isMember ? UserAvatar(
                      url: u.avatar!,
                      size: Size(165, 220),
                    ) : ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaY: 9, sigmaX: 9),
                      child: UserAvatar(
                        url: u.avatar!,
                        size: Size(165, 220),
                      ),
                    ),
                  )
                ),
                Positioned(
                    bottom: 12,
                    left: 12,
                    child: Visibility(
                        visible: newLike,
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
                    )
                ),
                Positioned(
                    bottom: 12,
                    right: 12,
                    child: Visibility(
                        visible: newLike,
                        child: Text(u.countryFlag ?? '')
                    )
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}