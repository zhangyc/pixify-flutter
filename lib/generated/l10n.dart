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

  /// `What’s your number?`
  String get userPhoneNumberPageTitle {
    return Intl.message(
      'What’s your number?',
      name: 'userPhoneNumberPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get userPhoneNumberPagePlaceholder {
    return Intl.message(
      'Phone Number',
      name: 'userPhoneNumberPagePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get nextButton {
    return Intl.message(
      'Next',
      name: 'nextButton',
      desc: '',
      args: [],
    );
  }

  /// `By tapping "Next Step", you agree to our `
  String get userPhoneNumberPageTermsPrefix {
    return Intl.message(
      'By tapping "Next Step", you agree to our ',
      name: 'userPhoneNumberPageTermsPrefix',
      desc: '',
      args: [],
    );
  }

  /// `terms of service`
  String get userPhoneNumberPageTermsText {
    return Intl.message(
      'terms of service',
      name: 'userPhoneNumberPageTermsText',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get userPhoneNumberPageTermsAnd {
    return Intl.message(
      ' and ',
      name: 'userPhoneNumberPageTermsAnd',
      desc: '',
      args: [],
    );
  }

  /// `privacy policy`
  String get userPhoneNumberPagePrivacyText {
    return Intl.message(
      'privacy policy',
      name: 'userPhoneNumberPagePrivacyText',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get userPhoneNumberPagePrivacySuffix {
    return Intl.message(
      '',
      name: 'userPhoneNumberPagePrivacySuffix',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get selectCountryPageTitle {
    return Intl.message(
      'Select Country',
      name: 'selectCountryPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter verification code we‘ve just sent`
  String get verifyCodePageTitle {
    return Intl.message(
      'Enter verification code we‘ve just sent',
      name: 'verifyCodePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resendButton {
    return Intl.message(
      'Resend',
      name: 'resendButton',
      desc: '',
      args: [],
    );
  }

  /// `Introduce yourself`
  String get userInfoPageTitle {
    return Intl.message(
      'Introduce yourself',
      name: 'userInfoPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get userNameInputLabel {
    return Intl.message(
      'Name',
      name: 'userNameInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `Day of birth`
  String get userBirthdayInputLabel {
    return Intl.message(
      'Day of birth',
      name: 'userBirthdayInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get userGenderInputLabel {
    return Intl.message(
      'Gender',
      name: 'userGenderInputLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get userInfoPageNamePlaceholder {
    return Intl.message(
      'Enter',
      name: 'userInfoPageNamePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get choosePlaceholder {
    return Intl.message(
      'Choose',
      name: 'choosePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Your gender will not be shown public, it only be used to help for match`
  String get userGenderPickerSubtitle {
    return Intl.message(
      'Your gender will not be shown public, it only be used to help for match',
      name: 'userGenderPickerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get userGenderOptionMale {
    return Intl.message(
      'Male',
      name: 'userGenderOptionMale',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get userGenderOptionFemale {
    return Intl.message(
      'Female',
      name: 'userGenderOptionFemale',
      desc: '',
      args: [],
    );
  }

  /// `Non-binary`
  String get userGenderOptionNonBinary {
    return Intl.message(
      'Non-binary',
      name: 'userGenderOptionNonBinary',
      desc: '',
      args: [],
    );
  }

  /// `Show Yourself`
  String get userAvatarPageTitle {
    return Intl.message(
      'Show Yourself',
      name: 'userAvatarPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `A good portrait gets you more matches. Keep it real and use a legit pic of yourself.`
  String get userAvatarPageSubtitle {
    return Intl.message(
      'A good portrait gets you more matches. Keep it real and use a legit pic of yourself.',
      name: 'userAvatarPageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `From gallery`
  String get userAvatarOptionGallery {
    return Intl.message(
      'From gallery',
      name: 'userAvatarOptionGallery',
      desc: '',
      args: [],
    );
  }

  /// `Take a photo`
  String get userAvatarOptionCamera {
    return Intl.message(
      'Take a photo',
      name: 'userAvatarOptionCamera',
      desc: '',
      args: [],
    );
  }

  /// `Upload done!`
  String get userAvatarUploadedLabel {
    return Intl.message(
      'Upload done!',
      name: 'userAvatarUploadedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get userAvatarPageChangeButton {
    return Intl.message(
      'Change',
      name: 'userAvatarPageChangeButton',
      desc: '',
      args: [],
    );
  }

  /// `Authorize location`
  String get locationPermissionRequestTitle {
    return Intl.message(
      'Authorize location',
      name: 'locationPermissionRequestTitle',
      desc: '',
      args: [],
    );
  }

  /// `Find foreigners in the same city`
  String get locationPermissionRequestSubtitle {
    return Intl.message(
      'Find foreigners in the same city',
      name: 'locationPermissionRequestSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Last step`
  String get signUpLastStepPageTitle {
    return Intl.message(
      'Last step',
      name: 'signUpLastStepPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Common language`
  String get commonLanguageTitle {
    return Intl.message(
      'Common language',
      name: 'commonLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Citizen of`
  String get userCitizenshipPickerTitle {
    return Intl.message(
      'Citizen of',
      name: 'userCitizenshipPickerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Once confirmed, citizenship cannot be changed`
  String get userCitizenshipPickerSubtitle {
    return Intl.message(
      'Once confirmed, citizenship cannot be changed',
      name: 'userCitizenshipPickerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get doneButton {
    return Intl.message(
      'Done',
      name: 'doneButton',
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
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'GB'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'PT'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
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
