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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
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
  String get buttonNext {
    return Intl.message('Next', name: 'buttonNext', desc: '', args: []);
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

  /// ` `
  String get userPhoneNumberPagePrivacySuffix {
    return Intl.message(
      ' ',
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
  String get buttonResend {
    return Intl.message('Resend', name: 'buttonResend', desc: '', args: []);
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
    return Intl.message('Name', name: 'userNameInputLabel', desc: '', args: []);
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
  String get buttonChange {
    return Intl.message('Change', name: 'buttonChange', desc: '', args: []);
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

  /// `We need your location to make your social experience better`
  String get locationPermissionRequestSubtitle {
    return Intl.message(
      'We need your location to make your social experience better',
      name: 'locationPermissionRequestSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Almost done`
  String get signUpLastStepPageTitle {
    return Intl.message(
      'Almost done',
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
  String get buttonDone {
    return Intl.message('Done', name: 'buttonDone', desc: '', args: []);
  }

  /// `Which Country are you more interested in?`
  String get wishCountryPickerTitle {
    return Intl.message(
      'Which Country are you more interested in?',
      name: 'wishCountryPickerTitle',
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

  /// `AstroPair is finding some potential friend...`
  String get firstLandingLoadingTitle {
    return Intl.message(
      'AstroPair is finding some potential friend...',
      name: 'firstLandingLoadingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Wishes`
  String get wishes {
    return Intl.message('Wishes', name: 'wishes', desc: '', args: []);
  }

  /// `Interests`
  String get interests {
    return Intl.message('Interests', name: 'interests', desc: '', args: []);
  }

  /// `Block`
  String get block {
    return Intl.message('Block', name: 'block', desc: '', args: []);
  }

  /// `Report`
  String get report {
    return Intl.message('Report', name: 'report', desc: '', args: []);
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
    return Intl.message('DM', name: 'dm', desc: '', args: []);
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

  /// `Let AstroPair say hi for you`
  String get letAstroPairSayHiForYou {
    return Intl.message(
      'Let AstroPair say hi for you',
      name: 'letAstroPairSayHiForYou',
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
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  /// `Preference`
  String get preference {
    return Intl.message('Preference', name: 'preference', desc: '', args: []);
  }

  /// `Wish List`
  String get wishList {
    return Intl.message('Wish List', name: 'wishList', desc: '', args: []);
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
    return Intl.message('Nearby', name: 'nearby', desc: '', args: []);
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
    return Intl.message('Age', name: 'age', desc: '', args: []);
  }

  /// `AstroPair Recommendation: Cooldown\nWhat to do: Wait\nSuggestion: Watch a movie?`
  String get astroPairRecommendationCooldown {
    return Intl.message(
      'AstroPair Recommendation: Cooldown\nWhat to do: Wait\nSuggestion: Watch a movie?',
      name: 'astroPairRecommendationCooldown',
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

  /// `Refresh`
  String get buttonRefresh {
    return Intl.message('Refresh', name: 'buttonRefresh', desc: '', args: []);
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
  String get buttonCancel {
    return Intl.message('Cancel', name: 'buttonCancel', desc: '', args: []);
  }

  /// `Gore`
  String get reportOptionGore {
    return Intl.message('Gore', name: 'reportOptionGore', desc: '', args: []);
  }

  /// `Pornography`
  String get reportOptionPornography {
    return Intl.message(
      'Pornography',
      name: 'reportOptionPornography',
      desc: '',
      args: [],
    );
  }

  /// `Scam`
  String get reportOptionScam {
    return Intl.message('Scam', name: 'reportOptionScam', desc: '', args: []);
  }

  /// `PerAstroPairl Attack`
  String get reportOptionPerAstroPairlAttack {
    return Intl.message(
      'PerAstroPairl Attack',
      name: 'reportOptionPerAstroPairlAttack',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get reportOptionOther {
    return Intl.message('Other', name: 'reportOptionOther', desc: '', args: []);
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
  String get buttonSubmit {
    return Intl.message('Submit', name: 'buttonSubmit', desc: '', args: []);
  }

  /// `All People`
  String get allPeople {
    return Intl.message('All People', name: 'allPeople', desc: '', args: []);
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
    return Intl.message('Liked you', name: 'likedYou', desc: '', args: []);
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
    return Intl.message('Chat', name: 'chat', desc: '', args: []);
  }

  /// `Who likes you`
  String get whoLikesU {
    return Intl.message('Who likes you', name: 'whoLikesU', desc: '', args: []);
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
    return Intl.message('New Matched!', name: 'newMatch', desc: '', args: []);
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

  /// `Have AstroPair Say Hi`
  String get haveAstroPairSayHi {
    return Intl.message(
      'Have AstroPair Say Hi',
      name: 'haveAstroPairSayHi',
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
    return Intl.message('See profile', name: 'seeProfile', desc: '', args: []);
  }

  /// `Unmatch`
  String get buttonUnmatch {
    return Intl.message('Unmatch', name: 'buttonUnmatch', desc: '', args: []);
  }

  /// `😪AstroPair is tired, 👇Tap to refuel her!`
  String get buttonHitAIInterpretationMaximumLimit {
    return Intl.message(
      '😪AstroPair is tired, 👇Tap to refuel her!',
      name: 'buttonHitAIInterpretationMaximumLimit',
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

  /// `⭕ AstroPair interpretation is turned off`
  String get astroPairInterpretationOff {
    return Intl.message(
      '⭕ AstroPair interpretation is turned off',
      name: 'astroPairInterpretationOff',
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
    return Intl.message('Copy', name: 'buttonCopy', desc: '', args: []);
  }

  /// `Delete`
  String get buttonDelete {
    return Intl.message('Delete', name: 'buttonDelete', desc: '', args: []);
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

  /// `Unsent. AstroPair will not translate prohibited words`
  String get exceptionAstroPairContentFilterTips {
    return Intl.message(
      'Unsent. AstroPair will not translate prohibited words',
      name: 'exceptionAstroPairContentFilterTips',
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

  /// `AstroPair is overloaded, please try again later.`
  String get exceptionAstroPairOverloadedTips {
    return Intl.message(
      'AstroPair is overloaded, please try again later.',
      name: 'exceptionAstroPairOverloadedTips',
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

  /// `Me`
  String get me {
    return Intl.message('Me', name: 'me', desc: '', args: []);
  }

  /// `Edit profile`
  String get buttonEditProfile {
    return Intl.message(
      'Edit profile',
      name: 'buttonEditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Get AstroPair Plus`
  String get getAstroPairPlus {
    return Intl.message(
      'Get AstroPair Plus',
      name: 'getAstroPairPlus',
      desc: '',
      args: [],
    );
  }

  /// `You're a Plus member`
  String get buttonAlreadyPlus {
    return Intl.message(
      'You\'re a Plus member',
      name: 'buttonAlreadyPlus',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get buttonPreview {
    return Intl.message('Preview', name: 'buttonPreview', desc: '', args: []);
  }

  /// `Photos`
  String get photos {
    return Intl.message('Photos', name: 'photos', desc: '', args: []);
  }

  /// `More photos, higher recommendation`
  String get morePhotosBenefit {
    return Intl.message(
      'More photos, higher recommendation',
      name: 'morePhotosBenefit',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message('Bio', name: 'bio', desc: '', args: []);
  }

  /// `Edit`
  String get buttonEdit {
    return Intl.message('Edit', name: 'buttonEdit', desc: '', args: []);
  }

  /// `Show your perAstroPairlity`
  String get showYourPerAstroPairlity {
    return Intl.message(
      'Show your perAstroPairlity',
      name: 'showYourPerAstroPairlity',
      desc: '',
      args: [],
    );
  }

  /// `Finding folks who share your interests`
  String get findingFolksWhoShareYourInterests {
    return Intl.message(
      'Finding folks who share your interests',
      name: 'findingFolksWhoShareYourInterests',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get buttonSave {
    return Intl.message('Save', name: 'buttonSave', desc: '', args: []);
  }

  /// `Get AstroPair Plus`
  String get subPageTitle {
    return Intl.message(
      'Get AstroPair Plus',
      name: 'subPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited Likes`
  String get plusFuncUnlimitedLikes {
    return Intl.message(
      'Unlimited Likes',
      name: 'plusFuncUnlimitedLikes',
      desc: '',
      args: [],
    );
  }

  /// `Unlock to see who likes you`
  String get plusFuncUnlockWhoLikesU {
    return Intl.message(
      'Unlock to see who likes you',
      name: 'plusFuncUnlockWhoLikesU',
      desc: '',
      args: [],
    );
  }

  /// `1000 AI Interpretation messages daily`
  String get plusFuncAIInterpretation {
    return Intl.message(
      '1000 AI Interpretation messages daily',
      name: 'plusFuncAIInterpretation',
      desc: '',
      args: [],
    );
  }

  /// `5 DM per week`
  String get plusFuncDMPerWeek {
    return Intl.message(
      '5 DM per week',
      name: 'plusFuncDMPerWeek',
      desc: '',
      args: [],
    );
  }

  /// `3 Wshes`
  String get plusFuncWishes {
    return Intl.message('3 Wshes', name: 'plusFuncWishes', desc: '', args: []);
  }

  /// `Filter matching Countries`
  String get plusFuncFilterMatchingCountries {
    return Intl.message(
      'Filter matching Countries',
      name: 'plusFuncFilterMatchingCountries',
      desc: '',
      args: [],
    );
  }

  /// `AstroPair Tips - Your chat advisor`
  String get plusFuncAstroPairTips {
    return Intl.message(
      'AstroPair Tips - Your chat advisor',
      name: 'plusFuncAstroPairTips',
      desc: '',
      args: [],
    );
  }

  /// `6 Months`
  String get sixMonths {
    return Intl.message('6 Months', name: 'sixMonths', desc: '', args: []);
  }

  /// `1 Year`
  String get aYear {
    return Intl.message('1 Year', name: 'aYear', desc: '', args: []);
  }

  /// `3 Months`
  String get threeMonths {
    return Intl.message('3 Months', name: 'threeMonths', desc: '', args: []);
  }

  /// `1 Month`
  String get aMonth {
    return Intl.message('1 Month', name: 'aMonth', desc: '', args: []);
  }

  /// `mo`
  String get month {
    return Intl.message('mo', name: 'month', desc: '', args: []);
  }

  /// `Standard`
  String get standard {
    return Intl.message('Standard', name: 'standard', desc: '', args: []);
  }

  /// `By tapping Continue, you will be charged, your subscription will auto-renew for the same price and package length until you cancel via  {storeName} settings, and you agree to our `
  String subscriptionAgreementPrefix(Object storeName) {
    return Intl.message(
      'By tapping Continue, you will be charged, your subscription will auto-renew for the same price and package length until you cancel via  $storeName settings, and you agree to our ',
      name: 'subscriptionAgreementPrefix',
      desc: '',
      args: [storeName],
    );
  }

  /// `Terms`
  String get subscriptionAgreement {
    return Intl.message(
      'Terms',
      name: 'subscriptionAgreement',
      desc: '',
      args: [],
    );
  }

  /// ` .`
  String get subscriptionAgreementSuffix {
    return Intl.message(
      ' .',
      name: 'subscriptionAgreementSuffix',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get buttonContinue {
    return Intl.message('Continue', name: 'buttonContinue', desc: '', args: []);
  }

  /// `Unlock to see\nwho likes you`
  String get subPageSubtitleUnlockWhoLikesU {
    return Intl.message(
      'Unlock to see\nwho likes you',
      name: 'subPageSubtitleUnlockWhoLikesU',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited Likes`
  String get subPageSubtitleUnlimitedLikes {
    return Intl.message(
      'Unlimited Likes',
      name: 'subPageSubtitleUnlimitedLikes',
      desc: '',
      args: [],
    );
  }

  /// `5 DM per week`
  String get subPageSubtitleDMWeekly {
    return Intl.message(
      '5 DM per week',
      name: 'subPageSubtitleDMWeekly',
      desc: '',
      args: [],
    );
  }

  /// `AstroPair Tips - \nYour chat advisor`
  String get subPageSubtitleAstroPairTips {
    return Intl.message(
      'AstroPair Tips - \nYour chat advisor',
      name: 'subPageSubtitleAstroPairTips',
      desc: '',
      args: [],
    );
  }

  /// `Filter matching \nCountries`
  String get subPageSubtitleFilterMatchingCountries {
    return Intl.message(
      'Filter matching \nCountries',
      name: 'subPageSubtitleFilterMatchingCountries',
      desc: '',
      args: [],
    );
  }

  /// `1000 AI \nInterpretation \nmessages daily`
  String get subPageSubtitleAIInterpretationDaily {
    return Intl.message(
      '1000 AI \nInterpretation \nmessages daily',
      name: 'subPageSubtitleAIInterpretationDaily',
      desc: '',
      args: [],
    );
  }

  /// `Manage`
  String get buttonManage {
    return Intl.message('Manage', name: 'buttonManage', desc: '', args: []);
  }

  /// `Next billing date`
  String get nextBilingDate {
    return Intl.message(
      'Next billing date',
      name: 'nextBilingDate',
      desc: '',
      args: [],
    );
  }

  /// `Unsubscribe`
  String get buttonUnsubscribe {
    return Intl.message(
      'Unsubscribe',
      name: 'buttonUnsubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Restore`
  String get buttonRestore {
    return Intl.message('Restore', name: 'buttonRestore', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Privacy`
  String get privacy {
    return Intl.message('Privacy', name: 'privacy', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Sign out`
  String get buttonSignOut {
    return Intl.message('Sign out', name: 'buttonSignOut', desc: '', args: []);
  }

  /// `Common language`
  String get commonLanguage {
    return Intl.message(
      'Common language',
      name: 'commonLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get buttonDeleteAccount {
    return Intl.message(
      'Delete account',
      name: 'buttonDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `If you delete your account, you won’t be able to log in with it anymore. are you sure want to delete?`
  String get warningDeleteAccount {
    return Intl.message(
      'If you delete your account, you won’t be able to log in with it anymore. are you sure want to delete?',
      name: 'warningDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get buttonConfirm {
    return Intl.message('Confirm', name: 'buttonConfirm', desc: '', args: []);
  }

  /// `Your account will be automatically deleted in 14 days. Please remember to go to the store to cancel your current subscription to avoid additional charges.`
  String get warningCancelSubscription {
    return Intl.message(
      'Your account will be automatically deleted in 14 days. Please remember to go to the store to cancel your current subscription to avoid additional charges.',
      name: 'warningCancelSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Got it`
  String get buttonGotIt {
    return Intl.message('Got it', name: 'buttonGotIt', desc: '', args: []);
  }

  /// `Keep account`
  String get buttonKeepAccount {
    return Intl.message(
      'Keep account',
      name: 'buttonKeepAccount',
      desc: '',
      args: [],
    );
  }

  /// `Push notifications`
  String get pushNotifications {
    return Intl.message(
      'Push notifications',
      name: 'pushNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Display my city`
  String get displayMyCity {
    return Intl.message(
      'Display my city',
      name: 'displayMyCity',
      desc: '',
      args: [],
    );
  }

  /// `When turned off, your city will not be displayed when matching`
  String get warningCancelDisplayCity {
    return Intl.message(
      'When turned off, your city will not be displayed when matching',
      name: 'warningCancelDisplayCity',
      desc: '',
      args: [],
    );
  }

  /// `The key is balance`
  String get theKeyIsBalance {
    return Intl.message(
      'The key is balance',
      name: 'theKeyIsBalance',
      desc: '',
      args: [],
    );
  }

  /// `Disclaimer`
  String get disclaimer {
    return Intl.message('Disclaimer', name: 'disclaimer', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message('Feedback', name: 'feedback', desc: '', args: []);
  }

  /// `👀You've hit your daily limit`
  String get toastHitDailyMaximumLimit {
    return Intl.message(
      '👀You\'ve hit your daily limit',
      name: 'toastHitDailyMaximumLimit',
      desc: '',
      args: [],
    );
  }

  /// `👅You've hit your weekly limit`
  String get toastHitWeeklyMaximumLimit {
    return Intl.message(
      '👅You\'ve hit your weekly limit',
      name: 'toastHitWeeklyMaximumLimit',
      desc: '',
      args: [],
    );
  }

  /// `Boost your appeal`
  String get boostYourAppeal {
    return Intl.message(
      'Boost your appeal',
      name: 'boostYourAppeal',
      desc: '',
      args: [],
    );
  }

  /// `More photos, More charm!`
  String get morePhotosMoreCharm {
    return Intl.message(
      'More photos, More charm!',
      name: 'morePhotosMoreCharm',
      desc: '',
      args: [],
    );
  }

  /// `AstroPair will generate a bio based on your interests`
  String get astroPairWillGenerateABioBasedOnInterests {
    return Intl.message(
      'AstroPair will generate a bio based on your interests',
      name: 'astroPairWillGenerateABioBasedOnInterests',
      desc: '',
      args: [],
    );
  }

  /// `Generate`
  String get buttonGenerate {
    return Intl.message('Generate', name: 'buttonGenerate', desc: '', args: []);
  }

  /// `Here's AstroPair cooked up for you!`
  String get hereAstroPairCookedUpForU {
    return Intl.message(
      'Here\'s AstroPair cooked up for you!',
      name: 'hereAstroPairCookedUpForU',
      desc: '',
      args: [],
    );
  }

  /// `You can edit it anytime`
  String get youCanEditItAnytime {
    return Intl.message(
      'You can edit it anytime',
      name: 'youCanEditItAnytime',
      desc: '',
      args: [],
    );
  }

  /// `Take It`
  String get takeIt {
    return Intl.message('Take It', name: 'takeIt', desc: '', args: []);
  }

  /// `No Thanks`
  String get noThanks {
    return Intl.message('No Thanks', name: 'noThanks', desc: '', args: []);
  }

  /// `From gallery`
  String get photoFromGallery {
    return Intl.message(
      'From gallery',
      name: 'photoFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Take a photo`
  String get photoFromCamera {
    return Intl.message(
      'Take a photo',
      name: 'photoFromCamera',
      desc: '',
      args: [],
    );
  }

  /// `Set Default`
  String get setDefault {
    return Intl.message('Set Default', name: 'setDefault', desc: '', args: []);
  }

  /// `AstroPair is like a home base for world citizens`
  String get onboarding0 {
    return Intl.message(
      'AstroPair is like a home base for world citizens',
      name: 'onboarding0',
      desc: '',
      args: [],
    );
  }

  /// `Whether at home or on the road, meet people worldwide. And...`
  String get onboarding1 {
    return Intl.message(
      'Whether at home or on the road, meet people worldwide. And...',
      name: 'onboarding1',
      desc: '',
      args: [],
    );
  }

  /// `You'll gain superpower:\nPolyglot\nNo more language worries`
  String get onboarding2 {
    return Intl.message(
      'You\'ll gain superpower:\nPolyglot\nNo more language worries',
      name: 'onboarding2',
      desc: '',
      args: [],
    );
  }

  /// `Talk less, Love more\nA legendary romance awaits you`
  String get onboarding3 {
    return Intl.message(
      'Talk less, Love more\nA legendary romance awaits you',
      name: 'onboarding3',
      desc: '',
      args: [],
    );
  }

  /// `Set your wishlist for\n better matching!`
  String get onboardingWish {
    return Intl.message(
      'Set your wishlist for\n better matching!',
      name: 'onboardingWish',
      desc: '',
      args: [],
    );
  }

  /// `They haven't shown their true self yet`
  String get profileNotShown {
    return Intl.message(
      'They haven\'t shown their true self yet',
      name: 'profileNotShown',
      desc: '',
      args: [],
    );
  }

  /// `💫 Send a star greeting to unlock album Continue`
  String get sendStarGreetingToUnlockAlbum {
    return Intl.message(
      '💫 Send a star greeting to unlock album Continue',
      name: 'sendStarGreetingToUnlockAlbum',
      desc: '',
      args: [],
    );
  }

  /// `Continue with phone`
  String get continueWithPhone {
    return Intl.message(
      'Continue with phone',
      name: 'continueWithPhone',
      desc: '',
      args: [],
    );
  }

  /// `Upload your photo`
  String get uploadYourPhoto {
    return Intl.message(
      'Upload your photo',
      name: 'uploadYourPhoto',
      desc: '',
      args: [],
    );
  }

  /// `What's your email?`
  String get whatsYourEmail {
    return Intl.message(
      'What\'s your email?',
      name: 'whatsYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Permission Required`
  String get permissionRequiredTitle {
    return Intl.message(
      'Permission Required',
      name: 'permissionRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `We need this permission to provide you with the best experience`
  String get permissionRequiredContent {
    return Intl.message(
      'We need this permission to provide you with the best experience',
      name: 'permissionRequiredContent',
      desc: '',
      args: [],
    );
  }

  /// `Go`
  String get buttonGo {
    return Intl.message('Go', name: 'buttonGo', desc: '', args: []);
  }

  /// `Show your personality`
  String get showYourPersonality {
    return Intl.message(
      'Show your personality',
      name: 'showYourPersonality',
      desc: '',
      args: [],
    );
  }

  /// `Just now`
  String get justNow {
    return Intl.message('Just now', name: 'justNow', desc: '', args: []);
  }

  /// `Duo Snap`
  String get duoSnap {
    return Intl.message('Duo Snap', name: 'duoSnap', desc: '', args: []);
  }

  /// `Catch more`
  String get catchMore {
    return Intl.message('Catch more', name: 'catchMore', desc: '', args: []);
  }

  /// `Unmissable special offer prices`
  String get unmissableSpecialOfferPrices {
    return Intl.message(
      'Unmissable special offer prices',
      name: 'unmissableSpecialOfferPrices',
      desc: '',
      args: [],
    );
  }

  /// `Check it out`
  String get checkItOut {
    return Intl.message('Check it out', name: 'checkItOut', desc: '', args: []);
  }

  /// `Issues`
  String get issues {
    return Intl.message('Issues', name: 'issues', desc: '', args: []);
  }

  /// `New gameplay`
  String get newGameplay {
    return Intl.message(
      'New gameplay',
      name: 'newGameplay',
      desc: '',
      args: [],
    );
  }

  /// `AI creating fun group pics`
  String get aiCreatingFunGroupPics {
    return Intl.message(
      'AI creating fun group pics',
      name: 'aiCreatingFunGroupPics',
      desc: '',
      args: [],
    );
  }

  /// `We need your location to show you nearby people`
  String get locationAuthorizeContent {
    return Intl.message(
      'We need your location to show you nearby people',
      name: 'locationAuthorizeContent',
      desc: '',
      args: [],
    );
  }

  /// `Authorize`
  String get buttonAuthorize {
    return Intl.message(
      'Authorize',
      name: 'buttonAuthorize',
      desc: '',
      args: [],
    );
  }

  /// `You are a club member now`
  String get youAreAClubMemberNow {
    return Intl.message(
      'You are a club member now',
      name: 'youAreAClubMemberNow',
      desc: '',
      args: [],
    );
  }

  /// `Unlock VIP perks`
  String get buttonUnlockVipPerks {
    return Intl.message(
      'Unlock VIP perks',
      name: 'buttonUnlockVipPerks',
      desc: '',
      args: [],
    );
  }

  /// `Personal Attack`
  String get reportOptionPersonalAttack {
    return Intl.message(
      'Personal Attack',
      name: 'reportOptionPersonalAttack',
      desc: '',
      args: [],
    );
  }

  /// `Join the Club`
  String get clubPromotionTitle {
    return Intl.message(
      'Join the Club',
      name: 'clubPromotionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Upload your best photo`
  String get uploadYourPhotoHint {
    return Intl.message(
      'Upload your best photo',
      name: 'uploadYourPhotoHint',
      desc: '',
      args: [],
    );
  }

  /// `Just kidding! It's free`
  String get clubFeeJoking {
    return Intl.message(
      'Just kidding! It\'s free',
      name: 'clubFeeJoking',
      desc: '',
      args: [],
    );
  }

  /// `Join Now`
  String get buttonJoinNow {
    return Intl.message('Join Now', name: 'buttonJoinNow', desc: '', args: []);
  }

  /// `Club fee: $99/month`
  String get clubFeePrefix {
    return Intl.message(
      'Club fee: \$99/month',
      name: 'clubFeePrefix',
      desc: '',
      args: [],
    );
  }

  /// `Members get exclusive perks`
  String get membersPerks {
    return Intl.message(
      'Members get exclusive perks',
      name: 'membersPerks',
      desc: '',
      args: [],
    );
  }

  /// `Join our exclusive club for amazing benefits`
  String get clubPromotionContent {
    return Intl.message(
      'Join our exclusive club for amazing benefits',
      name: 'clubPromotionContent',
      desc: '',
      args: [],
    );
  }

  /// `Duo Snap with Plus`
  String get plusPerkDuoSnap {
    return Intl.message(
      'Duo Snap with Plus',
      name: 'plusPerkDuoSnap',
      desc: '',
      args: [],
    );
  }

  /// `We need your real photo`
  String get requireYourRealPhoto {
    return Intl.message(
      'We need your real photo',
      name: 'requireYourRealPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Duo Snap anyway`
  String get duosnapAnyway {
    return Intl.message(
      'Duo Snap anyway',
      name: 'duosnapAnyway',
      desc: '',
      args: [],
    );
  }

  /// `This photo might not be real`
  String get photoMightNotBeReal {
    return Intl.message(
      'This photo might not be real',
      name: 'photoMightNotBeReal',
      desc: '',
      args: [],
    );
  }

  /// `Got it`
  String get gotIt {
    return Intl.message('Got it', name: 'gotIt', desc: '', args: []);
  }

  /// `Send DM`
  String get sendDm {
    return Intl.message('Send DM', name: 'sendDm', desc: '', args: []);
  }

  /// `Plus Description`
  String get plusDescTitle {
    return Intl.message(
      'Plus Description',
      name: 'plusDescTitle',
      desc: '',
      args: [],
    );
  }

  /// `Like Back`
  String get likeBack {
    return Intl.message('Like Back', name: 'likeBack', desc: '', args: []);
  }

  /// `Start Chat`
  String get startChat {
    return Intl.message('Start Chat', name: 'startChat', desc: '', args: []);
  }

  /// `Astro Report`
  String get astroReport {
    return Intl.message(
      'Astro Report',
      name: 'astroReport',
      desc: '',
      args: [],
    );
  }

  /// `No one found your charm yet`
  String get noOneFoundYourCharm {
    return Intl.message(
      'No one found your charm yet',
      name: 'noOneFoundYourCharm',
      desc: '',
      args: [],
    );
  }

  /// `Complete your astro profile`
  String get completeAstroProfile {
    return Intl.message(
      'Complete your astro profile',
      name: 'completeAstroProfile',
      desc: '',
      args: [],
    );
  }

  /// `Complete Astro Profile`
  String get completeAstroProfileButton {
    return Intl.message(
      'Complete Astro Profile',
      name: 'completeAstroProfileButton',
      desc: '',
      args: [],
    );
  }

  /// `Charm Tips`
  String get charmTips {
    return Intl.message('Charm Tips', name: 'charmTips', desc: '', args: []);
  }

  /// `Upload high-quality real photos`
  String get uploadQualityPhotos {
    return Intl.message(
      'Upload high-quality real photos',
      name: 'uploadQualityPhotos',
      desc: '',
      args: [],
    );
  }

  /// `Write an interesting personal bio`
  String get writeInterestingBio {
    return Intl.message(
      'Write an interesting personal bio',
      name: 'writeInterestingBio',
      desc: '',
      args: [],
    );
  }

  /// `Complete detailed astro information`
  String get completeAstroInfo {
    return Intl.message(
      'Complete detailed astro information',
      name: 'completeAstroInfo',
      desc: '',
      args: [],
    );
  }

  /// `Actively chat with matched users`
  String get chatWithMatches {
    return Intl.message(
      'Actively chat with matched users',
      name: 'chatWithMatches',
      desc: '',
      args: [],
    );
  }

  /// `Set clear interest tags`
  String get setInterestTags {
    return Intl.message(
      'Set clear interest tags',
      name: 'setInterestTags',
      desc: '',
      args: [],
    );
  }

  /// `Jump to astro profile page`
  String get navigateToAstroProfile {
    return Intl.message(
      'Jump to astro profile page',
      name: 'navigateToAstroProfile',
      desc: '',
      args: [],
    );
  }

  /// `Already liked back`
  String get likedBack {
    return Intl.message(
      'Already liked back',
      name: 'likedBack',
      desc: '',
      args: [],
    );
  }

  /// `Started chatting with`
  String get startedChat {
    return Intl.message(
      'Started chatting with',
      name: 'startedChat',
      desc: '',
      args: [],
    );
  }

  /// `View astro report with`
  String get viewAstroReport {
    return Intl.message(
      'View astro report with',
      name: 'viewAstroReport',
      desc: '',
      args: [],
    );
  }

  /// `Destiny Match`
  String get destinyMatch {
    return Intl.message(
      'Destiny Match',
      name: 'destinyMatch',
      desc: '',
      args: [],
    );
  }

  /// `Unlock {count} users including {destinyCount} destiny matches ⭐`
  String unlockUsersWithDestiny(Object count, Object destinyCount) {
    return Intl.message(
      'Unlock $count users including $destinyCount destiny matches ⭐',
      name: 'unlockUsersWithDestiny',
      desc: '',
      args: [count, destinyCount],
    );
  }

  /// `Unlock to view {count} high-match users ✨`
  String unlockHighMatchUsers(Object count) {
    return Intl.message(
      'Unlock to view $count high-match users ✨',
      name: 'unlockHighMatchUsers',
      desc: '',
      args: [count],
    );
  }

  /// `Destiny priority exposure in recommendations and likes`
  String get plusBenefitDestinyPriority {
    return Intl.message(
      'Destiny priority exposure in recommendations and likes',
      name: 'plusBenefitDestinyPriority',
      desc: '',
      args: [],
    );
  }

  /// `High match score display with percentage`
  String get plusBenefitHighMatchDisplay {
    return Intl.message(
      'High match score display with percentage',
      name: 'plusBenefitHighMatchDisplay',
      desc: '',
      args: [],
    );
  }

  /// `Star greeting package: 10 daily greetings`
  String get plusBenefitStarGreeting {
    return Intl.message(
      'Star greeting package: 10 daily greetings',
      name: 'plusBenefitStarGreeting',
      desc: '',
      args: [],
    );
  }

  /// `Smart opening lines: 3 high-conversion suggestions per person`
  String get plusBenefitSmartOpener {
    return Intl.message(
      'Smart opening lines: 3 high-conversion suggestions per person',
      name: 'plusBenefitSmartOpener',
      desc: '',
      args: [],
    );
  }

  /// `Conversation topic pool based on profile analysis`
  String get plusBenefitTopicPool {
    return Intl.message(
      'Conversation topic pool based on profile analysis',
      name: 'plusBenefitTopicPool',
      desc: '',
      args: [],
    );
  }

  /// `Real-time translation and polishing: multilingual auto-correction`
  String get plusBenefitRealTimeTranslation {
    return Intl.message(
      'Real-time translation and polishing: multilingual auto-correction',
      name: 'plusBenefitRealTimeTranslation',
      desc: '',
      args: [],
    );
  }

  /// `Overall compatibility score visualization`
  String get plusBenefitMatchScore {
    return Intl.message(
      'Overall compatibility score visualization',
      name: 'plusBenefitMatchScore',
      desc: '',
      args: [],
    );
  }

  /// `4-dimension breakdown: personality/communication/intimacy/boundaries`
  String get plusBenefitDimensionBreakdown {
    return Intl.message(
      '4-dimension breakdown: personality/communication/intimacy/boundaries',
      name: 'plusBenefitDimensionBreakdown',
      desc: '',
      args: [],
    );
  }

  /// `Conflict points and relationship advice`
  String get plusBenefitConflictAdvice {
    return Intl.message(
      'Conflict points and relationship advice',
      name: 'plusBenefitConflictAdvice',
      desc: '',
      args: [],
    );
  }

  /// `Advanced filters: country/language/timezone/city`
  String get plusBenefitAdvancedFilter {
    return Intl.message(
      'Advanced filters: country/language/timezone/city',
      name: 'plusBenefitAdvancedFilter',
      desc: '',
      args: [],
    );
  }

  /// `Interest and travel plan filters`
  String get plusBenefitInterestFilter {
    return Intl.message(
      'Interest and travel plan filters',
      name: 'plusBenefitInterestFilter',
      desc: '',
      args: [],
    );
  }

  /// `Sort by recent activity and reply rate`
  String get plusBenefitActivitySort {
    return Intl.message(
      'Sort by recent activity and reply rate',
      name: 'plusBenefitActivitySort',
      desc: '',
      args: [],
    );
  }

  /// `Like back and read receipt reminders`
  String get plusBenefitLikeReminder {
    return Intl.message(
      'Like back and read receipt reminders',
      name: 'plusBenefitLikeReminder',
      desc: '',
      args: [],
    );
  }

  /// `Activity and return reminders`
  String get plusBenefitActivityReminder {
    return Intl.message(
      'Activity and return reminders',
      name: 'plusBenefitActivityReminder',
      desc: '',
      args: [],
    );
  }

  /// `New destiny match arrival notifications`
  String get plusBenefitDestinyPush {
    return Intl.message(
      'New destiny match arrival notifications',
      name: 'plusBenefitDestinyPush',
      desc: '',
      args: [],
    );
  }

  /// `Image instant translation and text recognition`
  String get plusBenefitOCRTranslation {
    return Intl.message(
      'Image instant translation and text recognition',
      name: 'plusBenefitOCRTranslation',
      desc: '',
      args: [],
    );
  }

  /// `Quick message templates (compliments/invitations/platform switch)`
  String get plusBenefitMessageTemplates {
    return Intl.message(
      'Quick message templates (compliments/invitations/platform switch)',
      name: 'plusBenefitMessageTemplates',
      desc: '',
      args: [],
    );
  }

  /// `One-click translation of message history`
  String get plusBenefitHistoryTranslation {
    return Intl.message(
      'One-click translation of message history',
      name: 'plusBenefitHistoryTranslation',
      desc: '',
      args: [],
    );
  }

  /// `Priority anti-harassment protection and weight protection`
  String get plusBenefitAntiHarassment {
    return Intl.message(
      'Priority anti-harassment protection and weight protection',
      name: 'plusBenefitAntiHarassment',
      desc: '',
      args: [],
    );
  }

  /// `Fast-track subscription issue resolution`
  String get plusBenefitSupportChannel {
    return Intl.message(
      'Fast-track subscription issue resolution',
      name: 'plusBenefitSupportChannel',
      desc: '',
      args: [],
    );
  }

  /// `Unlock clear avatars and tags in Liked Me`
  String get plusBenefitUnlockLikedMe {
    return Intl.message(
      'Unlock clear avatars and tags in Liked Me',
      name: 'plusBenefitUnlockLikedMe',
      desc: '',
      args: [],
    );
  }

  /// `Complete basic profile`
  String get personaCompleteProfile {
    return Intl.message(
      'Complete basic profile',
      name: 'personaCompleteProfile',
      desc: '',
      args: [],
    );
  }

  /// `Complete name, birthday, gender to unlock more recommendations`
  String get personaCompleteProfileDesc {
    return Intl.message(
      'Complete name, birthday, gender to unlock more recommendations',
      name: 'personaCompleteProfileDesc',
      desc: '',
      args: [],
    );
  }

  /// `Upload your photos`
  String get personaUploadPhotos {
    return Intl.message(
      'Upload your photos',
      name: 'personaUploadPhotos',
      desc: '',
      args: [],
    );
  }

  /// `Add at least 2 clear photos to increase exposure`
  String get personaUploadPhotosDesc {
    return Intl.message(
      'Add at least 2 clear photos to increase exposure',
      name: 'personaUploadPhotosDesc',
      desc: '',
      args: [],
    );
  }

  /// `Enable message notifications`
  String get personaEnableNotifications {
    return Intl.message(
      'Enable message notifications',
      name: 'personaEnableNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Don't miss matches and messages, interact in time`
  String get personaEnableNotificationsDesc {
    return Intl.message(
      'Don\'t miss matches and messages, interact in time',
      name: 'personaEnableNotificationsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Show your city`
  String get personaShowCity {
    return Intl.message(
      'Show your city',
      name: 'personaShowCity',
      desc: '',
      args: [],
    );
  }

  /// `Easier to be discovered by local users`
  String get personaShowCityDesc {
    return Intl.message(
      'Easier to be discovered by local users',
      name: 'personaShowCityDesc',
      desc: '',
      args: [],
    );
  }

  /// `For you`
  String get personaForYou {
    return Intl.message('For you', name: 'personaForYou', desc: '', args: []);
  }

  /// `One line to win them over`
  String get oneLineToWin {
    return Intl.message(
      'One line to win them over',
      name: 'oneLineToWin',
      desc: '',
      args: [],
    );
  }

  /// `📸 Remind them to upload photos, get to know each other better`
  String get remindUploadPhoto {
    return Intl.message(
      '📸 Remind them to upload photos, get to know each other better',
      name: 'remindUploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Fate is on the way`
  String get fateOnTheWay {
    return Intl.message(
      'Fate is on the way',
      name: 'fateOnTheWay',
      desc: '',
      args: [],
    );
  }

  /// `Your private chat room is still empty\nBut the stars know, the right person is coming to you`
  String get emptyChatRoomMessage {
    return Intl.message(
      'Your private chat room is still empty\nBut the stars know, the right person is coming to you',
      name: 'emptyChatRoomMessage',
      desc: '',
      args: [],
    );
  }

  /// `Go Discover`
  String get goDiscover {
    return Intl.message('Go Discover', name: 'goDiscover', desc: '', args: []);
  }

  /// `Complete Profile`
  String get completeProfile {
    return Intl.message(
      'Complete Profile',
      name: 'completeProfile',
      desc: '',
      args: [],
    );
  }

  /// `✨ Complete your profile so the stars can know you better, for more accurate matching`
  String get profileTip {
    return Intl.message(
      '✨ Complete your profile so the stars can know you better, for more accurate matching',
      name: 'profileTip',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade to Premium for more recommendations`
  String get upgradeForMoreRecommendations {
    return Intl.message(
      'Upgrade to Premium for more recommendations',
      name: 'upgradeForMoreRecommendations',
      desc: '',
      args: [],
    );
  }

  /// `Uploading...`
  String get uploading {
    return Intl.message('Uploading...', name: 'uploading', desc: '', args: []);
  }

  /// `Plus Membership Benefits`
  String get plusMembershipBenefits {
    return Intl.message(
      'Plus Membership Benefits',
      name: 'plusMembershipBenefits',
      desc: '',
      args: [],
    );
  }

  /// `Delete Photo`
  String get deletePhoto {
    return Intl.message(
      'Delete Photo',
      name: 'deletePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this photo? This action cannot be undone.`
  String get deletePhotoContent {
    return Intl.message(
      'Are you sure you want to delete this photo? This action cannot be undone.',
      name: 'deletePhotoContent',
      desc: '',
      args: [],
    );
  }

  /// `GIF is not allowed`
  String get gifNotAllowed {
    return Intl.message(
      'GIF is not allowed',
      name: 'gifNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `My Photos`
  String get myPhotos {
    return Intl.message('My Photos', name: 'myPhotos', desc: '', args: []);
  }

  /// `Add Photo`
  String get addPhoto {
    return Intl.message('Add Photo', name: 'addPhoto', desc: '', args: []);
  }

  /// `Quick Actions`
  String get quickActions {
    return Intl.message(
      'Quick Actions',
      name: 'quickActions',
      desc: '',
      args: [],
    );
  }

  /// `Plus Member`
  String get plusMember {
    return Intl.message('Plus Member', name: 'plusMember', desc: '', args: []);
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

  /// `Member Center`
  String get memberCenter {
    return Intl.message(
      'Member Center',
      name: 'memberCenter',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfileTitle {
    return Intl.message(
      'My Profile',
      name: 'myProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update avatar`
  String get avatarUpdateFailed {
    return Intl.message(
      'Failed to update avatar',
      name: 'avatarUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileInfoTab {
    return Intl.message('Profile', name: 'profileInfoTab', desc: '', args: []);
  }

  /// `Astro Chart`
  String get astroChartTab {
    return Intl.message(
      'Astro Chart',
      name: 'astroChartTab',
      desc: '',
      args: [],
    );
  }

  /// `Information Incomplete`
  String get infoIncompleteTitle {
    return Intl.message(
      'Information Incomplete',
      name: 'infoIncompleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `The other user hasn't completed their birth location information yet, so we can't generate an astrological chart. Please wait for them to complete their information.`
  String get astroInfoIncompleteMessage {
    return Intl.message(
      'The other user hasn\'t completed their birth location information yet, so we can\'t generate an astrological chart. Please wait for them to complete their information.',
      name: 'astroInfoIncompleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Select Location`
  String get selectLocationTitle {
    return Intl.message(
      'Select Location',
      name: 'selectLocationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Current selected coordinates`
  String get currentSelectedCoordinates {
    return Intl.message(
      'Current selected coordinates',
      name: 'currentSelectedCoordinates',
      desc: '',
      args: [],
    );
  }

  /// `Map selected location`
  String get mapSelectedLocation {
    return Intl.message(
      'Map selected location',
      name: 'mapSelectedLocation',
      desc: '',
      args: [],
    );
  }

  /// `Confirm select this location`
  String get confirmSelectLocation {
    return Intl.message(
      'Confirm select this location',
      name: 'confirmSelectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Located to current position`
  String get locationLocatedSuccess {
    return Intl.message(
      'Located to current position',
      name: 'locationLocatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get location`
  String get locationLocatedFailed {
    return Intl.message(
      'Failed to get location',
      name: 'locationLocatedFailed',
      desc: '',
      args: [],
    );
  }

  /// `Use current location`
  String get useCurrentLocation {
    return Intl.message(
      'Use current location',
      name: 'useCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Please complete your birth location information`
  String get completeBirthLocationInfo {
    return Intl.message(
      'Please complete your birth location information',
      name: 'completeBirthLocationInfo',
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
