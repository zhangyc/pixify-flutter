import 'package:flutter/material.dart';

import '../../../account/models/hobby.dart';
import '../../../generated/l10n.dart';
import '../bean/match_user.dart';


class InterestItem extends StatelessWidget {
  const InterestItem({super.key, required this.interest});
  final List<UserHobby> interest;
  @override
  Widget build(BuildContext context) {
    return interest.isEmpty?Container():SizedBox(
      width: MediaQuery.of(context).size.width-16*2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).interests,style: TextStyle(
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
                color: Color(0xffBEFF06),
                border: Border.all(
                  width: 2,
                  color: Color(0xff2c2c2c)
                ),
                borderRadius: BorderRadius.circular(14)
              ),
              child: Text(e.displayName??'',style: TextStyle(
                color: Color(0xff2c2c2c)
              ),)
            )).toList(),
          )
        ],
      ),
    );
  }
}
