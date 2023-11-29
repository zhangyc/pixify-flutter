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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Expanded(
          child: SearchBar(
            controller: _searchController,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel'))
        ],
      ),
      body: ListView(
        children: widget.cities.where((city) => city.displayName.contains(_searchController.text.trim()))
          .map((city) =>  TextButton(
            onPressed: widget.selectedCities.contains(city) ? null : () => Navigator.pop(context, city),
            child: Text(
              city.displayName,
              textAlign: TextAlign.start,
            )
          )
        )
        .toList()
      ),
    );
  }
}