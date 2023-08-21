import 'package:flutter/material.dart';

class ForwardButton extends StatelessWidget {
  const ForwardButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final void Function() onTap;
  final String text;

  double get _radius => 6;
  double get _fontSize => 15;
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
                border: Border.all(color: Theme.of(context).colorScheme.primaryContainer, width: _borderWidth)
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    text,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: _fontSize
                    )
                ),
                Icon(Icons.arrow_forward_ios_outlined, color: Theme.of(context).colorScheme.onBackground)
              ],
            )
        ),
      ),
    );
  }
}
