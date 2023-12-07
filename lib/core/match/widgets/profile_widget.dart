import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/core/match/bean/match_user.dart';

import '../../../account/providers/profile.dart';
import '../../../common/permission/permission.dart';
import '../../../common/screens/profile.dart';
import '../../../generated/assets.dart';
import '../../../utils/dialog/report.dart';
import '../../../utils/global/global.dart';
import '../../subscribe/subscribe_page.dart';
import '../providers/match_provider.dart';
import '../providers/matched.dart';
import '../services/match.dart';
import '../util/event.dart';
import 'bio_item.dart';
import 'biz_action_item.dart';
import 'dialogs.dart';
import 'galley_item.dart';
import 'heard_item.dart';
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
  late MatchUserInfo info=widget.info;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            (widget.relation!=Relation.normal)?SizedBox(
              height: MediaQuery.of(context).padding.top+MediaQuery.of(context).viewPadding.top,
            ):
            SizedBox(
              height: MediaQuery.of(context).padding.top+MediaQuery.of(context).viewPadding.top+58,
            ),
            Container(alignment: Alignment.centerLeft,child: (widget.relation!=Relation.normal)?IconButton(onPressed: (){
                 Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)):Container(),
            ),
            const SizedBox(
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
                                final r =await showReport(context, info.id);
                                if (r == true) {
                                  ///users.removeAt(currentPage);
                                  widget.next.call();
                                  if (mounted) setState(() {});
                                }
                              }, block: () async{
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
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
        (widget.relation==Relation.normal||widget.relation==Relation.likeMe)?Positioned(bottom: 8+MediaQuery.of(context).padding.bottom,
          width: MediaQuery.of(context).size.width,child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(child: Image.asset(Assets.iconsSkip,width: 56,height: 56,),
                onTap: (){
                  widget.next.call();
                  ref.read(asyncMatchRecommendedProvider.notifier).skip(info.id);
                },
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
                      ref.read(asyncMatchRecommendedProvider.notifier).like(info.id);
                      ///显示匹配成功，匹配成功可以发送消息（自定义消息和sayhi）。点击发送以后，切换下一个人
                      showMatched(context,target: info,next: (){
                        widget.next.call();
                      });
                    }else{
                      ///
                      if(info.wishList.isEmpty){
                        ref.read(asyncMatchRecommendedProvider.notifier).like(info.id);
                        ref.read(backgroundImageProvider.notifier).updateBg(null);
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
                      return const SubscribePage(fromTag: FromTag.pay_match_likelimit,);
                    }));
                  }
                },
              ),
              GestureDetector(child: Image.asset(Assets.iconsArrow,width: 56,height: 56,),
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
                        return SubscribePage(fromTag: FromTag.pay_match_arrow,);
                      }));
                    }
                  }
                },
              ),
            ],
          ),
        ):Container()
      ],
    );
  }
}
