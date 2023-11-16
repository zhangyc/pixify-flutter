// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Match`
  String get match {
    return Intl.message(
      'Match',
      name: 'match',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `oOps, no data right now `
  String get noDataTips {
    return Intl.message(
      'oOps, no data right now ',
      name: 'noDataTips',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet or Tap to Refresh and try again`
  String get checkInternet {
    return Intl.message(
      'Please check your internet or Tap to Refresh and try again',
      name: 'checkInternet',
      desc: '',
      args: [],
    );
  }

  /// `BECOMING SUPER SONA`
  String get sonaTitle {
    return Intl.message(
      'BECOMING SUPER SONA',
      name: 'sonaTitle',
      desc: '',
      args: [],
    );
  }

  /// `YOU’RE SUPER SONA`
  String get superSonaTitle {
    return Intl.message(
      'YOU’RE SUPER SONA',
      name: 'superSonaTitle',
      desc: '',
      args: [],
    );
  }

  /// `UPGRADE`
  String get upgrade {
    return Intl.message(
      'UPGRADE',
      name: 'upgrade',
      desc: '',
      args: [],
    );
  }

  /// `100 Sona messages`
  String get powerSonaMessage {
    return Intl.message(
      '100 Sona messages',
      name: 'powerSonaMessage',
      desc: '',
      args: [],
    );
  }

  /// `daily`
  String get daily {
    return Intl.message(
      'daily',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `Unlock to see`
  String get powerUnlock {
    return Intl.message(
      'Unlock to see',
      name: 'powerUnlock',
      desc: '',
      args: [],
    );
  }

  /// `who liked me`
  String get powerWhoLike {
    return Intl.message(
      'who liked me',
      name: 'powerWhoLike',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited`
  String get unlimited {
    return Intl.message(
      'Unlimited',
      name: 'unlimited',
      desc: '',
      args: [],
    );
  }

  /// `Likes`
  String get likes {
    return Intl.message(
      'Likes',
      name: 'likes',
      desc: '',
      args: [],
    );
  }

  /// `Arrows -1 `
  String get arrow {
    return Intl.message(
      'Arrows -1 ',
      name: 'arrow',
      desc: '',
      args: [],
    );
  }

  /// `Message people you like directly`
  String get arrowInfo {
    return Intl.message(
      'Message people you like directly',
      name: 'arrowInfo',
      desc: '',
      args: [],
    );
  }

  /// `Strategy - `
  String get strategy {
    return Intl.message(
      'Strategy - ',
      name: 'strategy',
      desc: '',
      args: [],
    );
  }

  /// `Get advice from Sona anytime`
  String get strategyInfo {
    return Intl.message(
      'Get advice from Sona anytime',
      name: 'strategyInfo',
      desc: '',
      args: [],
    );
  }

  /// `Chat Styles - `
  String get chatStyle {
    return Intl.message(
      'Chat Styles - ',
      name: 'chatStyle',
      desc: '',
      args: [],
    );
  }

  /// `Unlock 6 chat styles`
  String get chatStyleInfo {
    return Intl.message(
      'Unlock 6 chat styles',
      name: 'chatStyleInfo',
      desc: '',
      args: [],
    );
  }

  /// `people liked you`
  String get homeWhoLikeMe {
    return Intl.message(
      'people liked you',
      name: 'homeWhoLikeMe',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `Let\'s see who likes you`
  String get homeGoToWhoLike {
    return Intl.message(
      'Let\\\'s see who likes you',
      name: 'homeGoToWhoLike',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Block`
  String get block {
    return Intl.message(
      'Block',
      name: 'block',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
