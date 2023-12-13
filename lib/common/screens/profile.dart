import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/providers/other_info_provider.dart';
import 'package:sona/core/match/widgets/profile_widget.dart';


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
}

enum Relation {
  normal,   ///互相没like
  likeOther, ///你喜欢的人
  likeMe,  ///喜欢我的
  matched, ///相互like
  self  ///查看自己
}