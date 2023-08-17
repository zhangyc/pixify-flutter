import 'dart:async';

import 'package:flutter/material.dart';

import '../../app.dart';

class ColoredButton extends StatefulWidget {
  const ColoredButton({
    Key? key,
    required this.onTap,
    this.loadingWhenAsyncAction = false,
    this.size = ColoredButtonSize.Big,
    this.color = scaffoldBackgroundColor,
    required this.text,
    this.fontColor = Colors.black,
    this.disabled = false
  }) : super(key: key);

  final dynamic Function()? onTap;
  final bool loadingWhenAsyncAction;
  final ColoredButtonSize size;
  final Color color;
  final String text;
  final Color fontColor;
  final bool disabled;

  @override
  State<StatefulWidget> createState() => _ColoredButtonState();
}

class _ColoredButtonState extends State<ColoredButton> {
  bool _loading = false;
  double get _height => widget.size == ColoredButtonSize.Big ? 44 : 30;
  double get _radius => widget.size == ColoredButtonSize.Big ? 6 : 4;
  double get _fontSize => widget.size == ColoredButtonSize.Big ? 15 : 12;
  double get _borderWidth => widget.size == ColoredButtonSize.Big ? 2 : 1;

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
          fontWeight: FontWeight.w900,
          fontSize: _fontSize
      )
  ) : Center(
    child: SizedBox(
      width: _height / 2,
      height: _height / 2,
      child: CircularProgressIndicator(
        backgroundColor: Color(0xFFD4D4D4),
        valueColor: AlwaysStoppedAnimation(Color(0xFF888888)),
        strokeWidth: 2.5,
      ),
    ),
  );

  EdgeInsets get padding => widget.size == ColoredButtonSize.Big
      ? EdgeInsets.symmetric(horizontal: 24, vertical: 8)
      : EdgeInsets.symmetric(horizontal: 12, vertical: 4);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.black12,
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderWidth)),
        child: Ink(
            decoration: BoxDecoration(
                color: widget.disabled ? Color(0xFF888888) : widget.color,
                borderRadius: BorderRadius.circular(_radius),
                border: Border.all(color: Theme.of(context).colorScheme.primaryContainer, width: _borderWidth)
            ),
            padding: padding,
            child: child
        ),
      ),
    );
  }

  void refreshUI() {
    if (mounted) setState(() {});
  }
}


enum ColoredButtonSize {
  Big,
  Small
}