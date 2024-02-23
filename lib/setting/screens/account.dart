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
import 'package:image/image.dart' as img;

import '../../generated/l10n.dart';
import '../../utils/dialog/input.dart';
import 'package:sona/core/match/screens/match.dart';
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
          title: Text(S.of(context).account),
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
                      text: S.of(context).commonLanguage,
                    ),
                    ForwardButton(
                      onTap: _switchGender,
                      text: S.of(context).userGenderInputLabel,
                    ),
                    ForwardButton(
                      onTap: _deleteAccount,
                      text: S.of(context).buttonDeleteAccount,
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
      title: S.of(context).buttonDeleteAccount,
      confirmDelay: const Duration(seconds: 15),
      content: S.of(context).warningDeleteAccount,
      confirmText: S.of(context).buttonDelete,
    );
  }

  Future<bool?> _showFinalConfirm() {
    return showConfirm(
        context: context,
        title: S.of(context).buttonDeleteAccount,
        content: S.of(context).warningCancelSubscription,
        confirmText: S.of(context).buttonGotIt,
        cancelText: S.of(context).buttonKeepAccount
    );
  }

  Future _switchLanguage() async {
    String? local = ref.read(myProfileProvider)!.locale;
    var value = await showLocalePicker(context: context, initialValue: local);
    if (value != null) {
      languageNotifier.value=findMatchedSonaLocale(value);
      await ref.read(myProfileProvider.notifier).updateFields(locale: findMatchedSonaLocale(value));
      ref.invalidate(asyncPopularTravelCountriesProvider);
      ref.invalidate(asyncTimeframeOptionsProvider);
      ref.invalidate(asyncMyTravelWishesProvider);
    }
  }

  Future _switchGender() async {
    var value = await showGenderPicker(context: context, initialValue: ref.read(myProfileProvider)!.gender);
    if (value != null) {
      await ref.read(myProfileProvider.notifier).updateFields(gender: value);
    }
  }
}