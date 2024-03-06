import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final Future<void> Function() onPressed;
  final Widget child;
  final Widget placeholder;
  const LoadingButton({Key? key, required this.onPressed, required this.child, required this.placeholder}) : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool _isLoading = false;

  void _handlePressed() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressed();
    } finally {
      if(mounted){
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _isLoading ? null : _handlePressed,
      child: _isLoading
          ? widget.placeholder // Replace with your custom loading widget
          : widget.child,
    );
  }
}
