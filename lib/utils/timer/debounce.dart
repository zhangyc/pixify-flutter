import 'package:flutter/foundation.dart';
import 'dart:async';

class Debounce {
  Debounce({required this.duration});

  final Duration duration;
  VoidCallback? action;
  Timer? _timer;

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(duration, action);
  }
}