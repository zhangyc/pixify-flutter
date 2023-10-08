import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/providers/profile.dart';
import 'package:sona/core/match/services/match.dart';
import 'package:sona/core/match/widgets/user_card.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/dialog/report.dart';

import '../../core/match/providers/matched.dart';
import '../../core/match/widgets/filter_dialog.dart';
import '../../core/subscribe/subscribe_page.dart';
import '../../generated/assets.dart';
import '../../utils/global/global.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-profile';

  const UserProfileScreen({
    super.key,
    required this.user,
    this.relation = Relation.normal
  });
  final UserInfo user;
  final Relation relation;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  late var _liked = widget.relation == Relation.matched || widget.relation == Relation.likeOther;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ref.watch(asyncOthersProfileProvider(widget.user.id)).when(
        data: (user) => UserCard(
            user: user,
            actions: [
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                left: 12,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Color.fromARGB(120, 0, 0, 0),
                      ),
                    ],
                  ),
                  onPressed: _onBack,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                right: 20,
                child: Visibility(
                  visible: widget.relation != Relation.self,
                  child: IconButton(
                    icon: Icon(
                      Icons.more_horiz_outlined,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Color.fromARGB(120, 0, 0, 0),
                        ),
                      ],
                    ),
                    onPressed: _showActions,
                  ),
                ),
              ),
              Positioned(
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 120,
                  child: Visibility(
                    visible: widget.relation == Relation.normal || widget.relation == Relation.likeMe,
                    child: InkWell(
                      onTap: _onLike,
                      child: Image.asset(Assets.iconsLike,width: 50,height: 50, color: _liked ? Colors.red : null),
                    ),
                  )
              )
            ]
        ),
        error: (err, stack) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => ref.refresh(asyncOthersProfileProvider(widget.user.id)),
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
    final action = await showRadioFieldDialog(context: context, options: {'Report': 'report', 'Block': 'block'});
    if (action == 'report' && mounted) {
      showReport(context, widget.user.id);
    } else if (action == 'block' && mounted) {
      await showRadioFieldDialog(context: context, options: {'Block': 'block', 'Unblock': 'unblock'});
      final resp = await matchAction(userId: widget.user.id, action: MatchAction.block);
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
    final resp=await ref.read(asyncMatchRecommendedProvider.notifier).like(widget.user.id);
    if(resp.isSuccess){
      SonaAnalytics.log('chatlist_member_like');
      if(resp.data['resultType']==2){
        // if (index < users.length - 1) {
        //   pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 200),
        //       curve: Curves.linearToEaseOut);
        // }
      }else if(resp.data['resultType']==1 && mounted){
        showMatched(context, () {
          // if (index < users.length - 1) {
          //   pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 200),
          //       curve: Curves.linearToEaseOut);
          // }
        },target: widget.user);
      }
    }else if(resp.statusCode==10150){
      Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder:(c){
        return const SubscribePage(fromTag: FromTag.pay_profile,);
      }));
    }
    return ref.read(asyncMatchRecommendedProvider.notifier).like(widget.user.id).then((resp){

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
  normal,
  likeOther,
  likeMe,
  matched,
  self
}