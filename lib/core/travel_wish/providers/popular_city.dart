import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';
import 'package:sona/core/travel_wish/services/travel_wish.dart';

@immutable
class AsyncPopularTravelCitiesNotifier extends FamilyAsyncNotifier<List<PopularTravelCity>, int> {
  Future<List<PopularTravelCity>> _fetchCities() async {
    return fetchPopularTravelDestinations(arg)
      .then<List>((resp) => resp.data as List)
      .then<List<PopularTravelCity>>(
        (data) => data.map<PopularTravelCity>((c) => PopularTravelCity.fromJson(c)
      ).toList()
    ).catchError((e) {
      if (kDebugMode) print('fetch popular cities-$int error: $e');
      throw e;
    });
  }

  @override
  Future<List<PopularTravelCity>> build(int arg) async {
    return _fetchCities();
  }
}

final asyncPopularTravelCitiesProvider = AsyncNotifierProviderFamily<
  AsyncPopularTravelCitiesNotifier,
  List<PopularTravelCity>,
  int
>(() => AsyncPopularTravelCitiesNotifier());

final asyncCurrentCitiesProvider = StateProvider<AsyncValue<List<PopularTravelCity>>>((ref) {
  final currentCountry = ref.watch(currentCountryProvider);
  if (currentCountry == null) return const AsyncLoading();
  return ref.watch(asyncPopularTravelCitiesProvider(currentCountry.id));
}, dependencies: [currentCountryProvider]);
