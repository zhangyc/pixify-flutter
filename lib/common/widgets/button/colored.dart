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
    this.confirmDelay,
    this.disabled = false
  }) : super(key: key);

  final dynamic Function()? onTap;
  final bool loadingWhenAsyncAction;
  final ColoredButtonSize size;
  final Color color;
  final String text;
  final Color borderColor;
  final Color fontColor;
  final Duration? confirmDelay;
  final bool disabled;

  @override
  State<StatefulWidget> createState() => _ColoredButtonState();
}

class _ColoredButtonState extends State<ColoredButton> {
  late bool _disabled = widget.disabled;
  bool _loading = false;
  Timer? _timer;

  void Function()? get onTap => !_loading ? () {
    if (_disabled || widget.onTap == null) return;
    if (widget.loadingWhenAsyncAction) {
      _loading = true;
      _refreshUI();
      final result = widget.onTap!();
      if (result is Future) {
        result.whenComplete(() {
          _loading = false;
          _refreshUI();
        });
      }
    } else {
      widget.onTap!();
    }
  } : null;

  @override
  void initState() {
    if (widget.confirmDelay != null) {
      _disabled = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _refreshUI();
        if (timer.tick >= widget.confirmDelay!.inSeconds) {
          _disabled = false;
          timer.cancel();
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null && _timer!.isActive) _timer!.cancel();
    super.dispose();
  }

  Widget get child => !_loading ? Text(
      _timer != null && _timer!.isActive ? '${widget.confirmDelay!.inSeconds - _timer!.tick}s' : widget.text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: _disabled ? Colors.white : widget.fontColor,
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
                color: _disabled ? Color(0xFF888888) : widget.color,
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

  void _refreshUI() {
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