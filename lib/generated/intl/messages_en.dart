// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(something) => "\"I\'m interested in ${something}\"";

  static String m1(something) => "I’m very interested in ‘${something}’!";

  static String m2(lang) => "Just type in ${lang}";

  static String m3(gender) =>
      "Which of ${Intl.gender(gender, female: 'her', male: 'his', other: 'their')} ideas do you like?";

  static String m4(country) => "Skip, Just ${country}";

  static String m5(country) => "are you planning to go to ${country}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "age": MessageLookupByLibrary.simpleMessage("Age"),
        "block": MessageLookupByLibrary.simpleMessage("Block"),
        "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
            MessageLookupByLibrary.simpleMessage(
                "Block this person so you won\'t receive any messages from them"),
        "breakIce": MessageLookupByLibrary.simpleMessage(
            "🔨🔨🔨 Don\'t mind me🔨🔨🔨 I\'m just here to break the ice🔨🔨🔨"),
        "buttonCopy": MessageLookupByLibrary.simpleMessage("Copy"),
        "buttonDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "buttonOpenLink": MessageLookupByLibrary.simpleMessage("Open Link"),
        "buttonResend": MessageLookupByLibrary.simpleMessage("Resend"),
        "buttonUnmatch": MessageLookupByLibrary.simpleMessage("Unmatch"),
        "cancelButton": MessageLookupByLibrary.simpleMessage("Cancel"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "checkOutTheirProfiles":
            MessageLookupByLibrary.simpleMessage("Check out their profiles"),
        "choosePlaceholder": MessageLookupByLibrary.simpleMessage("Choose"),
        "commonLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Common language"),
        "descriptionOptional":
            MessageLookupByLibrary.simpleMessage("Description (optional)"),
        "dm": MessageLookupByLibrary.simpleMessage("DM"),
        "doneButton": MessageLookupByLibrary.simpleMessage("Done"),
        "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
            "Failed to send, please try again later."),
        "exceptionSonaContentFilterTips": MessageLookupByLibrary.simpleMessage(
            "Unsent. SONA will not translate prohibited words"),
        "exceptionSonaOverloadedTips": MessageLookupByLibrary.simpleMessage(
            "SONA is overloaded, please try again later."),
        "filter": MessageLookupByLibrary.simpleMessage("Filter"),
        "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
            "SONA is finding some potential friend..."),
        "friendsIntention": MessageLookupByLibrary.simpleMessage(
            "Hey, I think you\'re pretty awesome. How about we hit it off as friends?"),
        "gore": MessageLookupByLibrary.simpleMessage("Gore"),
        "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
            "Hey, guess who\'s gonna break the silence first?"),
        "haveSonaSayHi":
            MessageLookupByLibrary.simpleMessage("Have SONA Say Hi"),
        "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
            "How do you feel about AI interpretation?"),
        "iDigYourEnergy":
            MessageLookupByLibrary.simpleMessage("I dig your energy!"),
        "iLikeYourStyle":
            MessageLookupByLibrary.simpleMessage("I like your style!"),
        "imInterestedSomething": m0,
        "imVeryInterestedInSomething": m1,
        "interests": MessageLookupByLibrary.simpleMessage("Interests"),
        "interpretationOff":
            MessageLookupByLibrary.simpleMessage("AI Interpretation: Off"),
        "interpretationOn":
            MessageLookupByLibrary.simpleMessage("AI Interpretation: On"),
        "justSendALike":
            MessageLookupByLibrary.simpleMessage("Just Send a Like"),
        "justTypeInYourLanguage": m2,
        "letSONASayHiForYou":
            MessageLookupByLibrary.simpleMessage("Let SONA say hi for you"),
        "likedPageMonetizeButton":
            MessageLookupByLibrary.simpleMessage("Check out their profiles"),
        "likedPageNoData": MessageLookupByLibrary.simpleMessage(
            "Status: No likes yet\n\nWhat to do: Take the initiative\n\nSuggestion:\n\"Self-portraits in light,\nA genuine bio\'s insight,\nInterests ignite.\"\n\nEmm..I mean...\nUpload some nice photos\nWrite a genuine bio\nPick your interests"),
        "likedYou": MessageLookupByLibrary.simpleMessage("Liked you"),
        "locationPermissionRequestSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Find foreigners in the same city"),
        "locationPermissionRequestTitle":
            MessageLookupByLibrary.simpleMessage("Authorize location"),
        "matchPageSelectIdeas": m3,
        "nearby": MessageLookupByLibrary.simpleMessage("Nearby"),
        "newMatch": MessageLookupByLibrary.simpleMessage("New Matched!"),
        "nextButton": MessageLookupByLibrary.simpleMessage("Next"),
        "noMessageTips": MessageLookupByLibrary.simpleMessage(
            "Status: No messages\n\nWhat to do: Go to match\n\nSuggestion: Make an awesome profile"),
        "oopsNoDataRightNow":
            MessageLookupByLibrary.simpleMessage("Oops, no data right now"),
        "other": MessageLookupByLibrary.simpleMessage("Other"),
        "peopleFromYourWishlistGetMoreRecommendations":
            MessageLookupByLibrary.simpleMessage(
                "People from your wishlist get more recommendations"),
        "personalAttack":
            MessageLookupByLibrary.simpleMessage("Personal Attack"),
        "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Please check your internet or Tap to Refresh and try again"),
        "pornography": MessageLookupByLibrary.simpleMessage("Pornography"),
        "preference": MessageLookupByLibrary.simpleMessage("Preference"),
        "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
        "report": MessageLookupByLibrary.simpleMessage("Report"),
        "resendButton": MessageLookupByLibrary.simpleMessage("Resend"),
        "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
            "Running into foreigners near you"),
        "scam": MessageLookupByLibrary.simpleMessage("Scam"),
        "screenshotEvidence":
            MessageLookupByLibrary.simpleMessage("Screenshot evidence"),
        "seeProfile": MessageLookupByLibrary.simpleMessage("See profile"),
        "seeWhoLikeU":
            MessageLookupByLibrary.simpleMessage("See who likes you"),
        "selectCountryPageTitle":
            MessageLookupByLibrary.simpleMessage("Select Country"),
        "signUpLastStepPageTitle":
            MessageLookupByLibrary.simpleMessage("Last step"),
        "sonaInterpretationOff": MessageLookupByLibrary.simpleMessage(
            "⭕ SONA interpretation is turned off"),
        "sonaRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
            "Sona Recommendation: Cooldown\nWhat to do: Wait\nSuggestion: Watch a movie?"),
        "speakSameLanguage": MessageLookupByLibrary.simpleMessage(
            "🤝 You guys speak the same language"),
        "submitButton": MessageLookupByLibrary.simpleMessage("Submit"),
        "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
            "👆 They\'re waiting for your reply"),
        "userAvatarOptionCamera":
            MessageLookupByLibrary.simpleMessage("Take a photo"),
        "userAvatarOptionGallery":
            MessageLookupByLibrary.simpleMessage("From gallery"),
        "userAvatarPageChangeButton":
            MessageLookupByLibrary.simpleMessage("Change"),
        "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
            "A good portrait gets you more matches. Keep it real and use a legit pic of yourself."),
        "userAvatarPageTitle":
            MessageLookupByLibrary.simpleMessage("Show Yourself"),
        "userAvatarUploadedLabel":
            MessageLookupByLibrary.simpleMessage("Upload done!"),
        "userBirthdayInputLabel":
            MessageLookupByLibrary.simpleMessage("Day of birth"),
        "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Once confirmed, citizenship cannot be changed"),
        "userCitizenshipPickerTitle":
            MessageLookupByLibrary.simpleMessage("Citizen of"),
        "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("Gender"),
        "userGenderOptionFemale":
            MessageLookupByLibrary.simpleMessage("Female"),
        "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("Male"),
        "userGenderOptionNonBinary":
            MessageLookupByLibrary.simpleMessage("Non-binary"),
        "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Your gender will not be shown public, it only be used to help for match"),
        "userInfoPageNamePlaceholder":
            MessageLookupByLibrary.simpleMessage("Enter"),
        "userInfoPageTitle":
            MessageLookupByLibrary.simpleMessage("Introduce yourself"),
        "userNameInputLabel": MessageLookupByLibrary.simpleMessage("Name"),
        "userPhoneNumberPagePlaceholder":
            MessageLookupByLibrary.simpleMessage("Phone Number"),
        "userPhoneNumberPagePrivacySuffix":
            MessageLookupByLibrary.simpleMessage(""),
        "userPhoneNumberPagePrivacyText":
            MessageLookupByLibrary.simpleMessage("privacy policy"),
        "userPhoneNumberPageTermsAnd":
            MessageLookupByLibrary.simpleMessage(" and "),
        "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
            "By tapping \"Next Step\", you agree to our "),
        "userPhoneNumberPageTermsText":
            MessageLookupByLibrary.simpleMessage("terms of service"),
        "userPhoneNumberPageTitle":
            MessageLookupByLibrary.simpleMessage("What’s your number?"),
        "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage(
            "Enter verification code we‘ve just sent"),
        "wannaHollaAt":
            MessageLookupByLibrary.simpleMessage("Wanna holla at..."),
        "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
            "External link. Verify source is trustworthy before tapping, as unknown links may be scams or steal data. Proceed with caution."),
        "warningTitleCaution": MessageLookupByLibrary.simpleMessage("Caution"),
        "warningUnmatching": MessageLookupByLibrary.simpleMessage(
            "After unmatching, all your chat history will be deleted."),
        "whoLIkesYou": MessageLookupByLibrary.simpleMessage("Who likes you"),
        "whoLikesU": MessageLookupByLibrary.simpleMessage("Who likes you"),
        "wishActivityAddTitle":
            MessageLookupByLibrary.simpleMessage("Add your thought"),
        "wishActivityPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("Help you find companions"),
        "wishActivityPickerTitle":
            MessageLookupByLibrary.simpleMessage("Wanna do something?"),
        "wishCityPickerSkipButton": m4,
        "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "if you go there, Which cities do you want to visit?"),
        "wishCountryPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Country\'s peeps you vibin\' with?"),
        "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage("Which"),
        "wishCreationComplete": MessageLookupByLibrary.simpleMessage(
            "Your wish has been received!"),
        "wishDateOptionHere":
            MessageLookupByLibrary.simpleMessage("Already here"),
        "wishDateOptionNotSure":
            MessageLookupByLibrary.simpleMessage("Not sure yet"),
        "wishDateOptionRecent":
            MessageLookupByLibrary.simpleMessage("Recently, I guess"),
        "wishDateOptionYear":
            MessageLookupByLibrary.simpleMessage("Within a year"),
        "wishDatePickerSubtitle": m5,
        "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("When"),
        "wishList": MessageLookupByLibrary.simpleMessage("Wish List"),
        "wishes": MessageLookupByLibrary.simpleMessage("Wishes"),
        "youSeemCool": MessageLookupByLibrary.simpleMessage("You seem cool")
      };
}
