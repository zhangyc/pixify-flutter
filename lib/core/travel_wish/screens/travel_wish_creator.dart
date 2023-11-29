import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/services/common.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/travel_wish/models/city.dart';
import 'package:sona/core/travel_wish/providers/activity.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';
import 'package:sona/core/travel_wish/providers/my_wish.dart';
import 'package:sona/core/travel_wish/providers/popular_city.dart';
import 'package:sona/core/travel_wish/screens/city_searching.dart';
import 'package:sona/core/travel_wish/services/travel_wish.dart';

import '../../../common/widgets/image/icon.dart';
import '../models/activity.dart';
import '../models/country.dart';
import '../providers/popular_country.dart';

class TravelWishCreator extends ConsumerStatefulWidget {
  const TravelWishCreator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TravelWishCreatorState();
}

class _TravelWishCreatorState extends ConsumerState<TravelWishCreator> {
  final _pageController = PageController();
  static const _pageTransitionDuration = Duration(milliseconds: 200);
  static const _pageTransitionCurve = Curves.ease;

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
      child: ref.watch(asyncPopularTravelCountriesProvider).when(
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
                                  side: MaterialStatePropertyAll(BorderSide(width: 2)),
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
          onTap: () => ref.refresh(asyncPopularTravelCountriesProvider),
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
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 100),
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 2),
                        child: Text(
                          'Where?',
                          style: Theme.of(context).textTheme.headlineLarge
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 32),
                        child: Text(
                            'If you go there, Which cities do you want to visit?',
                            style: Theme.of(context).textTheme.bodyMedium
                        ),
                      ),
                    ),
                    ref.watch(asyncCurrentCitiesProvider).when(
                      data: (cities) => SliverList(
                        delegate: SliverChildListDelegate(
                            cities.map((city) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                              child: OutlinedButtonTheme(
                                data: OutlinedButtonThemeData(
                                    style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                                        minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
                                        side: MaterialStatePropertyAll(BorderSide(width: 2)),
                                        backgroundColor: _selectedCities.contains(city) ? MaterialStatePropertyAll(Theme.of(context).primaryColor) : null
                                    )
                                ),
                                child: OutlinedButton(
                                    key: ValueKey(city.displayName),
                                    onPressed: () => _selectCity(city),
                                    child: Row(
                                      children: [
                                        Text(city.displayName, style: TextStyle(color: _selectedCities.contains(city) ? Colors.white : Theme.of(context).primaryColor))
                                      ],
                                    )
                                ),
                              ),
                            )).toList()
                        )
                      ),
                      error: (_, __) => SliverToBoxAdapter(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Center(
                            child: Text('Error to get initial data\nclick to try again'),
                          ),
                          onTap: () => ref.refresh(asyncPopularTravelCitiesProvider(ref.watch(currentCountryProvider)!.id)),
                        ),
                      ),
                      loading: () => SliverToBoxAdapter(
                        child: Center(
                            child: SizedBox(
                                width: 66,
                                height: 66,
                                child: CircularProgressIndicator()
                            )
                        ),
                      )
                  ),
                  SliverVisibility(
                    visible: ref.watch(asyncCurrentCitiesProvider).value != null,
                    sliver: SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: OutlinedButton(
                            onPressed: () async {
                              final city = await showCupertinoDialog<PopularTravelCity>(
                                  context: context,
                                  builder: (_) => ProviderScope(
                                    parent: ProviderScope.containerOf(context),
                                    child: CitySearching()
                                  )
                              );
                              // if (city != null) {
                              //   _selectedCities.iterator.
                              // }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Search'),
                                Icon(Icons.search)
                              ],
                            ),
                          ),
                        )
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Skip, just ${ref.read(currentCountryProvider)!.displayName}', style: TextStyle(color: Theme.of(context).primaryColor),),
                          SizedBox(width: 12),
                          Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor)
                        ],
                      ),
                      onPressed: () {
                        _pageController.nextPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
                      },
                    ),
                  ),
                ]
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: FilledButton(
              child: Text('Next'),
              onPressed: () {
                _pageController.nextPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _activitiesSelector() {
    return SafeArea(
      child: ref.watch(asyncCurrentActivitiesProvider).when(
        data: (activities) => Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 80),
                child: CustomScrollView(
                  shrinkWrap: true,
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
                  try {
                    final resp = await createTravelWish(country: ref.read(currentCountryProvider)!, cities: _selectedCities, activities: _selectedActivities);
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
          onTap: () => ref.refresh(asyncCurrentActivitiesProvider),
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
    ref.read(currentCountryProvider.notifier).update((state) => country);
    _selectedCities.clear();
    _selectedActivities.clear();
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
}