import 'package:flutter/material.dart';
import 'package:sona/account/dialogs/birthday_picker_dialog.dart';
import 'package:sona/account/dialogs/gender_picker_dialog.dart';
import 'package:sona/account/models/gender.dart';

class AccountDialogs {
  /// 生日选择器
  static Future<DateTime?> showBirthdayPicker(BuildContext context,
      {required DateTime initialDate, required bool dismissible}) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) => BirthdayPickerDialog(
        initialDate: initialDate,
        dismissible: dismissible,
      ),
    );
  }

  /// 性别选择器
  static Future<Gender?> showGenderPicker(BuildContext context,
      {required Gender initialValue,
      required bool dismissible,
      String? title,
      String? content}) async {
    final options =
        Map.fromEntries(Gender.allTypes.map((g) => MapEntry(g.displayName, g)));
    return showModalBottomSheet(
      context: context,
      builder: (context) => GenderPickerDialog(
          options: options,
          initialValue: initialValue,
          dismissible: dismissible,
          title: title,
          content: content),
    );
  }
}
