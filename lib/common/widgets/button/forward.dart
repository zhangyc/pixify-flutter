import 'package:flutter/material.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/theme/const.dart';

class ForwardButton extends StatelessWidget {
  const ForwardButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.color = primaryColor
  }) : super(key: key);

  final void Function() onTap;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(color: color)),
          SonaIcon(icon: SonaIcons.forward, color: color)
        ],
      ),
    );
  }
}
