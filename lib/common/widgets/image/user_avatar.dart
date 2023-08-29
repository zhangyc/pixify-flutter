import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserAvatar extends ConsumerStatefulWidget {
  const UserAvatar({super.key, required this.url});
  final String url;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserAvatarState();
}

class _UserAvatarState extends ConsumerState<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).colorScheme.secondaryContainer)
        ),
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          width: 42,
          imageUrl: widget.url,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        )
    );
  }
}