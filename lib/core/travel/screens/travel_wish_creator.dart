import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/utils/country/country.dart';

class TravelWishCreator extends ConsumerStatefulWidget {
  const TravelWishCreator({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TravelWishCreatorState();
}

class _TravelWishCreatorState extends ConsumerState<TravelWishCreator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  hotTravelCountries.map((country) => OutlinedButton(
                    key: ValueKey(country.code),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(country.flag),
                        SizedBox(width: 16),
                        Text(country.displayName)
                      ],
                    )
                  )).toList()
                )
              )
            ],
          ),
        ),
      )
    );
  }

}