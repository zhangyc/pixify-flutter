import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/core/travel_wish/services/travel_wish.dart';


@immutable
class AsyncPopularTravelCitiesNotifier extends FamilyAsyncNotifier<List<PopularTravelCity>, String> {
  Future<List<PopularTravelCity>> _fetchCities() async {
    final countryId = int.parse(arg.split('_').first);
    return fetchPopularTravelDestinations(countryId)
      .then<List>((resp) => resp.data as List)
      .then<List<PopularTravelCity>>(
        (data) => data.map<PopularTravelCity>((c) => PopularTravelCity.fromJson(c)
      ).toList()
    );
  }

  @override
  Future<List<PopularTravelCity>> build(String arg) async {
    return _fetchCities();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchCities());
  }
}

final asyncPopularTravelCitiesProvider = AsyncNotifierProviderFamily<
  AsyncPopularTravelCitiesNotifier,
  List<PopularTravelCity>,
  String
>(() => AsyncPopularTravelCitiesNotifier());

