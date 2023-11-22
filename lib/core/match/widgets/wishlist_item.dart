import 'package:flutter/material.dart';

class WishListItem extends StatelessWidget {
  const WishListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width-16*2,
      decoration: BoxDecoration(
        color: Color(0xff2c2c2c),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Her wishes',style: TextStyle(
            color: Colors.white
          ),),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: ['A','A','A','A','A','A','A'].map((e) => Container(
              padding: EdgeInsets.all(5),
              child: Text(e),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.white
                )
              ),
            )).toList(),
          )
        ],
      ),
    );
  }
}
