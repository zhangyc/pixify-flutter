import 'package:flutter/material.dart';

class TypeWriter extends StatefulWidget {
  const TypeWriter({super.key, required this.text});
  final String text;

  @override
  State<StatefulWidget> createState() => _TypeWriterState();
}

class _TypeWriterState extends State<TypeWriter> {
  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      children: [
        TextSpan()
      ]
    ));
  }
}