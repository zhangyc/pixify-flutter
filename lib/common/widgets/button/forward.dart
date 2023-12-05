import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForwardButton extends StatelessWidget {
  const ForwardButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Icon(CupertinoIcons.forward)
        ],
      ),
    );
  }
}
