import 'package:flutter/material.dart';
import 'package:sona/common/screens/profile.dart';
import 'package:sona/core/match/widgets/profile_widget.dart';

class BizActionItem extends StatelessWidget {
  const BizActionItem({super.key, required this.report, required this.block, required this.relation});
  final VoidCallback report;
  final VoidCallback block;
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
                child: Text('Unmatch',style: TextStyle(
                    color: Colors.black
                ),),
                onTap: report,
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ):Container(),
          GestureDetector(
            child: Text('Block',style: TextStyle(
              color: Colors.red
            ),),
            onTap: block,
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            child: Text('Report',style: TextStyle(
              color: Colors.black
            ),),
            onTap: report,
          ),

        ],
      ),
    );
  }
}
