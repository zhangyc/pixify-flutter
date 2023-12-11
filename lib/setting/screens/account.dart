import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/account/services/info.dart';
import 'package:sona/common/widgets/button/forward.dart';
import 'package:sona/core/providers/token.dart';
import 'package:sona/core/travel_wish/providers/my_wish.dart';
import 'package:sona/core/travel_wish/providers/popular_country.dart';
import 'package:sona/core/travel_wish/providers/timeframe.dart';
import 'package:sona/utils/global/global.dart';
import 'package:sona/utils/locale/locale.dart';
import 'package:sona/utils/picker/gender.dart';

import '../../generated/l10n.dart';
import '../../utils/dialog/input.dart';

class AccountSettingScreen extends StatefulHookConsumerWidget {
  const AccountSettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends ConsumerState<AccountSettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF6F3F3),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: Navigator.of(context).pop,
          ),
          centerTitle: true,
          title: Text(S.current.settings),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ForwardButton(
                      onTap: _switchLanguage,
                      text: 'Common Language',
                    ),
                    ForwardButton(
                      onTap: _switchGender,
                      text: 'Gender',
                    ),
                    ForwardButton(
                      onTap: _deleteAccount,
                      text: 'Delete Account',
                      color: Theme.of(context).disabledColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }

  Future _deleteAccount() async {
    final warningConfirm = await _showWarningConfirm();
    bool? finalConfirm;
    if (warningConfirm == true) {
      if (ref.read(myProfileProvider)!.isMember) {
        finalConfirm = await _showFinalConfirm();
      } else {
        finalConfirm = true;
      }
      if (finalConfirm == true) {
        final resp = await deleteAccount();
        if (resp.statusCode == 0) {
          await appCommonBox.clear();
          if (mounted) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
          ref.read(tokenProvider.notifier).state = null;
        }
      }
    }
  }

  Future<bool?> _showWarningConfirm() {
    return showConfirm(
      context: context,
      title: 'Delete Account',
      confirmDelay: const Duration(seconds: 2),
      content: 'Deleting your account is permanent.\nAll your data will be deleted and can\'t be recovered.\nAre you sure you want to proceed?',
      confirmText: 'Delete',
    );
  }

  Future<bool?> _showFinalConfirm() {
    return showConfirm(
        context: context,
        title: 'Delete Account',
        content: 'Your account will be automatically deleted in 14 days.\n\nPlease remember to go to the store to cancel your current subscription to avoid additional charges.',
        confirmText: 'Got it',
        cancelText: 'Keep Account'
    );
  }

  Future _switchLanguage() async {
    var value = await showLocalePicker(context: context, initialValue: ref.read(myProfileProvider)!.locale);
    if (value != null) {
      await ref.read(myProfileProvider.notifier).updateField(locale: findMatchedSonaLocale(value));
      ref.invalidate(asyncPopularTravelCountriesProvider);
      ref.invalidate(asyncTimeframeOptionsProvider);
      ref.invalidate(asyncMyTravelWishesProvider);
    }
  }

  Future _switchGender() async {
    var value = await showGenderPicker(context: context, initialValue: ref.read(myProfileProvider)!.gender);
    if (value != null) {
      await ref.read(myProfileProvider.notifier).updateField(gender: value);
    }
  }
}