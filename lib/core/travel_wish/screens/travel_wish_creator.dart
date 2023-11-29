import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/services/common.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';
import 'package:sona/core/travel_wish/providers/my_wish.dart';
import 'package:sona/core/travel_wish/screens/activities_selector.dart';
import 'package:sona/core/travel_wish/screens/cities_selector.dart';
import 'package:sona/core/travel_wish/screens/country_selector.dart';
import 'package:sona/core/travel_wish/screens/timeframe_selector.dart';
import 'package:sona/core/travel_wish/services/travel_wish.dart';

import '../../../common/widgets/image/icon.dart';

class TravelWishCreator extends ConsumerStatefulWidget {
  const TravelWishCreator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TravelWishCreatorState();
}

class _TravelWishCreatorState extends ConsumerState<TravelWishCreator> {
  final _pageController = PageController();
  static const _pageTransitionDuration = Duration(milliseconds: 200);
  static const _pageTransitionCurve = Curves.ease;

  @override
  void initState() {
    // TODO: implemSonaCityent initState
    fetchTravelTimeframeOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (_pageController.page == null || _pageController.page?.round() == 0) {
              Navigator.pop(context);
            } else {
              _pageController.previousPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
            }
          },
          icon: SonaIcon(icon: SonaIcons.back),
        ),
        centerTitle: false,
        titleSpacing: 0,
        title: Text('Back'),
      ),
      resizeToAvoidBottomInset: false,
      body: PopScope(
        canPop: false,
        onPopInvoked: (_) {
          if (_pageController.page != null && _pageController.page!.round() > 0) {
            _pageController.previousPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
          }
        },
        child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, int index) => switch(index) {
            0 => const CountrySelector(),
            1 => CitiesSelector(onSkip: _onSkipCities, onNext: _onSubmitCities),
            2 => const TimeframeSelector(),
            3 => ActivitiesSelector(onDone: _onDone),
            _ => Container()
          }
        ),
      )
    );
  }

  void _onSkipCities() {
    _pageController.nextPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
    ref.read(travelWishParamsProvider.notifier).clearCities();
  }

  void _onSubmitCities() {
    _pageController.nextPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
  }

  Future _onDone() async {
    try {
      final params = ref.read(travelWishParamsProvider);
      final resp = await createTravelWish(country: params.country!, cities: params.cities, activities: params.activities);
      if (resp.statusCode == 0) {
        Navigator.pop(context, true);
        ref.invalidate(asyncMyTravelWishesProvider);
      }
    } catch(e) {
      // Navigator.pop(context, true);
    }
  }
}