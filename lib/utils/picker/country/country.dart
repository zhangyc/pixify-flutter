import 'package:flutter/material.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/utils/dialog/common.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/picker/country/picker.dart';

Future<SonaCountry?> showCountryPicker({
  required BuildContext context,
  SonaCountry? initialValue,
  String? title,
  bool dismissible = true
}) {
  return showModalBottomSheet<SonaCountry>(
    context: context,
    isScrollControlled: true,
    isDismissible: dismissible,
    builder: (_) => CountryPicker(initialValue: initialValue)
  );
}