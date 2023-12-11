import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/providers/other_info_provider.dart';
import 'package:sona/core/match/services/match.dart';
import 'package:sona/core/match/widgets/profile_widget.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/dialog/report.dart';

import '../../core/match/providers/matched.dart';
import '../../core/subscribe/subscribe_page.dart';
import '../../utils/global/global.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-profile';

  const UserProfileScreen({
    super.key,
    required this.userId,
    this.relation = Relation.normal,
  });
  final int userId;
  final Relation relation;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  late var _liked = widget.relation == Relation.matched || widget.relation == Relation.likeOther;

  @override
  Widget build(BuildContext context) {
   // final userinfo = ref.watch(getProfileByIdProvider(widget.userId));

    //return Profile(info: info, next: next);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ref.watch(getProfileByIdProvider(widget.userId)).when(
        data: (user) => user==null?Container():ProfileWidget(
          relation: widget.relation,
          info: user.data, next: (){

        },onMatch: (v){},),
        error: (err, stack) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => ref.refresh(getProfileByIdProvider(widget.userId)),
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: const Text(
                'Load user info error\nclick the screen to try again.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, decoration: TextDecoration.none)
            ),
          ),
        ),
        loading: () => Container(
          color: Colors.white54,
          alignment: Alignment.center,
          child: const SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(strokeWidth: 2.5)
          ),
        ),
      )
    );
  }

  void _showActions() async {
    final action = await showActionButtons(context: context, options: {'Report': 'report', 'Block': 'block'});
    if (action == 'report' && mounted) {
      showReport(context, widget.userId);
    } else if (action == 'block' && mounted) {
      await showActionButtons(context: context, options: {'Block': 'block', 'Unblock': 'unblock'});
      final resp = await matchAction(userId: widget.userId, action: MatchAction.block);
      if (resp.statusCode == 0) {
        Fluttertoast.showToast(msg: 'the user has been blocked');
        SonaAnalytics.log('chat_block');
      }
    }
  }

  void _onBack() {
    Navigator.of(context).pop();
  }

  Future _onLike() async {
    final resp=await ref.read(asyncMatchRecommendedProvider.notifier).like(widget.userId);
    if(resp.isSuccess){
      SonaAnalytics.log('chatlist_member_like');
      if(resp.data['resultType']==2){
        // if (index < users.length - 1) {
        //   pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 200),
        //       curve: Curves.linearToEaseOut);
        // }
      }else if(resp.data['resultType']==1 && mounted){
       // showMatched(context,target: widget.userId,next: (){
          //ref.read(pageControllerProvider).nextPage(duration: Duration(milliseconds: 100), curve: Curves.linearToEaseOut);
       // });
      }
    }else if(resp.statusCode==10150){
      Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
        return const SubscribePage(fromTag: FromTag.pay_profile,);
      }));
    }
    return ref.read(asyncMatchRecommendedProvider.notifier).like(widget.userId).then((resp){

      if (mounted && resp.isSuccess) {
        setState(() {
          _liked = true;
        });
      }
      if (mounted && resp.statusCode == 10150) {
        Navigator.push(context, MaterialPageRoute(builder:(c){
          return SubscribePage(fromTag: FromTag.pay_profile,);
        }));
      }
    });
  }
}

enum Relation {
  normal,   ///互相没like
  likeOther, ///你喜欢的人
  likeMe,  ///喜欢我的
  matched, ///相互like
  self  ///查看自己
}