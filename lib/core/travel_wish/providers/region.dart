import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/country.dart';
import '../services/travel_wish.dart';

@immutable
class AsyncPopularTravelDestinationsNotifier extends AsyncNotifier<List<PopularTravelCountry>> {
  Future<List<PopularTravelCountry>> _fetchDestinations() async {
    return fetchPopularTravelDestinations()
      .then<List>((resp) => resp.data as List)
      .then<List<PopularTravelCountry>>(
        (data) => data.map<PopularTravelCountry>((c) => PopularTravelCountry.fromJson(c)).toList()
      );
  }

  @override
  Future<List<PopularTravelCountry>> build() async {
    return _fetchDestinations();
  }
}

final asyncPopularTravelDestinationsProvider = AsyncNotifierProvider<
    AsyncPopularTravelDestinationsNotifier,
    List<PopularTravelCountry>
>(() => AsyncPopularTravelDestinationsNotifier());