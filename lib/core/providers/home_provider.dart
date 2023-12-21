import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentHomeTapIndexProvider = StateProvider<int>((ref) => 0);

final matchIconProvider = StateNotifierProvider<MatchIconProvider, int>(
      (ref) => MatchIconProvider(),
);

class MatchIconProvider extends StateNotifier<int> {
  MatchIconProvider() : super(0);

  void updateIndex(int index) {
    state = index;
  }
}