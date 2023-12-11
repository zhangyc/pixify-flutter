import 'package:dio/dio.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/core/travel_wish/models/timeframe.dart';
import 'package:sona/utils/global/global.dart';

import '../models/activity.dart';

Future<Response> createTravelWish({
  required PopularTravelCountry country,
  required Set<PopularTravelCity> cities,
  required Set<PopularTravelActivity> activities,
  required TravelTimeframeOptions timeframe
}) async {
  return dio.post(
    '/travel-wish/save-update',
    data: {
      'countryId': country.id,
      'cityId': cities.map((city) => city.id).join('#'),
      'activityIds': activities.map((act) => act.id).join('#'),
      'timeType': timeframe.value
    }
  );
}

Future<Response> deleteMyWishe(int id) {
  return dio.post('/travel-wish/delete', data: {'id': id});
}

Future<Response> fetchMyTravelWishes(int id) {
  return dio.post('/travel-wish/find', data: {'userId': id, 'page': 1, 'pageSize': 3});
}

Future<Response> fetchPopularTravelDestinations(int? parentId) async {
  return dio.post('/region/find-parent', data: {'parentId': parentId});
}

Future<Response> fetchPopularTravelActivities(int countryId, List<int> cityIds) async {
  return dio.post('/activity/find-recommend', data: {
    'countryId': countryId,
    'cityIds': cityIds
  });
}

Future<Response> createActivity({
  required String description,
  required int countryId,
  Iterable<PopularTravelCity>? cities
}) async {
  return dio.post(
      '/activity/save-update',
      data: {
        'countryId': countryId,
        'cityIds': cities?.map((city) => city.id).join('#'),
        'title': description
      }
  );
}