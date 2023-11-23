import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/services/common.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/travel_wish/providers/activity.dart';
import 'package:sona/core/travel_wish/providers/my_wish.dart';
import 'package:sona/core/travel_wish/providers/region.dart';
import 'package:sona/core/travel_wish/services/travel_wish.dart';

import '../../../common/widgets/image/icon.dart';
import '../models/activity.dart';
import '../models/city.dart';
import '../models/country.dart';

class TravelWishCreator extends ConsumerStatefulWidget {
  const TravelWishCreator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TravelWishCreatorState();
}

class _TravelWishCreatorState extends ConsumerState<TravelWishCreator> {
  final _pageController = PageController();
  static const _pageTransitionDuration = Duration(milliseconds: 200);
  static const _pageTransitionCurve = Curves.ease;

  PopularTravelCountry? _selectedCountry;
  Set<PopularTravelCity> _selectedCities = {};
  Set<PopularTravelActivity> _selectedActivities = {};

  @override
  void initState() {
    // TODO: implemSonaCityent initState
    fetchTravelTimeOptions();
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
        centerTitle: true,
        title: Text('New travel wish'),
      ),
      body: WillPopScope(
        onWillPop: () {
          if (_pageController.page == null || _pageController.page?.round() == 0) {
            return Future.value(true);
          } else {
            _pageController.previousPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
            return Future.value(false);
          }
        },
        child: PageView.builder(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, int index) => switch(index) {
            0 => _countrySelector(),
            1 => _citiesSelector(),
            2 => _activitiesSelector(),
            _ => Container()
          }
        ),
      )
    );
  }

  Widget _countrySelector() {
    return SafeArea(
      child: ref.watch(asyncPopularTravelDestinationsProvider).when(
        data: (countries) => Padding(
          padding: const EdgeInsets.all(16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(bottom: 32),
                  child: Text(
                      'Where would you want to go?',
                      style: Theme.of(context).textTheme.headlineLarge
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                      countries.map((country) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        child: OutlinedButtonTheme(
                          data: OutlinedButtonThemeData(
                              style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                                  minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
                                  side: MaterialStatePropertyAll(BorderSide(width: 2))
                              )
                          ),
                          child: OutlinedButton(
                              key: ValueKey(country.id),
                              onPressed: () => _selectCountry(country),
                              child: Row(
                                children: [
                                  Text(findFlagByCountryCode(country.code)),
                                  SizedBox(width: 16),
                                  Text(country.displayName)
                                ],
                              )
                          ),
                        ),
                      )).toList()
                  )
              )
            ],
          ),
        ),
        error: (_, __) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Center(
            child: Text('Error to get initial data\nclick to try again'),
          ),
        ),
        loading: () => Center(
          child: SizedBox(
            width: 66,
            height: 66,
            child: CircularProgressIndicator()
          )
        )
      ),
    );
  }

  Widget _citiesSelector() {
    final popularDestinations = ref.watch(asyncPopularTravelDestinationsProvider).value;
    if (popularDestinations == null || popularDestinations.isEmpty) return Container();
    final cities = popularDestinations.firstWhere((country) => country == _selectedCountry).cities;
    if (cities.isEmpty) return Container();
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 80),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 32),
                      child: Text(
                          'Any specific city?',
                          style: Theme.of(context).textTheme.headlineLarge
                      ),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate(
                          cities.map((city) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            child: OutlinedButtonTheme(
                              data: OutlinedButtonThemeData(
                                  style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                                    minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
                                    side: MaterialStatePropertyAll(BorderSide(width: 2)),
                                    backgroundColor: _selectedCities.contains(city) ? MaterialStatePropertyAll(Colors.blue.withOpacity(0.33)) : null
                                  )
                              ),
                              child: OutlinedButton(
                                  key: ValueKey(city.displayName),
                                  onPressed: () => _selectCity(city),
                                  child: Row(
                                    children: [
                                      Text(city.displayName)
                                    ],
                                  )
                              ),
                            ),
                          )).toList()
                      )
                  ),
                  SliverToBoxAdapter(
                    child: TextButton(
                      child: Text('Skip, just ${_selectedCountry!.displayName}'),
                      onPressed: () {
                        _pageController.nextPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: ColoredButton(
              size: ColoredButtonSize.large,
              text: 'Next',
              onTap: () {
                _pageController.nextPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
              },
            ),
          )
        ],
      )
    );
  }

  Widget _activitiesSelector() {

    return SafeArea(
      child: ref.watch(asyncPopularTravelActivitiesProvider(_selectedCountry?.id)).when(
        data: (activities) => Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 80),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 32),
                        child: Text(
                            'Any interested activity?',
                            style: Theme.of(context).textTheme.headlineLarge
                        ),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate(
                            activities.map((activity) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                              child: OutlinedButtonTheme(
                                data: OutlinedButtonThemeData(
                                    style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                                        minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
                                        side: MaterialStatePropertyAll(BorderSide(width: 2)),
                                        backgroundColor: _selectedActivities.contains(activity) ? MaterialStatePropertyAll(Colors.blue.withOpacity(0.33)) : null
                                    )
                                ),
                                child: OutlinedButton(
                                    key: ValueKey(activity.displayName),
                                    onPressed: () => _selectActivity(activity),
                                    child: Row(
                                      children: [
                                        Text(activity.displayName)
                                      ],
                                    )
                                ),
                              ),
                            )).toList()
                        )
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: ColoredButton(
                size: ColoredButtonSize.large,
                text: 'Done',
                loadingWhenAsyncAction: true,
                onTap: () async {
                  if (_selectedCountry == null) return;
                  try {
                    final resp = await createTravelWish(country: _selectedCountry!, cities: _selectedCities, activities: _selectedActivities);
                    if (resp.statusCode == 0) {
                      Fluttertoast.showToast(msg: 'Done');
                      Navigator.pop(context, true);
                      ref.refresh(asyncMyTravelWishesProvider);
                    }
                  } catch(e) {
                    // Navigator.pop(context, true);
                  }
                },
              ),
            )
          ],
        ),
        error: (_, __) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => ref.refresh(asyncPopularTravelActivitiesProvider(_selectedCountry!.id)),
          child: Center(
            child: Text('Error to get initial data\nclick to try again'),
          ),
        ),
        loading: () => Center(
            child: SizedBox(
                width: 66,
                height: 66,
                child: CircularProgressIndicator()
            )
        )
      ),
    );
  }

  void _selectCountry(PopularTravelCountry country) {
    _selectedCountry = country;
    _pageController.nextPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
  }

  void _selectCity(PopularTravelCity city) {
    if (_selectedCities.contains(city)) {
      _selectedCities.remove(city);
    } else {
      _selectedCities.add(city);
    }
    setState(() {});
  }

  void _selectActivity(PopularTravelActivity activity) {
    if (_selectedActivities.contains(activity)) {
      _selectedActivities.remove(activity);
    } else {
      _selectedActivities.add(activity);
    }
    setState(() {});
  }
  //
  // List<SonaCity> cities = ['东京', '北海道', '稻香村', '稻妻'].map((e) => SonaCity(displayName: e)).toList();
  //
  // List<SonaActivity> activities = ['吃拉面', '拍照', '打团'].map((e) => SonaActivity(displayName: e)).toList();
}