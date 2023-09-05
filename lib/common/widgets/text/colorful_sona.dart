import 'package:flutter/material.dart';

class ColorfulSona extends StatelessWidget {
  const ColorfulSona({super.key});

  @override
  Widget build(BuildContext context) => const Text.rich(TextSpan(children: [
        TextSpan(
            text: 'S',
            style: TextStyle(
                color: Colors.blue, fontSize: 32, fontWeight: FontWeight.bold)),
        WidgetSpan(child: SizedBox(width: 10)),
        TextSpan(
            text: 'O',
            style: TextStyle(
                color: Colors.pink, fontSize: 32, fontWeight: FontWeight.bold)),
        WidgetSpan(child: SizedBox(width: 8)),
        TextSpan(
            text: 'N',
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 32,
                fontWeight: FontWeight.bold)),
        TextSpan(
            text: 'A',
            style: TextStyle(
                color: Colors.red, fontSize: 32, fontWeight: FontWeight.bold)),
      ]));
}
