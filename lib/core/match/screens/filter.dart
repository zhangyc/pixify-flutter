import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text('性别'),
              SizedBox(width: 20,),
              Text('女')
            ],
          ),
          Row(
            children: [
              Text('年龄'),
              SizedBox(width: 20,),
              Text('18-40')
            ],
          ),


        ],
      ),
    );
  }
}
