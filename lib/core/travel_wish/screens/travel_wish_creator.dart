import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/subscribe/subscribe_page.dart';
import 'package:sona/core/travel_wish/models/travel_wish.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';
import 'package:sona/core/travel_wish/providers/my_wish.dart';
import 'package:sona/core/travel_wish/screens/activities_selector.dart';
import 'package:sona/core/travel_wish/screens/cities_selector.dart';
import 'package:sona/core/travel_wish/screens/country_selector.dart';
import 'package:sona/core/travel_wish/screens/timeframe_selector.dart';
import 'package:sona/core/travel_wish/services/travel_wish.dart';
import 'package:sona/utils/dialog/subsciption.dart';

import '../../../common/widgets/image/icon.dart';

class TravelWishCreator extends ConsumerStatefulWidget {
  const TravelWishCreator({super.key, this.wish});
  final TravelWish? wish;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TravelWishCreatorState();
}

class _TravelWishCreatorState extends ConsumerState<TravelWishCreator> {
  final _pageController = PageController();
  static const _pageTransitionDuration = Duration(milliseconds: 200);
  static const _pageTransitionCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.wish != null)
        ref.read(travelWishParamsProvider.notifier).setState(TravelWishParams.fromTravelWish(widget.wish!));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (_pageController.page == null || _pageController.page?.round() == 0) {
              if (Navigator.canPop(context)) Navigator.pop(context);
            } else {
              _pageController.previousPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
            }
          },
          icon: SonaIcon(icon: SonaIcons.back),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) return;

          if (_pageController.page != null && _pageController.page!.round() > 0) {
            _pageController.previousPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
          } else {
            if (Navigator.canPop(context)) Navigator.pop(context);
          }
        },
        child: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, int index) => switch(index) {
            0 => CountrySelector(onDone: _onNextPage),
            1 => CitiesSelector(onSkip: _onSkipCities, onNext: _onNextPage),
            2 => TimeframeSelector(onDone: _onNextPage),
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

  void _onNextPage() {
    _pageController.nextPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
  }

  Future _onDone() async {
    try {
      final params = ref.read(travelWishParamsProvider);
      final resp = await createTravelWish(
        id: widget.wish?.id,
        countryId: params.countryId!,
        cityIds: params.cityIds,
        activityIds: params.activityIds,
        timeframe: params.timeframe!
      );
      if (resp.statusCode == 0) {
        ref.invalidate(asyncMyTravelWishesProvider);
        if (!mounted) return;
        if (Navigator.of(context).canPop()) {
          Navigator.pop(context, true);
        } else {
          await Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      } else if (resp.statusCode == 10150) {
        showSubscription(FromTag.travel_wish);
      }
    } catch(e) {
      // Navigator.pop(context, true);
    }
  }
}