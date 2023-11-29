import 'package:flutter/material.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/utils/dialog/input.dart';

Future<SonaCountry?> showCountryPicker({
  required BuildContext context,
  SonaCountry? initialValue,
  String? title,
  bool dismissible = true
}) {
  final options = Map.fromEntries(supportedSonaCountries.map((country) => MapEntry('${country.flag} ${country.displayName}', country)));
  return showRadioFieldDialog<SonaCountry>(
      context: context,
      initialValue: initialValue,
      options: options,
      title: 'Select Country',
      dismissible: dismissible
  );
}