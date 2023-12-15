// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(something) => "\"Ich interessiere mich für ${something}!\"";

  static String m1(something) => "Ich bin sehr interessiert an ‘${something}’!";

  static String m2(lang) => "Tippen Sie einfach auf ${lang}";

  static String m3(gender) =>
      "Welche ${Intl.gender(gender, female: 'ihrer', male: 'seiner', other: 'ihrer')} Ideen gefällt dir?";

  static String m4(country) => "Überspringen, Nur ${country}";

  static String m5(country) => "Planst du, nach ${country} zu gehen?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "age": MessageLookupByLibrary.simpleMessage("Alter"),
        "block": MessageLookupByLibrary.simpleMessage("Blockieren"),
        "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
            MessageLookupByLibrary.simpleMessage(
                "Blockieren Sie diese Person, damit Sie keine Nachrichten mehr von ihr erhalten"),
        "breakIce": MessageLookupByLibrary.simpleMessage(
            "🔨🔨🔨 Beachte mich nicht🔨🔨🔨 Ich breche nur das Eis🔨🔨🔨"),
        "buttonCopy": MessageLookupByLibrary.simpleMessage("Kopieren"),
        "buttonDelete": MessageLookupByLibrary.simpleMessage("Löschen"),
        "buttonOpenLink": MessageLookupByLibrary.simpleMessage("Link öffnen"),
        "buttonResend": MessageLookupByLibrary.simpleMessage("Erneut senden"),
        "buttonUnmatch": MessageLookupByLibrary.simpleMessage("Match aufheben"),
        "cancelButton": MessageLookupByLibrary.simpleMessage("Abbrechen"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "checkOutTheirProfiles":
            MessageLookupByLibrary.simpleMessage("Schau dir ihre Profile an"),
        "choosePlaceholder": MessageLookupByLibrary.simpleMessage("Wählen"),
        "commonLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Häufig verwendete Sprachen"),
        "descriptionOptional":
            MessageLookupByLibrary.simpleMessage("Beschreibung (optional)"),
        "dm": MessageLookupByLibrary.simpleMessage("DM"),
        "doneButton": MessageLookupByLibrary.simpleMessage("Erledigt"),
        "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
            "Senden fehlgeschlagen, bitte versuchen Sie es später noch einmal."),
        "exceptionSonaContentFilterTips": MessageLookupByLibrary.simpleMessage(
            "Nicht gesendet. SONA wird verbotene Wörter nicht übersetzen."),
        "exceptionSonaOverloadedTips": MessageLookupByLibrary.simpleMessage(
            "SONA ist überlastet, bitte versuchen Sie es später noch einmal."),
        "filter": MessageLookupByLibrary.simpleMessage("Filter"),
        "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
            "SONA sucht nach potenziellen Freunden..."),
        "friendsIntention": MessageLookupByLibrary.simpleMessage(
            "Hey, ich finde dich echt toll. Wie wäre es, wenn wir Freunde werden?"),
        "gore": MessageLookupByLibrary.simpleMessage("Blut"),
        "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
            "Hey, rate mal, wer zuerst das Schweigen bricht?"),
        "haveSonaSayHi":
            MessageLookupByLibrary.simpleMessage("Lass SONA Hallo sagen"),
        "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
            "Was halten Sie von der simultanen KI-Dolmetschung?"),
        "iDigYourEnergy":
            MessageLookupByLibrary.simpleMessage("Deine Energie gefällt mir!"),
        "iLikeYourStyle":
            MessageLookupByLibrary.simpleMessage("Ich mag deinen Stil!"),
        "imInterestedSomething": m0,
        "imVeryInterestedInSomething": m1,
        "interests": MessageLookupByLibrary.simpleMessage("Interessen"),
        "interpretationOff": MessageLookupByLibrary.simpleMessage(
            "KI-Synchrone Interpretation: Aus"),
        "interpretationOn": MessageLookupByLibrary.simpleMessage(
            "KI-Synchrone Interpretation: Ein"),
        "justSendALike":
            MessageLookupByLibrary.simpleMessage("Schicke einfach ein Like"),
        "justTypeInYourLanguage": m2,
        "letSONASayHiForYou":
            MessageLookupByLibrary.simpleMessage("Lass SONA für dich grüßen"),
        "likedPageMonetizeButton":
            MessageLookupByLibrary.simpleMessage("Schau dir ihre Profile an"),
        "likedPageNoData": MessageLookupByLibrary.simpleMessage(
            "Status: Noch keine Likes\n\nWas tun: Ergreifen Sie die Initiative\n\nVorschlag: Laden Sie Ihre zufriedenstellenden Fotos hoch\nSchreiben Sie eine echte Biografie\nWählen Sie Ihre Interessen"),
        "likedYou": MessageLookupByLibrary.simpleMessage("Hat dich gemocht"),
        "locationPermissionRequestSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Ausländer in derselben Stadt finden"),
        "locationPermissionRequestTitle":
            MessageLookupByLibrary.simpleMessage("Standort autorisieren"),
        "matchPageSelectIdeas": m3,
        "nearby": MessageLookupByLibrary.simpleMessage("In der Nähe"),
        "newMatch": MessageLookupByLibrary.simpleMessage("Neues Match!"),
        "nextButton": MessageLookupByLibrary.simpleMessage("Nächster Schritt"),
        "noMessageTips": MessageLookupByLibrary.simpleMessage(
            "Status: Keine Nachrichten\n\nVorschlag: Gehe zur Pairing-Seite\n\nVorschlag: Erstellen Sie ein tolles Profil"),
        "oopsNoDataRightNow":
            MessageLookupByLibrary.simpleMessage("Hoppla, gerade keine Daten"),
        "other": MessageLookupByLibrary.simpleMessage("Andere"),
        "peopleFromYourWishlistGetMoreRecommendations":
            MessageLookupByLibrary.simpleMessage(
                "Die Einstellungen Ihrer Wunschliste werden eine größere Rolle spielen"),
        "personalAttack":
            MessageLookupByLibrary.simpleMessage("Persönlicher Angriff"),
        "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Bitte überprüfen Sie Ihr Internet oder Tippen Sie auf Aktualisieren und versuchen Sie es erneut"),
        "pornography": MessageLookupByLibrary.simpleMessage("Pornografie"),
        "preference": MessageLookupByLibrary.simpleMessage("Präferenz"),
        "refresh": MessageLookupByLibrary.simpleMessage("Aktualisieren"),
        "report": MessageLookupByLibrary.simpleMessage("Melden"),
        "resendButton": MessageLookupByLibrary.simpleMessage("Erneut senden"),
        "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
            "Ausländer in deiner Nähe treffen"),
        "scam": MessageLookupByLibrary.simpleMessage("Betrug"),
        "screenshotEvidence":
            MessageLookupByLibrary.simpleMessage("Beweis-Screenshot"),
        "seeProfile": MessageLookupByLibrary.simpleMessage("Profil ansehen"),
        "seeWhoLikeU":
            MessageLookupByLibrary.simpleMessage("Sehen, wer dich mag"),
        "selectCountryPageTitle":
            MessageLookupByLibrary.simpleMessage("Land auswählen"),
        "signUpLastStepPageTitle":
            MessageLookupByLibrary.simpleMessage("Letzter Schritt"),
        "sonaInterpretationOff": MessageLookupByLibrary.simpleMessage(
            "⭕ SONA Simultanübersetzung deaktiviert"),
        "sonaRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
            "Sona-Empfehlung: Abkühlung.\nWas tun: Warten.\nVorschlag: Einen Film anschauen?"),
        "speakSameLanguage": MessageLookupByLibrary.simpleMessage(
            "Ihr sprecht dieselbe Sprache"),
        "submitButton": MessageLookupByLibrary.simpleMessage("Einreichen"),
        "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
            "👆 Sie warten auf deine Antwort"),
        "userAvatarOptionCamera":
            MessageLookupByLibrary.simpleMessage("Ein Foto machen"),
        "userAvatarOptionGallery":
            MessageLookupByLibrary.simpleMessage("Aus der Galerie auswählen"),
        "userAvatarPageChangeButton":
            MessageLookupByLibrary.simpleMessage("Ändern"),
        "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
            "Ein gutes Porträt bringt dir mehr Matches. Sei echt und benutze ein legitimes Foto von dir."),
        "userAvatarPageTitle":
            MessageLookupByLibrary.simpleMessage("Zeige dich"),
        "userAvatarUploadedLabel":
            MessageLookupByLibrary.simpleMessage("Upload abgeschlossen!"),
        "userBirthdayInputLabel":
            MessageLookupByLibrary.simpleMessage("Geburtsdatum"),
        "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Einmal bestätigt, kann die Staatsangehörigkeit nicht geändert werden"),
        "userCitizenshipPickerTitle":
            MessageLookupByLibrary.simpleMessage("Staatsangehörigkeit"),
        "userGenderInputLabel":
            MessageLookupByLibrary.simpleMessage("Geschlecht"),
        "userGenderOptionFemale":
            MessageLookupByLibrary.simpleMessage("Weiblich"),
        "userGenderOptionMale":
            MessageLookupByLibrary.simpleMessage("Männlich"),
        "userGenderOptionNonBinary":
            MessageLookupByLibrary.simpleMessage("Nichtbinär"),
        "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Ihr Geschlecht wird nicht öffentlich angezeigt, es wird nur zur Unterstützung der Übereinstimmung verwendet"),
        "userInfoPageNamePlaceholder":
            MessageLookupByLibrary.simpleMessage("Eintreten"),
        "userInfoPageTitle":
            MessageLookupByLibrary.simpleMessage("Grundinformationen"),
        "userNameInputLabel": MessageLookupByLibrary.simpleMessage("Name"),
        "userPhoneNumberPagePlaceholder":
            MessageLookupByLibrary.simpleMessage("Telefonnummer"),
        "userPhoneNumberPagePrivacySuffix":
            MessageLookupByLibrary.simpleMessage(" zu"),
        "userPhoneNumberPagePrivacyText":
            MessageLookupByLibrary.simpleMessage("Datenschutzbestimmungen"),
        "userPhoneNumberPageTermsAnd":
            MessageLookupByLibrary.simpleMessage(" und "),
        "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
            "Indem Sie auf \"Nächster Schritt\" tippen, stimmen Sie unseren "),
        "userPhoneNumberPageTermsText":
            MessageLookupByLibrary.simpleMessage("Nutzungsbedingungen"),
        "userPhoneNumberPageTitle": MessageLookupByLibrary.simpleMessage(
            "Geben Sie die Telefonnummer ein"),
        "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage(
            "Geben Sie den Verifizierungscode ein"),
        "wannaHollaAt": MessageLookupByLibrary.simpleMessage("Sag Hallo!"),
        "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
            "Externer Link. Überprüfen Sie, ob die Quelle vertrauenswürdig ist, bevor Sie darauf tippen, da unbekannte Links Betrügereien sein oder Daten stehlen können. Vorgehen Sie vorsichtig."),
        "warningTitleCaution": MessageLookupByLibrary.simpleMessage("Vorsicht"),
        "warningUnmatching": MessageLookupByLibrary.simpleMessage(
            "Nach dem Aufheben der Paarung wird der gesamte Chatverlauf gelöscht."),
        "whoLIkesYou": MessageLookupByLibrary.simpleMessage("Wer mag dich"),
        "whoLikesU": MessageLookupByLibrary.simpleMessage("Wer mag dich"),
        "wishActivityAddTitle":
            MessageLookupByLibrary.simpleMessage("Füge deinen Gedanken hinzu"),
        "wishActivityPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("Helfen, Begleiter zu finden"),
        "wishActivityPickerTitle":
            MessageLookupByLibrary.simpleMessage("Willst du etwas machen?"),
        "wishCityPickerSkipButton": m4,
        "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "wenn Sie dorthin gehen, Welche Städte möchten Sie besuchen?"),
        "wishCountryPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Landes fühlst du dich am meisten verbunden?"),
        "wishCountryPickerTitle":
            MessageLookupByLibrary.simpleMessage("Welches"),
        "wishCreationComplete":
            MessageLookupByLibrary.simpleMessage("Dein Wunsch wurde erhalten"),
        "wishDateOptionHere":
            MessageLookupByLibrary.simpleMessage("Schon hier"),
        "wishDateOptionNotSure":
            MessageLookupByLibrary.simpleMessage("Noch nicht sicher"),
        "wishDateOptionRecent":
            MessageLookupByLibrary.simpleMessage("Neulich, denke ich"),
        "wishDateOptionYear":
            MessageLookupByLibrary.simpleMessage("Innerhalb eines Jahres"),
        "wishDatePickerSubtitle": m5,
        "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("Wann"),
        "wishList": MessageLookupByLibrary.simpleMessage("Wunschliste"),
        "wishes": MessageLookupByLibrary.simpleMessage("Wunsch"),
        "youSeemCool": MessageLookupByLibrary.simpleMessage("Du wirkst cool")
      };
}
