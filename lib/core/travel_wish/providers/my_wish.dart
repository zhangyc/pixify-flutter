import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/travel_wish.dart';
import '../services/travel_wish.dart';

@immutable
class AsyncMyTravelWishesNotifier extends AsyncNotifier<List<TravelWish>> {
  Future<List<TravelWish>> _fetchMyTravelWishes() async {
    return fetchMyTravelWishes()
        .then<List>((resp) => resp.data['list'] as List)
        .then<List<TravelWish>>(
            (data) => data.map<TravelWish>((c) => TravelWish.fromJson(c)).toList()
        )
        .catchError((e) {print(e); throw e;});
  }

  @override
  Future<List<TravelWish>> build() async {
    return _fetchMyTravelWishes();
  }
}

final asyncMyTravelWishesProvider = AsyncNotifierProvider<
    AsyncMyTravelWishesNotifier,
    List<TravelWish>
>(() => AsyncMyTravelWishesNotifier());