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

  /// `Your gender will not be shown public, it only be used to help for connection`
  String get userGenderPickerSubtitle {
    return Intl.message(
      'Your gender will not be shown public, it only be used to help for connection',
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

  /// `A good portrait helps you connect with more listeners. Keep it real and use a legit pic of yourself.`
  String get userAvatarPageSubtitle {
    return Intl.message(
      'A good portrait helps you connect with more listeners. Keep it real and use a legit pic of yourself.',
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

  /// `AstroLearn is finding some potential friend...`
  String get firstLandingLoadingTitle {
    return Intl.message(
      'AstroLearn is finding some potential friend...',
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

  /// `Which of {gender, select, male {his} female {her} other {their}} sharing experiences resonate with you?`
  String matchPageSelectIdeas(String gender) {
    return Intl.message(
      'Which of ${Intl.gender(gender, male: 'his', female: 'her', other: 'their')} sharing experiences resonate with you?',
      name: 'matchPageSelectIdeas',
      desc: '',
      args: [gender],
    );
  }

  /// `Share Your Appreciation`
  String get justSendALike {
    return Intl.message(
      'Share Your Appreciation',
      name: 'justSendALike',
      desc: '',
      args: [],
    );
  }

  /// `DM`
  String get dm {
    return Intl.message('DM', name: 'dm', desc: '', args: []);
  }

  /// `Would you like to share...`
  String get wannaHollaAt {
    return Intl.message(
      'Would you like to share...',
      name: 'wannaHollaAt',
      desc: '',
      args: [],
    );
  }

  /// `Let AstroLearn say hi for you`
  String get letAstroLearnSayHiForYou {
    return Intl.message(
      'Let AstroLearn say hi for you',
      name: 'letAstroLearnSayHiForYou',
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

  /// `AstroLearn Recommendation: Cooldown\nWhat to do: Wait\nSuggestion: Watch a movie?`
  String get astroLearnRecommendationCooldown {
    return Intl.message(
      'AstroLearn Recommendation: Cooldown\nWhat to do: Wait\nSuggestion: Watch a movie?',
      name: 'astroLearnRecommendationCooldown',
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

  /// `PerAstroLearnl Attack`
  String get reportOptionPerAstroLearnlAttack {
    return Intl.message(
      'PerAstroLearnl Attack',
      name: 'reportOptionPerAstroLearnlAttack',
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

  /// `Who appreciates your sharing`
  String get whoLIkesYou {
    return Intl.message(
      'Who appreciates your sharing',
      name: 'whoLIkesYou',
      desc: '',
      args: [],
    );
  }

  /// `Appreciates your sharing`
  String get likedYou {
    return Intl.message(
      'Appreciates your sharing',
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

  /// `Learn about their sharing`
  String get likedPageMonetizeButton {
    return Intl.message(
      'Learn about their sharing',
      name: 'likedPageMonetizeButton',
      desc: '',
      args: [],
    );
  }

  /// `Status: No appreciations yet\n\nWhat to do: Start sharing\n\nSuggestion:\n"Authentic portraits,\nGenuine stories,\nShared interests connect."\n\nI mean...\nUpload some real photos\nShare your authentic story\nPick your interests`
  String get likedPageNoData {
    return Intl.message(
      'Status: No appreciations yet\n\nWhat to do: Start sharing\n\nSuggestion:\n"Authentic portraits,\nGenuine stories,\nShared interests connect."\n\nI mean...\nUpload some real photos\nShare your authentic story\nPick your interests',
      name: 'likedPageNoData',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message('Chat', name: 'chat', desc: '', args: []);
  }

  /// `Who appreciates you`
  String get whoLikesU {
    return Intl.message(
      'Who appreciates you',
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

  /// `New Connection!`
  String get newMatch {
    return Intl.message(
      'New Connection!',
      name: 'newMatch',
      desc: '',
      args: [],
    );
  }

  /// `Status: No messages\n\nWhat to do: Find listeners\n\nSuggestion: Share your authentic self`
  String get noMessageTips {
    return Intl.message(
      'Status: No messages\n\nWhat to do: Find listeners\n\nSuggestion: Share your authentic self',
      name: 'noMessageTips',
      desc: '',
      args: [],
    );
  }

  /// `See who appreciates you`
  String get seeWhoLikeU {
    return Intl.message(
      'See who appreciates you',
      name: 'seeWhoLikeU',
      desc: '',
      args: [],
    );
  }

  /// `Have AstroLearn Say Hi`
  String get haveAstroLearnSayHi {
    return Intl.message(
      'Have AstroLearn Say Hi',
      name: 'haveAstroLearnSayHi',
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

  /// `End sharing`
  String get buttonUnmatch {
    return Intl.message(
      'End sharing',
      name: 'buttonUnmatch',
      desc: '',
      args: [],
    );
  }

  /// `😪AstroLearn is tired, 👇Tap to refuel her!`
  String get buttonHitAIInterpretationMaximumLimit {
    return Intl.message(
      '😪AstroLearn is tired, 👇Tap to refuel her!',
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

  /// `After ending sharing, all your conversation history will be cleared.`
  String get warningUnmatching {
    return Intl.message(
      'After ending sharing, all your conversation history will be cleared.',
      name: 'warningUnmatching',
      desc: '',
      args: [],
    );
  }

  /// `⭕ AstroLearn interpretation is turned off`
  String get astroLearnInterpretationOff {
    return Intl.message(
      '⭕ AstroLearn interpretation is turned off',
      name: 'astroLearnInterpretationOff',
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

  /// `Unsent. AstroLearn will not translate prohibited words`
  String get exceptionAstroLearnContentFilterTips {
    return Intl.message(
      'Unsent. AstroLearn will not translate prohibited words',
      name: 'exceptionAstroLearnContentFilterTips',
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

  /// `AstroLearn is overloaded, please try again later.`
  String get exceptionAstroLearnOverloadedTips {
    return Intl.message(
      'AstroLearn is overloaded, please try again later.',
      name: 'exceptionAstroLearnOverloadedTips',
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

  /// `Get AstroLearn Plus`
  String get getAstroLearnPlus {
    return Intl.message(
      'Get AstroLearn Plus',
      name: 'getAstroLearnPlus',
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

  /// `Show your perAstroLearnlity`
  String get showYourPerAstroLearnlity {
    return Intl.message(
      'Show your perAstroLearnlity',
      name: 'showYourPerAstroLearnlity',
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

  /// `Get AstroLearn Plus`
  String get subPageTitle {
    return Intl.message(
      'Get AstroLearn Plus',
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

  /// `Unlock to see who appreciates your sharing`
  String get plusFuncUnlockWhoLikesU {
    return Intl.message(
      'Unlock to see who appreciates your sharing',
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

  /// `Filter connection Countries`
  String get plusFuncFilterMatchingCountries {
    return Intl.message(
      'Filter connection Countries',
      name: 'plusFuncFilterMatchingCountries',
      desc: '',
      args: [],
    );
  }

  /// `AstroLearn Tips - Your chat advisor`
  String get plusFuncAstroLearnTips {
    return Intl.message(
      'AstroLearn Tips - Your chat advisor',
      name: 'plusFuncAstroLearnTips',
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

  /// `Unlock to see\nwho appreciates you`
  String get subPageSubtitleUnlockWhoLikesU {
    return Intl.message(
      'Unlock to see\nwho appreciates you',
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

  /// `AstroLearn Tips - \nYour chat advisor`
  String get subPageSubtitleAstroLearnTips {
    return Intl.message(
      'AstroLearn Tips - \nYour chat advisor',
      name: 'subPageSubtitleAstroLearnTips',
      desc: '',
      args: [],
    );
  }

  /// `Filter connection \nCountries`
  String get subPageSubtitleFilterMatchingCountries {
    return Intl.message(
      'Filter connection \nCountries',
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

  /// `AstroLearn will generate a bio based on your interests`
  String get astroLearnWillGenerateABioBasedOnInterests {
    return Intl.message(
      'AstroLearn will generate a bio based on your interests',
      name: 'astroLearnWillGenerateABioBasedOnInterests',
      desc: '',
      args: [],
    );
  }

  /// `Generate`
  String get buttonGenerate {
    return Intl.message('Generate', name: 'buttonGenerate', desc: '', args: []);
  }

  /// `Here's AstroLearn cooked up for you!`
  String get hereAstroLearnCookedUpForU {
    return Intl.message(
      'Here\'s AstroLearn cooked up for you!',
      name: 'hereAstroLearnCookedUpForU',
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

  /// `AstroLearn is like a home base for world citizens`
  String get onboarding0 {
    return Intl.message(
      'AstroLearn is like a home base for world citizens',
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

  /// `Birth Information`
  String get birthInfo {
    return Intl.message(
      'Birth Information',
      name: 'birthInfo',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message('Birthday', name: 'birthday', desc: '', args: []);
  }

  /// `Click to set birthday`
  String get clickToSetBirthday {
    return Intl.message(
      'Click to set birthday',
      name: 'clickToSetBirthday',
      desc: '',
      args: [],
    );
  }

  /// `Birth Place`
  String get birthPlace {
    return Intl.message('Birth Place', name: 'birthPlace', desc: '', args: []);
  }

  /// `Click to set birth place`
  String get clickToSetBirthPlace {
    return Intl.message(
      'Click to set birth place',
      name: 'clickToSetBirthPlace',
      desc: '',
      args: [],
    );
  }

  /// `Select Birth Place`
  String get selectBirthPlace {
    return Intl.message(
      'Select Birth Place',
      name: 'selectBirthPlace',
      desc: '',
      args: [],
    );
  }

  /// `Enter birth place`
  String get enterBirthPlace {
    return Intl.message(
      'Enter birth place',
      name: 'enterBirthPlace',
      desc: '',
      args: [],
    );
  }

  /// `Synastry`
  String get synastryAnalysis {
    return Intl.message(
      'Synastry',
      name: 'synastryAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Deep Analysis`
  String get deepSynastryAnalysis {
    return Intl.message(
      'Deep Analysis',
      name: 'deepSynastryAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Analyzing...`
  String get analyzingText {
    return Intl.message(
      'Analyzing...',
      name: 'analyzingText',
      desc: '',
      args: [],
    );
  }

  /// `Sun Sign`
  String get sunSignLabel {
    return Intl.message('Sun Sign', name: 'sunSignLabel', desc: '', args: []);
  }

  /// `Ascendant Sign`
  String get ascendantSignLabel {
    return Intl.message(
      'Ascendant Sign',
      name: 'ascendantSignLabel',
      desc: '',
      args: [],
    );
  }

  /// `Birth Place`
  String get birthPlaceLabel {
    return Intl.message(
      'Birth Place',
      name: 'birthPlaceLabel',
      desc: '',
      args: [],
    );
  }

  /// `Birth Time`
  String get birthTimeLabel {
    return Intl.message(
      'Birth Time',
      name: 'birthTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `12:00 (Default)`
  String get defaultBirthTime {
    return Intl.message(
      '12:00 (Default)',
      name: 'defaultBirthTime',
      desc: '',
      args: [],
    );
  }

  /// `Deep AI Analysis Report`
  String get deepAnalysisReportTitle {
    return Intl.message(
      'Deep AI Analysis Report',
      name: 'deepAnalysisReportTitle',
      desc: '',
      args: [],
    );
  }

  /// `Light AI Analysis`
  String get lightAnalysisTitle {
    return Intl.message(
      'Light AI Analysis',
      name: 'lightAnalysisTitle',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get closeButtonText {
    return Intl.message('Close', name: 'closeButtonText', desc: '', args: []);
  }

  /// `Unsupported platform`
  String get unsupportedPlatform {
    return Intl.message(
      'Unsupported platform',
      name: 'unsupportedPlatform',
      desc: '',
      args: [],
    );
  }

  /// `Product not found`
  String get productNotFound {
    return Intl.message(
      'Product not found',
      name: 'productNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Diamond Store`
  String get diamondStoreTitle {
    return Intl.message(
      'Diamond Store',
      name: 'diamondStoreTitle',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Purchase Failed`
  String get purchaseFailed {
    return Intl.message(
      'Purchase Failed',
      name: 'purchaseFailed',
      desc: '',
      args: [],
    );
  }

  /// `Diamond Store`
  String get diamondStore {
    return Intl.message(
      'Diamond Store',
      name: 'diamondStore',
      desc: '',
      args: [],
    );
  }

  /// `Unlock premium features with diamonds`
  String get diamondStoreSubtitle {
    return Intl.message(
      'Unlock premium features with diamonds',
      name: 'diamondStoreSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Pending`
  String get purchasePending {
    return Intl.message(
      'Purchase Pending',
      name: 'purchasePending',
      desc: '',
      args: [],
    );
  }

  /// `Purchase`
  String get buttonPurchase {
    return Intl.message('Purchase', name: 'buttonPurchase', desc: '', args: []);
  }

  /// `Deep Synastry Analysis`
  String get deepSynastryRemark {
    return Intl.message(
      'Deep Synastry Analysis',
      name: 'deepSynastryRemark',
      desc: '',
      args: [],
    );
  }

  /// `Synastry Analysis`
  String get lightSynastryRemark {
    return Intl.message(
      'Synastry Analysis',
      name: 'lightSynastryRemark',
      desc: '',
      args: [],
    );
  }

  /// `Send DM Message`
  String get sendDmRemark {
    return Intl.message(
      'Send DM Message',
      name: 'sendDmRemark',
      desc: '',
      args: [],
    );
  }

  /// `Diamond consumption failed`
  String get diamondConsumeFailed {
    return Intl.message(
      'Diamond consumption failed',
      name: 'diamondConsumeFailed',
      desc: '',
      args: [],
    );
  }

  /// `Leo`
  String get leoSign {
    return Intl.message('Leo', name: 'leoSign', desc: '', args: []);
  }

  /// `Libra`
  String get libraSign {
    return Intl.message('Libra', name: 'libraSign', desc: '', args: []);
  }

  /// `Unknown`
  String get unknownLocation {
    return Intl.message('Unknown', name: 'unknownLocation', desc: '', args: []);
  }

  /// `User birthday information is incomplete`
  String get incompleteBirthdayInfo {
    return Intl.message(
      'User birthday information is incomplete',
      name: 'incompleteBirthdayInfo',
      desc: '',
      args: [],
    );
  }

  /// `Emotional`
  String get emotionalCompatibility {
    return Intl.message(
      'Emotional',
      name: 'emotionalCompatibility',
      desc: '',
      args: [],
    );
  }

  /// `Intellectual`
  String get intellectualCompatibility {
    return Intl.message(
      'Intellectual',
      name: 'intellectualCompatibility',
      desc: '',
      args: [],
    );
  }

  /// `Lifestyle`
  String get lifestyleCompatibility {
    return Intl.message(
      'Lifestyle',
      name: 'lifestyleCompatibility',
      desc: '',
      args: [],
    );
  }

  /// `Values`
  String get valuesCompatibility {
    return Intl.message(
      'Values',
      name: 'valuesCompatibility',
      desc: '',
      args: [],
    );
  }

  /// `Communication`
  String get communicationCompatibility {
    return Intl.message(
      'Communication',
      name: 'communicationCompatibility',
      desc: '',
      args: [],
    );
  }

  /// `Future`
  String get futureCompatibility {
    return Intl.message(
      'Future',
      name: 'futureCompatibility',
      desc: '',
      args: [],
    );
  }

  /// `Chart Preview`
  String get chartPreview {
    return Intl.message(
      'Chart Preview',
      name: 'chartPreview',
      desc: '',
      args: [],
    );
  }

  /// `Please select your birth date to view your astrological chart`
  String get selectBirthdayHint {
    return Intl.message(
      'Please select your birth date to view your astrological chart',
      name: 'selectBirthdayHint',
      desc: '',
      args: [],
    );
  }

  /// `Aries`
  String get ariesSign {
    return Intl.message('Aries', name: 'ariesSign', desc: '', args: []);
  }

  /// `Taurus`
  String get taurusSign {
    return Intl.message('Taurus', name: 'taurusSign', desc: '', args: []);
  }

  /// `Gemini`
  String get geminiSign {
    return Intl.message('Gemini', name: 'geminiSign', desc: '', args: []);
  }

  /// `Cancer`
  String get cancerSign {
    return Intl.message('Cancer', name: 'cancerSign', desc: '', args: []);
  }

  /// `Virgo`
  String get virgoSign {
    return Intl.message('Virgo', name: 'virgoSign', desc: '', args: []);
  }

  /// `Scorpio`
  String get scorpioSign {
    return Intl.message('Scorpio', name: 'scorpioSign', desc: '', args: []);
  }

  /// `Sagittarius`
  String get sagittariusSign {
    return Intl.message(
      'Sagittarius',
      name: 'sagittariusSign',
      desc: '',
      args: [],
    );
  }

  /// `Capricorn`
  String get capricornSign {
    return Intl.message('Capricorn', name: 'capricornSign', desc: '', args: []);
  }

  /// `Aquarius`
  String get aquariusSign {
    return Intl.message('Aquarius', name: 'aquariusSign', desc: '', args: []);
  }

  /// `Pisces`
  String get piscesSign {
    return Intl.message('Pisces', name: 'piscesSign', desc: '', args: []);
  }

  /// `Diamond Pack`
  String get diamondPack1 {
    return Intl.message(
      'Diamond Pack',
      name: 'diamondPack1',
      desc: '',
      args: [],
    );
  }

  /// `Diamond Chest`
  String get diamondPack2 {
    return Intl.message(
      'Diamond Chest',
      name: 'diamondPack2',
      desc: '',
      args: [],
    );
  }

  /// `Diamond Gift`
  String get diamondPack3 {
    return Intl.message(
      'Diamond Gift',
      name: 'diamondPack3',
      desc: '',
      args: [],
    );
  }

  /// `Diamond Bundle`
  String get diamondPack4 {
    return Intl.message(
      'Diamond Bundle',
      name: 'diamondPack4',
      desc: '',
      args: [],
    );
  }

  /// `Diamond Supreme Pack`
  String get diamondPack5 {
    return Intl.message(
      'Diamond Supreme Pack',
      name: 'diamondPack5',
      desc: '',
      args: [],
    );
  }

  /// `Diamonds are not enough`
  String get diamondInsufficient {
    return Intl.message(
      'Diamonds are not enough',
      name: 'diamondInsufficient',
      desc: '',
      args: [],
    );
  }

  /// `Compatibility`
  String get compatibilityScore {
    return Intl.message(
      'Compatibility',
      name: 'compatibilityScore',
      desc: '',
      args: [],
    );
  }

  /// `Astro Healing Calendar`
  String get healing_calendar_title {
    return Intl.message(
      'Astro Healing Calendar',
      name: 'healing_calendar_title',
      desc: '',
      args: [],
    );
  }

  /// `Active Days`
  String get active_days {
    return Intl.message('Active Days', name: 'active_days', desc: '', args: []);
  }

  /// `Healing Sessions`
  String get healing_count {
    return Intl.message(
      'Healing Sessions',
      name: 'healing_count',
      desc: '',
      args: [],
    );
  }

  /// `Streak Days`
  String get streak_days {
    return Intl.message('Streak Days', name: 'streak_days', desc: '', args: []);
  }

  /// `No records for this day`
  String get no_records_today {
    return Intl.message(
      'No records for this day',
      name: 'no_records_today',
      desc: '',
      args: [],
    );
  }

  /// `Psychological Healing`
  String get psychological_healing {
    return Intl.message(
      'Psychological Healing',
      name: 'psychological_healing',
      desc: '',
      args: [],
    );
  }

  /// `Toggle Background Music`
  String get toggle_background_music {
    return Intl.message(
      'Toggle Background Music',
      name: 'toggle_background_music',
      desc: '',
      args: [],
    );
  }

  /// `Daily Quote`
  String get daily_quote {
    return Intl.message('Daily Quote', name: 'daily_quote', desc: '', args: []);
  }

  /// `Click to record status`
  String get click_to_record_status {
    return Intl.message(
      'Click to record status',
      name: 'click_to_record_status',
      desc: '',
      args: [],
    );
  }

  /// `Click me for encouragement`
  String get click_for_encouragement {
    return Intl.message(
      'Click me for encouragement',
      name: 'click_for_encouragement',
      desc: '',
      args: [],
    );
  }

  /// `Great! Keep going ✨`
  String get great_keep_going {
    return Intl.message(
      'Great! Keep going ✨',
      name: 'great_keep_going',
      desc: '',
      args: [],
    );
  }

  /// `Find inner peace through astro meditation`
  String get meditation_subtitle {
    return Intl.message(
      'Find inner peace through astro meditation',
      name: 'meditation_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Emotion Management`
  String get emotion_management {
    return Intl.message(
      'Emotion Management',
      name: 'emotion_management',
      desc: '',
      args: [],
    );
  }

  /// `Understand your emotions and learn self-care`
  String get emotion_subtitle {
    return Intl.message(
      'Understand your emotions and learn self-care',
      name: 'emotion_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Healing energy from the stars`
  String get quotes_subtitle {
    return Intl.message(
      'Healing energy from the stars',
      name: 'quotes_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Relaxing astro audio for mind and body`
  String get music_subtitle {
    return Intl.message(
      'Relaxing astro audio for mind and body',
      name: 'music_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Select duration to start meditation`
  String get select_duration_start {
    return Intl.message(
      'Select duration to start meditation',
      name: 'select_duration_start',
      desc: '',
      args: [],
    );
  }

  /// `Take a deep breath and relax...`
  String get breathe_relax {
    return Intl.message(
      'Take a deep breath and relax...',
      name: 'breathe_relax',
      desc: '',
      args: [],
    );
  }

  /// `Select meditation duration`
  String get select_meditation_duration {
    return Intl.message(
      'Select meditation duration',
      name: 'select_meditation_duration',
      desc: '',
      args: [],
    );
  }

  /// `Start Meditation`
  String get start_meditation {
    return Intl.message(
      'Start Meditation',
      name: 'start_meditation',
      desc: '',
      args: [],
    );
  }

  /// `Stop Meditation`
  String get stop_meditation {
    return Intl.message(
      'Stop Meditation',
      name: 'stop_meditation',
      desc: '',
      args: [],
    );
  }

  /// `✅ Meditation record saved`
  String get meditation_saved {
    return Intl.message(
      '✅ Meditation record saved',
      name: 'meditation_saved',
      desc: '',
      args: [],
    );
  }

  /// `Current Emotion`
  String get current_emotion {
    return Intl.message(
      'Current Emotion',
      name: 'current_emotion',
      desc: '',
      args: [],
    );
  }

  /// `Record your feelings`
  String get record_your_feelings {
    return Intl.message(
      'Record your feelings',
      name: 'record_your_feelings',
      desc: '',
      args: [],
    );
  }

  /// `Write down how you feel...`
  String get write_feelings_hint {
    return Intl.message(
      'Write down how you feel...',
      name: 'write_feelings_hint',
      desc: '',
      args: [],
    );
  }

  /// `Every emotion deserves to be seen and recorded`
  String get every_emotion_matters {
    return Intl.message(
      'Every emotion deserves to be seen and recorded',
      name: 'every_emotion_matters',
      desc: '',
      args: [],
    );
  }

  /// `✅ Emotion diary saved`
  String get emotion_diary_saved {
    return Intl.message(
      '✅ Emotion diary saved',
      name: 'emotion_diary_saved',
      desc: '',
      args: [],
    );
  }

  /// `New moon moment, perfect for starting new healing plans`
  String get new_moon_insight {
    return Intl.message(
      'New moon moment, perfect for starting new healing plans',
      name: 'new_moon_insight',
      desc: '',
      args: [],
    );
  }

  /// `Moon is waxing, energy is gradually accumulating`
  String get waxing_crescent_insight {
    return Intl.message(
      'Moon is waxing, energy is gradually accumulating',
      name: 'waxing_crescent_insight',
      desc: '',
      args: [],
    );
  }

  /// `First quarter moon, good time for action and decisions`
  String get first_quarter_insight {
    return Intl.message(
      'First quarter moon, good time for action and decisions',
      name: 'first_quarter_insight',
      desc: '',
      args: [],
    );
  }

  /// `Full moon approaching, emotions may be more sensitive`
  String get waxing_gibbous_insight {
    return Intl.message(
      'Full moon approaching, emotions may be more sensitive',
      name: 'waxing_gibbous_insight',
      desc: '',
      args: [],
    );
  }

  /// `Full moon energy is strongest, perfect for releasing emotions`
  String get full_moon_insight {
    return Intl.message(
      'Full moon energy is strongest, perfect for releasing emotions',
      name: 'full_moon_insight',
      desc: '',
      args: [],
    );
  }

  /// `Moon is waning, good time for reflection and organization`
  String get waning_gibbous_insight {
    return Intl.message(
      'Moon is waning, good time for reflection and organization',
      name: 'waning_gibbous_insight',
      desc: '',
      args: [],
    );
  }

  /// `Last quarter moon, let go of the past and prepare for new beginnings`
  String get last_quarter_insight {
    return Intl.message(
      'Last quarter moon, let go of the past and prepare for new beginnings',
      name: 'last_quarter_insight',
      desc: '',
      args: [],
    );
  }

  /// `Waning crescent moment, rest and recovery are important`
  String get waning_crescent_insight {
    return Intl.message(
      'Waning crescent moment, rest and recovery are important',
      name: 'waning_crescent_insight',
      desc: '',
      args: [],
    );
  }

  /// `My Statistics`
  String get my_statistics {
    return Intl.message(
      'My Statistics',
      name: 'my_statistics',
      desc: '',
      args: [],
    );
  }

  /// `Total Duration`
  String get total_duration {
    return Intl.message(
      'Total Duration',
      name: 'total_duration',
      desc: '',
      args: [],
    );
  }

  /// `Practice Count`
  String get practice_count {
    return Intl.message(
      'Practice Count',
      name: 'practice_count',
      desc: '',
      args: [],
    );
  }

  /// `{x} days to 30-day goal`
  String days_to_30_goal(Object x) {
    return Intl.message(
      '$x days to 30-day goal',
      name: 'days_to_30_goal',
      desc: '',
      args: [x],
    );
  }

  /// `Emotion Analysis`
  String get emotion_analysis {
    return Intl.message(
      'Emotion Analysis',
      name: 'emotion_analysis',
      desc: '',
      args: [],
    );
  }

  /// `Average Mood`
  String get average_mood {
    return Intl.message(
      'Average Mood',
      name: 'average_mood',
      desc: '',
      args: [],
    );
  }

  /// `Recorded Days`
  String get recorded_days {
    return Intl.message(
      'Recorded Days',
      name: 'recorded_days',
      desc: '',
      args: [],
    );
  }

  /// `Emotion Distribution`
  String get emotion_distribution {
    return Intl.message(
      'Emotion Distribution',
      name: 'emotion_distribution',
      desc: '',
      args: [],
    );
  }

  /// `😊 Happy`
  String get emotion_happy {
    return Intl.message('😊 Happy', name: 'emotion_happy', desc: '', args: []);
  }

  /// `😢 Sad`
  String get emotion_sad {
    return Intl.message('😢 Sad', name: 'emotion_sad', desc: '', args: []);
  }

  /// `😠 Angry`
  String get emotion_angry {
    return Intl.message('😠 Angry', name: 'emotion_angry', desc: '', args: []);
  }

  /// `😰 Anxious`
  String get emotion_anxious {
    return Intl.message(
      '😰 Anxious',
      name: 'emotion_anxious',
      desc: '',
      args: [],
    );
  }

  /// `😌 Calm`
  String get emotion_calm {
    return Intl.message('😌 Calm', name: 'emotion_calm', desc: '', args: []);
  }

  /// `😴 Tired`
  String get emotion_tired {
    return Intl.message('😴 Tired', name: 'emotion_tired', desc: '', args: []);
  }

  /// `Daily Status`
  String get daily_status {
    return Intl.message(
      'Daily Status',
      name: 'daily_status',
      desc: '',
      args: [],
    );
  }

  /// `Energy Index`
  String get energy_index {
    return Intl.message(
      'Energy Index',
      name: 'energy_index',
      desc: '',
      args: [],
    );
  }

  /// `Stress Index`
  String get stress_index {
    return Intl.message(
      'Stress Index',
      name: 'stress_index',
      desc: '',
      args: [],
    );
  }

  /// `🔥 {x} day streak!`
  String streak_x_days(Object x) {
    return Intl.message(
      '🔥 $x day streak!',
      name: 'streak_x_days',
      desc: '',
      args: [x],
    );
  }

  /// `Keep it up! You're doing great ✨`
  String get keep_it_up {
    return Intl.message(
      'Keep it up! You\'re doing great ✨',
      name: 'keep_it_up',
      desc: '',
      args: [],
    );
  }

  /// `Healing Data`
  String get healing_data {
    return Intl.message(
      'Healing Data',
      name: 'healing_data',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get view_details {
    return Intl.message(
      'View Details',
      name: 'view_details',
      desc: '',
      args: [],
    );
  }

  /// `Meditation Count`
  String get meditation_count {
    return Intl.message(
      'Meditation Count',
      name: 'meditation_count',
      desc: '',
      args: [],
    );
  }

  /// `Emotion Records`
  String get emotion_records {
    return Intl.message(
      'Emotion Records',
      name: 'emotion_records',
      desc: '',
      args: [],
    );
  }

  /// `You shine like a star today`
  String get quote_1 {
    return Intl.message(
      'You shine like a star today',
      name: 'quote_1',
      desc: '',
      args: [],
    );
  }

  /// `Trust yourself like you trust the stars`
  String get quote_2 {
    return Intl.message(
      'Trust yourself like you trust the stars',
      name: 'quote_2',
      desc: '',
      args: [],
    );
  }

  /// `Everyone is a unique constellation`
  String get quote_3 {
    return Intl.message(
      'Everyone is a unique constellation',
      name: 'quote_3',
      desc: '',
      args: [],
    );
  }

  /// `The universe's energy is with you`
  String get quote_4 {
    return Intl.message(
      'The universe\'s energy is with you',
      name: 'quote_4',
      desc: '',
      args: [],
    );
  }

  /// `Accept yourself as you are now`
  String get quote_5 {
    return Intl.message(
      'Accept yourself as you are now',
      name: 'quote_5',
      desc: '',
      args: [],
    );
  }

  /// `Every emotion deserves to be seen`
  String get quote_6 {
    return Intl.message(
      'Every emotion deserves to be seen',
      name: 'quote_6',
      desc: '',
      args: [],
    );
  }

  /// `Let stellar energy flow through you`
  String get quote_7 {
    return Intl.message(
      'Let stellar energy flow through you',
      name: 'quote_7',
      desc: '',
      args: [],
    );
  }

  /// `Today is new with infinite possibilities`
  String get quote_8 {
    return Intl.message(
      'Today is new with infinite possibilities',
      name: 'quote_8',
      desc: '',
      args: [],
    );
  }

  /// `Your existence is a miracle itself`
  String get quote_9 {
    return Intl.message(
      'Your existence is a miracle itself',
      name: 'quote_9',
      desc: '',
      args: [],
    );
  }

  /// `Find answers in the quiet moments`
  String get quote_10 {
    return Intl.message(
      'Find answers in the quiet moments',
      name: 'quote_10',
      desc: '',
      args: [],
    );
  }

  /// `Starry Sky Meditation`
  String get audio_1_title {
    return Intl.message(
      'Starry Sky Meditation',
      name: 'audio_1_title',
      desc: '',
      args: [],
    );
  }

  /// `Find inner peace under the quiet starry sky`
  String get audio_1_desc {
    return Intl.message(
      'Find inner peace under the quiet starry sky',
      name: 'audio_1_desc',
      desc: '',
      args: [],
    );
  }

  /// `Aries Energy Audio`
  String get audio_2_title {
    return Intl.message(
      'Aries Energy Audio',
      name: 'audio_2_title',
      desc: '',
      args: [],
    );
  }

  /// `Ignite your inner courage and vitality`
  String get audio_2_desc {
    return Intl.message(
      'Ignite your inner courage and vitality',
      name: 'audio_2_desc',
      desc: '',
      args: [],
    );
  }

  /// `Deep Relaxation Guide`
  String get audio_3_title {
    return Intl.message(
      'Deep Relaxation Guide',
      name: 'audio_3_title',
      desc: '',
      args: [],
    );
  }

  /// `Release stress and find complete relaxation`
  String get audio_3_desc {
    return Intl.message(
      'Release stress and find complete relaxation',
      name: 'audio_3_desc',
      desc: '',
      args: [],
    );
  }

  /// `Emotion Balance Music`
  String get audio_4_title {
    return Intl.message(
      'Emotion Balance Music',
      name: 'audio_4_title',
      desc: '',
      args: [],
    );
  }

  /// `Balance emotions and find inner harmony`
  String get audio_4_desc {
    return Intl.message(
      'Balance emotions and find inner harmony',
      name: 'audio_4_desc',
      desc: '',
      args: [],
    );
  }

  /// `{month}/{day}`
  String date_format_md(Object month, Object day) {
    return Intl.message(
      '$month/$day',
      name: 'date_format_md',
      desc: '',
      args: [month, day],
    );
  }

  /// `No audio available`
  String get no_audio {
    return Intl.message(
      'No audio available',
      name: 'no_audio',
      desc: '',
      args: [],
    );
  }

  /// `Healing`
  String get healing_category {
    return Intl.message(
      'Healing',
      name: 'healing_category',
      desc: '',
      args: [],
    );
  }

  /// `Meditation`
  String get meditation_category {
    return Intl.message(
      'Meditation',
      name: 'meditation_category',
      desc: '',
      args: [],
    );
  }

  /// `Relaxation`
  String get relaxation_category {
    return Intl.message(
      'Relaxation',
      name: 'relaxation_category',
      desc: '',
      args: [],
    );
  }

  /// `Sleep`
  String get sleep_category {
    return Intl.message('Sleep', name: 'sleep_category', desc: '', args: []);
  }

  /// `Energy`
  String get energy_category {
    return Intl.message('Energy', name: 'energy_category', desc: '', args: []);
  }

  /// `Emotion`
  String get emotion_category {
    return Intl.message(
      'Emotion',
      name: 'emotion_category',
      desc: '',
      args: [],
    );
  }

  /// `Record Daily Status`
  String get record_daily_status {
    return Intl.message(
      'Record Daily Status',
      name: 'record_daily_status',
      desc: '',
      args: [],
    );
  }

  /// `Mood`
  String get mood {
    return Intl.message('Mood', name: 'mood', desc: '', args: []);
  }

  /// `Energy`
  String get energy {
    return Intl.message('Energy', name: 'energy', desc: '', args: []);
  }

  /// `Stress`
  String get stress {
    return Intl.message('Stress', name: 'stress', desc: '', args: []);
  }

  /// `Notes`
  String get notes {
    return Intl.message('Notes', name: 'notes', desc: '', args: []);
  }

  /// `✅ Status saved`
  String get status_saved {
    return Intl.message(
      '✅ Status saved',
      name: 'status_saved',
      desc: '',
      args: [],
    );
  }

  /// `No quotes available`
  String get no_quotes {
    return Intl.message(
      'No quotes available',
      name: 'no_quotes',
      desc: '',
      args: [],
    );
  }

  /// `Spiritual Growth`
  String get spiritual_growth {
    return Intl.message(
      'Spiritual Growth',
      name: 'spiritual_growth',
      desc: '',
      args: [],
    );
  }

  /// `Please write your feelings`
  String get please_write_feelings {
    return Intl.message(
      'Please write your feelings',
      name: 'please_write_feelings',
      desc: '',
      args: [],
    );
  }

  /// `❌ Save failed: {error}`
  String save_failed(Object error) {
    return Intl.message(
      '❌ Save failed: $error',
      name: 'save_failed',
      desc: '',
      args: [error],
    );
  }

  /// `{x} hours`
  String x_hours(Object x) {
    return Intl.message('$x hours', name: 'x_hours', desc: '', args: [x]);
  }

  /// `{x} times`
  String x_times(Object x) {
    return Intl.message('$x times', name: 'x_times', desc: '', args: [x]);
  }

  /// `{x} days`
  String x_days(Object x) {
    return Intl.message('$x days', name: 'x_days', desc: '', args: [x]);
  }

  /// `Meditation Practice`
  String get meditation_practice_title {
    return Intl.message(
      'Meditation Practice',
      name: 'meditation_practice_title',
      desc: '',
      args: [],
    );
  }

  /// `Emotion Management`
  String get emotion_management_title {
    return Intl.message(
      'Emotion Management',
      name: 'emotion_management_title',
      desc: '',
      args: [],
    );
  }

  /// `Daily Quotes`
  String get daily_quotes_title {
    return Intl.message(
      'Daily Quotes',
      name: 'daily_quotes_title',
      desc: '',
      args: [],
    );
  }

  /// `Healing Music`
  String get healing_music_title {
    return Intl.message(
      'Healing Music',
      name: 'healing_music_title',
      desc: '',
      args: [],
    );
  }

  /// `Emotion Diary`
  String get emotion_diary {
    return Intl.message(
      'Emotion Diary',
      name: 'emotion_diary',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Mood Index`
  String get mood_index {
    return Intl.message('Mood Index', name: 'mood_index', desc: '', args: []);
  }

  /// `Energy Level`
  String get energy_level {
    return Intl.message(
      'Energy Level',
      name: 'energy_level',
      desc: '',
      args: [],
    );
  }

  /// `Stress Level`
  String get stress_level {
    return Intl.message(
      'Stress Level',
      name: 'stress_level',
      desc: '',
      args: [],
    );
  }

  /// `What would you like to record today?`
  String get record_today_hint {
    return Intl.message(
      'What would you like to record today?',
      name: 'record_today_hint',
      desc: '',
      args: [],
    );
  }

  /// `Accept yourself in the present moment, emotions flow like stars and will eventually return to peace`
  String get emotion_tip {
    return Intl.message(
      'Accept yourself in the present moment, emotions flow like stars and will eventually return to peace',
      name: 'emotion_tip',
      desc: '',
      args: [],
    );
  }

  /// `Astro Healing Calendar`
  String get astro_calendar_title {
    return Intl.message(
      'Astro Healing Calendar',
      name: 'astro_calendar_title',
      desc: '',
      args: [],
    );
  }

  /// `Healing Sessions`
  String get healing_sessions {
    return Intl.message(
      'Healing Sessions',
      name: 'healing_sessions',
      desc: '',
      args: [],
    );
  }

  /// `{month}月{day}日`
  String month_day_format(Object month, Object day) {
    return Intl.message(
      '$month月$day日',
      name: 'month_day_format',
      desc: '',
      args: [month, day],
    );
  }

  /// `Meditation Practice`
  String get meditation_practice {
    return Intl.message(
      'Meditation Practice',
      name: 'meditation_practice',
      desc: '',
      args: [],
    );
  }

  /// `{minutes} minutes`
  String minutes_duration(Object minutes) {
    return Intl.message(
      '$minutes minutes',
      name: 'minutes_duration',
      desc: '',
      args: [minutes],
    );
  }

  /// `Emotion Diary`
  String get emotion_diary_title {
    return Intl.message(
      'Emotion Diary',
      name: 'emotion_diary_title',
      desc: '',
      args: [],
    );
  }

  /// `Recorded emotion`
  String get recorded_emotion {
    return Intl.message(
      'Recorded emotion',
      name: 'recorded_emotion',
      desc: '',
      args: [],
    );
  }

  /// `Mood {score}/10`
  String mood_score(Object score) {
    return Intl.message(
      'Mood $score/10',
      name: 'mood_score',
      desc: '',
      args: [score],
    );
  }

  /// `Played audio`
  String get played_audio {
    return Intl.message(
      'Played audio',
      name: 'played_audio',
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
