import 'package:flutter/material.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../account/models/gender.dart';

Future<Gender?> showGenderPicker({
  required BuildContext context,
  Gender? initialValue,
  String? title,
  bool dismissible = true
}) {
  final options = {
    Gender.male.name: Gender.male,
    Gender.female.name: Gender.female,
  };
  return showRadioFieldDialog<Gender?>(
    context: context,
    initialValue: initialValue,
    options: options,
    dismissible: dismissible
  );
}