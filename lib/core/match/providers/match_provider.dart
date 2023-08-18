// 1. Create a provider by extending ChangeNotifier
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/providers/dio.dart';

class MatchState extends StateNotifier<int> {
  int _count = 0;

  MatchState():super(0);
  int get count => _count;

  void increment() {
    _count++;
  }
  void dislike(){


  }
  void like(){

  }
}

// 2. Wrap the provider with StateNotifierProvider
final counterProvider = StateNotifierProvider<MatchState, int>((ref) {
  return MatchState();
});