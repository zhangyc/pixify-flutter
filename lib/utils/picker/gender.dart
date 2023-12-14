import 'package:flutter/material.dart';
import 'package:sona/utils/dialog/input.dart';

import '../../account/models/gender.dart';
import '../../generated/l10n.dart';

Future<Gender?> showGenderPicker({
  required BuildContext context,
  Gender? initialValue,
  String? title,
  bool dismissible = true
}) {
  final options = Map.fromEntries(Gender.allTypes.map((g) => MapEntry(g.displayName, g)));
  return showRadioFields<Gender?>(
    context: context,
    initialValue: initialValue,
    options: options,
    title: S.current.userGenderInputLabel,
    content: S.current.userGenderPickerSubtitle,
    dismissible: dismissible
  );
}