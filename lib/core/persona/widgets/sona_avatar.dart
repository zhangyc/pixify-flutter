import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/widgets/text/gradient_colored_text.dart';

class SonaAvatar extends ConsumerStatefulWidget {
  const SonaAvatar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SonaAvatarState();
}

class _SonaAvatarState extends ConsumerState<SonaAvatar> {
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
      child: GradientColoredText(
        text: 'S',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontSize: 24
        )
      )
    );
  }
}