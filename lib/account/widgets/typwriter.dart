import 'dart:async';

import 'package:flutter/material.dart';

class Typwriter extends StatefulWidget {
  const Typwriter({
    super.key,
    required this.textBuilder,
    required this.highlights,
    required this.duration,
    required this.onDone,
  });
  final String Function() textBuilder;
  final List<String> highlights;
  final Duration duration;
  final void Function() onDone;

  @override
  State<StatefulWidget> createState() => _TypwriterState();
}

class _TypwriterState extends State<Typwriter> {
  late final String _text;
  var _index = 0;
  late final Timer _timer;
  late Iterable<RegExpMatch> matches = [];

  @override
  void initState() {
    _initText();
    _timer = Timer.periodic(widget.duration, (_) {
      if (_index < _text.runes.length && mounted) {
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

  void _initText() {
    _text = widget.textBuilder();
    if (widget.highlights.isEmpty) return;
    final regExp = RegExp('(${widget.highlights.join('|')})+');
    matches = regExp.allMatches(_text);
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
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  border: Border.all(),
                  shape: BoxShape.circle
                ),
                alignment: Alignment.center,
                child: Text('SONA', style: TextStyle(fontSize: 7, fontWeight: FontWeight.w600)),
              )
            ),
            ...List.generate(_index, (index) => index).map((index) => TextSpan(
              text: _text[index],
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: matches.any((range) => index >= range.start && index <= range.end) ? Color(0xFFDD70E0) : Color(0xFF5D5D5F),
                  fontSize: 20
              )
            ))
          ]
        )
      ),
    );
  }
}
