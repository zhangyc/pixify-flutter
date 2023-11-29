import 'package:flutter/material.dart';

import '../image/icon.dart';

class SIconButton extends StatefulWidget {
  const SIconButton({
    Key? key,
    required this.icon,
    this.backgroundColor = const Color(0xFFF6F3F3),
    required this.onTap,
  }) : super(key: key);

  final SonaIcons icon;
  final Color backgroundColor;
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
          shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(32)
          )),
          alignment: Alignment.center
        )
      ),
      child: IconButton(
        onPressed: widget.onTap,
        padding: EdgeInsets.all(14),
        iconSize: 48,
        icon: SonaIcon(icon: widget.icon)
      ),
    );
  }
}
