import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/travel_wish/models/country.dart';

final currentCountryProvider = StateProvider<PopularTravelCountry?>((ref) => null);