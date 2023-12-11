import 'package:flutter/material.dart';
import 'package:sona/theme/const.dart';

import '../image/icon.dart';

class SIconButton extends StatefulWidget {
  const SIconButton({
    super.key,
    required this.icon,
    this.iconSize = 48,
    this.padding = const EdgeInsets.all(14),
    this.backgroundColor = const Color(0xFFF6F3F3),
    this.borderSide = BorderSide.none,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    required this.onTap,
  });

  factory SIconButton.outlined({
    Key? key,
    required SonaIcons icon,
    double iconSize = 40,
    EdgeInsets padding = const EdgeInsets.all(10),
    Color backgroundColor = Colors.transparent,
    BorderSide borderSide = const BorderSide(width: 2, color: primaryColor),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
    dynamic Function()? onTap,
  }) => SIconButton(
    key: key,
    icon: icon,
    iconSize: iconSize,
    padding: padding,
    backgroundColor: backgroundColor,
    borderSide: borderSide,
    onTap: onTap,
  );

  factory SIconButton.small({
    Key? key,
    required SonaIcons icon,
    double iconSize = 40,
    EdgeInsets padding = const EdgeInsets.all(10),
    Color backgroundColor = const Color(0xFFF6F3F3),
    BorderSide borderSide = BorderSide.none,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
    dynamic Function()? onTap,
  }) => SIconButton(
    key: key,
    icon: icon,
    iconSize: iconSize,
    padding: padding,
    backgroundColor: backgroundColor,
    borderSide: borderSide,
    borderRadius: borderRadius,
    onTap: onTap,
  );

  final SonaIcons icon;
  final double iconSize;
  final EdgeInsets padding;
  final Color backgroundColor;
  final BorderSide borderSide;
  final BorderRadius borderRadius;
  final dynamic Function()? onTap;

  @override
  State<StatefulWidget> createState() => _SIconButtonState();
}

class _SIconButtonState extends State<SIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButtonTheme(
      data: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return Color(0xFF7E7E7E);
            }
            return widget.backgroundColor;
          }),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: widget.borderRadius,
            side: widget.borderSide
          )),
          alignment: Alignment.center
        )
      ),
      child: IconButton(
        onPressed: widget.onTap,
        padding: widget.padding,
        iconSize: widget.iconSize,
        icon: SonaIcon(icon: widget.icon)
      ),
    );
  }
}
