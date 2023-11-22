import 'package:dio/dio.dart';
import 'package:sona/core/travel/models/country.dart';
import 'package:sona/utils/global/global.dart';

import '../models/activity.dart';
import '../models/city.dart';

Future<Response> createTravelWish({
  required SonaCountry country,
  required Set<SonaCity> cities,
  required Set<SonaActivity> activities
}) async {
  return dio.post(
    '/travel-wish/create',
    data: {
      'country': country.code,
      'cities': cities.map((city) => city.displayName).join(','),
      'activities': activities.map((act) => act.displayName).join(',')
    }
  );
}
