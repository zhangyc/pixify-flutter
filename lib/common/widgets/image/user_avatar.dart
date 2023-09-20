import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.url,
    this.size = 42
  });
  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFFD9D9D9), width: 0.2)
      ),
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        width: size,
        imageUrl: url,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      )
    );
  }
}