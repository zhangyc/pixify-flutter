import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/country.dart';
import '../services/travel_wish.dart';

@immutable
class AsyncPopularTravelCountriesNotifier extends AsyncNotifier<List<PopularTravelCountry>> {
  Future<List<PopularTravelCountry>> _fetchCountries() async {
    return fetchPopularTravelDestinations(null)
      .then<List>((resp) => resp.data as List)
      .then<List<PopularTravelCountry>>(
        (data) => data.map<PopularTravelCountry>((c) => PopularTravelCountry.fromJson(c)).toList()
      ).catchError((e) {
        if (kDebugMode) print('fetch popular countries error: $e');
        throw e;
      });
  }

  @override
  Future<List<PopularTravelCountry>> build() async {
    return _fetchCountries();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchCountries());
  }
}

final asyncPopularTravelCountriesProvider = AsyncNotifierProvider<
    AsyncPopularTravelCountriesNotifier,
    List<PopularTravelCountry>
>(() => AsyncPopularTravelCountriesNotifier());