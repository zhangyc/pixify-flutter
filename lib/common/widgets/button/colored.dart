import 'dart:async';

import 'package:flutter/material.dart';

class ColoredButton extends StatefulWidget {
  const ColoredButton({
    Key? key,
    required this.onTap,
    this.loadingWhenAsyncAction = false,
    this.size = ColoredButtonSize.medium,
    this.color = const Color(0xFFFFFFFF),
    required this.text,
    this.fontColor = const Color(0xFF000000),
    this.borderColor = const Color(0x00000000),
    this.disabled = false
  }) : super(key: key);

  final dynamic Function()? onTap;
  final bool loadingWhenAsyncAction;
  final ColoredButtonSize size;
  final Color color;
  final String text;
  final Color borderColor;
  final Color fontColor;
  final bool disabled;

  @override
  State<StatefulWidget> createState() => _ColoredButtonState();
}

class _ColoredButtonState extends State<ColoredButton> {
  bool _loading = false;

  void Function()? get onTap => !_loading ? () {
    if (widget.disabled || widget.onTap == null) return;
    if (widget.loadingWhenAsyncAction) {
      _loading = true;
      refreshUI();
      final result = widget.onTap!();
      if (result is Future) {
        result.whenComplete(() {
          _loading = false;
          refreshUI();
        });
      }
    } else {
      widget.onTap!();
    }
  } : null;

  Widget get child => !_loading ? Text(
      widget.text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: widget.disabled ? Color(0xFF888888) : widget.fontColor,
          fontWeight: FontWeight.w500,
          fontSize: widget.size.fontSize
      )
  ) : SizedBox(
      width: widget.size.height / 2,
      height: widget.size.height / 2,
      child: const CircularProgressIndicator(
        backgroundColor: Color(0xFFD4D4D4),
        valueColor: AlwaysStoppedAnimation(Color(0xFF888888)),
        strokeWidth: 2.5,
      ),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.black12,
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.size.borderRadiusCircular)),
        child: Ink(
            decoration: BoxDecoration(
                color: widget.disabled ? Color(0xFF888888) : widget.color,
                borderRadius: BorderRadius.circular(widget.size.borderRadiusCircular),
                border: Border.all(color: widget.borderColor, width: widget.size.borderWidth)
            ),
            padding: EdgeInsets.symmetric(horizontal: widget.size.height * 0.2),
            height: widget.size.height,
            child: Center(child: child)
        ),
      ),
    );
  }

  void refreshUI() {
    if (mounted) setState(() {});
  }
}


enum ColoredButtonSize {
  large(
      height: 64,
      fontSize: 17,
      borderWidth: 4,
      borderRadiusCircular: 10
  ),
  medium(
      height: 44,
      fontSize: 15,
      borderWidth: 2.5,
      borderRadiusCircular: 6
  ),
  small(
      height: 30,
      fontSize: 12,
      borderWidth: 1,
      borderRadiusCircular: 4
  );

  const ColoredButtonSize({
    required this.height,
    required this.fontSize,
    required this.borderWidth,
    required this.borderRadiusCircular
  });
  final double height;
  final double fontSize;
  final double borderWidth;
  final double borderRadiusCircular;
}