// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class SonaIcon extends StatelessWidget {
  const SonaIcon({super.key, required this.icon, this.size = 24, required this.color});
  final SonaIcons icon;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/icons/${icon.name}.png',
        width: size, height: size,color: color,);
  }
}

enum SonaIcons {
  navicon_sona,
  navicon_sona_active,
  navicon_match,
  navicon_match_active,
  navicon_chat,
  navicon_chat_active
}
