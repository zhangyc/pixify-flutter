import 'package:dio/dio.dart';
import 'package:sona/utils/global/global.dart';

Future<Response> createTravelWish({
  int? id,
  required int countryId,
  required Set<int> cityIds,
  required Set<int> activityIds,
  required String timeframe
}) async {
  return dio.post(
    '/travel-wish/save-update',
    data: {
      'id': id,
      'countryId': countryId,
      'cityId': cityIds.join('#'),
      'activityIds': activityIds.join('#'),
      'timeType': timeframe
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
  Iterable<int>? cityIds
}) async {
  return dio.post(
      '/activity/save-update',
      data: {
        'countryId': countryId,
        'cityIds': cityIds?.join('#'),
        'title': description
      }
  );
}