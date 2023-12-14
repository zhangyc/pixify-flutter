import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sona/account/providers/profile.dart';
import 'package:sona/common/services/common.dart';
import 'package:sona/core/travel_wish/models/country.dart';
import 'package:sona/core/travel_wish/screens/travel_wish_creator.dart';
import 'package:sona/utils/dialog/input.dart';
import 'package:sona/utils/locale/locale.dart';
import 'package:sona/utils/picker/country/country.dart';

import '../../generated/l10n.dart';
import '../models/gender.dart';


class NationAndLanguageScreen extends StatefulHookConsumerWidget {
  const NationAndLanguageScreen({
    super.key,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.avatar,
    required this.location,
    required this.country
  });
  final String name;
  final DateTime birthday;
  final Gender gender;
  final Uint8List avatar;
  final Position location;
  final SonaCountry country;

  @override
  ConsumerState<StatefulHookConsumerWidget> createState() => _NationAndLanguageScreenState();
}

class _NationAndLanguageScreenState extends ConsumerState<NationAndLanguageScreen> {

  SonaCountry? _nation;
  String? _language;

  @override
  void initState() {
    _language = findMatchedSonaLocale(Intl.canonicalizedLocale(Platform.localeName)).locale.toLanguageTag();
    _nation = widget.country;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: false,
      extendBodyBehindAppBar: true,
      body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: MediaQuery.of(context).viewPadding.top + 16,
                bottom: 160
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    S.current.signUpLastStepPageTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    final value = await showLocalePicker(
                        context: context,
                        initialValue: _language,
                        dismissible: true
                    );
                    if (value != null) {
                      setState(() {
                        _language = value;
                      });
                    }
                  },
                  child: Container(
                      height: 64,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_language != null) Text(
                              findMatchedSonaLocale(_language!).displayName,
                              style: Theme.of(context).textTheme.bodyMedium
                          ) else Text(
                            S.current.commonLanguageTitle,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).hintColor
                            ),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      )
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    final value = await showCountryPicker(
                        context: context,
                        initialValue: _nation,
                        dismissible: _nation != null
                    );
                    if (value != null) {
                      setState(() {
                        _nation = value;
                      });
                    }
                  },
                  child: Container(
                      height: 64,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_nation != null) Text(
                              '${_nation!.flag} ${_nation!.displayName}',
                              style: Theme.of(context).textTheme.bodyMedium
                          ) else Text(
                            S.current.userCitizenshipPickerTitle,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).hintColor
                            ),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      )
                  ),
                ),
              ],
            ),
          )
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.current.userCitizenshipPickerSubtitle, style: Theme.of(context).textTheme.labelSmall),
            SizedBox(height: 16),
            FilledButton(
              child: Text(S.current.nextButton),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).primaryColor
                  )
              ),
              onPressed: _next,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _next() async {
    if (_nation == null || _language == null) return;
    String? url;
    try {
      EasyLoading.show();
      url = await uploadImage(bytes: widget.avatar);
    } catch (e) {
      if (kDebugMode) print('upload avatar error: $e');
      EasyLoading.dismiss();
      return;
    }
    try {
      await ref.read(myProfileProvider.notifier).updateField(
        name: widget.name,
        birthday: widget.birthday,
        gender: widget.gender,
        avatar: url,
        position: widget.location,
        locale: findMatchedSonaLocale(_language!),
        countryCode: _nation!.code
      );
      EasyLoading.dismiss();
      if (!mounted) return;
      await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => TravelWishCreator()), (_) => false);
    } catch (e) {
      //
    } finally {
      EasyLoading.dismiss();
    }
  }
}