import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../generated/assets.dart';
import '../bean/match_user.dart';
import '../providers/match_provider.dart';
import '../providers/matched.dart';
import 'choice_bytton.dart';

class WishCardWidget extends ConsumerStatefulWidget {
  WishCardWidget({
    super.key,
    required this.context,
    required this.info,
    required this.next,
  });

  final BuildContext context;
  final MatchUserInfo info;
  final VoidCallback next;

  @override
  ConsumerState<WishCardWidget> createState() => _WishCardWidgetState();
}

class _WishCardWidgetState extends ConsumerState<WishCardWidget> {
  PageController pageController=PageController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(backgroundImageProvider.notifier).updateBg(widget.info.wishList.first.pic!);

    });

    super.initState();
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top+MediaQuery.of(context).viewPadding.top+58,
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(Assets.imagesTest),fit: BoxFit.cover),
              border: Border.all(
                  color: Colors.black,
                  width: 2
              ),
              borderRadius: BorderRadius.circular(20)
          ),
          clipBehavior: Clip.antiAlias,
          width: 95,height: 118,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text('Are you interested in her ideas',style: TextStyle(
              color: Colors.black,
              fontSize: 28
          ),),
        ),
        Expanded(
          child: PageView(
            onPageChanged: (value){
              ref.read(backgroundImageProvider.notifier).updateBg(widget.info.wishList[value].pic!);
              },
            controller: pageController,
            children: widget.info.wishList.map((wish) => Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 8
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 327,
                    height: 262,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: Colors.black,
                          width: 2
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Text('${wish.countryName}',style: TextStyle(color: Colors.black),),
                            Text('${wish.countryFlag}')
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: List.generate(wish.activities.length, (index2) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ChoiceButton(text: wish.activities[index2].title??'', onTap: () {
                                ///点击切换，下一个用户.并且调用like接口
                                ref.read(asyncMatchRecommendedProvider.notifier).like(widget.info.id,
                                    activityId: wish.activities[index2].id,
                                    travelWishId: wish.id
                                );

                                widget.next.call();
                              },),
                            )),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextButton(onPressed: (){
                    widget.next.call();
                    ref.read(asyncMatchRecommendedProvider.notifier).like(widget.info.id,
                        travelWishId: wish.id
                    );
                  }, child: Text('Just like ->'))

                ],
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }
}
