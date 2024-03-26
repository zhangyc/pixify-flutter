import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/bean/match_user.dart';
import 'package:sona/core/match/util/http_util.dart';
import 'package:sona/core/match/widgets/image_scale_animation.dart';
import 'package:sona/core/match/widgets/loading_button.dart';
import 'package:sona/utils/dialog/input.dart';
import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../common/screens/profile.dart';
import '../../../generated/assets.dart';
import '../../../generated/l10n.dart';
import '../../../utils/dialog/report.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/match_provider.dart';
import '../providers/matched.dart';
import '../services/match.dart';
import '../util/event.dart';
import 'bio_item.dart';
import 'biz_action_item.dart';
import 'choice_bytton.dart';
import 'dialogs.dart';
import 'galley_item.dart';
import 'interest_item.dart';
import 'wishlist_item.dart';

class ProfileWidget extends ConsumerStatefulWidget {
  const ProfileWidget( {super.key,
    required this.info,
    required this.next,
    required this.onMatch,
    required this.relation,
  });
  final MatchUserInfo info;
  final VoidCallback next;
  final Function(bool matched) onMatch;
  final Relation relation;
  @override
  ConsumerState createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<ProfileWidget> {
  late MatchUserInfo info;
  @override
  void initState() {
    info=widget.info;
    // info.photos.removeAt(0);
    super.initState();
  }

  PageController pageController=PageController(viewportFraction: 0.9);


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        CustomScrollView(
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
                        //HeardItem(userInfo: info,),
                        //HeardInitAnimation(child: ),
                        ///头像，动画。
                        SizedBox(height: widget.info.matched&&info.wishList.isNotEmpty?27:0,),
                        MyImageAnimation(info: widget.info),
                        SizedBox(
                          height: 16,
                        ),
                        Stack(
                          children: [
                            widget.info.matched?Container():Column(
                              children: [
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
                                  final r =await showReport(context, info.id);
                                  if (r == true) {
                                    ///users.removeAt(currentPage);
                                    widget.next.call();
                                    if (mounted) setState(() {});
                                  }
                                }, block: () async{
                                  bool? result=await showConfirm(context: context,
                                      title:S.of(context).block,
                                      content: S.of(context).blockThisPersonSoYouWontReceiveAnyMessagesFromThem,
                                      confirmText: S.of(context).block,
                                      cancelText: S.of(context).buttonCancel,
                                      danger: true
                                  );
                                  if(result!=true){
                                    return;
                                  }
                                  final resp = await matchAction(userId: info.id, action: MatchAction.block);
                                  if (resp.statusCode == 0) {
                                    ///users.removeAt(currentPage);
                                    widget.next.call();
                                    if (mounted) setState(() {});
                                    Fluttertoast.showToast(msg: 'The user has been blocked');
                                    SonaAnalytics.log('post_block');
                                  }
                                },
                                  unMatch: () async{
                                    bool? result=await showConfirm(context: context,
                                      title: S.of(context).buttonUnmatch,
                                      content: S.of(context).warningUnmatching,
                                      confirmText: S.of(context).buttonUnmatch,
                                      cancelText: S.of(context).buttonCancel
                                    );
                                    if(result!=true){
                                      return;
                                    }
                                    final resp = await matchAction(userId: info.id, action: MatchAction.unmatch);
                                    if (resp.statusCode == 0) {
                                      ///users.removeAt(currentPage);
                                      widget.next.call();
                                      if (mounted) setState(() {});
                                      Fluttertoast.showToast(msg: 'Unmatch Success');
                                      SonaAnalytics.log('post_block');
                                    }
                                  },
                                  relation: widget.relation,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).padding.bottom+64,
                                ),
                              ],
                            ),
                            !widget.info.matched?Container():Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32),
                                  child: Text(S.of(context).matchPageSelectIdeas(widget.info.gender!.name.toLowerCase()),style: TextStyle(
                                      color: Color(0xff2c2c2c),
                                      fontSize: 20
                                  ),),
                                ),
                                widget.info.wishList.length>1?_buildPageIndicator():Container(),
                                SizedBox(
                                  height: 500+100,
                                  // width: MediaQuery.of(context).size.width,
                                  child:PageView(
                                    onPageChanged: (value){
                                      _currentPage = value;
                                      ref.read(backgroundImageProvider.notifier).updateBgImage(widget.info.wishList[value].pic!);
                                    },
                                    controller: pageController,
                                    children: widget.info.wishList.map((wish) => Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 4
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                            constraints: BoxConstraints(
                                              minHeight: 266
                                            ),
                                            // width: MediaQuery.of(context).size.width,
                                            // height: 266,
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
                                                    SizedBox(width: 4,),
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
                                                      child: ChoiceButton(activity: wish.activities[index2], onTap: () {
                                                        ///点击切换，下一个用户.并且调用like接口
                                                        MatchApi.like(widget.info.id,
                                                            activityId: wish.activities[index2].id,
                                                            travelWishId: wish.id
                                                        );
                                                        SonaAnalytics.log(MatchEvent.match_like_wishlist.name);

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
                                        ],
                                      ),
                                    )).toList(),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
        (widget.relation==Relation.likeMe)?Positioned(bottom: 8+MediaQuery.of(context).padding.bottom,
          width: MediaQuery.of(context).size.width,child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 68),
            child: (widget.relation==Relation.likeMe)?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoadingButton(onPressed: ()async{
                  if(widget.relation==Relation.likeMe){
                    await post('/user/friend/remove-like',data: {'id':info.id},);
                    Navigator.pop(context);
                  }else {
                    widget.next.call();
                    MatchApi.skip(info.id);
                  }

                }, child: Image.asset(Assets.iconsSkip,width: 56,height: 56,), placeholder: Container(
                     width: 56,height: 56,
                    alignment: Alignment.center,
                    child: SizedBox(child: CircularProgressIndicator(),width: 32,height: 32,))),
                SizedBox(
                  width: 48,
                ),
                GestureDetector(child: Image.asset(Assets.iconsLike,width: 64,height: 64,),
                  onTap: (){
                    // showMatched(context,target: info,next: (){
                    //   //pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
                    // });
                    ///是否能like
                    if(canLike){
                      if(like>0){
                        like=like-1;
                      }
                      //currentPage=index;
                      ///如果对方喜欢我。
                      if(info.likeMe==1){
                        MatchApi.like(info.id);
                        ///显示匹配成功，匹配成功可以发送消息（自定义消息和sayhi）。点击发送以后，切换下一个人
                        showMatched(context,target: info,next: (){
                          widget.next.call();
                        });
                      }else{
                        ///
                        if(info.wishList.isEmpty){
                          MatchApi.like(info.id);
                          ref.read(backgroundImageProvider.notifier).updateBgImage(null);
                          widget.next.call();
                        }else {
                          widget.onMatch.call(true);
                        }
                      }

                      setState(() {

                      });
                      SonaAnalytics.log(MatchEvent.match_like.name);

                    }else {
                      SonaAnalytics.log(MatchEvent.match_like_limit.name);
                      Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                        return SubscribePage(fromTag: FromTag.pay_match_likelimit,);
                      }));
                    }
                  },
                ),
              ],
            ):Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoadingButton(onPressed: ()async{
                  if(widget.relation==Relation.likeMe){
                    await post('/user/friend/remove-like',data: {'id':info.id},);
                    Navigator.pop(context);
                  }else {
                   widget.next.call();
                   MatchApi.skip(info.id);
                  }

                 }, child: Image.asset(Assets.iconsSkip,width: 56,height: 56,), placeholder: CircularProgressIndicator()),
                GestureDetector(child: Image.asset(Assets.iconsLike,width: 64,height: 64,),
                  onTap: (){
                    // showMatched(context,target: info,next: (){
                    //   //pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.linearToEaseOut);
                    // });
                    ///是否能like
                    if(canLike){

                      if(like>0){
                        like=like-1;
                      }
                      //currentPage=index;
                      ///如果对方喜欢我。
                      if(info.likeMe==1){
                        MatchApi.like(info.id);
                        ///显示匹配成功，匹配成功可以发送消息（自定义消息和sayhi）。点击发送以后，切换下一个人
                        showMatched(context,target: info,next: (){
                          widget.next.call();
                        });
                      }else{
                        ///
                        if(info.wishList.isEmpty){
                          MatchApi.like(info.id);
                          ref.read(backgroundImageProvider.notifier).updateBgImage(null);
                          widget.next.call();
                        }else {
                          widget.onMatch.call(true);
                        }
                      }

                      setState(() {

                      });
                      SonaAnalytics.log(MatchEvent.match_like.name);

                    }else {
                      SonaAnalytics.log(MatchEvent.match_like_limit.name);
                      Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                        return SubscribePage(fromTag: FromTag.pay_match_likelimit,);
                      }));
                    }
                  },
                ),
                (widget.relation==Relation.likeMe)?Container():GestureDetector(child: Image.asset(Assets.iconsArrow,width: 56,height: 56,),
                  onTap: (){
                    if(canArrow){
                      showDm(context, info,(){
                        widget.next.call();
                        //pageController.nextPage(duration: Duration(milliseconds: 1000), curve:  Curves.linearToEaseOut);
                      });
                    }else {
                      bool isMember=ref.read(myProfileProvider)?.isMember??false;
                      if(isMember){
                        Fluttertoast.showToast(msg: 'Arrow on cool down this week');
                      }else{
                        Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
                          return SubscribePage(fromTag: FromTag.duo_snap,);
                        }));
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ):Container()
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
    return _currentPage == index?Container(

      width: _currentPage == index ?16:8,
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
        color: _currentPage == index ? Color(0xff2C2C2C) : Color(0xffE8E6E6),
      ),
    ):Container(

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
