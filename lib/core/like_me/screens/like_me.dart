import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/models/age.dart';
import 'package:sona/core/chat/providers/liked_me.dart';

import '../../../common/models/user.dart';

class LikeMeScreen extends StatefulHookConsumerWidget {
  const LikeMeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LikeMeScreenState();
}

class _LikeMeScreenState extends ConsumerState<LikeMeScreen> {
  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 166/260
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
    return Container(
      key: ValueKey(u.id),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(u.avatar!),
          alignment: Alignment.center,
          fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.circular(4)
      ),
      child: Stack(
        children: [
          Positioned(
            left: 4,
            bottom: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  u.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Color.fromARGB(120, 0, 0, 0),
                        )
                      ]
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  u.birthday!.toAge().toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                        blurRadius: 2.0,
                        color: Color.fromARGB(120, 0, 0, 0),
                      )
                    ]
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}