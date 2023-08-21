import 'package:flutter/material.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../account/models/gender.dart';

Future<Gender?> showGenderPicker({
  required BuildContext context,
  Gender? initialValue,
  String? title,
}) {
  return showRadioFieldDialog<Gender>(
    context: context,
    initialValue: initialValue,
    options: [Gender.male, Gender.female],
    labels: [Gender.male.name, Gender.female.name]
  );
}