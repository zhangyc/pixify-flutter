import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/common/models/user.dart';
import 'package:sona/common/providers/profile.dart';
import 'package:sona/core/match/widgets/user_card.dart';
import 'package:sona/utils/dialog/input.dart';

import '../widgets/button/colored.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static const String routeName = '/user-profile';

  const UserProfileScreen({super.key, required this.user});
  final UserInfo user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
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
                  onPressed: Navigator.of(context).pop,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 8,
                right: 20,
                child: IconButton(
                  icon: Icon(Icons.more_horiz_outlined),
                  onPressed: _showActions,
                ),
              )
            ],
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
      await showRadioFieldDialog(context: context, options: {'Spam': 'spam', 'Inappropriate': 'inappropriate'});
    } else if (action == 'block') {
      await showRadioFieldDialog(context: context, options: {'Block': 'block', 'Unblock': 'unblock'});
    }
  }
}