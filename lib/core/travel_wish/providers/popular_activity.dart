import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/activity.dart';
import '../services/travel_wish.dart';


@immutable
class AsyncPopularTravelActivitiesNotifier extends FamilyAsyncNotifier<List<PopularTravelActivity>, String> {
  Future<List<PopularTravelActivity>> _fetchActivities() async {
    final countryId = int.parse(arg.split('_').first);
    return fetchPopularTravelActivities(countryId, [])
      .then<List>((resp) => resp.data as List)
      .then<List<PopularTravelActivity>>(
        (data) => data
          .map<PopularTravelActivity>((c) => PopularTravelActivity.fromJson(c))
          .toList()
      );
  }

  @override
  Future<List<PopularTravelActivity>> build(arg) async {
    return _fetchActivities();
  }
}

final asyncPopularTravelActivitiesProvider = AsyncNotifierProviderFamily<
  AsyncPopularTravelActivitiesNotifier,
  List<PopularTravelActivity>,
  String
>(() => AsyncPopularTravelActivitiesNotifier());

