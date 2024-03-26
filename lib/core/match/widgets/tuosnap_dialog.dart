import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/core/match/widgets/duosnap_button.dart';

import '../../../generated/assets.dart';
import '../bean/match_user.dart';
import '../providers/duo_provider.dart';

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
            // decoration: BoxDecoration(
            //   border: Border(bottom: BorderSide(color: Colors.grey)),
            // ),
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
                    return Container(
                      width: 122,
                      height: 163,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff2c2c2c),
                          width: 2
                        ),
                          borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(image: CachedNetworkImageProvider(ref.read(myProfileProvider)!.avatar??''),fit: BoxFit.cover,)

                      ),
                      clipBehavior: Clip.antiAlias,
                    );
                  },)), // 替换为您的左侧图片路径
              Transform.rotate(
                  angle: 15 * 3.14 / 180,
                  child: Container(
                    width: 122,
                    height: 163,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: CachedNetworkImageProvider(target.avatar??''),fit: BoxFit.cover,),
                      border: Border.all(
                          color: Color(0xff2c2c2c),
                          width: 2
                      ),
                      borderRadius: BorderRadius.circular(12)
                      ),

                  )

              ), // 替换为您的右侧图片路径
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
                Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final AsyncValue<List<SdModel>> result = ref.watch(getSDModelProvider);
                  if(result.hasValue){
                    return SizedBox(
                      height: 250,
                      child: ListView(
                        shrinkWrap: true,
                        children: result.value!.map((e) => Column(
                          children: [
                            SizedBox(height: 8.0),
                            _buildOptionButton(e,target),
                          ],
                        )).toList(),
                      ),
                    );
                  }else if(result.hasError){
                    return  Center(child: const Text('Oops, something unexpected happened'));
                  }else {
                    return Center(child: SizedBox(width: 32,height: 32,child: CircularProgressIndicator(),));
                  }

                },),
              ],
            ),
          ),
        ],
      )
    );
  }
  // 构建带有底部边框的按钮
  Widget _buildOptionButton(SdModel model,MatchUserInfo targetUrl) {
    return DuosnapButton(targetUrl,model);
  }
}
