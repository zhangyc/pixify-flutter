import 'package:flutter/material.dart';
import 'package:sona/core/chat/models/audio_message.dart';

class TypeWriter extends StatefulWidget {
  const TypeWriter({super.key, required this.message, this.style});
  final AudioMessage message;
  final TextStyle? style;

  @override
  State<StatefulWidget> createState() => _TypeWriterState();
}

class _TypeWriterState extends State<TypeWriter> {
  @override
  Widget build(BuildContext context) {
    return widget.message.recognizedText != null ? Text.rich(TextSpan(
      children: [
        ...widget.message.recognizedText!.split(' ').map((token) => TextSpan(
            text: ' $token '
        ))
      ]
    ), style: widget.style) : Container();
  }
}