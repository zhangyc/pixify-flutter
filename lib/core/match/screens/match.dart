import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/match/widgets/custom_scrollphysics.dart';
import 'package:sona/core/match/widgets/user_card.dart';
import 'package:sona/generated/assets.dart';
import 'package:sona/utils/providers/dio.dart';
import 'package:stacked_page_view/stacked_page_view.dart';

import '../../../account/models/gender.dart';
import '../../../common/widgets/button/colored.dart';
import '../../../common/widgets/button/forward.dart';
import '../../../utils/dialog/input.dart';
import '../../providers/navigator_key.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/pageing_match.dart';
import '../providers/setting.dart';
import '../widgets/like_animation.dart';
import '../widgets/match_init_animation.dart';
// import '../widgets/scroller.dart' as s;

class MatchScreen extends StatefulHookConsumerWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen>
    with AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin {
  late AnimationController _animationController2;

  @override
  void initState() {
    _animationController2=AnimationController(vsync: this,duration: Duration(milliseconds: 1500));
    _animationController2.addStatusListener((s) {

           if(s==AnimationStatus.completed){
             tapArrow=false;
           }
    });
    _animationController2.addListener(() {
      setState(() {

      });
    });
    //ref.read(pagingProvider.notifier).refresh(ref);

    _initData();
    super.initState();
  }
  List<UserInfo> users =[];

  @override
  void dispose() {
    _animationController2.dispose();
    super.dispose();
  }
  String imageUrl='';
  Gender? _gender=Gender.nonBinary;
  int currentPage=0;
  PageController pageController=PageController();
  bool scrolling=true;
  ScrollPhysics scrollPhysics=AlwaysScrollableScrollPhysics();
  bool tapArrow=false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(child: Container(
      color: Colors.black.withOpacity(0.5),
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              itemBuilder: (c,index) {
                return StackPageView(
                    index: index,
                    controller: pageController,
                    child: UserCard(
                      key: ValueKey(users[index].id),
                      user: users[index],
                      actions: [
                        Positioned(
                          right: 0,
                          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
                          child: ActionAnimation(
                            userInfo: users[index],
                            onLike: () {
                              users[index].matched=true;
                              ref.read(asyncMatchRecommendedProvider.notifier).like(users[index].id).then((resp){
                                if(resp==null){
                                  return;
                                }
                                if(resp.statusCode==10150){
                                  Navigator.push(ref.read(navigatorKeyProvider).currentContext!, MaterialPageRoute(builder:(c){
                                    return SubscribePage();
                                  }));
                                }
                              });
                              if (index < users.length - 1) {
                                pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 200),
                                    curve: Curves.linearToEaseOut);
                              }
                            },
                            onArrow: () {
                              tapArrow=true;
                              setState(() {

                              });
                              ref.read(asyncMatchRecommendedProvider.notifier)
                                  .arrow(users[index].id).then((resp){
                                if(resp==null){
                                  return;
                                }
                                if(resp.statusCode==10150){
                                  /// 判断如果不是会员，跳转道会员页面
                                  if(ref.read(asyncMyProfileProvider).value?.isMember??false){
                                    Navigator.push(ref.read(navigatorKeyProvider).currentContext!, MaterialPageRoute(builder:(c){
                                      return SubscribePage();
                                    }));
                                  }else {
                                    Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                                  }
                                  ///如果是会员，提示超过限制
                                }else if(resp.statusCode==200){
                                  users[index].arrowed=true;
                                  if (index < users.length - 1) {
                                    pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 200),
                                        curve: Curves.linearToEaseOut);
                                  }
                                }
                              });

                            }, arrowController: _animationController2,
                          ),
                        ),
                        // 加action组件
                      ],
                    )
                );
              },
              itemCount: users.length,
              scrollDirection: Axis.vertical,
              controller: pageController,
              onPageChanged: (value){
                if(value%5==0){
                  current++;
                  _loadMore();
                }
                print('>>>>>>>>>>>>>>$value');
                ///滑动结束后调用这个回调，来表示当前是哪个index。此时需要处理上个page上的数据，来表示不喜欢的状态

                // if(users[value-1].arrowed||users[value-1].matched){
                //   return;
                // }else {
                //   users[value-1].skipped=true;
                //   ref.read(asyncMatchRecommendedProvider.notifier)
                //       .skip(users[value-1].id);
                // }
              },
            ),
          ),
          Arrow(animationController2: _animationController2),
          Positioned(
            right: 20,
            top: 73,
            child: Column(
              children: [
                GestureDetector(child: Image.asset(Assets.iconsFliter,width: 24,height: 24,),onTap: (){
                  showDialog(context: context, builder: (c){
                    return Consumer(builder: (_,ref,__){
                      return Column(
                        children: [
                          Container(
                            width:335,
                            height: 230,
                            decoration: BoxDecoration(
                                color: Color(0xff2969E9),
                                borderRadius: BorderRadius.circular(40)
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 90
                            ),
                            child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text('Gender',style: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xfff9f9f9)
                                  ),),
                                  // SizedBox(
                                  //   height: 24,
                                  // ),
                                  ...Gender.allTypes.map((e) => GestureDetector(
                                    onTap: (){
                                      _gender=e;
                                      ref.read(matchSettingProvider.notifier).setGender(e);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 10
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          e==_gender?Image.asset(Assets.iconsSelected,width: 28,height: 28,):Container(),
                                          Text(e.name,style: TextStyle(
                                              fontSize: 36,
                                              color:e==_gender?Color(0xfff9f9f9):Colors.white.withOpacity(0.2)
                                          ),)
                                        ],
                                      ),
                                    ),
                                  )).toList(),
                                ]
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width:335,
                            height: 158,
                            decoration: BoxDecoration(
                                color: Color(0xff2969E9),
                                borderRadius: BorderRadius.circular(40)
                            ),
                            child: Column(
                              children: [
                                Text('Age',style: TextStyle(
                                    fontSize: 29,
                                    color: Color(0xfff9f9f9)
                                ),),
                                // ForwardButton(
                                //     onTap: () {},
                                //     text: '年龄  ${ref.watch(matchSettingProvider).ageRange.start.toInt()} - ${ref.watch(matchSettingProvider).ageRange.end.toInt()}'
                                // ),
                                SizedBox(height: 8),
                                SizedBox(child: RangeSlider(
                                    activeColor: Colors.white,
                                    inactiveColor:Color(0xff54b7ed) ,
                                    min: 18,
                                    max: 80,
                                    divisions: 10,
                                    labels: RangeLabels(ref.watch(matchSettingProvider).ageRange.start.toString(),
                                        ref.watch(matchSettingProvider).ageRange.end.toString()),
                                    values: ref.watch(matchSettingProvider).ageRange,
                                    onChanged: (rv) {
                                      ref.read(matchSettingProvider.notifier).setAgeRange(rv);
                                    }
                                ),width: 277,),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            child: Container(
                              width:335,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Color(0xff2969E9),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              child: Text('Save',style: TextStyle(
                                  fontSize: 36,
                                  color: Color(0xfff9f9f9)
                              ),),
                              alignment: Alignment.center,
                            ),
                            onTap: (){
                              Navigator.pop(context);
                            },
                          )

                        ],
                      );
                    });
                  });
                },),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(child: Image.asset(Assets.iconsMore,width: 24,height: 24,),onTap: () async {
                  var result=await showRadioFieldDialog(context: context, options: {'Report': 'report', 'Block': 'block'});
                  if(result!=null){
                    Fluttertoast.showToast(msg: result);
                  }
                },)
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).padding.top,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.0),
                    ]
                ),
              ),
            ),
          )
        ],
      ),
    ),
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification &&
            scrollNotification.metrics.extentAfter == 0) {
          // 滚动到底部时加载下一页
          //ref.read(pagingProvider.notifier).refresh(ref);
          current++;
          //_loadMore();
        }
        return true;
      },

    );
    return ref.watch(asyncMatchRecommendedProvider).when<Widget>(
      data: (List<UserInfo> users) {
        // if (users.isEmpty) {
        //   return Container(
        //     alignment: Alignment.center,
        //     child: const Text('No more.'),
        //   );
        // }
        return Container(
          color: Colors.black.withOpacity(0.5),
          child: Stack(
            children: [
              Positioned.fill(
                child: PageView.builder(
                  itemBuilder: (c,index) {
                    return StackPageView(
                      index: index,
                      controller: pageController,
                      child: UserCard(
                        key: ValueKey(users[index].id),
                        user: users[index],
                        actions: [
                          Positioned(
                            right: 0,
                            bottom: MediaQuery.of(context).viewInsets.bottom + 120,
                            child: ActionAnimation(
                                userInfo: users[index],
                                onLike: () {
                                users[index].matched=true;
                                ref.read(asyncMatchRecommendedProvider.notifier).like(users[index].id).then((resp){
                                  if(resp==null){
                                    return;
                                  }
                                  if(resp.statusCode==10150){
                                    Navigator.push(ref.read(navigatorKeyProvider).currentContext!, MaterialPageRoute(builder:(c){
                                      return SubscribePage();
                                    }));
                                  }
                                });
                                if (index < users.length - 1) {
                                  pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 200),
                                      curve: Curves.linearToEaseOut);
                                  }
                                },
                                onArrow: () {
                                  tapArrow=true;
                                  setState(() {

                                  });
                                  ref.read(asyncMatchRecommendedProvider.notifier)
                                    .arrow(users[index].id).then((resp){
                                    if(resp==null){
                                      return;
                                    }
                                    if(resp.statusCode==10150){
                                      /// 判断如果不是会员，跳转道会员页面
                                      if(ref.read(asyncMyProfileProvider).value?.isMember??false){
                                        Navigator.push(ref.read(navigatorKeyProvider).currentContext!, MaterialPageRoute(builder:(c){
                                          return SubscribePage();
                                        }));
                                      }else {
                                        Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                                      }
                                      ///如果是会员，提示超过限制
                                    }else if(resp.statusCode==200){
                                      users[index].arrowed=true;
                                      if (index < users.length - 1) {
                                        pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 200),
                                            curve: Curves.linearToEaseOut);
                                      }
                                    }
                                  });

                              }, arrowController: _animationController2,
                            ),
                          ),
                          // 加action组件
                        ],
                      )
                    );
                  },
                  itemCount: users.length,
                  scrollDirection: Axis.vertical,
                  controller: pageController,
                  onPageChanged: (value){
                    ///滑动结束后调用这个回调，来表示当前是哪个index。此时需要处理上个page上的数据，来表示不喜欢的状态

                    // if(users[value-1].arrowed||users[value-1].matched){
                    //   return;
                    // }else {
                    //   users[value-1].skipped=true;
                    //   ref.read(asyncMatchRecommendedProvider.notifier)
                    //       .skip(users[value-1].id);
                    // }
                  },
                ),
              ),
              Arrow(animationController2: _animationController2),
              Positioned(
                right: 20,
                top: 73,
                child: Column(
                  children: [
                    GestureDetector(child: Image.asset(Assets.iconsFliter,width: 24,height: 24,),onTap: (){
                      showDialog(context: context, builder: (c){
                        return Consumer(builder: (_,ref,__){
                          return Column(
                            children: [
                              Container(
                                width:335,
                                height: 230,
                                decoration: BoxDecoration(
                                    color: Color(0xff2969E9),
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 90
                                ),
                                child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text('Gender',style: TextStyle(
                                        fontSize: 24,
                                        color: Color(0xfff9f9f9)
                                      ),),
                                      // SizedBox(
                                      //   height: 24,
                                      // ),
                                      ...Gender.allTypes.map((e) => GestureDetector(
                                        onTap: (){
                                          _gender=e;
                                          ref.read(matchSettingProvider.notifier).setGender(e);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            top: 10
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              e==_gender?Image.asset(Assets.iconsSelected,width: 28,height: 28,):Container(),
                                              Text(e.name,style: TextStyle(
                                                  fontSize: 36,
                                                  color:e==_gender?Color(0xfff9f9f9):Colors.white.withOpacity(0.2)
                                              ),)
                                            ],
                                          ),
                                        ),
                                      )).toList(),
                                    ]
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width:335,
                                height: 158,
                                decoration: BoxDecoration(
                                    color: Color(0xff2969E9),
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Column(
                                  children: [
                                    Text('Age',style: TextStyle(
                                        fontSize: 29,
                                        color: Color(0xfff9f9f9)
                                    ),),
                                    // ForwardButton(
                                    //     onTap: () {},
                                    //     text: '年龄  ${ref.watch(matchSettingProvider).ageRange.start.toInt()} - ${ref.watch(matchSettingProvider).ageRange.end.toInt()}'
                                    // ),
                                    SizedBox(height: 8),
                                    SizedBox(child: RangeSlider(
                                      activeColor: Colors.white,
                                        inactiveColor:Color(0xff54b7ed) ,
                                        min: 18,
                                        max: 80,
                                        divisions: 10,
                                        labels: RangeLabels(ref.watch(matchSettingProvider).ageRange.start.toString(),
                                            ref.watch(matchSettingProvider).ageRange.end.toString()),
                                        values: ref.watch(matchSettingProvider).ageRange,
                                        onChanged: (rv) {
                                          ref.read(matchSettingProvider.notifier).setAgeRange(rv);
                                        }
                                    ),width: 277,),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                child: Container(
                                  width:335,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Color(0xff2969E9),
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  child: Text('Save',style: TextStyle(
                                      fontSize: 36,
                                      color: Color(0xfff9f9f9)
                                  ),),
                                  alignment: Alignment.center,
                                ),
                                onTap: (){
                                  Navigator.pop(context);
                                },
                              )

                            ],
                          );
                        });
                      });
                    },),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(child: Image.asset(Assets.iconsMore,width: 24,height: 24,),onTap: () async {
                      var result=await showRadioFieldDialog(context: context, options: {'Report': 'report', 'Block': 'block'});
                      if(result!=null){
                        Fluttertoast.showToast(msg: result);
                      }
                    },)
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).padding.top,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.0),
                      ]
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
      error: (err, stack) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => ref.refresh(asyncMatchRecommendedProvider),
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text(
            'Load match data error\nclick the screen to try again.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, decoration: TextDecoration.none)
          ),
        ),
      ),
      loading: () => MatchInitAnimation(),
    );
  }

  void _showActions(UserInfo user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Container(
                width: 30,
                height: 3,
                color: Colors.black12,
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...['分享名片', '取消匹配', '屏蔽', '举报'].map((t) => Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: ColoredButton(
                                    onTap: () {
                                      Navigator.pop(context, t);
                                    },
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    text: t),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40)
            ],
          ),
        );
      },
    );
  }
  Widget _buildWidget(int position, Color color) {
    return Container(
      color: color,
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "0x${position.toRadixString(16).toUpperCase()}",
              style: TextStyle(
                color: Color(0xFF2e282a),
                fontSize: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
  int current=1;
  void _initData() async{
    final position = ref.read(positionProvider);
    final setting = ref.read(matchSettingProvider);
   try{
     final resp=await ref.read(dioProvider).post('/user/match-v2',data: {
       'gender': setting.gender?.index,
       'minAge': setting.ageRange.start.toInt(),
       'maxAge': setting.ageRange.end.toInt(),
       'longitude': position?.longitude,
       'latitude': position?.latitude,
       "page":current,    // 页码
       "pageSize":10 // 每页数量
     });
     List list= resp.data;
     users=list.map((e) => UserInfo.fromJson(e)).toList();

     setState(() {

     });
   }catch(e){
     print(e);
   }

  }
  void _loadMore() async{
    final position = ref.read(positionProvider);
    final setting = ref.read(matchSettingProvider);
    try{
      final resp=await ref.read(dioProvider).post('/user/match-v2',data: {
        'gender': setting.gender?.index,
        'minAge': setting.ageRange.start.toInt(),
        'maxAge': setting.ageRange.end.toInt(),
        'longitude': position?.longitude,
        'latitude': position?.latitude,
        "page":current,    // 页码
        "pageSize":10 // 每页数量
      });
      List list= resp.data;
      List users1=list.map((e) => UserInfo.fromJson(e)).toList();
      users=[...users,...users1];
      setState(() {

      });
    }catch(e){
      print(e);
    }

  }
}

class Arrow extends StatelessWidget {
  const Arrow({
    super.key,
    required AnimationController animationController2,
  }) : _animationController2 = animationController2;

  final AnimationController _animationController2;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: ColoredBox(
          color: _animationController2.isAnimating?Colors.black.withOpacity(0.5):Colors.transparent,
          child: Center(child: _animationController2.isAnimating?Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(duration: Duration(milliseconds: 1500),
                child: Image.asset(Assets.imagesArrow,),
                curve: Curves.fastOutSlowIn,
                width: 300,
                height:300,
              ),
              Lottie.asset(Assets.lottieArrowAnimation,
                  controller: _animationController2,repeat: true),

            ],
           ):Container()),
        ),
      ),
    );
  }
}
