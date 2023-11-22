import 'package:flutter/material.dart';

class BlzActionItem extends StatelessWidget {
  const BlzActionItem({super.key});

  @override
  Widget build(BuildContext context) {
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
          GestureDetector(
            child: Text('Block',style: TextStyle(
              color: Colors.red
            ),),
            onTap: (){

            },
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            child: Text('Report',style: TextStyle(
              color: Colors.black
            ),),
            onTap: (){

            },
          )
        ],
      ),
    );
  }
}
