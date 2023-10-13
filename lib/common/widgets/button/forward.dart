import 'package:flutter/material.dart';

class ForwardButton extends StatelessWidget {
  const ForwardButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.placeholder
  }) : super(key: key);

  final void Function() onTap;
  final String? text;
  final String? placeholder;

  double get _radius => 6;
  double get _fontSize => 14;
  double get _borderWidth => 2;

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
              borderRadius: BorderRadius.circular(_radius),
              border: Border.all(color: Color(0xFFF3F3F3), width: _borderWidth),
              color: Color(0xFFF3F3F3)
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    text ?? placeholder ?? '',
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: _fontSize,
                      color: text != null ? Color(0xFF3F3F3F) : Color(0xFFBABABA)
                    )
                  ),
                ),
                Icon(Icons.arrow_forward_ios_outlined, size: 12, color: Color(0xFFB9B9B9))
              ],
            )
        ),
      ),
    );
  }
}
