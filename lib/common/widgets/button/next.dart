import 'dart:async';

import 'package:flutter/material.dart';

class NextButton extends StatefulWidget {
  const NextButton({
    Key? key,
    required this.onTap,
    this.loadingWhenAsyncAction = false,
    this.size = ButtonSize.medium,
    this.disabled = false
  }) : super(key: key);

  final dynamic Function()? onTap;
  final bool loadingWhenAsyncAction;
  final ButtonSize size;
  final bool disabled;

  @override
  State<StatefulWidget> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  late bool _disabled = widget.disabled;
  bool _loading = false;

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

  Widget get child => !_loading ? Icon(Icons.arrow_forward, size: widget.size.height / 2, color: Colors.white,) : SizedBox(
    width: widget.size.height / 2,
    height: widget.size.height / 2,
    child: const CircularProgressIndicator(
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation(Color(0xFF888888)),
      strokeWidth: 2.5,
    ),
  );

  Color get backgroundColor {
    if (_disabled) {
      return Theme.of(context).primaryColor.withOpacity(0.7);
    }
    return Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.black12,
        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.size.height / 2)),
        child: Ink(
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(widget.size.height / 2),
          ),
          width: widget.size.height * 1.2,
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


enum ButtonSize {
  large(
      height: 64,
      borderWidth: 2.5,
      borderRadiusCircular: 10
  ),
  medium(
      height: 50,
      borderWidth: 2.5,
      borderRadiusCircular: 6
  ),
  small(
      height: 30,
      borderWidth: 1,
      borderRadiusCircular: 4
  );

  const ButtonSize({
    required this.height,
    required this.borderWidth,
    required this.borderRadiusCircular
  });
  final double height;
  final double borderWidth;
  final double borderRadiusCircular;
}