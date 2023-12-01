

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/permission/permission.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/match/screens/filter_page.dart';
import 'package:sona/core/match/widgets/bio_item.dart';
import 'package:sona/core/match/widgets/biz_action_item.dart';
import 'package:sona/core/match/widgets/dialogs.dart';
import 'package:sona/core/match/widgets/galley_item.dart';
import 'package:sona/core/match/widgets/interest_item.dart';
import 'package:sona/core/match/widgets/no_data.dart';
import 'package:sona/core/match/widgets/no_more.dart';
import 'package:sona/core/match/widgets/wishlist_item.dart';
import 'package:sona/generated/assets.dart';
import 'package:sona/utils/dialog/report.dart';
import 'package:sona/utils/global/global.dart';

import '../../../account/providers/profile.dart';
import '../../../utils/location/location.dart';
import '../../subscribe/subscribe_page.dart';
import '../services/match.dart';
import '../util/event.dart';
import '../util/http_util.dart';
import '../util/local_data.dart';
import '../widgets/heard_item.dart';
import '../widgets/match_init_animation.dart';
import '../widgets/wish_card.dart';


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
        longitude=value.longitude;
        latitude=value.latitude;
        ref.read(myProfileProvider.notifier).updateField(position: value);
        _initData();
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
    return Stack(
      children: [
        Positioned.fill(
          child: _buildMatch()
        ),
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
                        Navigator.push(context, MaterialPageRoute(builder: (c){
                          return FilterPage();
                        })).then((value){
                          _initData();
                        });
                        // showFilter(context,(){
                        //   //_initData();
                        //   _state=PageState.loading;
                        //   _initData();
                        // });
                      },
                    ),
                  ],
                )
              ],
            ),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
  int current=1;
  void _initData() async{
    current=1;
    try{
      final resp=await post('/user/match-v2',data: {
        'gender': currentFilterGender,
        'minAge': currentFilterMinAge,
        'maxAge': currentFilterMaxAge,
        'longitude': longitude,
        'latitude': latitude,
        "page":current,    // 页码
        "pageSize":5, // 每页数量
        "recommendMode":recommendMode

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
    try{
      final resp=await post('/user/match-v2',data: {
        'gender': currentFilterGender,
        'minAge': currentFilterMinAge,
        'maxAge': currentFilterMaxAge,
        'longitude': longitude,
        'latitude': latitude,
        "page":current,    // 页码
        "pageSize":5, // 每页数量,
        "recommendMode":recommendMode
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
     return  Container(color: Colors.black,child: Center(child: MatchInitAnimation()),);
    }else if(_state==PageState.fail){
      return NoDataWidget();

    }
    else if(_state==PageState.success){
      return PageView.builder(
        itemBuilder: (c,index) {
          UserInfo info=users[index];
          if(info.id==-1){
            return NoMoreWidget();
          }
          if(info.matched){
            return WishCardWidget(context: context,
                info: info,
                next: (){
                  pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
                },
            );
          }else {
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
                                      WishListItem(wishes: info.wishList,),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      BioItem(bio: info.bio??'',),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      GalleyItem(images: info.photos,),
                                      InterestItem(interest: info.interest,),
                                      BizActionItem(report: () async{
                                        SonaAnalytics.log(MatchEvent.match_report.name);
                                        final r =await showReport(context, users[currentPage].id);
                                        if (r == true) {
                                          users.removeAt(currentPage);
                                          if (mounted) setState(() {});
                                        }
                                      }, block: () async{
                                        final resp = await matchAction(userId: users[currentPage].id, action: MatchAction.block);
                                        if (resp.statusCode == 0) {
                                          users.removeAt(currentPage);
                                          if (mounted) setState(() {});
                                          Fluttertoast.showToast(msg: 'The user has been blocked');
                                          SonaAnalytics.log('post_block');
                                        }
                                      },),
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
                          pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
                          ref.read(asyncMatchRecommendedProvider.notifier).skip(info.id);
                        },
                      ),
                      GestureDetector(child: Image.asset(Assets.iconsLike,width: 64,height: 64,),
                        onTap: (){
                                // showMatched(context,target: info,next: (){
                                //   pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
                                // });
                         ///是否能like
                          if(canLike){
                            if(like>0){
                              like=like-1;
                            }
                            currentPage=index;
                            ///如果对方喜欢我。
                            if(info.likeMe==1){
                               ///显示匹配成功，匹配成功可以发送消息（自定义消息和sayhi）。点击发送以后，切换下一个人
                               showMatched(context,target: info,next: (){
                                 pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
                               });
                            }else{
                              ///
                              if(users[index].wishList.isEmpty){
                                pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
                              }else {
                                users[index].matched=true;
                              }
                            }

                            setState(() {

                            });
                            SonaAnalytics.log(MatchEvent.match_like.name);

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
                            showDm(context, info,(){
                              pageController.nextPage(duration: Duration(milliseconds: 1000), curve:  Curves.linearToEaseOut);
                            });
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
          }
        },
        itemCount: users.length,
        scrollDirection: Axis.horizontal,
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (value) async {
          //currentPage=value;
          if (value != 0 && value % 5 == 0 &&
              ScrollDirection.reverse == direction) {
            current++;
            _loadMore();
          }
        }
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
