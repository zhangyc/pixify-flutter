import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/match/widgets/match_item.dart';
import 'package:sona/generated/assets.dart';
import 'package:sona/utils/dialog/report.dart';
import 'package:sona/utils/global/global.dart';
import 'package:stacked_page_view/stacked_page_view.dart';

import '../../../account/providers/profile.dart';
import '../../../utils/dialog/input.dart';
import '../../../utils/location/location.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/setting.dart';
import '../services/match.dart';
import '../util/event.dart';
import '../util/http_util.dart';
import '../widgets/filter_dialog.dart';
import '../widgets/match_init_animation.dart';
// import '../widgets/scroller.dart' as s;

class MatchScreen extends StatefulHookConsumerWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen>
    with AutomaticKeepAliveClientMixin {
  ScrollDirection? direction;
  void _determinePosition() async {
    final position = await determinePosition();
  }
  @override
  void initState() {
      determinePosition().then((value) async {
        if(value!=null){
          await ref.read(myProfileProvider.notifier).updateField(position: value);
          await _initData();
        }
      }).catchError((e){
        Fluttertoast.showToast(msg: 'Failed to obtain permission.');
      });

    // _determinePosition();
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
    });
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
          child: _state==PageState.loading?
          Container(child: Center(child: MatchInitAnimation()),color: Colors.black,):_state==PageState.noData?
          Center(child: Text('No data'),):
          PageView.builder(
            itemBuilder: (c,index) {
              return StackPageView(index: index,
                  controller: pageController,
                  child: MatchItem(index,
                    length: users.length,
                    userInfo: users[index],
                    controller: pageController,
                    onLike: (){
                      users[index].matched=true;
                      ref.read(asyncMatchRecommendedProvider.notifier).like(users[index].id).then((resp){
                        if(resp.isSuccess){
                          SonaAnalytics.log(MatchEvent.match_like.name);
                          if(resp.data['resultType']==2){

                            if (index < users.length - 1) {
                              pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 200),
                                  curve: Curves.linearToEaseOut);
                            }
                          }else if(resp.data['resultType']==1){
                            showMatched(context, () {
                              if (index < users.length - 1) {
                                pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 200),
                                    curve: Curves.linearToEaseOut);
                              }
                            },target: users[index]);
                          }
                        }else if(resp.statusCode==10150){
                          SonaAnalytics.log(MatchEvent.match_like_limit.name);
                          Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                            return const SubscribePage(fromTag: FromTag.pay_match_likelimit,);
                          }));
                        }
                      });

                    },

                  ));
            },
            itemCount: users.length,
            scrollDirection: Axis.vertical,
            controller: pageController,
            onPageChanged: (value){
              currentPage=value;
              if(value%5==0){
                current++;
                _loadMore();
              }
              if(direction!=null){
                if(ScrollDirection.forward==direction){
                  SonaAnalytics.log(MatchEvent.match_swipe_down.name);

                }else if(ScrollDirection.reverse==direction){
                  if(value==0){
                    return;
                  }
                  SonaAnalytics.log(MatchEvent.match_swipe_up.name);
                  if(users[value-1].arrowed||users[value-1].matched){
                    return;
                  }else {
                    users[value-1].skipped=true;
                    ref.read(asyncMatchRecommendedProvider.notifier)
                        .skip(users[value-1].id);
                  }
                }
              }
              // print('>>>>>>>>>>>>>>$value');
              ///滑动结束后调用这个回调，来表示当前是哪个index。此时需要处理上个page上的数据，来表示不喜欢的状态


            },
          ),
        ),
        Positioned(
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
                  _initData();
                });
              },),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(offset: Offset(0, 4),color: Colors.black.withOpacity(0.75),blurRadius:40 )
                    ]
                ),
                child: Image.asset(Assets.iconsMore,width: 24,height: 24,),
              ),onTap: () async {
                var result=await showRadioFieldDialog(context: context, options: {'Report': 'report', 'Block': 'block'});
                if(result!=null){
                  if (result == 'report' && mounted){
                    SonaAnalytics.log(MatchEvent.match_report.name);
                    showReport(context, users[currentPage].id);
                  }else if(result=='block'){
                    final resp = await matchAction(userId: users[currentPage].id, action: MatchAction.block);
                    if (resp.statusCode == 0) {
                      Fluttertoast.showToast(msg: 'The user has been blocked');
                      SonaAnalytics.log('post_block');
                    }
                  }
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
    );
  }

  @override
  bool get wantKeepAlive => true;
  int current=1;
  Future<void> _initData() async{
    int? gender;
    current=1;
    if(currentFilterGender==FilterGender.male.index){
      gender=1;
    }else if(currentFilterGender==FilterGender.female.index){
      gender=2;
    }else if(currentFilterGender==FilterGender.all.index){
      gender=null;
    }
    final position =ref.read(positionProvider);
   try{
     final resp=await post('/user/match-v2',data: {
       'gender': gender,
       'minAge': currentFilterMinAge,
       'maxAge': currentFilterMaxAge,
       'longitude': position?.longitude,
       'latitude': position?.latitude,
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
       users=list.map((e) => UserInfo.fromJson(e)).toList();
       for (var element in users) {
         if(element.avatar!=null){
           DefaultCacheManager().downloadFile(element.avatar!);
         }
       }
       setState(() {

       });
     }
   }catch(e){
     if (kDebugMode) print(e);
   }

  }
  void _loadMore() async{
    int? gender;
    if(currentFilterGender==FilterGender.male.index){
      gender=1;

    }else if(currentFilterGender==FilterGender.female.index){
      gender=2;

    }else if(currentFilterGender==FilterGender.all.index){
      gender=null;
    }
    final position = ref.read(positionProvider);
    try{
      final resp=await post('/user/match-v2',data: {
        'gender': gender,
        'minAge': currentFilterMinAge,
        'maxAge': currentFilterMaxAge,
        'longitude': position?.longitude,
        'latitude': position?.latitude,
        "page":current,    // 页码
        "pageSize":10 // 每页数量
      });
      if(resp.isSuccess){
        List list= resp.data;

        List users1=list.map((e) => UserInfo.fromJson(e)).toList();
        for (var element in users1) {
          if(element.avatar!=null){
            DefaultCacheManager().downloadFile(element.avatar!);
          }
        }
        users=[...users,...users1];
        setState(() {

        });
      }

    }catch(e){
      if (kDebugMode) print(e);
    }

  }
  late PageState _state= PageState.loading;
}
enum PageState{
  loading,
  noData,
  success
}

enum FilterGender{
  male,
  female,
  all
}