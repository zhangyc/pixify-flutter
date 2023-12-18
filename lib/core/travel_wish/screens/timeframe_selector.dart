import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/no_data/empty.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';
import 'package:sona/core/travel_wish/providers/timeframe.dart';

import '../../../generated/l10n.dart';
import '../providers/popular_country.dart';

class TimeframeSelector extends ConsumerStatefulWidget {
  const TimeframeSelector({super.key, required this.onDone});
  final void Function() onDone;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends ConsumerState<TimeframeSelector> {

  @override
  Widget build(BuildContext context) {
    final params = ref.watch(travelWishParamsProvider);
    final countryId = params.countryId;
    return ref.watch(asyncTimeframeOptionsProvider).when(
        data: (options) => Padding(
          padding: const EdgeInsets.all(16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Text(
                      S.of(context).wishDatePickerTitle,
                      style: Theme.of(context).textTheme.headlineLarge
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(bottom: 32),
                  child: Text(
                      S.of(context).wishDatePickerSubtitle(ref.read(asyncPopularTravelCountriesProvider).value!.firstWhere((country) => country.id == countryId).displayName),
                      style: Theme.of(context).textTheme.bodyMedium
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                      options.map((option) => Container(
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
                                backgroundColor: MaterialStatePropertyAll(ref.watch(travelWishParamsProvider).timeframe == option.value ? Color(0xFFFFE806) : null),
                                foregroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
                                minimumSize: MaterialStatePropertyAll(Size.fromHeight(56)),
                                side: MaterialStatePropertyAll(BorderSide(width: 2)),
                              )
                          ),
                          child: OutlinedButton(
                              key: ValueKey(option.value),
                              onPressed: () {
                                ref.read(travelWishParamsProvider.notifier).setTimeframe(option.value);
                                widget.onDone();
                              },
                              child: Row(
                                children: [
                                  Text(option.name)
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
        error: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: NoData(
            onRefresh: ref.read(asyncTimeframeOptionsProvider.notifier).refresh,
          ),
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