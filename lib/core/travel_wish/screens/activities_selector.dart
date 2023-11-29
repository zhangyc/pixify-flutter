import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';
import 'package:sona/core/travel_wish/providers/popular_activity.dart';
import 'package:sona/core/travel_wish/providers/popular_city.dart';

import '../../../common/widgets/button/colored.dart';
import '../models/country.dart';
import '../providers/my_wish.dart';
import '../services/travel_wish.dart';
import 'city_searching.dart';

class ActivitiesSelector extends ConsumerStatefulWidget {
  const ActivitiesSelector({
    super.key,
    required this.onDone
  });
  final void Function() onDone;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CitiesSelectorState();
}

class _CitiesSelectorState extends ConsumerState<ActivitiesSelector> {

  @override
  Widget build(BuildContext context) {
    final lang = ref.read(myProfileProvider)!.locale ?? 'en';
    final params = ref.watch(travelWishParamsProvider);
    final countryId = params.country?.id;
    if (countryId == null) return Container();
    final key = '${countryId}_$lang';
    final asyncActivities = ref.watch(asyncPopularTravelActivitiesProvider(key));
    final selectedActivities = params.activities;
    return asyncActivities.when(
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
                                        backgroundColor: selectedActivities.contains(activity) ? MaterialStatePropertyAll(Colors.blue.withOpacity(0.33)) : null
                                    )
                                ),
                                child: OutlinedButton(
                                    key: ValueKey(activity.displayName),
                                    onPressed: () => ref.read(travelWishParamsProvider.notifier).toggleActivity(activity),
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
                onTap: widget.onDone,
              ),
            )
          ],
        ),
        error: (_, __) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => ref.refresh(asyncPopularTravelActivitiesProvider(key)),
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
    );
  }
}