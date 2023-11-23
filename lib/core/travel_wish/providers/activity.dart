import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/activity.dart';
import '../services/travel_wish.dart';

@immutable
class AsyncPopularTravelActivitiesNotifier extends FamilyAsyncNotifier<List<PopularTravelActivity>, int> {
  Future<List<PopularTravelActivity>> _fetchActivities() async {
    return fetchPopularTravelActivities(arg, [])
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
    int?
>(() => AsyncPopularTravelActivitiesNotifier());