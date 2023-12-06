import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/providers/match_provider.dart';
import 'package:sona/core/match/screens/filter_page.dart';
import 'package:sona/core/match/widgets/no_data.dart';
import 'package:sona/core/match/widgets/no_more.dart';
import 'package:sona/core/match/widgets/profile_widget.dart';
import 'package:sona/generated/assets.dart';

import '../../../account/providers/profile.dart';
import '../../../common/screens/profile.dart';
import '../../../utils/location/location.dart';
import '../bean/match_user.dart';
import '../util/http_util.dart';
import '../util/local_data.dart';
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
  List<MatchUserInfo> users =[];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  int currentPage=0;
  PageController pageController=PageController();
  @override
  Widget build(BuildContext context) {
    String? bgImage=ref.watch(backgroundImageProvider);
    super.build(context);
    return Stack(
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
  _buildMatch() {
    if(_state==PageState.loading){
     return  Container(color: Colors.black,child: Center(child: MatchInitAnimation()),);
    }else if(_state==PageState.fail){
      return NoDataWidget();
    }
    else if(_state==PageState.success){
      return PageView.builder(
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
        itemCount: users.length,
        scrollDirection: Axis.horizontal,
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) async {
          //currentPage=value;
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
