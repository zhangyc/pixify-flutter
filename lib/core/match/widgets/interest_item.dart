import 'package:flutter/material.dart';

class InterestItem extends StatelessWidget {
  const InterestItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width-16*2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Interest'),
          SizedBox(
            height: 16,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: ["A","A","A","A","A","A","A","A",].map((e) => Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                )
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle),
                  Text(e)
                ],
              ),
            )).toList(),
          )
        ],
      ),
    );
  }
}
