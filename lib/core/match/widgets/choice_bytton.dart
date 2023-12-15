import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  const ChoiceButton({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border(
            top: BorderSide(color: Colors.black),
            right: BorderSide(color: Colors.black),
            bottom: BorderSide(color: Colors.black,width: 3),
            left: BorderSide(color: Colors.black),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black,
          //   )
          // ]
        ),
        child: Text('$text',
          maxLines: 3,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff2c2c2c),
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
