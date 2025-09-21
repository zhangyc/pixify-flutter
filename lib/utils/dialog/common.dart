import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/widgets/button/icon.dart';
import 'package:sona/common/widgets/image/icon.dart';

Future<T?> showCommonBottomSheet<T>({
  required BuildContext context,
  String? title,
  String? content,
  List<Widget>? actions,
  String? description,
  bool dismissible = true
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    elevation: 0,
    clipBehavior: Clip.none,
    isDismissible: dismissible,
    builder: (BuildContext context) {
      return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7
        ),
        padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: MediaQuery.of(context).padding.bottom + 16),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFF2C2C2C),
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          shadows: [
            BoxShadow(
              color: Color(0xFF2C2C2C),
              blurRadius: 0,
              offset: Offset(0, -4),
              spreadRadius: 0,
            )
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title != null) Text(title, style: Theme.of(context).textTheme.titleLarge),
                      if (content != null) Text(content, style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                ),
                SIconButton(
                  icon: SonaIcons.close,
                  onTap: () => Navigator.pop(context)
                )
              ],
            ),
            SizedBox(height: 16),
            ...?actions,
            SizedBox(height: 10),
            if (description != null) Text(description, style: Theme.of(context).textTheme.labelSmall)
          ],
        ),
      );
    },
  );
}