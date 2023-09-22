import 'dart:async';

import 'package:flutter/material.dart';

class SIconButton extends StatefulWidget {
  const SIconButton({
    Key? key,
    this.size = 24,
    required this.onTap,
    this.loadingWhenAsyncAction = false,
    this.color = const Color(0xFFFFFFFF),
    required this.child,
    this.borderColor = const Color(0x00000000),
    this.disabled = false
  }) : super(key: key);

  final double size;
  final dynamic Function()? onTap;
  final bool loadingWhenAsyncAction;
  final Color color;
  final Widget child;
  final Color borderColor;
  final bool disabled;

  @override
  State<StatefulWidget> createState() => _SIconButtonState();
}

class _SIconButtonState extends State<SIconButton> {
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

  Widget get child => !_loading ? widget.child : Padding(
    padding: EdgeInsets.all(4),
    child: const CircularProgressIndicator(
      backgroundColor: Color(0xFFD4D4D4),
      valueColor: AlwaysStoppedAnimation(Color(0xFF888888)),
      strokeWidth: 1.5,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.black12,
      borderRadius: BorderRadius.circular(widget.size * 0.5),
      child: Ink(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.disabled ? Color(0xFF888888) : widget.color,
          shape: BoxShape.circle
        ),
        child: Center(child: child)
      ),
    );
  }

  void refreshUI() {
    if (mounted) setState(() {});
  }
}
