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

  /// `Which`
  String get wishCountryPickerTitle {
    return Intl.message(
      'Which',
      name: 'wishCountryPickerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Country's peeps you vibin' with?`
  String get wishCountryPickerSubtitle {
    return Intl.message(
      'Country\'s peeps you vibin\' with?',
      name: 'wishCountryPickerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `if you go there, Which cities do you want to visit?`
  String get wishCityPickerSubtitle {
    return Intl.message(
      'if you go there, Which cities do you want to visit?',
      name: 'wishCityPickerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Skip, Just {country}`
  String wishCityPickerSkipButton(Object country) {
    return Intl.message(
      'Skip, Just $country',
      name: 'wishCityPickerSkipButton',
      desc: '',
      args: [country],
    );
  }

  /// `When`
  String get wishDatePickerTitle {
    return Intl.message(
      'When',
      name: 'wishDatePickerTitle',
      desc: '',
      args: [],
    );
  }

  /// `are you planning to go to {country}`
  String wishDatePickerSubtitle(Object country) {
    return Intl.message(
      'are you planning to go to $country',
      name: 'wishDatePickerSubtitle',
      desc: '',
      args: [country],
    );
  }

  /// `Already here`
  String get wishDateOptionHere {
    return Intl.message(
      'Already here',
      name: 'wishDateOptionHere',
      desc: '',
      args: [],
    );
  }

  /// `Recently, I guess`
  String get wishDateOptionRecent {
    return Intl.message(
      'Recently, I guess',
      name: 'wishDateOptionRecent',
      desc: '',
      args: [],
    );
  }

  /// `Within a year`
  String get wishDateOptionYear {
    return Intl.message(
      'Within a year',
      name: 'wishDateOptionYear',
      desc: '',
      args: [],
    );
  }

  /// `Not sure yet`
  String get wishDateOptionNotSure {
    return Intl.message(
      'Not sure yet',
      name: 'wishDateOptionNotSure',
      desc: '',
      args: [],
    );
  }

  /// `Wanna do something?`
  String get wishActivityPickerTitle {
    return Intl.message(
      'Wanna do something?',
      name: 'wishActivityPickerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Help you find companions`
  String get wishActivityPickerSubtitle {
    return Intl.message(
      'Help you find companions',
      name: 'wishActivityPickerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Add your thought`
  String get wishActivityAddTitle {
    return Intl.message(
      'Add your thought',
      name: 'wishActivityAddTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your wish has been received!`
  String get wishCreationComplete {
    return Intl.message(
      'Your wish has been received!',
      name: 'wishCreationComplete',
      desc: '',
      args: [],
    );
  }

  /// `SONA is finding some potential friend...`
  String get firstLandingLoadingTitle {
    return Intl.message(
      'SONA is finding some potential friend...',
      name: 'firstLandingLoadingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Wishes`
  String get wishes {
    return Intl.message(
      'Wishes',
      name: 'wishes',
      desc: '',
      args: [],
    );
  }

  /// `Interests`
  String get interests {
    return Intl.message(
      'Interests',
      name: 'interests',
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

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Which of {gender, select, male {his} female {her} other {their}} ideas do you like?`
  String matchPageSelectIdeas(String gender) {
    return Intl.message(
      'Which of ${Intl.gender(gender, male: 'his', female: 'her', other: 'their')} ideas do you like?',
      name: 'matchPageSelectIdeas',
      desc: '',
      args: [gender],
    );
  }

  /// `Just Send a Like`
  String get justSendALike {
    return Intl.message(
      'Just Send a Like',
      name: 'justSendALike',
      desc: '',
      args: [],
    );
  }

  /// `DM`
  String get dm {
    return Intl.message(
      'DM',
      name: 'dm',
      desc: '',
      args: [],
    );
  }

  /// `Wanna holla at...`
  String get wannaHollaAt {
    return Intl.message(
      'Wanna holla at...',
      name: 'wannaHollaAt',
      desc: '',
      args: [],
    );
  }

  /// `Let SONA say hi for you`
  String get letSONASayHiForYou {
    return Intl.message(
      'Let SONA say hi for you',
      name: 'letSONASayHiForYou',
      desc: '',
      args: [],
    );
  }

  /// `I’m very interested in ‘{something}’!`
  String imVeryInterestedInSomething(Object something) {
    return Intl.message(
      'I’m very interested in ‘$something’!',
      name: 'imVeryInterestedInSomething',
      desc: '',
      args: [something],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Preference`
  String get preference {
    return Intl.message(
      'Preference',
      name: 'preference',
      desc: '',
      args: [],
    );
  }

  /// `Wish List`
  String get wishList {
    return Intl.message(
      'Wish List',
      name: 'wishList',
      desc: '',
      args: [],
    );
  }

  /// `People from your wishlist get more recommendations`
  String get peopleFromYourWishlistGetMoreRecommendations {
    return Intl.message(
      'People from your wishlist get more recommendations',
      name: 'peopleFromYourWishlistGetMoreRecommendations',
      desc: '',
      args: [],
    );
  }

  /// `Nearby`
  String get nearby {
    return Intl.message(
      'Nearby',
      name: 'nearby',
      desc: '',
      args: [],
    );
  }

  /// `Running into foreigners near you`
  String get runningIntoForeignersNearYou {
    return Intl.message(
      'Running into foreigners near you',
      name: 'runningIntoForeignersNearYou',
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

  /// `Sona Recommendation: Cooldown\nWhat to do: Wait\nSuggestion: Watch a movie?`
  String get sonaRecommendationCooldown {
    return Intl.message(
      'Sona Recommendation: Cooldown\nWhat to do: Wait\nSuggestion: Watch a movie?',
      name: 'sonaRecommendationCooldown',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Oops, no data right now`
  String get oopsNoDataRightNow {
    return Intl.message(
      'Oops, no data right now',
      name: 'oopsNoDataRightNow',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet or Tap to Refresh and try again`
  String get pleaseCheckYourInternetOrTapToRefreshAndTryAgain {
    return Intl.message(
      'Please check your internet or Tap to Refresh and try again',
      name: 'pleaseCheckYourInternetOrTapToRefreshAndTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Block this person so you won't receive any messages from them`
  String get blockThisPersonSoYouWontReceiveAnyMessagesFromThem {
    return Intl.message(
      'Block this person so you won\'t receive any messages from them',
      name: 'blockThisPersonSoYouWontReceiveAnyMessagesFromThem',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelButton {
    return Intl.message(
      'Cancel',
      name: 'cancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Gore`
  String get gore {
    return Intl.message(
      'Gore',
      name: 'gore',
      desc: '',
      args: [],
    );
  }

  /// `Pornography`
  String get pornography {
    return Intl.message(
      'Pornography',
      name: 'pornography',
      desc: '',
      args: [],
    );
  }

  /// `Scam`
  String get scam {
    return Intl.message(
      'Scam',
      name: 'scam',
      desc: '',
      args: [],
    );
  }

  /// `Personal Attack`
  String get personalAttack {
    return Intl.message(
      'Personal Attack',
      name: 'personalAttack',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Screenshot evidence`
  String get screenshotEvidence {
    return Intl.message(
      'Screenshot evidence',
      name: 'screenshotEvidence',
      desc: '',
      args: [],
    );
  }

  /// `Description (optional)`
  String get descriptionOptional {
    return Intl.message(
      'Description (optional)',
      name: 'descriptionOptional',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submitButton {
    return Intl.message(
      'Submit',
      name: 'submitButton',
      desc: '',
      args: [],
    );
  }

  /// `Who likes you`
  String get whoLIkesYou {
    return Intl.message(
      'Who likes you',
      name: 'whoLIkesYou',
      desc: '',
      args: [],
    );
  }

  /// `Liked you`
  String get likedYou {
    return Intl.message(
      'Liked you',
      name: 'likedYou',
      desc: '',
      args: [],
    );
  }

  /// `"I'm interested in {something}"`
  String imInterestedSomething(Object something) {
    return Intl.message(
      '"I\'m interested in $something"',
      name: 'imInterestedSomething',
      desc: '',
      args: [something],
    );
  }

  /// `👆 They're waiting for your reply`
  String get theyAreWaitingForYourReply {
    return Intl.message(
      '👆 They\'re waiting for your reply',
      name: 'theyAreWaitingForYourReply',
      desc: '',
      args: [],
    );
  }

  /// `Check out their profiles`
  String get likedPageMonetizeButton {
    return Intl.message(
      'Check out their profiles',
      name: 'likedPageMonetizeButton',
      desc: '',
      args: [],
    );
  }

  /// `Status: No likes yet\n\nWhat to do: Take the initiative\n\nSuggestion:\n"Self-portraits in light,\nA genuine bio's insight,\nInterests ignite."\n\nEmm..I mean...\nUpload some nice photos\nWrite a genuine bio\nPick your interests`
  String get likedPageNoData {
    return Intl.message(
      'Status: No likes yet\n\nWhat to do: Take the initiative\n\nSuggestion:\n"Self-portraits in light,\nA genuine bio\'s insight,\nInterests ignite."\n\nEmm..I mean...\nUpload some nice photos\nWrite a genuine bio\nPick your interests',
      name: 'likedPageNoData',
      desc: '',
      args: [],
    );
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

  /// `Who likes you`
  String get whoLikesU {
    return Intl.message(
      'Who likes you',
      name: 'whoLikesU',
      desc: '',
      args: [],
    );
  }

  /// `Check out their profiles`
  String get checkOutTheirProfiles {
    return Intl.message(
      'Check out their profiles',
      name: 'checkOutTheirProfiles',
      desc: '',
      args: [],
    );
  }

  /// `New Matched!`
  String get newMatch {
    return Intl.message(
      'New Matched!',
      name: 'newMatch',
      desc: '',
      args: [],
    );
  }

  /// `Status: No messages\n\nWhat to do: Go to match\n\nSuggestion: Make an awesome profile`
  String get noMessageTips {
    return Intl.message(
      'Status: No messages\n\nWhat to do: Go to match\n\nSuggestion: Make an awesome profile',
      name: 'noMessageTips',
      desc: '',
      args: [],
    );
  }

  /// `See who likes you`
  String get seeWhoLikeU {
    return Intl.message(
      'See who likes you',
      name: 'seeWhoLikeU',
      desc: '',
      args: [],
    );
  }

  /// `Have SONA Say Hi`
  String get haveSonaSayHi {
    return Intl.message(
      'Have SONA Say Hi',
      name: 'haveSonaSayHi',
      desc: '',
      args: [],
    );
  }

  /// `Just type in {lang}`
  String justTypeInYourLanguage(Object lang) {
    return Intl.message(
      'Just type in $lang',
      name: 'justTypeInYourLanguage',
      desc: '',
      args: [lang],
    );
  }

  /// `You seem cool`
  String get youSeemCool {
    return Intl.message(
      'You seem cool',
      name: 'youSeemCool',
      desc: '',
      args: [],
    );
  }

  /// `I like your style!`
  String get iLikeYourStyle {
    return Intl.message(
      'I like your style!',
      name: 'iLikeYourStyle',
      desc: '',
      args: [],
    );
  }

  /// `I dig your energy!`
  String get iDigYourEnergy {
    return Intl.message(
      'I dig your energy!',
      name: 'iDigYourEnergy',
      desc: '',
      args: [],
    );
  }

  /// `Hey, I think you're pretty awesome. How about we hit it off as friends?`
  String get friendsIntention {
    return Intl.message(
      'Hey, I think you\'re pretty awesome. How about we hit it off as friends?',
      name: 'friendsIntention',
      desc: '',
      args: [],
    );
  }

  /// `🔨🔨🔨 Don't mind me🔨🔨🔨 I'm just here to break the ice🔨🔨🔨`
  String get breakIce {
    return Intl.message(
      '🔨🔨🔨 Don\'t mind me🔨🔨🔨 I\'m just here to break the ice🔨🔨🔨',
      name: 'breakIce',
      desc: '',
      args: [],
    );
  }

  /// `Hey, guess who's gonna break the silence first?`
  String get guessWhoBreakSilence {
    return Intl.message(
      'Hey, guess who\'s gonna break the silence first?',
      name: 'guessWhoBreakSilence',
      desc: '',
      args: [],
    );
  }

  /// `See profile`
  String get seeProfile {
    return Intl.message(
      'See profile',
      name: 'seeProfile',
      desc: '',
      args: [],
    );
  }

  /// `Unmatch`
  String get buttonUnmatch {
    return Intl.message(
      'Unmatch',
      name: 'buttonUnmatch',
      desc: '',
      args: [],
    );
  }

  /// `AI Interpretation: On`
  String get interpretationOn {
    return Intl.message(
      'AI Interpretation: On',
      name: 'interpretationOn',
      desc: '',
      args: [],
    );
  }

  /// `AI Interpretation: Off`
  String get interpretationOff {
    return Intl.message(
      'AI Interpretation: Off',
      name: 'interpretationOff',
      desc: '',
      args: [],
    );
  }

  /// `After unmatching, all your chat history will be deleted.`
  String get warningUnmatching {
    return Intl.message(
      'After unmatching, all your chat history will be deleted.',
      name: 'warningUnmatching',
      desc: '',
      args: [],
    );
  }

  /// `⭕ SONA interpretation is turned off`
  String get sonaInterpretationOff {
    return Intl.message(
      '⭕ SONA interpretation is turned off',
      name: 'sonaInterpretationOff',
      desc: '',
      args: [],
    );
  }

  /// `🤝 You guys speak the same language`
  String get speakSameLanguage {
    return Intl.message(
      '🤝 You guys speak the same language',
      name: 'speakSameLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get buttonCopy {
    return Intl.message(
      'Copy',
      name: 'buttonCopy',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get buttonDelete {
    return Intl.message(
      'Delete',
      name: 'buttonDelete',
      desc: '',
      args: [],
    );
  }

  /// `How do you feel about AI interpretation?`
  String get howDoUFeelAboutAI {
    return Intl.message(
      'How do you feel about AI interpretation?',
      name: 'howDoUFeelAboutAI',
      desc: '',
      args: [],
    );
  }

  /// `Unsent. SONA will not translate prohibited words`
  String get exceptionSonaContentFilterTips {
    return Intl.message(
      'Unsent. SONA will not translate prohibited words',
      name: 'exceptionSonaContentFilterTips',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send, please try again later.`
  String get exceptionFailedToSendTips {
    return Intl.message(
      'Failed to send, please try again later.',
      name: 'exceptionFailedToSendTips',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get buttonResend {
    return Intl.message(
      'Resend',
      name: 'buttonResend',
      desc: '',
      args: [],
    );
  }

  /// `SONA is overloaded, please try again later.`
  String get exceptionSonaOverloadedTips {
    return Intl.message(
      'SONA is overloaded, please try again later.',
      name: 'exceptionSonaOverloadedTips',
      desc: '',
      args: [],
    );
  }

  /// `Caution`
  String get warningTitleCaution {
    return Intl.message(
      'Caution',
      name: 'warningTitleCaution',
      desc: '',
      args: [],
    );
  }

  /// `External link. Verify source is trustworthy before tapping, as unknown links may be scams or steal data. Proceed with caution.`
  String get warningOpenExternalLink {
    return Intl.message(
      'External link. Verify source is trustworthy before tapping, as unknown links may be scams or steal data. Proceed with caution.',
      name: 'warningOpenExternalLink',
      desc: '',
      args: [],
    );
  }

  /// `Open Link`
  String get buttonOpenLink {
    return Intl.message(
      'Open Link',
      name: 'buttonOpenLink',
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
