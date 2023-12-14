import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/widgets/image_scale_animation.dart';
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
  PageController pageController=PageController(viewportFraction: 0.8);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(backgroundImageProvider.notifier).updateBgImage(widget.info.wishList.first.pic!);
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
        // MyImageAnimation(url: widget.info.avatar!),
        Container(
          decoration: BoxDecoration(
              image: widget.info.avatar==null?null:DecorationImage(image: CachedNetworkImageProvider(widget.info.avatar!),fit: BoxFit.cover),
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
          child: Text('Are you interested in her ideas？',style: TextStyle(
              color: Colors.black,
              fontSize: 28
          ),),
        ),
        _buildPageIndicator(),
        Expanded(
          child: PageView(
            onPageChanged: (value){
              _currentPage = value;

              ref.read(backgroundImageProvider.notifier).updateBgImage(widget.info.wishList[value].pic!);
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
                              width: 16,
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
                                MatchApi.like(widget.info.id,
                                    activityId: wish.activities[index2].id,
                                    travelWishId: wish.id
                                );
                                ref.read(backgroundImageProvider.notifier).updateBgImage(null);

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
                    ref.read(backgroundImageProvider.notifier).updateBgImage(null);
                    MatchApi.like(widget.info.id,
                        travelWishId: wish.id
                    );
                  }, child: Text('Just like ->'))

                ],
              ),
            )).toList(),
          ),
        )
      ],
    );
  }
  int _currentPage = 0;

  Widget _buildPageIndicator() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          widget.info.wishList.length, // Replace with the total number of pages
              (index) => _buildIndicator(index),
        ),
      ),
    );
  }
  Widget _buildIndicator(int index) {
    return Container(

      width: _currentPage == index ?16:8,
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Color(0xff2C2C2C) : Color(0xffE8E6E6),
      ),
    );
  }
}
