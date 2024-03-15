import 'package:flutter/material.dart';

class BaseDialogContainer extends StatelessWidget {
  const BaseDialogContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24)
          ),
          border: Border(
            top: BorderSide(width: 4.0, color: Colors.black), // 添加黑色顶部边框
          )
      ),
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: child
      ),
    );
  }
}
