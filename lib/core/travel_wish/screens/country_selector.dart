import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';

import '../models/country.dart';
import '../providers/popular_country.dart';

class CountrySelector extends ConsumerStatefulWidget {
  const CountrySelector({super.key, required this.onDone});
  final void Function() onDone;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CountrySelector();
}

class _CountrySelector extends ConsumerState<CountrySelector> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(asyncPopularTravelCountriesProvider).when(
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
                              onPressed: () {
                                if (ref.read(travelWishParamsProvider).country?.id != country.id) {
                                  ref.read(travelWishParamsProvider.notifier)
                                    ..clearCities()
                                    ..clearActivities();
                                }
                                ref.read(travelWishParamsProvider.notifier).setCountry(country);
                                widget.onDone();
                              },
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
    );
  }
}