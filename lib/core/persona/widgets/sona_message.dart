import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/persona/widgets/sona_avatar.dart';

class SonaMessage extends ConsumerStatefulWidget {
  const SonaMessage({super.key, required this.content});
  final String content;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SonaMessageState();
}

class _SonaMessageState extends ConsumerState<SonaMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SonaAvatar(),
          const SizedBox(width: 20),
          Flexible(child: Text(widget.content, softWrap: true))
        ],
      ),
    );
  }
}