import 'package:flutter/material.dart';

class SonaRadio<T> extends StatelessWidget {
  const SonaRadio({
    Key? key,
    required this.onTap,
    required this.text,
    required this.value,
    required this.groupValue,
    this.disabled = false
  }) : super(key: key);

  final dynamic Function()? onTap;
  final String text;
  final T value;
  final T? groupValue;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(value: value, groupValue: groupValue, onChanged: (_) {});
  }
}