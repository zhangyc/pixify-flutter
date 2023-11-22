import 'dart:ui';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/permission/permission.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/match/widgets/bio_item.dart';
import 'package:sona/core/match/widgets/blz_action_item.dart';
import 'package:sona/core/match/widgets/galley_item.dart';
import 'package:sona/core/match/widgets/interest_item.dart';
import 'package:sona/core/match/widgets/match_item.dart';
import 'package:sona/core/match/widgets/no_data.dart';
import 'package:sona/core/match/widgets/no_more.dart';
import 'package:sona/core/match/widgets/wishlist_item.dart';
import 'package:sona/generated/assets.dart';
import 'package:sona/utils/dialog/report.dart';
import 'package:sona/utils/global/global.dart';
import 'package:stacked_page_view/stacked_page_view.dart';

import '../../../account/providers/profile.dart';
import '../../../generated/l10n.dart';
import '../../../utils/dialog/input.dart';
import '../../../utils/location/location.dart';
import '../../../utils/picker/interest.dart';
import '../../providers/home_provider.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/setting.dart';
import '../services/match.dart';
import '../util/event.dart';
import '../util/http_util.dart';
import '../widgets/filter_dialog.dart';
import '../widgets/heard_item.dart';
import '../widgets/match_init_animation.dart';
// import '../widgets/scroller.dart' as s;
// final clickSubject = BehaviorSubject <void>();

class MatchScreen extends StatefulHookConsumerWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen>
    with AutomaticKeepAliveClientMixin {
  ScrollDirection? direction;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      determinePosition().then((value){
        if(value!=null){
          longitude=value.longitude;
          latitude=value.latitude;
          ref.read(myProfileProvider.notifier).updateField(position: value);
          _initData();
        }
      }).catchError((e){
        Fluttertoast.showToast(msg: 'Failed to obtain permission.');
      });
    });
    // clickSubject
    //     .debounceTime(Duration(seconds: 1))
    //     .listen((_) {
    //
    //   // 处理点击逻辑
    // });
    super.initState();
    pageController.addListener(() {
      //页面正在向上滑动
      if (pageController.position.userScrollDirection == ScrollDirection.reverse) {
          direction=ScrollDirection.reverse;
      }
      //页面正在向下滑动
      else if(pageController.position.userScrollDirection == ScrollDirection.forward){
        direction=ScrollDirection.forward;
      }
    }
    );
    if(showGuideAnimation){
      Future.delayed(Duration(seconds: 4),(){
        showGuideAnimation=false;
        pageController.animateTo(200, duration: Duration(seconds: 1), curve: Curves.linear,);
      });
    }

  }
  List<UserInfo> users =[];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  int currentPage=0;
  PageController pageController=PageController();
  @override
  Widget build(BuildContext context) {

    super.build(context);
    int iconIndex= ref.watch(matchIconProvider);

    return Stack(
      children: [

        Positioned(
          width: MediaQuery.of(context).size.width,
          top: MediaQuery.of(context).padding.top+MediaQuery.of(context).viewPadding.top,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sona"),
                Row(
                  children: [
                    Image.asset(Assets.iconsNotice,width: 48,height: 48,),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(child: Image.asset(Assets.iconsFliter,width: 48,height: 48,),
                      onTap: (){
                        showFilter(context,(){
                          //_initData();
                          _state=PageState.loading;
                          _initData();
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: _buildMatch()
        ),
        /**
        iconIndex==1?Container():Positioned(
          right: 20,
          top: 73,
          child: Column(
            children: [

              GestureDetector(child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(offset: Offset(0, 4),color: Colors.black.withOpacity(0.75),blurRadius:40 )
                    ]
                ),
                child: Image.asset(Assets.iconsFliter,width: 24,height: 24,),
              ),onTap: (){
                showFilter(context,(){
                  //_initData();
                  _state=PageState.loading;
                  _initData();
                });
                // clickSubject.add(null);
              },),
              const SizedBox(
                height: 20,
              ),

              GestureDetector(child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(offset: Offset(0, 4),color: Colors.black.withOpacity(0.75),blurRadius:40 )
                    ]
                ),
                child: Image.asset(Assets.iconsMore,width: 24,height: 24,),
              ),onTap: () async {
                var result=await showRadioFieldDialog(context: context, options: {S.current.report: 'report', S.current.block: 'block'});
                if(result!=null){
                  if (result == 'report' && mounted){
                    SonaAnalytics.log(MatchEvent.match_report.name);
                    final r = await showReport(context, users[currentPage].id);
                    if (r == true) {
                      users.removeAt(currentPage);
                      if (mounted) setState(() {});
                    }
                  }else if(result=='block'&& mounted){
                    final resp = await matchAction(userId: users[currentPage].id, action: MatchAction.block);
                    if (resp.statusCode == 0) {
                      users.removeAt(currentPage);
                      if (mounted) setState(() {});
                      Fluttertoast.showToast(msg: 'The user has been blocked');
                      SonaAnalytics.log('post_block');
                    }
                  }
                }
               },
              )

            ],
          ),
        ),
         */
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
    );
  }

  @override
  bool get wantKeepAlive => true;
  int current=1;
  void _initData() async{
    current=1;
    int? gender;
    if(currentFilterGender==FilterGender.Male.index){
      gender=1;

    }else if(currentFilterGender==FilterGender.Female.index){
      gender=2;

    }else if(currentFilterGender==FilterGender.All.index){
      gender=null;
    }
    try{
      final resp=await post('/user/match-v2',data: {
        'gender': gender,
        'minAge': currentFilterMinAge,
        'maxAge': currentFilterMaxAge,
        'longitude': longitude,
        'latitude': latitude,
        "page":current,    // 页码
        "pageSize":10 // 每页数量
      });
      if(resp.isSuccess){
        List list= resp.data;
        if(list.isEmpty){
          _state=PageState.noData;
        }else {
          _state=PageState.success;
        }

        List<UserInfo> users1=list.map((e) => UserInfo.fromJson(e)).toList();
        users=users1;
        if(users.every((element) => element.id!=-1)&&users.length<10){
          users.add(UserInfo(id: -1, name: '', gender: null, birthday: null, avatar: null));
        }
        for (var element in users1) {
          if(element.avatar!=null){
            DefaultCacheManager().downloadFile(element.avatar!);
          }
        }
        setState(() {

        });
      }else {
        _state=PageState.fail;
        setState(() {

        });
      }

    }catch(e){
      if (kDebugMode) print(e);
      if(mounted){
        _state=PageState.fail;
        setState(() {

        });
      }
    }
  }
  void _loadMore() async{
    int? gender;
    if(currentFilterGender==FilterGender.Male.index){
      gender=1;

    }else if(currentFilterGender==FilterGender.Female.index){
      gender=2;

    }else if(currentFilterGender==FilterGender.All.index){
      gender=null;
    }
    try{
      final resp=await post('/user/match-v2',data: {
        'gender': gender,
        'minAge': currentFilterMinAge,
        'maxAge': currentFilterMaxAge,
        'longitude': longitude,
        'latitude': latitude,
        "page":current,    // 页码
        "pageSize":10 // 每页数量
      });
      if(resp.isSuccess){
        List list= resp.data;

        // if(list.isEmpty){
        //   _state=PageState.noData;
        // }else {
        //   _state=PageState.success;
        // }
        List<UserInfo> users1=list.map((e) => UserInfo.fromJson(e)).toList();
        // users=[...users,...users1,...[UserInfo(id: -1, name: '', gender: null, birthday: null, avatar: null)]];


        users.addAll(users1);
        if(users.every((element) => element.id!=-1)){
          users.add(UserInfo(id: -1, name: '', gender: null, birthday: null, avatar: null));
        }else {
          users.removeWhere((element) => element.id==-1);
          users.add(UserInfo(id: -1, name: '', gender: null, birthday: null, avatar: null));
        }
        for (var element in users1) {
          if(element.avatar!=null){
            DefaultCacheManager().downloadFile(element.avatar!);
          }
        }
        setState(() {

        });
      }else {
        _state=PageState.fail;
        setState(() {

        });
      }

    }catch(e){
      if (kDebugMode) print(e);
      if(mounted){
        _state=PageState.fail;
        setState(() {

        });
      }
    }
  }
  late PageState _state= PageState.loading;

  _buildMatch() {
    if(_state==PageState.loading){
     return  Container(child: Center(child: MatchInitAnimation()),color: Colors.black,);
    }else if(_state==PageState.fail){
      return NoDataWidget();

    }
    else if(_state==PageState.success){
      return PageView.builder(
        itemBuilder: (c,index) {
          UserInfo info=users[index];
          return PageView(
            children: ['A','B','C'].map((e) => Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top+MediaQuery.of(context).viewPadding.top+58,
                ),
                SizedBox(
                  height: 8,
                ),
                Text('Are you interested in her ideas',style: TextStyle(
                  color: Colors.black,
                  fontSize: 28
                ),),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: 327,
                  height: 470,
                  decoration: BoxDecoration(
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
                          border: Border.all(
                              color: Colors.black,
                              width: 2
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(child: Image.asset(Assets.imagesTest,width: 48,height: 48,)),
                            Positioned(child: Row(
                              children: [
                                Text('data,china'),
                                Text('flag')
                              ],
                            )),
                          ],
                        ),
                      ),
                      Column(
                        children: [''],
                      )

                    ],
                  ),
                ),
              ],
            )).toList(),
          );
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top+MediaQuery.of(context).viewPadding.top+58,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [

                        SliverToBoxAdapter(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16
                                ),
                                child: Column(
                                  children: [
                                    HeardItem(userInfo: info,),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    WishListItem(),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    BioItem(),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    GalleyItem(),
                                    InterestItem(),
                                    BlzActionItem(),
                                    SizedBox(
                                      height: MediaQuery.of(context).padding.bottom+64,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              Positioned(bottom: 8+MediaQuery.of(context).padding.bottom,
                width: MediaQuery.of(context).size.width,child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(child: Image.asset(Assets.iconsSkip,width: 56,height: 56,),
                     onTap: (){
                       ref.read(asyncMatchRecommendedProvider.notifier)
                           .skip(info.id);
                     },
                  ),
                  GestureDetector(child: Image.asset(Assets.iconsLike,width: 64,height: 64,),
                     onTap: (){
                       if(canLike){
                         if(like>0){
                           like=like-1;
                         }
                         users[index].matched=true;
                         SonaAnalytics.log(MatchEvent.match_like.name);
                         if(users[index].likeMe==1){
                           showMatched(context, () {
                             if (index < users.length - 1) {
                               pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 1000),
                                   curve: Curves.linearToEaseOut);
                             }
                           },target: users[index],);
                         }else if(users[index].likeMe==0){
                           if (index < users.length - 1) {
                             pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 1000),
                                 curve: Curves.linearToEaseOut);
                           }
                         }
                       }else {
                         SonaAnalytics.log(MatchEvent.match_like_limit.name);
                         Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                           return const SubscribePage(fromTag: FromTag.pay_match_likelimit,);
                         }));
                       }
                       ref.read(asyncMatchRecommendedProvider.notifier).like(users[index].id);
                     },
                  ),
                  GestureDetector(child: Image.asset(Assets.iconsArrow,width: 56,height: 56,),
                    onTap: (){
                      if(canArrow){
                        arrow=arrow-1;
                        ref.read(asyncMatchRecommendedProvider.notifier).arrow(info.id);
                        SonaAnalytics.log(MatchEvent.match_arrow_send.name);
                        //arrowController.reset();
                        //arrowController.forward() ;
                        //widget.userInfo.arrowed=true;
                      }else {
                        bool isMember=ref.read(myProfileProvider)?.isMember??false;
                        if(isMember){
                          Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                        }else{
                          Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                            return SubscribePage(fromTag: FromTag.pay_match_arrow,);
                          }));
                        }
                      }
                    },
                  ),
                ],
              ),
              )
            ],
          );
          return StackPageView(index: index,
              controller: pageController,
              child: (info.id==-1)?NoMoreWidget(): MatchItem(index,
                length: users.length,
                userInfo: users[index],
                controller: pageController,
                onLike: (){
                  if(canLike){
                    if(like>0){
                      like=like-1;
                    }
                    users[index].matched=true;
                    SonaAnalytics.log(MatchEvent.match_like.name);
                    if(users[index].likeMe==1){
                      showMatched(context, () {
                        if (index < users.length - 1) {
                          pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 1000),
                              curve: Curves.linearToEaseOut);
                        }
                      },target: users[index],);
                    }else if(users[index].likeMe==0){
                      if (index < users.length - 1) {
                        pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 1000),
                            curve: Curves.linearToEaseOut);
                      }
                    }
                  }else {
                    SonaAnalytics.log(MatchEvent.match_like_limit.name);
                    Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                      return const SubscribePage(fromTag: FromTag.pay_match_likelimit,);
                    }));
                  }
                  ref.read(asyncMatchRecommendedProvider.notifier).like(users[index].id);
                },

              ));
        },
        itemCount: users.length,
        scrollDirection: Axis.horizontal,
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        //onPageChanged: (value) async {

          //currentPage=value;
          // if(value!=0&&value%5==0&&ScrollDirection.reverse==direction){
          //   current++;
          //   _loadMore();
          // }
          // if(direction!=null){
          //   if(ScrollDirection.forward==direction){
          //     /// down
          //     SonaAnalytics.log(MatchEvent.match_swipe_down.name);
          //
          //   }else if(ScrollDirection.reverse==direction){
          //     if(value==0){
          //       return;
          //     }
          //     if(value==1&&isShowArrowReward){
          //       final values=ref.read(myProfileProvider)?.interests;
          //       final result = await showInterestPicker(context: context,initialValue: values?.toSet());
          //       if (result != null) {
          //         isShowArrowReward=false;
          //         ref.read(myProfileProvider.notifier).updateField(interests: result);
          //         Future.delayed(const Duration(milliseconds: 200),(){
          //           showArrowReward(context);
          //         });
          //       }
          //
          //     }
          //     ///up
          //     SonaAnalytics.log(MatchEvent.match_swipe_up.name);
          //     if(users[value-1].arrowed||users[value-1].matched){
          //       return;
          //     }else {
          //       users[value-1].skipped=true;
          //       ref.read(asyncMatchRecommendedProvider.notifier)
          //           .skip(users[value-1].id);
          //     }
          //   }
          //  }
          //},
      );
    }else if(_state==PageState.noData){
      return const NoMoreWidget();
    }
  }
}
enum PageState{
  loading,
  noData,
  success,
  fail
}

enum FilterGender{
  Male,
  Female,
  All
}