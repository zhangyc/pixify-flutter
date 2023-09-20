import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SonaIcon extends ConsumerWidget {
  const SonaIcon({
    super.key,
    required this.icon,
    this.size = 24,
    this.color,
    this.activeProvider
  });
  final SonaIcons icon;
  final double size;
  final Color? color;
  final StateProvider<bool>? activeProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final child = Image.asset(
        'assets/icons/${icon.name}.png',
        width: size,
        height: size,
        color: color
    );
    if (activeProvider == null) {
      return child;
    } else {
      return SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            Positioned.fill(child: child),
            Positioned(
              top: 0,
              right: 0,
              child: Visibility(
                visible: ref.watch(activeProvider!),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black, width: 1)
                  ),
                  clipBehavior: Clip.antiAlias,
                )
              )
            )
          ],
        ),
      );
    }
  }
}

enum SonaIcons {
  navicon_sona,
  navicon_match,
  navicon_chat,
}
