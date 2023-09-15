import 'package:flutter/material.dart';

class CustomScrollPhysics extends AlwaysScrollableScrollPhysics{
  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    return 0;
  }
}