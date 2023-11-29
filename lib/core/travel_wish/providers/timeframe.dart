import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/services/common.dart';
import 'package:sona/core/travel_wish/models/timeframe.dart';


@immutable
class AsyncTravelTimeframeOptionsNotifier extends AsyncNotifier<List<TravelTimeframeOptions>> {
  Future<List<TravelTimeframeOptions>> _fetchFrameOptions() async {
    return fetchTravelTimeframeOptions()
        .then<List>((resp) => resp.data as List)
        .then<List<TravelTimeframeOptions>>(
            (data) => data.map<TravelTimeframeOptions>((c) => TravelTimeframeOptions.fromJson(c)).toList()
    ).catchError((e) {
      if (kDebugMode) print('fetch timeframe-options error: $e');
      throw e;
    });
  }

  @override
  Future<List<TravelTimeframeOptions>> build() async {
    return _fetchFrameOptions();
  }
}

final asyncTimeframeOptionsProvider = AsyncNotifierProvider<
    AsyncTravelTimeframeOptionsNotifier,
    List<TravelTimeframeOptions>
>(() => AsyncTravelTimeframeOptionsNotifier());