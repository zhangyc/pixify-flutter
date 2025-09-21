import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sona/core/match/util/local_data.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/global/global.dart';
import 'dart:ui' as ui;

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<_P> ps = [
    _P(S.current.wishList,
        S.current.peopleFromYourWishlistGetMoreRecommendations, 'WISH'),
    _P(S.current.nearby, S.current.runningIntoForeignersNearYou, 'LOCAL'),
  ];
  List<_Gender> genders = [
    _Gender(S.current.userGenderOptionMale, 1, [Assets.iconsManUnselected],
        [Assets.iconsManSelected]),
    _Gender(S.current.userGenderOptionFemale, 2, [Assets.iconsWomanUnselected],
        [Assets.iconsWonmanSelected]),
    _Gender(
        S.current.allPeople,
        null,
        [Assets.iconsManUnselected, Assets.iconsWomanUnselected],
        [Assets.iconsManSelected, Assets.iconsWonmanSelected]),
  ];
  String? p = recommendMode;
  int? gender = currentFilterGender;
  ui.Image? customImage;

  @override
  void initState() {
    load(Assets.iconsHandle).then((image) {
      setState(() {
        customImage = image;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).filter,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ValueListenableBuilder(
          valueListenable: appCommonBox.listenable(),
          builder: (_, b, __) {
            RangeValues rv = RangeValues(
                currentFilterMinAge.toDouble(), currentFilterMaxAge.toDouble());

            return ListView(
              children: [
                // Container(
                //   child: Text(
                //     S.of(context).preference,
                //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                //   ),
                //   alignment: Alignment.centerLeft,
                // ),
                // SizedBox(
                //   height: 12,
                // ),
                // LayoutBuilder(builder: (context, constraints) {
                //   final double cardWidth = (constraints.maxWidth - 12) / 2;
                //   return Wrap(
                //     spacing: 12,
                //     runSpacing: 12,
                //     children: ps
                //         .map((e) => SizedBox(
                //               width: cardWidth,
                //               child: GestureDetector(
                //                 child: p == e.value
                //                     ? SelectedButton(p: e)
                //                     : UnselectedButton(p: e),
                //                 onTap: () {
                //                   recommendMode = e.value;
                //                   if (p != e.value) {
                //                     p = e.value;
                //                   }
                //                   setState(() {});
                //                 },
                //               ),
                //             ))
                //         .toList(),
                //   );
                // }),
                // SizedBox(
                //   height: 24,
                // ),
                Align(
                  child: Text(
                    S.of(context).userGenderInputLabel,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  height: 12,
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.spaceBetween,
                  children: genders
                      .map((e) => GestureDetector(
                            child: e.value == gender
                                ? GenderButton(gender: e)
                                : UnSelectedGenderButton(gender: e),
                            onTap: () {
                              currentFilterGender = e.value;
                              if (gender != e.value) {
                                gender = e.value;
                              }
                              setState(() {});
                            },
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          width: 1)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).age,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          Text('$currentFilterMinAge-$currentFilterMaxAge')
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      customImage == null
                          ? Container()
                          : SliderTheme(
                              data: SliderThemeData(
                                rangeThumbShape: CustomThumbShape2(
                                    thumbRadius: 20, minTrackHeight: 10),
                              ),
                              child: RangeSlider(
                                  activeColor:
                                      Theme.of(context).colorScheme.primary,
                                  inactiveColor: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant,
                                  min: 18,
                                  max: 80,
                                  labels: RangeLabels(
                                      rv.start.toStringAsFixed(0),
                                      rv.end.toStringAsFixed(0)),
                                  values: rv,
                                  onChanged: (rv) {
                                    currentFilterMinAge = rv.start.toInt();
                                    currentFilterMaxAge = rv.end.toInt();
                                  }),
                            ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class SelectedButton extends StatelessWidget {
  const SelectedButton({super.key, required this.p});
  final _P p;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,

      // width: 343,
      height: 105,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            p.title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w900),
          ),
          Text(
            p.subTitle,
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onPrimaryContainer
                  .withOpacity(0.75),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}

class UnselectedButton extends StatelessWidget {
  const UnselectedButton({super.key, required this.p});
  final _P p;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // width: 343,
      height: 105,
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              width: 2, color: Theme.of(context).colorScheme.outlineVariant)),
      child: Column(
        children: [
          Text(
            p.title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w600),
          ),
          Text(
            p.subTitle,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  const GenderButton({super.key, required this.gender});
  final _Gender gender;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.center,
            width: 108,
            height: 56,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(24),
            ),
            child: ListView.separated(
              itemBuilder: (_, i) {
                return Image.asset(
                  gender.selectedIcons[i],
                  width: 24,
                  height: 24,
                );
              },
              separatorBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: VerticalDivider(
                    indent: 16,
                    endIndent: 16,
                    width: 1, // 分割线高度
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                );
              },
              itemCount: gender.selectedIcons.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            )),
        SizedBox(
          height: 4,
        ),
        Center(
          child: Text(
            gender.label,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class UnSelectedGenderButton extends StatelessWidget {
  const UnSelectedGenderButton({super.key, required this.gender});
  final _Gender gender;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.center,
            width: 108,
            height: 56,
            // padding: EdgeInsets.all(16),
            // margin: EdgeInsets.only(
            //     right: 10
            // ),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).colorScheme.outlineVariant,
                )),
            child: ListView.separated(
              itemBuilder: (_, i) {
                return Image.asset(
                  gender.unSelectedIcons[i],
                  width: 24,
                  height: 24,
                );
              },
              separatorBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: VerticalDivider(
                    indent: 16,
                    endIndent: 16,
                    width: 1,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                );
              },
              itemCount: gender.unSelectedIcons.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            )),
        SizedBox(
          height: 4,
        ),
        Center(
          child: Text(
            gender.label,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

class _P {
  String title;
  String subTitle;
  String value;
  _P(this.title, this.subTitle, this.value);
}

class _Gender {
  String label;
  int? value;
  List<String> unSelectedIcons;
  List<String> selectedIcons;

  _Gender(this.label, this.value, this.unSelectedIcons, this.selectedIcons);
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
  void paint(
    PaintingContext context,
    Offset center, {
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
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    //旋转坐标系
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(45 * (pi / 180));

    // final thumbRadius = 10.0;
    final radius = 100 * (pi / 180);

    final path = Path()
      ..moveTo(0, -thumbRadius / 2)
      ..lineTo(thumbRadius / 2, 0)
      ..lineTo(0, thumbRadius / 2)
      ..lineTo(-thumbRadius / 2, 0);

    final thumbRect = Rect.fromPoints(
        Offset(-thumbRadius / 2, -thumbRadius / 2),
        Offset(thumbRadius / 2, thumbRadius / 2));
    path.addRRect(RRect.fromRectXY(thumbRect, radius, radius));

    // path.addRRect(
    //     RRect.fromRectAndCorners(
    //         thumbRect,
    //         topLeft: Radius.circular(radius),
    //         topRight: Radius.circular(radius),
    //         bottomLeft: Radius.circular(radius),
    //         bottomRight: Radius.circular(radius),
    //     )
    // );
    path.close();

    //绘制边框和填充
    canvas.drawPath(path, borderPaint);
    canvas.drawPath(path, paint);

    canvas.restore();
  }
}

class SliderThumbImage extends SliderComponentShape {
  final ui.Image image;

  SliderThumbImage(this.image);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(image.width.toDouble(), image.height.toDouble());
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final imageWidth = image.width;
    final imageHeight = image.height;

    Offset imageOffset = Offset(
      center.dx - (imageWidth / 2),
      center.dy - (imageHeight / 2),
    );

    Paint paint = Paint()..filterQuality = FilterQuality.high;
    canvas.drawImage(image, imageOffset, paint);
  }
}

Future<ui.Image> load(String asset) async {
  ByteData data = await rootBundle.load(asset);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  ui.FrameInfo fi = await codec.getNextFrame();
  return fi.image;
}
