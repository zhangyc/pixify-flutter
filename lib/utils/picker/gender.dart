import 'package:flutter/material.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../account/models/gender.dart';

Future<Gender?> showGenderPicker({
  required BuildContext context,
  Gender? initialValue,
  String? title,
  bool dismissible = true
}) {
  final options = Map.fromEntries(Gender.allTypes.map((g) => MapEntry(g.name, g)));
  return showRadioFields<Gender?>(
    context: context,
    initialValue: initialValue,
    options: options,
    title: 'Gender',
    content: 'Your gender will not be shown public, it only be used to help for match',
    dismissible: dismissible
  );
}