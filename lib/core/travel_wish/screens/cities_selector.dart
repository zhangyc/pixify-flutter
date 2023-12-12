import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';
import 'package:sona/core/travel_wish/providers/popular_city.dart';
import 'package:sona/core/travel_wish/providers/popular_country.dart';

import '../models/country.dart';
import 'city_searching.dart';

class CitiesSelector extends ConsumerStatefulWidget {
  const CitiesSelector({
    super.key,
    required this.onSkip,
    required this.onNext
  });
  final void Function() onSkip;
  final void Function() onNext;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CitiesSelectorState();
}

class _CitiesSelectorState extends ConsumerState<CitiesSelector> {

  @override
  Widget build(BuildContext context) {
    final lang = ref.read(myProfileProvider)!.locale ?? 'en';
    final params = ref.watch(travelWishParamsProvider);
    final countryId = params.countryId;
    if (countryId == null) return Container();
    final key = '${countryId}_$lang';
    final asyncCities = ref.watch(asyncPopularTravelCitiesProvider(key));
    final selectedCityIds = params.cityIds;
    return Stack(
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
                  asyncCities.when(
                      data: (cities) => SliverList(
                          delegate: SliverChildListDelegate(
                              cities.where((city) => city.popular).map((city) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF2C2C2C),
                                        blurRadius: 0,
                                        offset: Offset(0, 2),
                                        spreadRadius: 0,
                                      )
                                    ]
                                ),
                                child: OutlinedButtonTheme(
                                  data: OutlinedButtonThemeData(
                                      style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                                        minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
                                        side: MaterialStatePropertyAll(BorderSide(width: 2)),
                                        backgroundColor: selectedCityIds.contains(city.id) ? MaterialStatePropertyAll(Color(0xFFFFE806)) : null,
                                        foregroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor)
                                      )
                                  ),
                                  child: OutlinedButton(
                                      key: ValueKey(city.displayName),
                                      onPressed: () => ref.read(travelWishParamsProvider.notifier).toggleCity(city.id),
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
                      error: (_, __) => SliverToBoxAdapter(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Center(
                            child: Text('Error to get initial data\nclick to try again'),
                          ),
                          onTap: () => ref.read(asyncPopularTravelCitiesProvider(key).notifier).refresh(),
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
                  if (asyncCities.value != null) ...asyncCities.value!.where((city) => city.popular && selectedCityIds.contains(city.id))
                    .map<Widget>((city) => SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF2C2C2C),
                                blurRadius: 0,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ]
                        ),
                        child: OutlinedButtonTheme(
                          data: OutlinedButtonThemeData(
                              style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                                  minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
                                  side: MaterialStatePropertyAll(BorderSide(width: 2)),
                                  backgroundColor: selectedCityIds.contains(city.id) ? MaterialStatePropertyAll(Color(0xFFFFE806)) : null,
                                  foregroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor)
                              )
                          ),
                          child: OutlinedButton(
                              key: ValueKey(city.displayName),
                              onPressed: () => ref.read(travelWishParamsProvider.notifier).toggleCity(city.id),
                              child: Row(
                                children: [
                                  Text(city.displayName)
                                ],
                              )
                          ),
                        ),
                      )
                    )
                  ),
                  if (asyncCities.value != null) SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: OutlinedButton(
                        onPressed: () async {
                          final city = await showCupertinoDialog<PopularTravelCity>(
                              context: context,
                              builder: (_) => ProviderScope(
                                  parent: ProviderScope.containerOf(context),
                                  child: CitySearching(
                                    cities: asyncCities.value!,
                                    selectedCityIds: selectedCityIds,
                                  )
                              )
                          );
                          if (city != null) {
                            ref.read(travelWishParamsProvider.notifier).toggleCity(city.id);
                          }
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
                ]
            ),
          ),
        ),
        if (params.cityIds.isEmpty) Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Skip, just ${ref.read(asyncPopularTravelCountriesProvider).value!.firstWhere((country) => country.id == params.countryId).displayName}', style: TextStyle(color: Theme.of(context).primaryColor),),
                SizedBox(width: 12),
                Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor)
              ],
            ),
            onPressed: widget.onSkip,
          ),
        ) else Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: FilledButton(
            child: Text('Next'),
            onPressed: widget.onNext
          ),
        ),
      ],
    );
  }
}