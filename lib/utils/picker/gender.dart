import 'package:flutter/material.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../account/models/gender.dart';

Future<Gender?> showGenderPicker({
  required BuildContext context,
  Gender? initialValue,
  String? title,
  bool dismissible = true
}) {
  final options = Map.fromEntries(Gender.all.map((g) => MapEntry(g.name, g)));
  return showRadioFieldDialog<Gender?>(
    context: context,
    initialValue: initialValue,
    options: options,
    dismissible: dismissible
  );
}