import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/core/match/providers/matched.dart';
import 'package:sona/core/match/screens/report.dart';
import 'package:sona/core/match/widgets/match_item.dart';
import 'package:sona/generated/assets.dart';
import 'package:sona/utils/global/global.dart';
import 'package:stacked_page_view/stacked_page_view.dart';

import '../../../utils/dialog/input.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/setting.dart';
import '../util/http_util.dart';
import '../widgets/filter_dialog.dart';
// import '../widgets/scroller.dart' as s;

class MatchScreen extends StatefulHookConsumerWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    _initData();
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
    return NotificationListener(child: Stack(
      children: [
        Positioned.fill(
          child: PageView.builder(
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
                        if(resp==null){
                          return;
                        }
                        if(resp.isSuccess){
                          if(resp.data['resultType']==2){

                            // if(users[value-1].arrowed||users[value-1].matched){
                            //   return;
                            // }else {
                            //   users[value-1].skipped=true;
                            //   ref.read(asyncMatchRecommendedProvider.notifier)
                            //       .skip(users[value-1].id);
                            // }

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
                          Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                            return const SubscribePage();
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
                child: Image.asset(Assets.iconsFliter,width: 24,height: 24,),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(offset: Offset(0, 4),color: Colors.black.withOpacity(0.75),blurRadius:40 )
                  ]
                ),
              ),onTap: (){
                showFilter(context,(){
                  _initData();
                });
              },),
              SizedBox(
                height: 20,
              ),
              GestureDetector(child: Container(
                  child: Image.asset(Assets.iconsMore,width: 24,height: 24,),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(offset: Offset(0, 4),color: Colors.black.withOpacity(0.75),blurRadius:40 )
                    ]
                ),
              ),onTap: () async {
                var result=await showRadioFieldDialog(context: context, options: {'Report': 'report', 'Block': 'block'});
                if(result!=null){
                  if(result=='report'){
                    Navigator.push(context, MaterialPageRoute(builder: (c){
                      return Report(ReportType.user,users[currentPage].id);
                    }));

                  }else if(result=='block'){
                    post('/user/update-relation',data:{
                      "userId":users[currentPage].id, // 对方用户ID
                      "relationType":5 // 匹配结果：1:忽略，2：喜欢，3：ARROW 5拉黑 6查看
                    });
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
    ),
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification &&
            scrollNotification.metrics.extentAfter == 0) {
          // 滚动到底部时加载下一页
          //ref.read(pagingProvider.notifier).refresh(ref);
          //current++;
          //_loadMore();
        }
        return true;
      },

    );
  }

  @override
  bool get wantKeepAlive => true;
  int current=1;
  void _initData() async{
    final position =ref.read(positionProvider);
   try{
     final resp=await post('/user/match-v2',data: {
       'gender': currentFilterGender,
       'minAge': currentFilterMinAge,
       'maxAge': currentFilterMaxAge,
       'longitude': position?.longitude,
       'latitude': position?.latitude,
       "page":current,    // 页码
       "pageSize":10 // 每页数量
     });
     if(resp.isSuccess){
       List list= resp.data;
       users=list.map((e) => UserInfo.fromJson(e)).toList();

       setState(() {

       });
     }
   }catch(e){
     print(e);
   }

  }
  void _loadMore() async{
    final position = ref.read(positionProvider);
    try{
      final resp=await post('/user/match-v2',data: {
        'gender': currentFilterGender,
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
        users=[...users,...users1];
        setState(() {

        });
      }

    }catch(e){
      print(e);
    }

  }
}


enum FilterGender{
  male,
  female,
  all
}