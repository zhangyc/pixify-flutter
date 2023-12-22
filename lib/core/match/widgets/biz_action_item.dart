import 'package:flutter/material.dart';
import 'package:sona/common/screens/profile.dart';
import 'package:sona/core/match/widgets/profile_widget.dart';

import '../../../generated/l10n.dart';

class BizActionItem extends StatelessWidget {
  const BizActionItem({super.key, required this.report, required this.block, required this.relation, required this.unMatch});
  final VoidCallback report;
  final VoidCallback block;
  final VoidCallback unMatch;


  final Relation relation;
  @override
  Widget build(BuildContext context) {
    if(relation==Relation.self){
      return Container();
    }
    return SizedBox(
      //alignment: Alignment.center,
      height: 80,
      width: MediaQuery.of(context).size.width-16*2,
      //color: Colors.amber,
      //padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          relation==Relation.matched?Row(
            children: [
              GestureDetector(
                onTap: unMatch,
                child: Text(S.of(context).buttonUnmatch,style: TextStyle(
                    color: Color(0xffBDBDBD)
                ),),
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ):Container(),
          GestureDetector(
            child: Text(S.of(context).block,style: TextStyle(
                color: Color(0xffBDBDBD)
            ),),
            onTap: block,
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            child: Text(S.of(context).report,style: TextStyle(
                color: Color(0xffBDBDBD)
            ),),
            onTap: report,
          ),

        ],
      ),
    );
  }
}
