import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sona/account/models/my_profile.dart';
import 'package:sona/core/match/providers/match_provider.dart';
import 'package:sona/core/match/providers/setting.dart';
import 'package:sona/core/match/screens/filter_page.dart';
import 'package:sona/core/match/util/image_util.dart';
import 'package:sona/core/match/widgets/button_animations.dart';
import 'package:sona/core/match/widgets/catch_more.dart';
import 'package:sona/core/match/widgets/custom_pageview/src/skip_transformer.dart';
import 'package:sona/core/match/widgets/icon_animation.dart';
import 'package:sona/core/match/widgets/no_data.dart';
import 'package:sona/core/match/widgets/no_location.dart';
import 'package:sona/core/match/widgets/no_more.dart';
import 'package:sona/core/match/widgets/profile_widget.dart';
import 'package:sona/core/match/widgets/time_limited_offer.dart';
import 'package:sona/core/subscribe/model/member.dart';
import 'package:sona/core/widgets/generate_banner.dart';
import 'package:sona/core/widgets/not_meet_conditions.dart';
import 'package:sona/core/widgets/other_not_meet_conditions.dart';
import 'package:sona/generated/assets.dart';
import 'package:sona/utils/face_detection/detection.dart';
import 'package:sona/utils/locale/locale.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:system_settings/system_settings.dart';

import '../../../account/providers/profile.dart';
import '../../../account/services/info.dart';
import '../../../common/permission/permission.dart';
import '../../../common/screens/profile.dart';
import '../../../generated/l10n.dart';
import '../../../utils/dialog/common.dart';
import '../../../utils/dialog/crop_image.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../bean/match_user.dart';
import '../providers/matched.dart';
import '../util/event.dart';
import '../util/http_util.dart';
import '../util/local_data.dart';
import '../widgets/custom_pageview/src/transformer_page_view.dart';
import '../widgets/dialogs.dart';
import '../widgets/match_init_animation.dart';

var languageNotifier = ValueNotifier<SonaLocale>(SonaLocale.fromLanguageTag('en', 'English (US)'));

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
      longitude=ref.read(myProfileProvider)!.position?.longitude;
      latitude=ref.read(myProfileProvider)!.position?.latitude;
      if(longitude==null||latitude==null){
        _state=PageState.notLocation;
      }else {
        _initData();
      }
      ///直接获取用户信息里的经纬度。
    });
    languageNotifier.addListener(() {
      _initData();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(openAppCount==2&&todayIsShowedTimed&&showTimeLimitedCount<3){
        showDuoSnapTip(context, child: TimeLimitedOffer(close: (){
          Navigator.pop(context);
        }), dialogHeight: 427);
        todayIsShowedTimed=false;
        showTimeLimitedCount+=1;
      }
    });
    super.initState();
    controller.addListener(() {
      pageControllerProgress.value=controller.page??0.0;
    });
  }
  List<MatchUserInfo> users =[];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  int currentPage=0;
  late TransformerPageController controller=TransformerPageController();
  bool detecting=false;
  @override
  Widget build(BuildContext context) {
    // pageControllerProvider=controller;
    String? bgImage=ref.watch(backgroundImageProvider);
    super.build(context);
    return Stack(
      children: [
        Positioned.fill(child: bgImage==null?Container():Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.topCenter,
          color: Colors.white,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin:Alignment.bottomCenter,
                end:Alignment.topCenter  ,
                colors: [Colors.transparent, Colors.black],
                stops: [0.0, 0.8], // 调整渐变的范围
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: CachedNetworkImage(imageUrl: bgImage,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,

            ),
          ),
        ),),
        Scaffold(
          extendBodyBehindAppBar: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(Assets.iconsSona,width: 96,height: 24 ,),
                Row(
                  children: [
                    GestureDetector(child: Image.asset(Assets.iconsFliter,width: 48,height: 48,),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c){
                          return FilterPage();
                        })).then((value){
                          _initData();
                          if(mounted){
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
          body: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  children: [
                    GenerateBanner(),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(child: _buildMatch())

                  ],
                )
              ),
              (users.isNotEmpty&&users[currentPage].id==-1)||_state==PageState.fail||_state==PageState.noData||_state==PageState.loading||_state==PageState.notLocation?Container():
              Positioned(bottom: 8+MediaQuery.of(context).padding.bottom,
                width: MediaQuery.of(context).size.width,child: Padding(
                  padding:EdgeInsets.symmetric(
                    horizontal: 68
                  ),
                  child: (users.isNotEmpty&&users[currentPage].wishList.isNotEmpty&&users[currentPage].matched)?
                  TextButton(onPressed: (){
                    //widget.next.call();
                    controller.nextPage(duration: Duration(milliseconds: 2000), curve: Curves.linearToEaseOut);
                    ref.read(backgroundImageProvider.notifier).updateBgImage(null);
                    MatchApi.like(users[currentPage].id,);
                    SonaAnalytics.log(MatchEvent.match_like_justlike.name);

                   }, child: Text('${S.of(context).justSendALike} >',style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),)):Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ScaleAnimation(onTap: (){
                        if(currentPage==users.length-1){
                          return;
                        }
                        matchAnimation.value=TransformStatus.leftRotate;
                        SonaAnalytics.log(MatchEvent.match_dislike.name);
                        // status=PageAnimStatus.dislike;
                        controller.nextPage(duration: Duration(milliseconds: 2000), curve: Curves.linearToEaseOut);
                        MatchApi.skip(users[currentPage].id);
                      },
                          child: SvgPicture.asset(Assets.svgDislike,width: 56,height: 56,)
                      ),
                      ScaleAnimation(child: SvgPicture.asset(Assets.svgLike,width: 64,height: 64,), onTap: (){
                          if(currentPage==users.length-1){
                                  return;
                                }
                          if(canLike){
                            matchAnimation.value=TransformStatus.rightRotate;

                            if(like>0){
                              like=like-1;
                            }
                            //currentPage=index;
                            ///如果对方喜欢我。
                            if(users[currentPage].likeMe==1){
                              SonaAnalytics.log(MatchEvent.match_matched.name);

                              MatchApi.like(users[currentPage].id);
                              ///显示匹配成功，匹配成功可以发送消息（自定义消息和sayhi）。点击发送以后，切换下一个人
                              showMatched(context,target: users[currentPage],next: (){

                                controller.nextPage(duration: Duration(milliseconds: 2000), curve: Curves.linearToEaseOut);
                              });
                            }else{
                              ///
                              if(users[currentPage].wishList.isEmpty){
                                MatchApi.like(users[currentPage].id);
                                ref.read(backgroundImageProvider.notifier).updateBgImage(null);

                                controller.nextPage(duration: Duration(milliseconds: 2000), curve: Curves.linearToEaseOut);
                              }else {
                                users[currentPage].matched=true;
                                if(users[currentPage].matched&&users[currentPage].wishList.isNotEmpty){
                                  ref.read(backgroundImageProvider.notifier).updateBgImage(users[currentPage].wishList.first.pic!);
                                }
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
                              return SubscribePage(fromTag: FromTag.pay_match_likelimit,);
                            }));
                          }
                      }),
                      detecting?Container(width: 56,height: 56,decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xff2c2c2c),
                          width: 2
                        )
                      ),child: SizedBox(child: CircularProgressIndicator(),width: 30,height: 30,),
                        alignment: Alignment.center,

                      ):
                      ScaleAnimation(child: SvgPicture.asset(Assets.svgDuosnap,width: 56,height: 56,), onTap: () async {
                              if(currentPage==users.length-1){
                                  return;
                               }
                              SonaAnalytics.log(DuoSnapEvent.click_duo.name);
                              if(!canDuoSnap){
                                if(ref.read(myProfileProvider)!.memberType==MemberType.none){
                                  SonaAnalytics.log(DuoSnapEvent.Duo_click_pay.name);
                                  Navigator.push(context, MaterialPageRoute(builder:(c){
                                    return const SubscribePage(fromTag: FromTag.duo_snap,);
                                  }));
                                }else if(ref.read(myProfileProvider)!.memberType==MemberType.club){
                                  SonaAnalytics.log(DuoSnapEvent.plus_duo_limit.name);

                                  Navigator.push(context, MaterialPageRoute(builder:(c){
                                    return const SubscribePage(fromTag: FromTag.pay_match_arrow,);
                                  }));
                                }else if(ref.read(myProfileProvider)!.memberType==MemberType.plus){
                                  SonaAnalytics.log(DuoSnapEvent.club_clickduo_payplus.name);

                                  Fluttertoast.showToast(msg: S.current.weeklyLimitReached);
                                }
                                return;
                              }
                              try{
                                detecting=true;
                                HttpResult result=await post('/merge-photo/find-last');
                                if(result.statusCode.toString()=='60010') {
                                  setState(() {

                                  });
                                    FileInfo file=await DefaultCacheManager().downloadFile(ref.read(myProfileProvider)!.photos.first.url);
                                    FileInfo file2=await DefaultCacheManager().downloadFile(users[currentPage].photos.first);

                                    bool con1=await faceDetection(file.file.path);
                                    bool con2=await faceDetection(file2.file.path);
                                    detecting=false;
                                    setState(() {

                                    });
                                    if(con1&&con2){
                                     await showDuoSnapDialog(context,target: users[currentPage]);
                                     controller.nextPage(duration: Duration(milliseconds: 2000), curve: Curves.linearToEaseOut);

                                    }else if(!con1&&con2){
                                      SonaAnalytics.log(DuoSnapEvent.notreal_self.name);

                                      showDuoSnapTip(context, child: NotMeetConditions(
                                        close: (){
                                          Navigator.pop(context);
                                        },
                                        camera: () async {
                                          setUserAvatarPhoto(ImageSource.camera, ref);
                                          if(mounted){
                                            Navigator.pop(context);
                                          }
                                        },
                                        gallery: () async {
                                          setUserAvatarPhoto(ImageSource.gallery, ref);
                                          if(mounted){
                                            Navigator.pop(context);
                                          }
                                        },
                                        anyway: () async{
                                          if(mounted){
                                            Navigator.pop(context);
                                          }
                                          await showDuoSnapDialog(context,target: users[currentPage]);
                                          controller.nextPage(duration: Duration(milliseconds: 2000), curve: Curves.linearToEaseOut);

                                        },
                                      ),
                                          dialogHeight: 361);
                                    }else if(con1&&!con2){
                                      SonaAnalytics.log(DuoSnapEvent.notreal_other.name);

                                      showDuoSnapTip(context, child: OtherNotMeetConditions(
                                        close: (){
                                          Navigator.pop(context);
                                        },
                                        gotit: (){
                                          Navigator.pop(context);
                                        },
                                        sendDM: (){
                                          Future.delayed(Duration(milliseconds: 200),(){
                                            matchAnimation.value=TransformStatus.rightRotate;
                                            if(canArrow){
                                              showDm(context, users[currentPage],(){
                                                controller.nextPage(duration: Duration(milliseconds: 2000), curve: Curves.linearToEaseOut);
                                                //pageController.nextPage(duration: Duration(milliseconds: 2000), curve:  Curves.linearToEaseOut);
                                              });
                                            }else {
                                              bool isMember=ref.read(myProfileProvider)?.isMember??false;
                                              if(isMember){
                                                Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                                              }else{
                                                Navigator.push(context, MaterialPageRoute(builder:(c){
                                                  return SubscribePage(fromTag: FromTag.duo_snap,);
                                                }));
                                              }
                                            }
                                          });
                                          if(mounted){
                                            Navigator.pop(context);
                                          }
                                        }, anyway: () async{
                                        Navigator.pop(context);

                                        await showDuoSnapDialog(context,target: users[currentPage]);
                                        controller.nextPage(duration: Duration(milliseconds: 2000), curve: Curves.linearToEaseOut);

                                      },

                                      ), dialogHeight: 390);
                                    }else if(!con1&&!con2){
                                      showDuoSnapTip(context, child: NotMeetConditions(
                                        close: (){
                                          Navigator.pop(context);
                                        },
                                        camera: () async {
                                          setUserAvatarPhoto(ImageSource.camera, ref);
                                          if(mounted){
                                            Navigator.pop(context);
                                          }
                                        },
                                        gallery: () async {
                                          setUserAvatarPhoto(ImageSource.gallery, ref);
                                          if(mounted){
                                            Navigator.pop(context);
                                          }
                                        }, anyway: ()async{
                                        if(mounted){
                                          Navigator.pop(context);
                                        }
                                        await showDuoSnapDialog(context,target: users[currentPage]);
                                        controller.nextPage(duration: Duration(milliseconds: 2000), curve: Curves.linearToEaseOut);

                                      },
                                      ), dialogHeight: 361);
                                    }

                                }else {
                                  Fluttertoast.showToast(msg: S.current.onlyOneAtatime);
                                  detecting=false;
                                  setState(() {

                                  });
                                }
                              }catch(e){
                                detecting=false;
                                setState(() {

                                });
                              }



                      })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
  int current=1;

  void _initData() async{
    longitude=ref.read(myProfileProvider)!.position?.longitude;
    latitude=ref.read(myProfileProvider)!.position?.latitude;
    _state=PageState.loading;
    if(mounted){
      setState(() {

      });
    }
    current=1;
    currentPage=0;
    try{
      final resp=await post('/user/match-v2',data: {
        'gender': currentFilterGender,
        'minAge': currentFilterMinAge,
        'maxAge': currentFilterMaxAge,
        'longitude': longitude,
        'latitude': latitude,
        "page":current,    // 页码
        "pageSize":30, // 每页数量
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
        if(users.every((element) => element.id!=-1)&&users.length<=30){
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
        "pageSize":30, // 每页数量,
        "recommendMode":recommendMode
      });
      if(resp.isSuccess){
        List list= resp.data;

        if(list.isEmpty){
          //_state=PageState.noData;
        }else {
          _state=PageState.success;
        }
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

  PageState _state= PageState.loading;
  _buildMatch() {
    if(_state==PageState.loading){
     return Container(color: Colors.black,child: Center(child: MatchInitAnimation()),);
    }else if(_state==PageState.fail){
      return NoDataWidget(onTap: (){
        _initData();
        setState(() {

        });
      },);
    } else if(_state==PageState.success){
      return TransformerPageView(
          itemBuilder: (c,index) {
            MatchUserInfo info=users[index];
            if(info.id==-1){
              return NoMoreWidget(
                onTap: (){
                  _initData();
                  setState(() {

                  });
                },
              );
            }
            return ProfileWidget(
              relation: Relation.normal,
              info:info,
              next:(){
                  controller.nextPage(duration: Duration(milliseconds: 2000), curve: Curves.linearToEaseOut);
                  },
              onMatch: (v){},
            );
          },
          pageController: controller,
          index: currentPage,
          itemCount: users.length,
          //loop: false,
          scrollDirection: Axis.horizontal,
          //pageController: pageController,
          transformer: RotatePageTransformer(),
          duration: const Duration(milliseconds: 2000),
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) async {
            currentPage=value!;
            if(value==4&&!todayIsShowedInterest){
              SonaAnalytics.log(MatchEvent.match_interests_pop.name);

              if(ref.watch(myProfileProvider)!.interests.isEmpty&&ref.watch(myProfileProvider)!.bio==null){
                if(mounted){
                  showChooseHobbies(context);
                  todayIsShowedInterest=true;
                }
              }
            }else if(value==10&&!todayIsShowedPhoto){
              SonaAnalytics.log(MatchEvent.match_avatar_pop.name);

              if(ref.watch(myProfileProvider)!.photos.length<3&&!todayIsShowedPhoto){
                if(mounted){
                  showUploadPortrait(context);
                  todayIsShowedPhoto=true;
                }
              }
            }
            setState(() {

            });
            if (value != 0 && value % 25 == 0 ) {
              ///判断当天的次数为null
              current++;
              _loadMore();
            }
          }
      );

    }else if(_state==PageState.noData){
      return NoMoreWidget(onTap: (){
        _initData();
        setState(() {

        });
      },);
    }else if(_state==PageState.notLocation){
      return NoLocation(onTap: ()async{
        var permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          if (!mounted) return;
          await showCommonBottomSheet(
          context: context,
          title: S.current.permissionRequiredTitle,
          content: S.current.permissionRequiredContent,
          actions: [
            FilledButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await SystemSettings.app();
                },
                child: Text(S.current.buttonGo)
            )
          ]
          );
        }
      },);
    }
  }
}

enum PageState{
  loading,
  noData,
  success,
  fail,
  notLocation
}
enum PageAnimStatus {
  dislike,
  like,
  dm
}
