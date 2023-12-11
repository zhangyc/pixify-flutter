import 'package:flutter/material.dart';

class BioItem extends StatelessWidget {
  const BioItem({super.key, required this.bio});
  final String bio;
  @override
  Widget build(BuildContext context) {
    return bio.isEmpty?Container():Container(
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width-16*2,
      decoration: BoxDecoration(
        color: Color(0xffF6F3F3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(bio,
       style: TextStyle(
         color: Color(0xff2c2c2c)
       ),
      ),
    );
  }
}
