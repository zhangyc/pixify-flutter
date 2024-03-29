import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/no_data/empty.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';

import '../../../generated/l10n.dart';
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
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(
                      S.of(context).wishCountryPickerTitle.split(' ').first,
                      style: Theme.of(context).textTheme.headlineLarge
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(bottom: 32),
                  child: Text(
                      S.of(context).wishCountryPickerTitle.substring(S.of(context).wishCountryPickerTitle.split(' ').first.length),
                      style: Theme.of(context).textTheme.bodyMedium
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                      countries.map((country) => Container(
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
                                backgroundColor: MaterialStatePropertyAll(ref.watch(travelWishParamsProvider).countryId == country.id ? Color(0xFFBEFF06) : null),
                                foregroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                                minimumSize: MaterialStatePropertyAll(Size(128, 56)),
                                side: MaterialStatePropertyAll(BorderSide(width: 2)),
                              )
                          ),
                          child: OutlinedButton(
                              key: ValueKey(country.id),
                              onPressed: () {
                                if (ref.read(travelWishParamsProvider).countryId != country.id) {
                                  ref.read(travelWishParamsProvider.notifier)
                                    ..clearCities()
                                    ..clearActivities();
                                }
                                ref.read(travelWishParamsProvider.notifier).setCountryId(country.id);
                                widget.onDone();
                              },
                              child: Row(
                                children: [
                                  Text(findFlagByCountryCode(country.code)),
                                  SizedBox(width: 16),
                                  Text(country.displayName),
                                  Expanded(child: Container()),
                                  if (ref.read(travelWishParamsProvider).countryId == country.id) SonaIcon(icon: SonaIcons.conch_selected)
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
        error: (_, __) => NoData(
          onRefresh: ref.read(asyncPopularTravelCountriesProvider.notifier).refresh,
        ),
        loading: () => Center(
            child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator()
            )
        )
    );
  }
}