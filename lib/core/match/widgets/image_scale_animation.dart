import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/match/widgets/icon_animation.dart';

import '../../../generated/assets.dart';
import '../../subscribe/model/member.dart';

class MyImageAnimation extends StatefulWidget {
  const MyImageAnimation({super.key, required this.info});
  final MatchUserInfo info;
  @override
  _MyImageAnimationState createState() => _MyImageAnimationState();
}
class _MyImageAnimationState extends State<MyImageAnimation> {

  @override
  void initState() {
    _startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
        width: widget.info.matched ? 95 : MediaQuery.of(context).size.width-16*2,
        height: widget.info.matched ? 118 : 457,
        child: widget.info.matched
            ? Container(decoration: BoxDecoration(
            color: Colors.black,
            image: widget.info.avatar==null?null:DecorationImage(image: CachedNetworkImageProvider(widget.info.avatar!),fit: BoxFit.cover),
            border: Border.all(
                color: Colors.black,
                width: 2
            ),
            borderRadius: BorderRadius.circular(20)
        ),
          clipBehavior: Clip.antiAlias,
        ):
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              widget.info.avatar==null?Container():CachedNetworkImage(imageUrl: widget.info.avatar!,fit: BoxFit.cover,width: MediaQuery.of(context).size.width-16*2,height: 457,),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.5)
                  ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(widget.info.originNickname??'',style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800
                    ),
                      maxLines: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${widget.info.name??''}, ${widget.info.age} '
                                ),
                                WidgetSpan(child: switch(widget.info.memberType) {
                                  MemberType.club => FittedBox(
                                    child: Container(
                                        height: 42,
                                        alignment: Alignment.centerLeft,
                                        child: SonaIcon(icon: SonaIcons.club_mark, size: 24)
                                    ),
                                  ),
                                  MemberType.plus => FittedBox(
                                    child: Container(
                                        height: 42,
                                        alignment: Alignment.centerLeft,
                                        child: SonaIcon(icon: SonaIcons.plus_mark, size: 24)
                                    ),
                                  ),
                                  _ => Container(height: 42),
                                })
                              ]
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              height: 1.5,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (widget.info.countryFlag != null) Text(widget.info.countryFlag??''),
                        if (widget.info.countryName != null) Padding(
                          padding: const EdgeInsets.only(left: 6, right: 12),
                          child: Text(widget.info.countryName??'', style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w900
                          )),
                        ),
                        if (widget.info.currentCity != null && widget.info.currentCity!.isNotEmpty) Image.asset(Assets.iconsGps,width: 16,height: 16,),
                        SizedBox(
                          width: 4,
                        ),
                        if (widget.info.currentCity != null && widget.info.currentCity!.isNotEmpty) Text('${widget.info.currentCity}',style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w900
                        ),)
                      ],
                    )
                  ],
                ),
              ),

              Positioned(top: 11,child: IconAnimation())
            ],
          ),
        ),
        onEnd: () {
          // 在动画结束时切换widget
          setState(() {
            //widget.matched = !widget.matched;
          });
        },
      ),
    );
  }

  void _startAnimation() {
    setState(() {
      // 在这里修改目标宽高比例
      // _containerWidth = 95;
      // _containerHeight = 118;
    });
  }
}
