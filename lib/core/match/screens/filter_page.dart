import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sona/core/match/util/local_data.dart';
import '../../../utils/global/global.dart';

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
                 recommendMode=e.value;
                 if(p!=e){
                   p=e;
                   //e.selected=true;
                 }
                 // e.selected=!e.selected;
                 setState(() {

                 });
               },
             )),
            SizedBox(
              height: 24,
            ),
             Align(child: Text('Gender'),alignment: Alignment.centerLeft,),
             SizedBox(
              height: 12,
             ),
             Row(
               children: genders.map((e) => GestureDetector(
                 child: e==gender?GenderButton(gender: e):UnSelectedGenderButton(gender: e),
                 onTap: (){
                   currentFilterGender=e.value;
                   if(gender!=e){
                     gender=e;
                   }
                   // e.selected=!e.selected;
                   setState(() {

                   });
                 },
               )).toList(),
             ),
            SizedBox(
              height: 24,
            ),
            ValueListenableBuilder(valueListenable: appCommonBox.listenable(), builder: (c,b,_){
              RangeValues rv=RangeValues(currentFilterMinAge.toDouble(), currentFilterMaxAge.toDouble());
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Age'),
                      Text('$currentFilterMinAge-$currentFilterMaxAge')
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      rangeThumbShape: CustomThumbShape2(
                          thumbRadius:20,
                          minTrackHeight:10
                      ),

                      // thumbColor: Colors.black,
                      // thumbShape: SliderThumbImage(customImage!),
                    ),
                    child: RangeSlider(
                        activeColor: Colors.black,
                        inactiveColor:Color(0xffE8E6E6),
                        min: 18,
                        max: 80,
                        // divisions: 10,
                        labels: RangeLabels(rv.start.toStringAsFixed(0), rv.end.toStringAsFixed(0)),
                        values: rv,
                        onChanged: (rv) {
                          currentFilterMinAge=rv.start.toInt();
                          currentFilterMaxAge=rv.end.toInt();
                        }
                    ),
                  ),
                ],
              );
            }),
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
      alignment: Alignment.center,

      // width: 343,
      height: 105,
      padding: EdgeInsets.all(16),
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
      alignment: Alignment.center,
      // width: 343,
      height: 105,
      margin: EdgeInsets.only(
          top: 12
      ),
      padding: EdgeInsets.all(16),
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
      margin: EdgeInsets.only(
        right: 10
      ),
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
      margin: EdgeInsets.only(
          right: 10
      ),
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
  String value;
  _P(this.title,this.subTitle,this.value);
}
List<_P> ps=[
  _P('Wishlist', 'People from your wishlist get more recommendations','WISH'),
  _P('Nearby', 'Running into foreigners near you','LOCAL'),
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




class CustomThumbShape2 extends RangeSliderThumbShape {

  final double thumbRadius;
  final double minTrackHeight;

  CustomThumbShape2({
    required this.thumbRadius,
    required this.minTrackHeight,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }
  @override
  void paint(PaintingContext context, Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required SliderThemeData sliderTheme,
    bool? isDiscrete,
    bool? isEnabled,
    bool? isOnTop,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final canvas = context.canvas;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    //旋转坐标系
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(45 * (pi/180));

    // final thumbRadius = 10.0;
    final radius = 100 * (pi/180);

    final path = Path()
      ..moveTo(0, -thumbRadius/2)
      ..lineTo(thumbRadius/2, 0)
      ..lineTo(0, thumbRadius/2)
      ..lineTo(-thumbRadius/2, 0);

    final thumbRect = Rect.fromPoints(Offset(-thumbRadius/2, -thumbRadius/2),Offset(thumbRadius/2,thumbRadius/2));
    path.addRRect(RRect.fromRectXY(thumbRect, radius, radius));
    path.close();

    //绘制边框和填充
    canvas.drawPath(path, borderPaint);
    canvas.drawPath(path, paint);

    canvas.restore();
  }
}