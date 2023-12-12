import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/travel_wish/models/travel_wish.dart';


class TravelWishParamsNotifier extends StateNotifier<TravelWishParams> {
  TravelWishParamsNotifier(super.state);

  void setState(TravelWishParams params) {
    state = params;
  }

  void setCountryId(int countryId) {
    state = state.copyWith(
      countryId: countryId
    );
  }

  void setTimeframe(String timeframe) {
    state = state.copyWith(
      timeframe: timeframe
    );
  }

  void toggleCity(int cityId) {
    if (state.cityIds.contains(cityId)) {
      state = state.copyWith(
        cityIds: state.cityIds..remove(cityId)
      );
    } else if (state.cityIds.length < 3) {
      state = state.copyWith(
        cityIds: state.cityIds..add(cityId)
      );
    }
  }

  void clearCities() {
    state = state.copyWith(
      cityIds: {}
    );
  }

  void toggleActivity(int activityId) {
    if (state.activityIds.contains(activityId)) {
      state = state.copyWith(
        activityIds: state.activityIds..remove(activityId)
      );
    } else if (state.activityIds.length < 3) {
      state = state.copyWith(
        activityIds: state.activityIds..add(activityId)
      );
    }
  }

  void clearActivities() {
    state = state.copyWith(
        activityIds: {}
    );
  }
}

final travelWishParamsProvider = StateNotifierProvider<
    TravelWishParamsNotifier,
    TravelWishParams
>((ref) => TravelWishParamsNotifier(TravelWishParams()));