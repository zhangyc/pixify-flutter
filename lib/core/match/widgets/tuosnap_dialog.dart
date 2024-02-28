
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/match/widgets/duosnap_button.dart';

import '../../../generated/assets.dart';
import '../bean/match_user.dart';

class CustomBottomDialog extends StatelessWidget {
  final String title;
  final VoidCallback onClosePressed;
  final MatchUserInfo target;
  CustomBottomDialog({required this.title, required this.onClosePressed,required this.target});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24)
        ),
        border: Border(
          top: BorderSide(width: 4.0, color: Colors.black), // 添加黑色顶部边框
        )
      ),
      height: 640,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
                ),
                IconButton(
                  icon: SvgPicture.asset(Assets.svgDislike,width: 40,height: 40,),
                  onPressed: onClosePressed,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Transform.rotate(
                  angle: -15 * 3.14 / 180,
                  child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return CachedNetworkImage(imageUrl: ref.read(myProfileProvider)!.avatar??'',width: 122,height: 163,);
                  },)), // 替换为您的左侧图片路径
              Transform.rotate(
                  angle: 15 * 3.14 / 180,
                  child: CachedNetworkImage(imageUrl: target.avatar??'',width: 122,height: 163,)), // 替换为您的右侧图片路径
            ],
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pick a style',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 8.0),
                _buildOptionButton('🐉 Eastern 🐉',target),
                SizedBox(height: 8.0),

                _buildOptionButton('🏕️ Africa 🏕️',target),
                SizedBox(height: 8.0),

                _buildOptionButton('🕶️ Trendy 🕶️',target),
                SizedBox(height: 8.0),

                _buildOptionButton('👅 Meme 👅',target),
              ],
            ),
          ),
        ],
      )
    );
  }
  // 构建带有底部边框的按钮
  Widget _buildOptionButton(String text,MatchUserInfo targetUrl) {
    return DuosnapButton(targetUrl,text);
  }
}
