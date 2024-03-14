import 'package:flutter/material.dart';
import 'package:sona/core/chat/models/audio_message.dart';

class TypeWriter extends StatefulWidget {
  const TypeWriter({
    super.key,
    required this.message,
    required this.duration,
    this.style
  });
  final AudioMessage message;
  final Duration duration;
  final TextStyle? style;

  @override
  State<StatefulWidget> createState() => _TypeWriterState();
}

class _TypeWriterState extends State<TypeWriter> {

  late final List<String> tokens;
  late final int gap;

  @override
  void initState() {
    tokens = widget.message.recognizedText!.split('');
    gap = (((widget.message.duration! * 1000) - 200 - 200) / (tokens.length - 2 + 1)).floor();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TypeWriter oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.message.recognizedText != null ? Text.rich(TextSpan(
      children: [
        ...tokens.asMap().keys.map((index) => TextSpan(
          text: '${tokens[index]}',
          style: TextStyle(
            color: widget.duration.inMilliseconds > (200 + (index * gap)) ? widget.style?.color : Colors.transparent
          )
        ))
      ]
    ), style: widget.style) : Container();
  }
}