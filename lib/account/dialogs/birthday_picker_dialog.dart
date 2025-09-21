import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sona/account/models/age.dart';

class BirthdayPickerDialog extends StatelessWidget {
  const BirthdayPickerDialog(
      {super.key, required this.initialDate, required this.dismissible});
  final DateTime initialDate;
  final bool dismissible;
  @override
  Widget build(BuildContext context) {
    DateTime _birthday = initialDate;
    return Container(
      height: 338,
      padding: const EdgeInsets.only(top: 6.0),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        border: Border.all(
          width: 2,
          color: Color(0xFF2C2C2C),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Container(
            width: 30,
            height: 3,
            color: Colors.black12,
          ),
          SizedBox(height: 24),
          SizedBox(
            height: 188,
            child: CupertinoDatePicker(
                initialDateTime: initialDate,
                mode: CupertinoDatePickerMode.date,
                showDayOfWeek: true,
                maximumDate: DateTime.now().yearsAgo(18),
                onDateTimeChanged: (DateTime newDate) {
                  _birthday = newDate;
                },
                itemExtent: 40),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: FilledButton(
                child: Text('Confirm'),
                onPressed: () {
                  Navigator.pop(context, _birthday);
                }),
          )
        ],
      ),
    );
  }
}
