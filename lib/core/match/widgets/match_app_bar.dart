// lib/core/match/widgets/match_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../generated/assets.dart';

class MatchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onFilterTap;
  final VoidCallback? onUndoTap;
  final String? title;
  final bool showUndo;

  const MatchAppBar({
    super.key,
    this.onFilterTap,
    this.onUndoTap,
    this.title,
    this.showUndo = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          Assets.svgArrow,
          width: 24,
          height: 24,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title ?? '发现',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        // 撤销按钮
        if (showUndo)
          IconButton(
            icon: const Icon(
              Icons.undo,
              color: Colors.white,
              size: 24,
            ),
            onPressed: onUndoTap,
          ),

        // 筛选按钮
        IconButton(
          icon: SvgPicture.asset(
            Assets.iconsFliter,
            width: 24,
            height: 24,
            color: Colors.white,
          ),
          onPressed: onFilterTap,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
