import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    Key? key,
    required this.onTap,
    this.color = const Color(0xFFFFFFFF),
    required this.text,
    this.fontColor = const Color(0xFF000000),
    this.disabled = false
  }) : super(key: key);

  final dynamic Function()? onTap;
  final Color color;
  final String text;
  final Color fontColor;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(color),
        shape: MaterialStatePropertyAll(ContinuousRectangleBorder()),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap
      ),
      onPressed: onTap,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: fontColor
          )
        ),
      ),
    );
  }
}