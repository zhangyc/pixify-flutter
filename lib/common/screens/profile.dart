import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/providers/profile.dart';
import 'package:sona/common/services/report.dart';
import 'package:sona/core/match/widgets/user_card.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/providers/dio.dart';

import '../../account/providers/profile.dart';
import '../../core/match/providers/matched.dart';
import '../../core/match/widgets/like_animation.dart';
import '../../core/providers/navigator_key.dart';
import '../../core/subscribe/subscribe_page.dart';
import '../../generated/assets.dart';
import '../widgets/button/colored.dart';

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
                  icon: Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: _onBack,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                right: 20,
                child: Visibility(
                  visible: widget.relation != Relation.self,
                  child: IconButton(
                    icon: Icon(Icons.more_horiz_outlined),
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
    if (action == 'report') {
      final reason = await showRadioFieldDialog(
        context: context,
        options: {
          'Spam': 1,
          'Inappropriate': 2
        }
      );
      if (reason != null) {
        final resp = await report(httpClient: ref.read(dioProvider), type: 1, id: widget.user.id, reason: 1);
        if (resp.statusCode == 200) {
          Fluttertoast.showToast(msg: 'Reported');
        }
      }
    } else if (action == 'block') {
      await showRadioFieldDialog(context: context, options: {'Block': 'block', 'Unblock': 'unblock'});
    }
  }

  void _onBack() {
    Navigator.of(context).pop();
  }

  Future _onLike() {
    return ref.read(asyncMatchRecommendedProvider.notifier).like(widget.user.id).then((resp){
      if (mounted && resp?.statusCode == 200) {
        setState(() {
          _liked = true;
        });
      }
      if (mounted && resp?.statusCode == 10150) {
        Navigator.push(context, MaterialPageRoute(builder:(c){
          return SubscribePage();
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