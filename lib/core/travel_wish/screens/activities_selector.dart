import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/travel_wish/models/activity.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';
import 'package:sona/core/travel_wish/providers/popular_activity.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../../common/widgets/button/colored.dart';
import '../services/travel_wish.dart';

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
                    SliverToBoxAdapter(
                      child: Wrap(
                        spacing: 0,
                        runSpacing: 0,
                        children: [
                          ...activities.map((activity) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            child: OutlinedButton(
                              key: ValueKey(activity.displayName),
                              onPressed: () => ref.read(travelWishParamsProvider.notifier).toggleActivity(activity),
                              style: ButtonStyle(
                                  minimumSize: MaterialStatePropertyAll(Size.zero),
                                  side: MaterialStatePropertyAll(BorderSide(width: 2)),
                                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
                                  backgroundColor: selectedActivities.contains(activity) ? MaterialStatePropertyAll(Theme.of(context).primaryColor) : null
                              ),
                              child: Text(activity.displayName, style: TextStyle(color: selectedActivities.contains(activity) ? Colors.white : Theme.of(context).primaryColor),)
                            ),
                          )).toList(),
                          ...selectedActivities
                              .where((act) => !activities.contains(act))
                              .map((activity) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            child: OutlinedButton(
                                key: ValueKey(activity.displayName),
                                onPressed: () => ref.read(travelWishParamsProvider.notifier).toggleActivity(activity),
                                style: ButtonStyle(
                                    minimumSize: MaterialStatePropertyAll(Size.zero),
                                    side: MaterialStatePropertyAll(BorderSide(width: 2)),
                                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
                                    backgroundColor: selectedActivities.contains(activity) ? MaterialStatePropertyAll(Theme.of(context).primaryColor) : null
                                ),
                                child: Text(activity.displayName, style: TextStyle(color: selectedActivities.contains(activity) ? Colors.white : Theme.of(context).primaryColor),)
                            ),
                          )),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                            child: OutlinedButton(
                              onPressed: () async {
                                final input = await showSingleLineTextField(context: context, title: 'Add your thought');
                                if (input != null) {
                                  try {
                                    EasyLoading.show();
                                    final result = await createActivity(
                                        description: input.trim(),
                                        countryId: ref.read(travelWishParamsProvider).country!.id,
                                        cities: ref.read(travelWishParamsProvider).cities
                                    );
                                    if (result.statusCode == 0) {
                                      ref.read(travelWishParamsProvider.notifier).toggleActivity(PopularTravelActivity(
                                          id: result.data,
                                          displayName: input
                                      ));
                                    }
                                  } catch (e) {
                                    //
                                  } finally {
                                    EasyLoading.dismiss();
                                  }
                                }
                              },
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(Size.zero),
                                padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 16, vertical: 4)),
                                side: MaterialStatePropertyAll(BorderSide(width: 2)),
                              ),
                              child: Icon(Icons.add, color: Theme.of(context).primaryColor,)
                            ),
                          )
                        ]
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