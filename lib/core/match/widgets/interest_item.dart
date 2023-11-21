import 'package:flutter/material.dart';

class InterestItem extends StatelessWidget {
  const InterestItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Interest'),
        Wrap(
          children: ["A","A","A","A","A","A","A","A",].map((e) => Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.circle),
                Text(e)
              ],
            ),
          )).toList(),
        )
      ],
    );
  }
}
