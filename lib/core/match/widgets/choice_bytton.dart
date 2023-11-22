import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  const ChoiceButton({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black
        )
      ),
      child: Text(text,
        maxLines: 1,
      ),
    );
  }
}
