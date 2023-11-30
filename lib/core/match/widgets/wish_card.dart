import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../common/models/user.dart';
import '../../../generated/assets.dart';
import 'choice_bytton.dart';
class WishCardWidget extends StatelessWidget {
  WishCardWidget({
    super.key,
    required this.context,
    required this.info,
    required this.next,
  });

  final BuildContext context;
  final UserInfo info;
  PageController pageController=PageController();
  final VoidCallback next;

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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text('Are you interested in her ideas',style: TextStyle(
              color: Colors.black,
              fontSize: 28
          ),),
        ),
        Expanded(
          child: PageView(
            controller: pageController,
            children: info.wishList.map((e) => Container(
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
                    height: 470,
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
                        Container(
                          width: 259,
                          height: 166,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2
                              ),
                              image: e.pic==null?null:DecorationImage(image: CachedNetworkImageProvider(e.pic!),fit: BoxFit.cover)
                          ),
                          child: Stack(
                            children: [
                              Positioned(top: 16,
                                left: 16,child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage(Assets.imagesTest),fit: BoxFit.cover),
                                      border: Border.all(
                                          color: Colors.black,
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  width: 48,height: 48,
                                ),
                              ),
                              Positioned(
                                width: 259,
                                bottom: 0,
                                child: Padding(
                                  padding: EdgeInsets.all(11.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${e.activityNames},${e.countryName}',style: TextStyle(color: Colors.white),),
                                      Text('${e.countryFlag}')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: List.generate(e.activities.length, (index2) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ChoiceButton(text: e.activities[index2].title??'', onTap: () {
                                ///点击切换，下一个用户.冰球调用like接口
                                next.call();
                              },),
                            )),
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }
}
