import 'package:flutter/material.dart';

class BioItem extends StatelessWidget {
  const BioItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width-16*2,
      decoration: BoxDecoration(
        color: Color(0xff2c2c2c),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text('You can use the Google Translate app to translate written words or phrases. You can also use Google Translate in a web browser like Chrome or Firefox. Learn more about Google Translate in a web browser.',
       style: TextStyle(
         color: Colors.white
       ),
      ),
    );
  }
}
