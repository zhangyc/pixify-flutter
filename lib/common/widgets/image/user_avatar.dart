import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserAvatar extends ConsumerWidget {
  const UserAvatar({
    super.key,
    required this.url,
    this.size = const Size.square(50),
  });

  final String url;
  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24)
      ),
      foregroundDecoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE8E6E6), width: 1),
        borderRadius: BorderRadius.circular(24)
      ),
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        width: size.width,
        height: size.height,
        imageUrl: url,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }
}

class UserAvatarImageProvider extends CachedNetworkImageProvider {
  const UserAvatarImageProvider(
    super.url,
    // Map<String, String>? headers
  ) : super(
    // headers: headers
  );
}