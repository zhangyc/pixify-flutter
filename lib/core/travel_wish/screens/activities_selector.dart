import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/no_data/empty.dart';
import 'package:sona/core/travel_wish/models/activity.dart';
import 'package:sona/core/travel_wish/providers/creator.dart';
import 'package:sona/core/travel_wish/providers/popular_activity.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../../common/widgets/button/colored.dart';
import '../../../generated/l10n.dart';
import '../providers/popular_country.dart';
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

  static const maxCount = 3;

  @override
  Widget build(BuildContext context) {
    final lang = ref.read(myProfileProvider)!.locale ?? 'en';
    final params = ref.watch(travelWishParamsProvider);
    final countryId = params.countryId;
    if (countryId == null) return Container();
    final key = '${countryId}_$lang';
    final asyncActivities = ref.watch(asyncPopularTravelActivitiesProvider(key));
    final selectedActivityIds = params.activityIds;
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
                        margin: EdgeInsets.only(bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                                S.of(context).wishActivityPickerTitle,
                                style: Theme.of(context).textTheme.headlineLarge
                            ),
                            Text.rich(
                                TextSpan(
                                    children: [
                                      TextSpan(
                                          text: '${selectedActivityIds.length}'
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
                            S.of(context).wishActivityPickerSubtitle,
                            style: Theme.of(context).textTheme.bodyMedium
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
                            child: OutlinedButton(
                              key: ValueKey(activity.displayName),
                              onPressed: () => ref.read(travelWishParamsProvider.notifier).toggleActivity(activity.id),
                              style: ButtonStyle(
                                  minimumSize: MaterialStatePropertyAll(Size.zero),
                                  side: MaterialStatePropertyAll(BorderSide(width: 2)),
                                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
                                  backgroundColor: selectedActivityIds.contains(activity.id) ? MaterialStatePropertyAll(Color(0xFFBEFF06)) : null,
                                foregroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor)
                              ),
                              child: Text(activity.displayName)
                            ),
                          )).toList(),
                          Container(
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
                            child: OutlinedButton(
                              onPressed: () async {
                                final input = await showSingleLineTextField(context: context, title: 'Add your thought', maxLen: 30);
                                if (input != null) {
                                  try {
                                    EasyLoading.show();
                                    final result = await createActivity(
                                        description: input.trim(),
                                        countryId: ref.read(travelWishParamsProvider).countryId!,
                                        cityIds: ref.read(travelWishParamsProvider).cityIds
                                    );
                                    asyncActivities.value!.add(PopularTravelActivity(id: result.data, displayName: input.trim()));
                                    if (result.statusCode == 0) {
                                      ref.read(travelWishParamsProvider.notifier).toggleActivity(result.data);
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
                key: ValueKey(selectedActivityIds.length),
                size: ColoredButtonSize.large,
                text: S.of(context).buttonDone,
                loadingWhenAsyncAction: true,
                onTap: widget.onDone,
                disabled: selectedActivityIds.isEmpty,
              ),
            )
          ],
        ),
        error: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: NoData(
            onRefresh: ref.read(asyncPopularTravelActivitiesProvider(key).notifier).refresh,
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