import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final backgroundColorProvider = StateNotifierProvider<BackgroundColorController, BottomColor>(
      (ref) => BackgroundColorController(),
);

class BackgroundColorController extends StateNotifier<BottomColor> {
  BackgroundColorController() : super(BottomColor(Colors.black, 1));

  void updateColor(BottomColor color) {
    state = color;
  }
}
class BottomColor{
  Color color;
  int index;
  BottomColor(this.color,this.index);
}
