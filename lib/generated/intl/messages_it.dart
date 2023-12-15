// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a it locale. All the
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
  String get localeName => 'it';

  static String m0(something) => "\"Sono interessato a ${something}!\"";

  static String m1(something) => "Sono molto interessato a ‘${something}’!";

  static String m2(lang) => "Basta scrivere in ${lang}";

  static String m3(gender) =>
      "Quale delle ${Intl.gender(gender, female: 'sue', male: 'sue', other: 'loro')} idee ti piace?";

  static String m4(country) => "Saltare, Solo ${country}";

  static String m5(country) => "Hai in programma di andare in ${country}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "age": MessageLookupByLibrary.simpleMessage("Età"),
        "block": MessageLookupByLibrary.simpleMessage("Bloccare"),
        "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
            MessageLookupByLibrary.simpleMessage(
                "Blocca questa persona per non ricevere più messaggi da loro"),
        "breakIce": MessageLookupByLibrary.simpleMessage(
            "🔨🔨🔨 Non fare caso a me🔨🔨🔨 Sto solo rompendo il ghiaccio🔨🔨🔨"),
        "buttonCopy": MessageLookupByLibrary.simpleMessage("Copiare"),
        "buttonDelete": MessageLookupByLibrary.simpleMessage("Cancellare"),
        "buttonOpenLink": MessageLookupByLibrary.simpleMessage("Apri Link"),
        "buttonResend": MessageLookupByLibrary.simpleMessage("Reinviare"),
        "buttonUnmatch":
            MessageLookupByLibrary.simpleMessage("Annulla il match"),
        "cancelButton": MessageLookupByLibrary.simpleMessage("Annullare"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "checkOutTheirProfiles":
            MessageLookupByLibrary.simpleMessage("Controlla i loro profili"),
        "choosePlaceholder": MessageLookupByLibrary.simpleMessage("Scegliere"),
        "commonLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Lingue comunemente usate"),
        "descriptionOptional":
            MessageLookupByLibrary.simpleMessage("Descrizione (opzionale)"),
        "dm": MessageLookupByLibrary.simpleMessage("DM"),
        "doneButton": MessageLookupByLibrary.simpleMessage("Fatto"),
        "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
            "Invio fallito, per favore riprova più tardi."),
        "exceptionSonaContentFilterTips": MessageLookupByLibrary.simpleMessage(
            "Non inviato. SONA non tradurrà parole proibite."),
        "exceptionSonaOverloadedTips": MessageLookupByLibrary.simpleMessage(
            "SONA è sovraccaricata, per favore riprova più tardi."),
        "filter": MessageLookupByLibrary.simpleMessage("Filtro"),
        "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
            "SONA sta trovando alcuni amici potenziali..."),
        "friendsIntention": MessageLookupByLibrary.simpleMessage(
            "Ehi, penso che tu sia fantastico. Che ne dici di diventare amici?"),
        "gore": MessageLookupByLibrary.simpleMessage("Gore"),
        "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
            "Ehi, indovina chi romperà il silenzio per primo?"),
        "haveSonaSayHi":
            MessageLookupByLibrary.simpleMessage("Lascia che SONA dica ciao"),
        "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
            "Cosa ne pensi dell\'interpretazione simultanea AI?"),
        "iDigYourEnergy":
            MessageLookupByLibrary.simpleMessage("Mi piace la tua energia!"),
        "iLikeYourStyle":
            MessageLookupByLibrary.simpleMessage("Mi piace il tuo stile!"),
        "imInterestedSomething": m0,
        "imVeryInterestedInSomething": m1,
        "interests": MessageLookupByLibrary.simpleMessage("Interessi"),
        "interpretationOff": MessageLookupByLibrary.simpleMessage(
            "Interpretazione Sincrona AI: Disattiva"),
        "interpretationOn": MessageLookupByLibrary.simpleMessage(
            "Interpretazione Sincrona AI: Attiva"),
        "justSendALike":
            MessageLookupByLibrary.simpleMessage("Invia solo un Mi Piace"),
        "justTypeInYourLanguage": m2,
        "letSONASayHiForYou": MessageLookupByLibrary.simpleMessage(
            "Lascia che SONA dica ciao per te"),
        "likedPageMonetizeButton":
            MessageLookupByLibrary.simpleMessage("Controlla i loro profili"),
        "likedPageNoData": MessageLookupByLibrary.simpleMessage(
            "Stato: Ancora nessun mi piace\n\nCosa fare: Prendi l\'iniziativa\n\nSuggerimento: Carica le tue foto soddisfacenti\nScrivi una biografia autentica\nScegli i tuoi interessi"),
        "likedYou": MessageLookupByLibrary.simpleMessage("Ti è piaciuto"),
        "locationPermissionRequestSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Trovare stranieri nella stessa città"),
        "locationPermissionRequestTitle":
            MessageLookupByLibrary.simpleMessage("Autorizza la posizione"),
        "matchPageSelectIdeas": m3,
        "nearby": MessageLookupByLibrary.simpleMessage("Vicino"),
        "newMatch": MessageLookupByLibrary.simpleMessage("Nuova partita!"),
        "nextButton": MessageLookupByLibrary.simpleMessage("Prossimo Passo"),
        "noMessageTips": MessageLookupByLibrary.simpleMessage(
            "Stato: Nessun messaggio\n\nSuggerimento: Vai alla pagina di abbinamento\n\nSuggerimento: Crea un profilo fantastico"),
        "oopsNoDataRightNow":
            MessageLookupByLibrary.simpleMessage("Ops, nessun dato al momento"),
        "other": MessageLookupByLibrary.simpleMessage("Altro"),
        "peopleFromYourWishlistGetMoreRecommendations":
            MessageLookupByLibrary.simpleMessage(
                "Le impostazioni della tua lista dei desideri avranno un ruolo più grande"),
        "personalAttack":
            MessageLookupByLibrary.simpleMessage("Attacco personale"),
        "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Si prega di controllare la propria connessione internet o Toccare per Aggiornare e riprovare"),
        "pornography": MessageLookupByLibrary.simpleMessage("Pornografia"),
        "preference": MessageLookupByLibrary.simpleMessage("Preferenza"),
        "refresh": MessageLookupByLibrary.simpleMessage("Aggiornare"),
        "report": MessageLookupByLibrary.simpleMessage("Segnalare"),
        "resendButton": MessageLookupByLibrary.simpleMessage("Reinviare"),
        "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
            "Incontrare stranieri vicino a te"),
        "scam": MessageLookupByLibrary.simpleMessage("Truffa"),
        "screenshotEvidence":
            MessageLookupByLibrary.simpleMessage("Prova dello screenshot"),
        "seeProfile": MessageLookupByLibrary.simpleMessage("Vedi profilo"),
        "seeWhoLikeU":
            MessageLookupByLibrary.simpleMessage("Vedi chi ti piace"),
        "selectCountryPageTitle":
            MessageLookupByLibrary.simpleMessage("Seleziona Paese"),
        "signUpLastStepPageTitle":
            MessageLookupByLibrary.simpleMessage("Ultimo passo"),
        "sonaInterpretationOff": MessageLookupByLibrary.simpleMessage(
            "⭕ SONA Interpretazione disattivata"),
        "sonaRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
            "Raccomandazione di Sona: Cooldown.\nCosa fare: Aspettare.\nSuggerimento: Guardare un film?"),
        "speakSameLanguage":
            MessageLookupByLibrary.simpleMessage("Parlate la stessa lingua"),
        "submitButton": MessageLookupByLibrary.simpleMessage("Inviare"),
        "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
            "👆 Stanno aspettando la tua risposta"),
        "userAvatarOptionCamera":
            MessageLookupByLibrary.simpleMessage("Scattare una foto"),
        "userAvatarOptionGallery":
            MessageLookupByLibrary.simpleMessage("Selezionare dalla galleria"),
        "userAvatarPageChangeButton":
            MessageLookupByLibrary.simpleMessage("Cambiare"),
        "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
            "Un buon ritratto ti dà più corrispondenze. Sii reale e usa una foto legittima di te stesso."),
        "userAvatarPageTitle":
            MessageLookupByLibrary.simpleMessage("Mostra te stesso"),
        "userAvatarUploadedLabel":
            MessageLookupByLibrary.simpleMessage("Caricamento completato!"),
        "userBirthdayInputLabel":
            MessageLookupByLibrary.simpleMessage("Data di nascita"),
        "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Una volta confermato, la nazionalità non può essere cambiata"),
        "userCitizenshipPickerTitle":
            MessageLookupByLibrary.simpleMessage("Nazionalità"),
        "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("Genere"),
        "userGenderOptionFemale":
            MessageLookupByLibrary.simpleMessage("Femminile"),
        "userGenderOptionMale":
            MessageLookupByLibrary.simpleMessage("Maschile"),
        "userGenderOptionNonBinary":
            MessageLookupByLibrary.simpleMessage("Non binario"),
        "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Il tuo genere non sarà mostrato pubblicamente, verrà utilizzato solo per aiutare nel match"),
        "userInfoPageNamePlaceholder":
            MessageLookupByLibrary.simpleMessage("Inserire"),
        "userInfoPageTitle":
            MessageLookupByLibrary.simpleMessage("Informazioni di base"),
        "userNameInputLabel": MessageLookupByLibrary.simpleMessage("Nome"),
        "userPhoneNumberPagePlaceholder":
            MessageLookupByLibrary.simpleMessage("Numero di Telefono"),
        "userPhoneNumberPagePrivacySuffix":
            MessageLookupByLibrary.simpleMessage(""),
        "userPhoneNumberPagePrivacyText":
            MessageLookupByLibrary.simpleMessage("politica sulla privacy"),
        "userPhoneNumberPageTermsAnd":
            MessageLookupByLibrary.simpleMessage(" e "),
        "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
            "Toccando \"Prossimo Passo\", accetti i nostri "),
        "userPhoneNumberPageTermsText":
            MessageLookupByLibrary.simpleMessage("termini di servizio"),
        "userPhoneNumberPageTitle": MessageLookupByLibrary.simpleMessage(
            "Inserisci il numero di telefono"),
        "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage(
            "Inserisci il codice di verifica"),
        "wannaHollaAt": MessageLookupByLibrary.simpleMessage("Dì ciao!"),
        "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
            "Link esterno. Verifica che la fonte sia affidabile prima di cliccare, poiché i link sconosciuti possono essere truffe o rubare dati. Procedere con cautela."),
        "warningTitleCaution":
            MessageLookupByLibrary.simpleMessage("Attenzione"),
        "warningUnmatching": MessageLookupByLibrary.simpleMessage(
            "Dopo lo sganciamento, tutta la cronologia della chat verrà cancellata."),
        "whoLIkesYou": MessageLookupByLibrary.simpleMessage("Chi ti piace"),
        "whoLikesU": MessageLookupByLibrary.simpleMessage("Chi ti piace"),
        "wishActivityAddTitle":
            MessageLookupByLibrary.simpleMessage("Aggiungi il tuo pensiero"),
        "wishActivityPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("Aiutarti a trovare compagni"),
        "wishActivityPickerTitle":
            MessageLookupByLibrary.simpleMessage("Vuoi fare qualcosa?"),
        "wishCityPickerSkipButton": m4,
        "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "se vai là, Quali città vuoi visitare?"),
        "wishCountryPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "paese ti senti più in sintonia?"),
        "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage("Quale"),
        "wishCreationComplete": MessageLookupByLibrary.simpleMessage(
            "Il tuo desiderio è stato ricevuto"),
        "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("Già qui"),
        "wishDateOptionNotSure":
            MessageLookupByLibrary.simpleMessage("Non sono ancora sicuro"),
        "wishDateOptionRecent":
            MessageLookupByLibrary.simpleMessage("Recentemente, credo"),
        "wishDateOptionYear":
            MessageLookupByLibrary.simpleMessage("Entro un anno"),
        "wishDatePickerSubtitle": m5,
        "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("Quando"),
        "wishList": MessageLookupByLibrary.simpleMessage("Lista dei desideri"),
        "wishes": MessageLookupByLibrary.simpleMessage("Desiderio"),
        "youSeemCool": MessageLookupByLibrary.simpleMessage("Sembri figo")
      };
}
