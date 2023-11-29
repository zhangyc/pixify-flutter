import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/travel_wish/models/activity.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/core/travel_wish/models/timeframe.dart';
import 'package:sona/core/travel_wish/models/travel_wish.dart';


class TravelWishParamsNotifier extends StateNotifier<TravelWishParams> {
  TravelWishParamsNotifier(super.state);

  void setCountry(PopularTravelCountry country) {
    state = state.copyWith(
      country: country
    );
  }

  void setTimeframe(TravelTimeframeOptions timeframe) {
    state = state.copyWith(
      timeframe: timeframe
    );
  }

  void toggleCity(PopularTravelCity city) {
    if (state.cities.contains(city)) {
      state = state.copyWith(
        cities: state.cities..remove(city)
      );
    } else {
      state = state.copyWith(
        cities: state.cities..add(city)
      );
    }
  }

  void clearCities() {
    state = state.copyWith(
      cities: {}
    );
  }

  void toggleActivity(PopularTravelActivity activity) {
    if (state.activities.contains(activity)) {
      state = state.copyWith(
          activities: state.activities..remove(activity)
      );
    } else {
      state = state.copyWith(
          activities: state.activities..add(activity)
      );
    }
  }
}

final travelWishParamsProvider = StateNotifierProvider<
    TravelWishParamsNotifier,
    TravelWishParams
>((ref) => TravelWishParamsNotifier(TravelWishParams()));