import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/core/travel/services/travel_wish.dart';

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

  SonaCountry? _selectedCountry;
  Set<SonaCity> _selectedCities = {};
  Set<SonaActivity> _selectedActivities = {};

  @override
  void initState() {
    // TODO: implemSonaCityent initState
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
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _countrySelector(),
            _citiesSelector(),
            _activitiesSelector()
          ],
        ),
      )
    );
  }

  Widget _countrySelector() {
    return SafeArea(
      child: Padding(
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
                    hotTravelCountries.map((country) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      child: OutlinedButtonTheme(
                        data: OutlinedButtonThemeData(
                            style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                                minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
                                side: MaterialStatePropertyAll(BorderSide(width: 2))
                            )
                        ),
                        child: OutlinedButton(
                            key: ValueKey(country.code),
                            onPressed: () => _selectCountry(country),
                            child: Row(
                              children: [
                                Text(country.flag),
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
    );
  }

  Widget _citiesSelector() {
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
                  } else {
                    Navigator.pop(context, true);
                  }
                } catch(e) {
                  Navigator.pop(context, true);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void _selectCountry(SonaCountry country) {
    _selectedCountry = country;
    _pageController.nextPage(duration: _pageTransitionDuration, curve: _pageTransitionCurve);
  }

  void _selectCity(SonaCity city) {
    if (_selectedCities.contains(city)) {
      _selectedCities.remove(city);
    } else {
      _selectedCities.add(city);
    }
    setState(() {});
  }

  void _selectActivity(SonaActivity activity) {
    if (_selectedActivities.contains(activity)) {
      _selectedActivities.remove(activity);
    } else {
      _selectedActivities.add(activity);
    }
    setState(() {});
  }

  List<SonaCity> cities = ['东京', '北海道', '稻香村', '稻妻'].map((e) => SonaCity(displayName: e)).toList();

  List<SonaActivity> activities = ['吃拉面', '拍照', '打团'].map((e) => SonaActivity(displayName: e)).toList();
}