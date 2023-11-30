import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/travel_wish/models/country.dart';


class CitySearching extends ConsumerStatefulWidget {
  const CitySearching({
    super.key,
    required this.cities,
    required this.selectedCities
  });
  final List<PopularTravelCity> cities;
  final Set<PopularTravelCity> selectedCities;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CitySearchingState();
}

class _CitySearchingState extends ConsumerState<CitySearching> {

  late final TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController()
      ..addListener(_changeListener);
    super.initState();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_changeListener)
      ..dispose();
    super.dispose();
  }

  void _changeListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 64,
                width: MediaQuery.of(context).size.width,
                child: Row(
                    children: [
                      SizedBox(width: 16),
                      Flexible(
                        flex: 6,
                        child: SearchBar(
                          controller: _searchController,
                          hintText: 'Search',
                        ),
                      ),
                      SizedBox(width: 16),
                      Flexible(
                        flex: 1,
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.clear)
                        ),
                      ),
                      SizedBox(width: 16)
                    ],
                  ),
              ),
            ),
            SliverList.list(
              children: widget.cities.where((city) => _searchController.text.trim().isNotEmpty && city.displayName.contains(_searchController.text.trim()))
                .map((city) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: widget.selectedCities.contains(city) ? null : () => Navigator.pop(context, city),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Text(
                      city.displayName,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: widget.selectedCities.contains(city) ? Theme.of(context).disabledColor : Theme.of(context).primaryColor),
                    ),
                  )
                )).toList()
            )
          ]
        ),
      ),
    );
  }
}