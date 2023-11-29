import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';
import 'package:sona/core/travel_wish/providers/popular_city.dart';

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
    print('country: -${params.country?.displayName}');
    final countryId = params.country?.id;
    if (countryId == null) return Container();
    final key = '${countryId}_$lang';
    final asyncCities = ref.watch(asyncPopularTravelCitiesProvider(key));
    final selectedCities = params.cities;
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
                                child: OutlinedButtonTheme(
                                  data: OutlinedButtonThemeData(
                                      style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                                          minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
                                          side: MaterialStatePropertyAll(BorderSide(width: 2)),
                                          backgroundColor: selectedCities.contains(city) ? MaterialStatePropertyAll(Theme.of(context).primaryColor) : null
                                      )
                                  ),
                                  child: OutlinedButton(
                                      key: ValueKey(city.displayName),
                                      onPressed: () => ref.read(travelWishParamsProvider.notifier).toggleCity(city),
                                      child: Row(
                                        children: [
                                          Text(city.displayName, style: TextStyle(color: selectedCities.contains(city) ? Colors.white : Theme.of(context).primaryColor))
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
                          onTap: () => ref.refresh(asyncPopularTravelCitiesProvider(key)),
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
                  if (asyncCities.value != null) ...selectedCities
                    .where((city) => !asyncCities.value!.where((city) => city.popular).contains(city))
                    .map<Widget>((city) => SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        child: OutlinedButtonTheme(
                          data: OutlinedButtonThemeData(
                              style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
                                  minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
                                  side: MaterialStatePropertyAll(BorderSide(width: 2)),
                                  backgroundColor: selectedCities.contains(city) ? MaterialStatePropertyAll(Theme.of(context).primaryColor) : null
                              )
                          ),
                          child: OutlinedButton(
                              key: ValueKey(city.displayName),
                              onPressed: () => ref.read(travelWishParamsProvider.notifier).toggleCity(city),
                              child: Row(
                                children: [
                                  Text(city.displayName, style: TextStyle(color: selectedCities.contains(city) ? Colors.white : Theme.of(context).primaryColor))
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
                                    selectedCities: selectedCities,
                                  )
                              )
                          );
                          if (city != null) {
                            ref.read(travelWishParamsProvider.notifier).toggleCity(city);
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
                  SliverToBoxAdapter(
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Skip, just ${params.country!.displayName}', style: TextStyle(color: Theme.of(context).primaryColor),),
                          SizedBox(width: 12),
                          Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor)
                        ],
                      ),
                      onPressed: widget.onSkip,
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
            onPressed: widget.onNext
          ),
        )
      ],
    );
  }
}