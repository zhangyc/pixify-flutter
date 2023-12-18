import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/no_data/empty.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';
import 'package:sona/core/travel_wish/providers/popular_city.dart';
import 'package:sona/core/travel_wish/providers/popular_country.dart';

import '../../../generated/l10n.dart';
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

  static const maxCount = 3;

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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              '${ref.read(asyncPopularTravelCountriesProvider).value?.firstWhere((country) => country.id == countryId).displayName}',
                              style: Theme.of(context).textTheme.headlineLarge
                          ),
                          Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${selectedCityIds.length}'
                                  ),
                                  TextSpan(
                                    text: '/$maxCount',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                    )
                                  )
                                ]
                              ),
                              style: Theme.of(context).textTheme.titleMedium
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 32),
                      child: Text(
                          S.of(context).wishCityPickerSubtitle,
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
                        child: NoData(
                          onRefresh: ref.read(asyncPopularTravelCitiesProvider(key).notifier).refresh,
                        ),
                      ),
                      loading: () => SliverToBoxAdapter(
                        child: Center(
                            child: SizedBox(
                                width: 32,
                                height: 32,
                                child: CircularProgressIndicator()
                            )
                        ),
                      )
                  ),
                  if (asyncCities.hasValue) ...asyncCities.value!.where((city) => !city.popular && selectedCityIds.contains(city.id))
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
                  if (asyncCities.hasValue) SliverToBoxAdapter(
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
                Text(S.of(context).wishCityPickerSkipButton(ref.read(asyncPopularTravelCountriesProvider).value!.firstWhere((country) => country.id == params.countryId).displayName), style: TextStyle(color: Theme.of(context).primaryColor),),
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
            child: Text(S.of(context).buttonNext),
            onPressed: widget.onNext
          ),
        ),
      ],
    );
  }
}