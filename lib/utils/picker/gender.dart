import 'package:flutter/material.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../account/models/gender.dart';

Future<Gender?> showGenderPicker({
  required BuildContext context,
  Gender? initialValue,
  String? title,
  bool nullable = false,
}) {
  final options = [Gender.male, Gender.female, if (nullable) null];
  final labels = [Gender.male.name, Gender.female.name, if (nullable) 'All'];
  return showRadioFieldDialog<Gender?>(
    context: context,
    initialValue: initialValue,
    options: options,
    labels: labels
  );
}