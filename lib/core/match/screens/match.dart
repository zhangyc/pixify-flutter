import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/providers/match_provider.dart';
import 'package:sona/core/match/screens/filter_page.dart';
import 'package:sona/core/match/widgets/button_animations.dart';
import 'package:sona/core/match/widgets/custom_pageview/src/index_controller.dart';
import 'package:sona/core/match/widgets/custom_pageview/src/skip_transformer.dart';
import 'package:sona/core/match/widgets/no_data.dart';
import 'package:sona/core/match/widgets/no_more.dart';
import 'package:sona/core/match/widgets/profile_widget.dart';
import 'package:sona/generated/assets.dart';

import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../common/screens/profile.dart';
import '../../../utils/global/global.dart';
import '../../../utils/location/location.dart';
import '../../subscribe/subscribe_page.dart';
import '../bean/match_user.dart';
import '../providers/matched.dart';
import '../util/event.dart';
import '../util/http_util.dart';
import '../util/local_data.dart';
import '../widgets/custom_pageview/src/transformer_page_view.dart';
import '../widgets/dialogs.dart';
import '../widgets/match_init_animation.dart';
import '../widgets/wish_card.dart';


class MatchScreen extends StatefulHookConsumerWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   determinePosition().then((value){
    //     longitude=value.longitude;
    //     latitude=value.latitude;
    //     ref.read(myProfileProvider.notifier).updateField(position: value);
    //     _initData();
    //   }).catchError((e){
    //     Fluttertoast.showToast(msg: 'Failed to obtain permission.');
    //   });
    // });
    _initData();

    // clickSubject
    //     .debounceTime(Duration(seconds: 1))
    //     .listen((_) {
    //
    //   // 处理点击逻辑
    // });
    super.initState();
  }
  List<MatchUserInfo> users =[];

  @override
  void dispose() {
    pageController.dispose();
    // indexController.dispose();
    super.dispose();
  }
  int currentPage=0;
  TransformerPageController pageController=TransformerPageController();
  // IndexController indexController=IndexController();

  @override
  Widget build(BuildContext context) {
    String? bgImage=ref.watch(backgroundImageProvider);
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          bgImage==null?Container():Positioned(child: Container(
            foregroundDecoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.transparent,
                Colors.white
              ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )
            ),
            child: CachedNetworkImage(imageUrl: bgImage,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,

            ),
          )),
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
                  Image.asset(Assets.iconsSona,width: 96,height: 24 ,),
                  //Text("Sona"),
                  Row(
                    children: [
                      // Image.asset(Assets.iconsNotice,width: 48,height: 48,),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      GestureDetector(child: Image.asset(Assets.iconsFliter,width: 48,height: 48,),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (c){
                            return FilterPage();
                          })).then((value){
                            _initData();
                            if(mounted){
                              _state=PageState.loading;
                              setState(() {

                              });
                            }

                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          (users.isNotEmpty&&users[currentPage].matched)?Container():Positioned(bottom: 8+MediaQuery.of(context).padding.bottom,
            width: MediaQuery.of(context).size.width,child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ScaleAnimation(onTap: (){

                  pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
                  ref.read(asyncMatchRecommendedProvider.notifier).skip(users[currentPage].id);
                },
                    child: Image.asset(Assets.iconsSkip,width: 56,height: 56,)
                ),
                ScaleAnimation(child: Image.asset(Assets.iconsLike,width: 64,height: 64,), onTap: (){
                    if(canLike){

                      if(like>0){
                        like=like-1;
                      }
                      //currentPage=index;
                      ///如果对方喜欢我。
                      if(users[currentPage].likeMe==1){
                        ref.read(asyncMatchRecommendedProvider.notifier).like(users[currentPage].id);
                        ///显示匹配成功，匹配成功可以发送消息（自定义消息和sayhi）。点击发送以后，切换下一个人
                        showMatched(context,target: users[currentPage],next: (){

                          pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
                        });
                      }else{
                        ///
                        if(users[currentPage].wishList.isEmpty){
                          ref.read(asyncMatchRecommendedProvider.notifier).like(users[currentPage].id);
                          ref.read(backgroundImageProvider.notifier).updateBg(null);
                         pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
                        }else {
                          users[currentPage].matched=true;
                          setState(() {

                          });
                        }
                      }

                      setState(() {

                      });
                      SonaAnalytics.log(MatchEvent.match_like.name);

                    }else {
                      SonaAnalytics.log(MatchEvent.match_like_limit.name);
                      Navigator.push(context, MaterialPageRoute(builder:(c){
                        return const SubscribePage(fromTag: FromTag.pay_match_likelimit,);
                      }));
                    }
                }),
                ScaleAnimation(child: Image.asset(Assets.iconsArrow,width: 56,height: 56,), onTap: (){
                        Future.delayed(Duration(milliseconds: 200),(){
                           if(canArrow){

                      showDm(context, users[currentPage],(){

                        pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
                        //pageController.nextPage(duration: Duration(milliseconds: 1000), curve:  Curves.linearToEaseOut);
                      });
                    }else {
                      bool isMember=ref.read(myProfileProvider)?.isMember??false;
                      if(isMember){
                        Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder:(c){
                          return SubscribePage(fromTag: FromTag.pay_match_arrow,);
                        }));
                      }
                    }
                    });

                })
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

        List<MatchUserInfo> users1=list.map((e) => MatchUserInfo.fromJson(e)).toList();
        users=users1;
        if(users.every((element) => element.id!=-1)&&users.length<10){
          users.add(MatchUserInfo(id: -1, name: '', gender: null, birthday: null, avatar: null));
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
        List<MatchUserInfo> users1=list.map((e) => MatchUserInfo.fromJson(e)).toList();
        // users=[...users,...users1,...[UserInfo(id: -1, name: '', gender: null, birthday: null, avatar: null)]];


        users.addAll(users1);
        if(users.every((element) => element.id!=-1)){
          users.add(MatchUserInfo(id: -1, name: '', gender: null, birthday: null, avatar: null));
        }else {
          users.removeWhere((element) => element.id==-1);
          users.add(MatchUserInfo(id: -1, name: '', gender: null, birthday: null, avatar: null));
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
  TransformerPageController transformerPageController=TransformerPageController();
  double _c=0.0;
  _buildMatch() {
    if(_state==PageState.loading){
     return  Container(color: Colors.black,child: Center(child: MatchInitAnimation()),);
    }else if(_state==PageState.fail){
      return NoDataWidget();
    }
    else if(_state==PageState.success){
      return TransformerPageView(
        itemBuilder: (c,index) {
          MatchUserInfo info=users[index];
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
            return ProfileWidget(
              relation: Relation.normal,
              info:info,next:(){

              pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);

            },
              onMatch: (v){
                 info.matched=v;
                 setState(() {

                 });
              },
            );
          }
        },
          index: currentPage,
          itemCount: users.length,
          loop: false,
        //scrollDirection: Axis.horizontal,
        pageController: pageController,
          transformer: RotateDepthPageTransformer(),
          duration: Duration(milliseconds: 1000),
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) async {
          currentPage=value!;
          if (value != 0 && value % 3 == 0 ) {
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
