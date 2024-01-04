import 'package:flutter/material.dart';

import '../bean/match_user.dart';

class ChoiceButton extends StatefulWidget {
  const ChoiceButton({super.key, required this.activity, required this.onTap});
  final Activity activity;
  final VoidCallback onTap;

  @override
  State<ChoiceButton> createState() => _ChoiceButtonState();
}

class _ChoiceButtonState extends State<ChoiceButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTap.call();
        widget.activity.selected=true;
        setState(() {

        });
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16
        ),
        decoration: BoxDecoration(
          color: widget.activity.selected?Color(0xffBEFF06):null,
          borderRadius: BorderRadius.circular(20),
          border: Border(
            top: BorderSide(color: Colors.black),
            right: BorderSide(color: Colors.black),
            bottom: widget.activity.selected?BorderSide(color: Colors.black):BorderSide(color: Colors.black,width: 3),
            left: BorderSide(color: Colors.black),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black,
          //   )
          // ]
        ),
        child: Text(widget.activity.title??'',
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
