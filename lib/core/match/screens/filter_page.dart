import 'package:flutter/material.dart';
import 'package:sona/core/match/util/local_data.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  _P? p;
  _Gender? gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
             Container(child: Text('Preference'),
              alignment: Alignment.centerLeft,
             ),
             SizedBox(
               height: 12,
             ),
             ...ps.map((e) => GestureDetector(
               child: p==e?SelectedButton(
                 p: e,
               ):UnselectedButton(p: e),
               onTap: (){
                 if(p!=e){
                   p=e;
                   //e.selected=true;
                 }
                 // e.selected=!e.selected;
                 setState(() {

                 });
               },
             )),
             Text('Gender'),
             SizedBox(
              height: 12,
             ),
             Row(
               children: genders.map((e) => GestureDetector(
                 child: e==gender?GenderButton(gender: e):UnSelectedGenderButton(gender: e),
                 onTap: (){
                   currentFilterGender=e;
                   if(gender!=e){
                     gender=e;
                   }
                   // e.selected=!e.selected;
                   setState(() {

                   });
                 },
               )).toList(),
             )
          ],
        ),
      ),
    );
  }
}
class SelectedButton extends StatelessWidget {
  const SelectedButton({super.key,required this.p});
  final _P p;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 76,
      margin: EdgeInsets.only(
        top: 12
      ),
      decoration: BoxDecoration(
          color: Color(0xff2c2c2c),
          borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(p.title,style: TextStyle(
              color: Colors.white
          ),),
          Text(p.subTitle,style: TextStyle(
              color: Colors.white
          ),)
        ],
      ),
    );
  }
}
class UnselectedButton extends StatelessWidget {
  const UnselectedButton({super.key,required this.p});
  final _P p;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 76,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              width: 2,
              color: Colors.black
          )
      ),
      child: Column(
        children: [
          Text(p.title),
          Text(p.subTitle)
        ],
      ),
    );
  }
}



class GenderButton extends StatelessWidget {
  const GenderButton({super.key,required this.gender});
  final _Gender gender;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Color(0xff2c2c2c),
          borderRadius: BorderRadius.circular(24),

      ),
      child: Text(gender.label,style: TextStyle(
        color: Colors.white
      ),),
    );
  }
}
class UnSelectedGenderButton extends StatelessWidget {
  const UnSelectedGenderButton({super.key,required this.gender});
  final _Gender gender;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              width: 2,
              color: Colors.black
          )
      ),
      child: Text(gender.label),
    );
  }
}
class _P{
  String title;
  String subTitle;
  _P(this.title,this.subTitle);
}
List<_P> ps=[
  _P('Wishlist', 'People from your wishlist get more recommendations'),
  _P('Nearby', 'Running into foreigners near you'),
];
List<_Gender> genders=[
  _Gender('Male', 1),
  _Gender('Female', 2),
  _Gender('All People',null),
];
class _Gender{
  String label;
  int? value;
  _Gender(this.label,this.value);
}