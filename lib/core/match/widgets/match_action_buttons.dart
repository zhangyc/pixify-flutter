// lib/core/match/widgets/match_action_buttons.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../generated/assets.dart';

class MatchActionButtons extends StatelessWidget {
  final VoidCallback onLike;
  final VoidCallback onSkip;
  final VoidCallback onSuperLike;
  final VoidCallback onPass;

  const MatchActionButtons({
    super.key,
    required this.onLike,
    required this.onSkip,
    required this.onSuperLike,
    required this.onPass,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8 + MediaQuery.of(context).padding.bottom,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 68),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 跳过按钮
            _buildActionButton(
              onTap: onSkip,
              child: SvgPicture.asset(
                Assets.svgDislike,
                width: 56,
                height: 56,
              ),
            ),

            // 喜欢按钮
            _buildActionButton(
              onTap: onLike,
              child: SvgPicture.asset(
                Assets.svgLike,
                width: 64,
                height: 64,
              ),
            ),

            // 超级喜欢按钮
            _buildActionButton(
              onTap: onSuperLike,
              child: Image.asset(
                Assets.iconsArrow,
                width: 56,
                height: 56,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}
