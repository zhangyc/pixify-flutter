import 'package:flutter/material.dart';

import '../bean/match_user.dart';


class InterestItem extends StatelessWidget {
  const InterestItem({super.key, required this.interest});
  final List<Interest> interest;
  @override
  Widget build(BuildContext context) {
    return interest.isEmpty?Container():SizedBox(
      width: MediaQuery.of(context).size.width-16*2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Interest',style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800
          ),),
          SizedBox(
            height: 16,
          ),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: interest.map((e) => Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Color(0xff2c2c2c)
                ),
                borderRadius: BorderRadius.circular(14)
              ),
              child: Text(e.name??'',style: TextStyle(
                color: Color(0xff2c2c2c)
              ),)
            )).toList(),
          )
        ],
      ),
    );
  }
}
