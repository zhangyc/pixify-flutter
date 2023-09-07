import 'dart:async';

import 'package:flutter/material.dart';

class Typwriter extends StatefulWidget {
  const Typwriter({
    super.key,
    required this.text,
    required this.duration,
    required this.onDone,
  });
  final String text;
  final Duration duration;
  final void Function() onDone;

  @override
  State<StatefulWidget> createState() => _TypwriterState();
}

class _TypwriterState extends State<Typwriter> {
  var _index = 0;
  late final Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(widget.duration, (_) {
      if (_index < widget.text.length && mounted) {
        setState(() {
          _index++;
        });
      } else {
        Future.delayed(widget.duration * 10, widget.onDone);
        _timer.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(widget.text.substring(0, _index),
          style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
