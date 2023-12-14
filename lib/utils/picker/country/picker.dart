import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/widgets/button/icon.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/travel_wish/models/country.dart';

import '../../../generated/l10n.dart';

class CountryPicker extends ConsumerStatefulWidget {
  const CountryPicker({
    super.key,
    this.initialValue
  });
  final SonaCountry? initialValue;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CountryPickerState();
}

class _CountryPickerState extends ConsumerState<CountryPicker> {
  late final List<SonaCountry> _countries;
  late final TextEditingController _searchController;

  List<SonaCountry> get filtered => _countries.where((country) => country.displayName.toLowerCase().contains(_searchController.text.toLowerCase().trim())).toList(growable: false);

  @override
  void initState() {
    _countries = supportedSonaCountries.toList(growable: false);
    _searchController = TextEditingController()
      ..addListener(_onInputChanged);
    super.initState();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onInputChanged)
      ..dispose();
    super.dispose();
  }

  void _onInputChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Color(0xFF2C2C2C),
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        shadows: [
          BoxShadow(
            color: Color(0xFF2C2C2C),
            blurRadius: 0,
            offset: Offset(0, -4),
            spreadRadius: 0,
          )
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(S.of(context).selectCountryPageTitle, style: Theme.of(context).textTheme.titleLarge),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SIconButton.outlined(
                  icon: SonaIcons.close,
                  onTap: () => Navigator.pop(context),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                child: SonaIcon(icon: SonaIcons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: _countryBuilder,
              itemCount: filtered.length
            ),
          ),
        ],
      ),
    );
  }

  Widget _countryBuilder(BuildContext context, int index) {
    final country = filtered[index];
    return TextButton(
      key: ValueKey(country.code),
        onPressed: () => Navigator.pop(context, country),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(country == widget.initialValue ? Color(0xFFF6F3F3) : Colors.transparent)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${country.flag} ${country.displayName}'),
            Text('${country.dialCode}')
          ],
        )
    );
  }
}