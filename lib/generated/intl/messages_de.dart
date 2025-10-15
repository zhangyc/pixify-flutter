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

  static String m0(month, day) => "${month}/${day}";

  static String m1(x) => "${x} Tage bis zum 30-Tage-Ziel";

  static String m2(something) => "\"Ich interessiere mich für ${something}!\"";

  static String m3(something) => "Ich bin sehr interessiert an ‘${something}’!";

  static String m4(lang) => "Tippen Sie einfach auf ${lang}";

  static String m5(gender) =>
      "Welche ${Intl.gender(gender, female: 'ihrer', male: 'seiner', other: 'ihrer')} geteilten Erfahrungen sprechen dich an?";

  static String m6(minutes) => "${minutes} Minuten";

  static String m7(month, day) => "${month}月${day}日";

  static String m8(score) => "Stimmung ${score}/10";

  static String m9(error) => "❌ Speichern fehlgeschlagen: ${error}";

  static String m10(x) => "🔥 ${x} Tage am Stück!";

  static String m11(storeName) =>
      "Durch Klicken auf \"Fortsetzen\" entstehen Kosten, Ihr Abonnement verlängert sich automatisch zum Paketpreis und kann über den ${storeName} gekündigt werden. Mit dem Fortfahren stimmen Sie ";

  static String m12(count) => "${count} hochpassende Benutzer freischalten ✨";

  static String m13(count, destinyCount) =>
      "${count} Benutzer freischalten einschließlich ${destinyCount} Schicksals-Matches ⭐";

  static String m14(country) => "Überspringen, Nur ${country}";

  static String m15(country) => "Planst du, nach ${country} zu gehen?";

  static String m16(x) => "${x} Tage";

  static String m17(x) => "${x} Stunden";

  static String m18(x) => "${x} Mal";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aMonth": MessageLookupByLibrary.simpleMessage("1 Monate"),
    "aYear": MessageLookupByLibrary.simpleMessage("1 Jahr"),
    "about": MessageLookupByLibrary.simpleMessage("Über"),
    "account": MessageLookupByLibrary.simpleMessage("Konto"),
    "active_days": MessageLookupByLibrary.simpleMessage("Aktive Tage"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("Foto hinzufügen"),
    "age": MessageLookupByLibrary.simpleMessage("Alter"),
    "aiCreatingFunGroupPics": MessageLookupByLibrary.simpleMessage(
      "KI erstellt lustige Gruppenfotos",
    ),
    "allPeople": MessageLookupByLibrary.simpleMessage("Alles"),
    "analyzingText": MessageLookupByLibrary.simpleMessage("Анализирую..."),
    "aquariusSign": MessageLookupByLibrary.simpleMessage("Wassermann"),
    "ariesSign": MessageLookupByLibrary.simpleMessage("Widder"),
    "ascendantSignLabel": MessageLookupByLibrary.simpleMessage(
      "Segno Ascendente",
    ),
    "astroChartTab": MessageLookupByLibrary.simpleMessage("Astro Chart"),
    "astroInfoIncompleteMessage": MessageLookupByLibrary.simpleMessage(
      "Der andere Benutzer hat seine Geburtsort-Informationen noch nicht vervollständigt, daher können wir kein astrologisches Diagramm erstellen. Bitte warten Sie, bis sie ihre Informationen vervollständigen.",
    ),
    "astroLearnInterpretationOff": MessageLookupByLibrary.simpleMessage(
      "⭕ Zena Simultanübersetzung deaktiviert",
    ),
    "astroLearnRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
      "Zena-Empfehlung: Abkühlung.\nWas tun: Warten.\nVorschlag: Einen Film anschauen?",
    ),
    "astroLearnWillGenerateABioBasedOnInterests":
        MessageLookupByLibrary.simpleMessage(
          "Zena wird eine Biografie basierend auf deinen Interessen erstellen",
        ),
    "astroReport": MessageLookupByLibrary.simpleMessage("Astro-Bericht"),
    "astro_calendar_title": MessageLookupByLibrary.simpleMessage(
      "Astrologischer Heilungskalender",
    ),
    "audio_1_desc": MessageLookupByLibrary.simpleMessage(
      "Finde inneren Frieden unter dem stillen Sternenhimmel",
    ),
    "audio_1_title": MessageLookupByLibrary.simpleMessage(
      "Sternenhimmel-Meditation",
    ),
    "audio_2_desc": MessageLookupByLibrary.simpleMessage(
      "Entfache deinen inneren Mut und deine Vitalität",
    ),
    "audio_2_title": MessageLookupByLibrary.simpleMessage(
      "Widder-Energie-Audio",
    ),
    "audio_3_desc": MessageLookupByLibrary.simpleMessage(
      "Lass den Stress los und finde vollständige Entspannung",
    ),
    "audio_3_title": MessageLookupByLibrary.simpleMessage(
      "Tiefenentspannungsführer",
    ),
    "audio_4_desc": MessageLookupByLibrary.simpleMessage(
      "Balanciere Emotionen und finde innere Harmonie",
    ),
    "audio_4_title": MessageLookupByLibrary.simpleMessage(
      "Emotionale Balance-Musik",
    ),
    "avatarUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Avatar-Update fehlgeschlagen",
    ),
    "average_mood": MessageLookupByLibrary.simpleMessage(
      "Durchschnittliche Stimmung",
    ),
    "bio": MessageLookupByLibrary.simpleMessage("Einführung"),
    "birthInfo": MessageLookupByLibrary.simpleMessage(
      "Informazioni di nascita",
    ),
    "birthPlace": MessageLookupByLibrary.simpleMessage("Luogo di nascita"),
    "birthPlaceLabel": MessageLookupByLibrary.simpleMessage("Luogo di nascita"),
    "birthTimeLabel": MessageLookupByLibrary.simpleMessage("Ora di nascita"),
    "birthday": MessageLookupByLibrary.simpleMessage("Compleanno"),
    "block": MessageLookupByLibrary.simpleMessage("Blockieren"),
    "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
        MessageLookupByLibrary.simpleMessage(
          "Blockieren Sie diese Person, damit Sie keine Nachrichten mehr von ihr erhalten",
        ),
    "boostYourAppeal": MessageLookupByLibrary.simpleMessage("Charme Erhöhen"),
    "breakIce": MessageLookupByLibrary.simpleMessage(
      "🔨🔨🔨 Beachte mich nicht🔨🔨🔨 Ich breche nur das Eis🔨🔨🔨",
    ),
    "breathe_relax": MessageLookupByLibrary.simpleMessage(
      "Atmen Sie tief durch und entspannen Sie sich...",
    ),
    "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage(
      "Du bist Plus Mitglied",
    ),
    "buttonAuthorize": MessageLookupByLibrary.simpleMessage("Autorisieren"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Abbrechen"),
    "buttonChange": MessageLookupByLibrary.simpleMessage("Ändern"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Conferma"),
    "buttonContinue": MessageLookupByLibrary.simpleMessage("Fortsetzen"),
    "buttonCopy": MessageLookupByLibrary.simpleMessage("Kopieren"),
    "buttonDelete": MessageLookupByLibrary.simpleMessage("Löschen"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Konto löschen",
    ),
    "buttonDone": MessageLookupByLibrary.simpleMessage("Erledigt"),
    "buttonEdit": MessageLookupByLibrary.simpleMessage("Bearbeiten"),
    "buttonEditProfile": MessageLookupByLibrary.simpleMessage(
      "Profil bearbeiten",
    ),
    "buttonGenerate": MessageLookupByLibrary.simpleMessage("Generieren"),
    "buttonGo": MessageLookupByLibrary.simpleMessage("Gehen"),
    "buttonGotIt": MessageLookupByLibrary.simpleMessage("Verstanden"),
    "buttonHitAIInterpretationMaximumLimit":
        MessageLookupByLibrary.simpleMessage(
          "😪Zena ist müde, 👇Tippen Sie, um sie aufzuladen!",
        ),
    "buttonJoinNow": MessageLookupByLibrary.simpleMessage("Jetzt beitreten"),
    "buttonKeepAccount": MessageLookupByLibrary.simpleMessage("Konto behalten"),
    "buttonManage": MessageLookupByLibrary.simpleMessage("Verwalten"),
    "buttonNext": MessageLookupByLibrary.simpleMessage("Nächster Schritt"),
    "buttonOpenLink": MessageLookupByLibrary.simpleMessage("Link öffnen"),
    "buttonPreview": MessageLookupByLibrary.simpleMessage("Vorschau"),
    "buttonPurchase": MessageLookupByLibrary.simpleMessage("Kaufen"),
    "buttonRefresh": MessageLookupByLibrary.simpleMessage("Aktualisieren"),
    "buttonResend": MessageLookupByLibrary.simpleMessage("Erneut senden"),
    "buttonRestore": MessageLookupByLibrary.simpleMessage("Wiederherstellen"),
    "buttonSave": MessageLookupByLibrary.simpleMessage("Speichern"),
    "buttonSignOut": MessageLookupByLibrary.simpleMessage("Abmelden"),
    "buttonSubmit": MessageLookupByLibrary.simpleMessage("Einreichen"),
    "buttonUnlockVipPerks": MessageLookupByLibrary.simpleMessage(
      "VIP-Vorteile freischalten",
    ),
    "buttonUnmatch": MessageLookupByLibrary.simpleMessage("Teilen beenden"),
    "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("Abbestellen"),
    "cancerSign": MessageLookupByLibrary.simpleMessage("Krebs"),
    "capricornSign": MessageLookupByLibrary.simpleMessage("Steinbock"),
    "catchMore": MessageLookupByLibrary.simpleMessage("Fangen Sie mehr"),
    "charmTips": MessageLookupByLibrary.simpleMessage("Charme-Tipps"),
    "chartPreview": MessageLookupByLibrary.simpleMessage("Diagrammvorschau"),
    "chat": MessageLookupByLibrary.simpleMessage("Chat"),
    "chatWithMatches": MessageLookupByLibrary.simpleMessage(
      "Chatten Sie aktiv mit passenden Benutzern",
    ),
    "checkItOut": MessageLookupByLibrary.simpleMessage(
      "Schauen Sie es sich an",
    ),
    "checkOutTheirProfiles": MessageLookupByLibrary.simpleMessage(
      "Schau dir ihre Profile an",
    ),
    "choosePlaceholder": MessageLookupByLibrary.simpleMessage("Wählen"),
    "clickToSetBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Clicca per impostare il luogo di nascita",
    ),
    "clickToSetBirthday": MessageLookupByLibrary.simpleMessage(
      "Clicca per impostare il compleanno",
    ),
    "click_for_encouragement": MessageLookupByLibrary.simpleMessage(
      "Klick für Ermutigung",
    ),
    "click_to_record_status": MessageLookupByLibrary.simpleMessage(
      "Klicken zum Status aufzeichnen",
    ),
    "closeButtonText": MessageLookupByLibrary.simpleMessage("Chiudi"),
    "clubFeeJoking": MessageLookupByLibrary.simpleMessage(
      "Das war ein Scherz! Es ist kostenlos",
    ),
    "clubFeePrefix": MessageLookupByLibrary.simpleMessage(
      "Club-Gebühr: \$99/Monat",
    ),
    "clubPromotionContent": MessageLookupByLibrary.simpleMessage(
      "Treten Sie unserem exklusiven Club für großartige Vorteile bei",
    ),
    "clubPromotionTitle": MessageLookupByLibrary.simpleMessage(
      "Dem Club beitreten",
    ),
    "commonLanguage": MessageLookupByLibrary.simpleMessage("Hauptsprache"),
    "commonLanguageTitle": MessageLookupByLibrary.simpleMessage(
      "Häufig verwendete Sprachen",
    ),
    "communicationCompatibility": MessageLookupByLibrary.simpleMessage(
      "Kommunikation",
    ),
    "compatibilityScore": MessageLookupByLibrary.simpleMessage(
      "Kompatibilität",
    ),
    "completeAstroInfo": MessageLookupByLibrary.simpleMessage(
      "Vervollständigen Sie detaillierte astrologische Informationen",
    ),
    "completeAstroProfile": MessageLookupByLibrary.simpleMessage(
      "Vervollständige dein Astro-Profil",
    ),
    "completeAstroProfileButton": MessageLookupByLibrary.simpleMessage(
      "Astro-Profil vervollständigen",
    ),
    "completeBirthLocationInfo": MessageLookupByLibrary.simpleMessage(
      "Completa le tue informazioni sulla posizione di nascita",
    ),
    "completeProfile": MessageLookupByLibrary.simpleMessage("Completa Profilo"),
    "confirmSelectLocation": MessageLookupByLibrary.simpleMessage(
      "Diese Position bestätigen",
    ),
    "continueWithPhone": MessageLookupByLibrary.simpleMessage(
      "Mit Telefon fortfahren",
    ),
    "currentSelectedCoordinates": MessageLookupByLibrary.simpleMessage(
      "Aktuell ausgewählte Koordinaten",
    ),
    "current_emotion": MessageLookupByLibrary.simpleMessage("Aktuelle Emotion"),
    "daily_quote": MessageLookupByLibrary.simpleMessage("Zitat des Tages"),
    "daily_quotes_title": MessageLookupByLibrary.simpleMessage(
      "Tägliche Zitate",
    ),
    "daily_status": MessageLookupByLibrary.simpleMessage("Tagesstatus"),
    "date_format_md": m0,
    "days_to_30_goal": m1,
    "deepAnalysisReportTitle": MessageLookupByLibrary.simpleMessage(
      "Rapporto di Analisi AI Approfondita",
    ),
    "deepSynastryAnalysis": MessageLookupByLibrary.simpleMessage(
      "Analisi Approfondita",
    ),
    "deepSynastryRemark": MessageLookupByLibrary.simpleMessage(
      "Tiefe Synastrie-Analyse",
    ),
    "defaultBirthTime": MessageLookupByLibrary.simpleMessage(
      "12:00 (Predefinito)",
    ),
    "deletePhoto": MessageLookupByLibrary.simpleMessage("Foto löschen"),
    "deletePhotoContent": MessageLookupByLibrary.simpleMessage(
      "Sind Sie sicher, dass Sie dieses Foto löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.",
    ),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage(
      "Beschreibung (optional)",
    ),
    "destinyMatch": MessageLookupByLibrary.simpleMessage("Schicksals-Match"),
    "diamondConsumeFailed": MessageLookupByLibrary.simpleMessage(
      "Diamant-Verbrauch fehlgeschlagen",
    ),
    "diamondInsufficient": MessageLookupByLibrary.simpleMessage(
      "Diamanten sind nicht genug",
    ),
    "diamondPack1": MessageLookupByLibrary.simpleMessage("Diamanten-Pack"),
    "diamondPack2": MessageLookupByLibrary.simpleMessage("Diamanten-Truhe"),
    "diamondPack3": MessageLookupByLibrary.simpleMessage("Diamanten-Geschenk"),
    "diamondPack4": MessageLookupByLibrary.simpleMessage(
      "Großes Diamanten-Bundle",
    ),
    "diamondPack5": MessageLookupByLibrary.simpleMessage(
      "Höchstes Diamanten-Pack",
    ),
    "diamondStore": MessageLookupByLibrary.simpleMessage("Diamanten-Shop"),
    "diamondStoreSubtitle": MessageLookupByLibrary.simpleMessage(
      "Schalten Sie Premium-Funktionen mit Diamanten frei",
    ),
    "diamondStoreTitle": MessageLookupByLibrary.simpleMessage("Diamanten-Shop"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Haftungsausschluss"),
    "displayMyCity": MessageLookupByLibrary.simpleMessage(
      "Meine Stadt anzeigen",
    ),
    "dm": MessageLookupByLibrary.simpleMessage("DM"),
    "duoSnap": MessageLookupByLibrary.simpleMessage("Duo Snap"),
    "duosnapAnyway": MessageLookupByLibrary.simpleMessage("Duo Snap trotzdem"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Profil bearbeiten"),
    "emotion_analysis": MessageLookupByLibrary.simpleMessage("Emotionsanalyse"),
    "emotion_angry": MessageLookupByLibrary.simpleMessage("😠 Wütend"),
    "emotion_anxious": MessageLookupByLibrary.simpleMessage("😰 Ängstlich"),
    "emotion_calm": MessageLookupByLibrary.simpleMessage("😌 Ruhig"),
    "emotion_category": MessageLookupByLibrary.simpleMessage("Emotion"),
    "emotion_diary": MessageLookupByLibrary.simpleMessage("Emotionstagebuch"),
    "emotion_diary_saved": MessageLookupByLibrary.simpleMessage(
      "✅ Emotionstagebuch gespeichert",
    ),
    "emotion_diary_title": MessageLookupByLibrary.simpleMessage(
      "Emotionstagebuch",
    ),
    "emotion_distribution": MessageLookupByLibrary.simpleMessage(
      "Emotionsverteilung",
    ),
    "emotion_happy": MessageLookupByLibrary.simpleMessage("😊 Glücklich"),
    "emotion_management": MessageLookupByLibrary.simpleMessage(
      "Emotionsmanagement",
    ),
    "emotion_management_title": MessageLookupByLibrary.simpleMessage(
      "Emotionsmanagement",
    ),
    "emotion_records": MessageLookupByLibrary.simpleMessage(
      "Emotionsaufzeichnungen",
    ),
    "emotion_sad": MessageLookupByLibrary.simpleMessage("😢 Traurig"),
    "emotion_subtitle": MessageLookupByLibrary.simpleMessage(
      "Verstehen Sie Ihre Emotionen und lernen Sie Selbstfürsorge",
    ),
    "emotion_tip": MessageLookupByLibrary.simpleMessage(
      "Nehmen Sie sich im gegenwärtigen Moment an, Emotionen fließen wie Sterne und kehren schließlich zum Frieden zurück",
    ),
    "emotion_tired": MessageLookupByLibrary.simpleMessage("😴 Müde"),
    "emotionalCompatibility": MessageLookupByLibrary.simpleMessage("Emotional"),
    "emptyChatRoomMessage": MessageLookupByLibrary.simpleMessage(
      "La tua chat privata è ancora vuota\nMa le stelle sanno, la persona giusta sta venendo da te",
    ),
    "energy": MessageLookupByLibrary.simpleMessage("Energie"),
    "energy_category": MessageLookupByLibrary.simpleMessage("Energie"),
    "energy_index": MessageLookupByLibrary.simpleMessage("Energie-Index"),
    "energy_level": MessageLookupByLibrary.simpleMessage("Energieniveau"),
    "enterBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Inserisci luogo di nascita",
    ),
    "every_emotion_matters": MessageLookupByLibrary.simpleMessage(
      "Jede Emotion verdient es, gesehen und aufgezeichnet zu werden",
    ),
    "exceptionAstroLearnContentFilterTips":
        MessageLookupByLibrary.simpleMessage(
          "Nicht gesendet. Zena wird verbotene Wörter nicht übersetzen.",
        ),
    "exceptionAstroLearnOverloadedTips": MessageLookupByLibrary.simpleMessage(
      "Zena ist überlastet, bitte versuchen Sie es später noch einmal.",
    ),
    "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
      "Senden fehlgeschlagen, bitte versuchen Sie es später noch einmal.",
    ),
    "fateOnTheWay": MessageLookupByLibrary.simpleMessage(
      "Il destino è in arrivo",
    ),
    "feedback": MessageLookupByLibrary.simpleMessage("Rückmeldung"),
    "filter": MessageLookupByLibrary.simpleMessage("Filter"),
    "findingFolksWhoShareYourInterests": MessageLookupByLibrary.simpleMessage(
      "Menschen finden, die deine Interessen teilen",
    ),
    "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
      "Zena sucht nach potenziellen Freunden...",
    ),
    "first_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "Primo quarto di luna, buon momento per l\'azione e le decisioni",
    ),
    "friendsIntention": MessageLookupByLibrary.simpleMessage(
      "Hey, ich finde dich echt toll. Wie wäre es, wenn wir Freunde werden?",
    ),
    "full_moon_insight": MessageLookupByLibrary.simpleMessage(
      "L\'energia della luna piena è più forte, perfetta per liberare le emozioni",
    ),
    "futureCompatibility": MessageLookupByLibrary.simpleMessage("Zukunft"),
    "geminiSign": MessageLookupByLibrary.simpleMessage("Zwillinge"),
    "getAstroLearnPlus": MessageLookupByLibrary.simpleMessage(
      "Zena Plus holen",
    ),
    "gifNotAllowed": MessageLookupByLibrary.simpleMessage(
      "GIF ist nicht erlaubt",
    ),
    "goDiscover": MessageLookupByLibrary.simpleMessage("Vai a Scoprire"),
    "gotIt": MessageLookupByLibrary.simpleMessage("Verstanden"),
    "great_keep_going": MessageLookupByLibrary.simpleMessage(
      "Großartig! Weiter so ✨",
    ),
    "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
      "Hey, rate mal, wer zuerst das Schweigen bricht?",
    ),
    "haveAstroLearnSayHi": MessageLookupByLibrary.simpleMessage(
      "Lass Zena Hallo sagen",
    ),
    "healing_calendar_title": MessageLookupByLibrary.simpleMessage(
      "Astrologischer Heilungskalender",
    ),
    "healing_category": MessageLookupByLibrary.simpleMessage("Heilung"),
    "healing_count": MessageLookupByLibrary.simpleMessage("Heilungssitzungen"),
    "healing_data": MessageLookupByLibrary.simpleMessage("Heilungsdaten"),
    "healing_music_title": MessageLookupByLibrary.simpleMessage(
      "Heilungsmusik",
    ),
    "healing_sessions": MessageLookupByLibrary.simpleMessage(
      "Heilungssitzungen",
    ),
    "hereAstroLearnCookedUpForU": MessageLookupByLibrary.simpleMessage(
      "Dies wurde von Zena für dich gemacht",
    ),
    "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
      "Was halten Sie von der simultanen KI-Dolmetschung?",
    ),
    "iDigYourEnergy": MessageLookupByLibrary.simpleMessage(
      "Deine Energie gefällt mir!",
    ),
    "iLikeYourStyle": MessageLookupByLibrary.simpleMessage(
      "Ich mag deinen Stil!",
    ),
    "imInterestedSomething": m2,
    "imVeryInterestedInSomething": m3,
    "incompleteBirthdayInfo": MessageLookupByLibrary.simpleMessage(
      "Benutzer-Geburtsinformationen sind unvollständig",
    ),
    "infoIncompleteTitle": MessageLookupByLibrary.simpleMessage(
      "Information Unvollständig",
    ),
    "intellectualCompatibility": MessageLookupByLibrary.simpleMessage(
      "Intellektuell",
    ),
    "interests": MessageLookupByLibrary.simpleMessage("Interessen"),
    "interpretationOff": MessageLookupByLibrary.simpleMessage(
      "KI-Synchrone Interpretation: Aus",
    ),
    "interpretationOn": MessageLookupByLibrary.simpleMessage(
      "KI-Synchrone Interpretation: Ein",
    ),
    "issues": MessageLookupByLibrary.simpleMessage("Probleme"),
    "justNow": MessageLookupByLibrary.simpleMessage("Gerade eben"),
    "justSendALike": MessageLookupByLibrary.simpleMessage(
      "Teile einfach deine Wertschätzung",
    ),
    "justTypeInYourLanguage": m4,
    "keep_it_up": MessageLookupByLibrary.simpleMessage(
      "Weiter so! Du machst das großartig ✨",
    ),
    "last_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "Ultimo quarto di luna, lascia andare il passato e preparati per nuovi inizi",
    ),
    "leoSign": MessageLookupByLibrary.simpleMessage("Löwe"),
    "letAstroLearnSayHiForYou": MessageLookupByLibrary.simpleMessage(
      "Lass Zena für dich grüßen",
    ),
    "libraSign": MessageLookupByLibrary.simpleMessage("Libra"),
    "lifestyleCompatibility": MessageLookupByLibrary.simpleMessage(
      "Lebensstil",
    ),
    "lightAnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "Analisi AI Leggera",
    ),
    "lightSynastryRemark": MessageLookupByLibrary.simpleMessage(
      "Synastrie-Analyse",
    ),
    "likeBack": MessageLookupByLibrary.simpleMessage("Zurück liken"),
    "likedBack": MessageLookupByLibrary.simpleMessage("Bereits zurück geliked"),
    "likedPageMonetizeButton": MessageLookupByLibrary.simpleMessage(
      "Lerne ihr Teilen kennen",
    ),
    "likedPageNoData": MessageLookupByLibrary.simpleMessage(
      "Status: Noch keine Wertschätzungen\n\nWas tun: Beginne zu teilen\n\nVorschlag: Authentische Porträts\nEchte Geschichten\nGeteilte Interessen verbinden\n\nIch meine...\nLaden Sie Ihre echten Fotos hoch\nTeilen Sie Ihre authentische Geschichte\nWählen Sie Ihre Interessen",
    ),
    "likedYou": MessageLookupByLibrary.simpleMessage("Schätzt dein Teilen"),
    "loading": MessageLookupByLibrary.simpleMessage("Laden..."),
    "locationAuthorizeContent": MessageLookupByLibrary.simpleMessage(
      "Wir benötigen Ihren Standort, um Ihnen nahegelegene Personen zu zeigen",
    ),
    "locationLocatedFailed": MessageLookupByLibrary.simpleMessage(
      "Standort konnte nicht abgerufen werden",
    ),
    "locationLocatedSuccess": MessageLookupByLibrary.simpleMessage(
      "An aktueller Position lokalisiert",
    ),
    "locationPermissionRequestSubtitle": MessageLookupByLibrary.simpleMessage(
      "Wir benötigen Ihren Standort, um Ihr soziales Erlebnis zu verbessern",
    ),
    "locationPermissionRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Standort autorisieren",
    ),
    "mapSelectedLocation": MessageLookupByLibrary.simpleMessage(
      "Auf Karte ausgewählter Standort",
    ),
    "matchPageSelectIdeas": m5,
    "me": MessageLookupByLibrary.simpleMessage("Ich"),
    "meditation_category": MessageLookupByLibrary.simpleMessage("Meditation"),
    "meditation_count": MessageLookupByLibrary.simpleMessage(
      "Meditationsanzahl",
    ),
    "meditation_practice": MessageLookupByLibrary.simpleMessage(
      "Meditationspraxis",
    ),
    "meditation_practice_title": MessageLookupByLibrary.simpleMessage(
      "Meditationsübung",
    ),
    "meditation_saved": MessageLookupByLibrary.simpleMessage(
      "✅ Meditationsaufzeichnung gespeichert",
    ),
    "meditation_subtitle": MessageLookupByLibrary.simpleMessage(
      "Finden Sie inneren Frieden durch Astro-Meditation",
    ),
    "memberCenter": MessageLookupByLibrary.simpleMessage("Mitglieder Center"),
    "membersPerks": MessageLookupByLibrary.simpleMessage(
      "Mitglieder erhalten exklusive Vorteile",
    ),
    "minutes_duration": m6,
    "month": MessageLookupByLibrary.simpleMessage("Monat"),
    "month_day_format": m7,
    "mood": MessageLookupByLibrary.simpleMessage("Stimmung"),
    "mood_index": MessageLookupByLibrary.simpleMessage("Stimmungsindex"),
    "mood_score": m8,
    "morePhotosBenefit": MessageLookupByLibrary.simpleMessage(
      "Je mehr Fotos, desto höher die Empfehlung",
    ),
    "morePhotosMoreCharm": MessageLookupByLibrary.simpleMessage(
      "Mehr Fotos, Mehr Charme!",
    ),
    "music_subtitle": MessageLookupByLibrary.simpleMessage(
      "Entspannende Astro-Audio für Geist und Körper",
    ),
    "myPhotos": MessageLookupByLibrary.simpleMessage("Meine Fotos"),
    "myProfileTitle": MessageLookupByLibrary.simpleMessage("Mein Profil"),
    "my_statistics": MessageLookupByLibrary.simpleMessage("Meine Statistiken"),
    "navigateToAstroProfile": MessageLookupByLibrary.simpleMessage(
      "Zur Astro-Profilseite springen",
    ),
    "nearby": MessageLookupByLibrary.simpleMessage("In der Nähe"),
    "newGameplay": MessageLookupByLibrary.simpleMessage("Neues Gameplay"),
    "newMatch": MessageLookupByLibrary.simpleMessage("Neue Verbindung!"),
    "new_moon_insight": MessageLookupByLibrary.simpleMessage(
      "Momento di luna nuova, perfetto per iniziare nuovi piani di guarigione",
    ),
    "nextBilingDate": MessageLookupByLibrary.simpleMessage(
      "Nächster Zahlungstermin",
    ),
    "noMessageTips": MessageLookupByLibrary.simpleMessage(
      "Status: Keine Nachrichten\n\nWas tun: Finde Zuhörer\n\nVorschlag: Teile deine Authentizität",
    ),
    "noOneFoundYourCharm": MessageLookupByLibrary.simpleMessage(
      "Noch hat niemand deinen Charme entdeckt",
    ),
    "noThanks": MessageLookupByLibrary.simpleMessage("Nein, danke"),
    "no_audio": MessageLookupByLibrary.simpleMessage("Kein Audio verfügbar"),
    "no_quotes": MessageLookupByLibrary.simpleMessage("Keine Zitate verfügbar"),
    "no_records_today": MessageLookupByLibrary.simpleMessage(
      "Keine Aufzeichnungen für diesen Tag",
    ),
    "notes": MessageLookupByLibrary.simpleMessage("Notizen"),
    "notifications": MessageLookupByLibrary.simpleMessage("Benachrichtigungen"),
    "onboarding0": MessageLookupByLibrary.simpleMessage(
      "Zena ist wie eine Heimatbasis für Weltbürger",
    ),
    "onboarding1": MessageLookupByLibrary.simpleMessage(
      "Ob zu Hause oder unterwegs, treffe Menschen weltweit. Und...",
    ),
    "onboarding2": MessageLookupByLibrary.simpleMessage(
      "Du wirst eine Superkraft erlangen: \nSprachenbeherrschung Keine Kommunikationsbarrieren mehr",
    ),
    "onboarding3": MessageLookupByLibrary.simpleMessage(
      "Weniger reden, mehr lieben. Eine legendäre Romanze wartet auf dich",
    ),
    "onboardingWish": MessageLookupByLibrary.simpleMessage(
      "Bitte vervollständige die\nWunschliste für eine ideale Übereinstimmung",
    ),
    "oneLineToWin": MessageLookupByLibrary.simpleMessage(
      "Una frase per conquistarli",
    ),
    "oopsNoDataRightNow": MessageLookupByLibrary.simpleMessage(
      "Hoppla, gerade keine Daten",
    ),
    "peopleFromYourWishlistGetMoreRecommendations":
        MessageLookupByLibrary.simpleMessage(
          "Die Einstellungen Ihrer Wunschliste werden eine größere Rolle spielen",
        ),
    "permissionRequiredContent": MessageLookupByLibrary.simpleMessage(
      "Wir benötigen diese Berechtigung um Ihnen die beste Erfahrung zu bieten",
    ),
    "permissionRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Berechtigung Erforderlich",
    ),
    "personaCompleteProfile": MessageLookupByLibrary.simpleMessage(
      "Grundprofil vervollständigen",
    ),
    "personaCompleteProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Completa nome, compleanno, genere per sbloccare più raccomandazioni",
    ),
    "personaEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "Abilita notifiche messaggi",
    ),
    "personaEnableNotificationsDesc": MessageLookupByLibrary.simpleMessage(
      "Non perdere match e messaggi, interagisci in tempo",
    ),
    "personaForYou": MessageLookupByLibrary.simpleMessage("Per te"),
    "personaShowCity": MessageLookupByLibrary.simpleMessage(
      "Mostra la tua città",
    ),
    "personaShowCityDesc": MessageLookupByLibrary.simpleMessage(
      "Più facile essere scoperti dagli utenti locali",
    ),
    "personaUploadPhotos": MessageLookupByLibrary.simpleMessage(
      "Carica le tue foto",
    ),
    "personaUploadPhotosDesc": MessageLookupByLibrary.simpleMessage(
      " um die Sichtbarkeit zu erhöhen",
    ),
    "photoFromCamera": MessageLookupByLibrary.simpleMessage("Ein Foto machen"),
    "photoFromGallery": MessageLookupByLibrary.simpleMessage(
      "Aus der Galerie auswählen",
    ),
    "photoMightNotBeReal": MessageLookupByLibrary.simpleMessage(
      "Dieses Foto ist möglicherweise nicht echt",
    ),
    "photos": MessageLookupByLibrary.simpleMessage("Fotos"),
    "piscesSign": MessageLookupByLibrary.simpleMessage("Fische"),
    "played_audio": MessageLookupByLibrary.simpleMessage("Audio abgespielt"),
    "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
        MessageLookupByLibrary.simpleMessage(
          "Bitte überprüfen Sie Ihr Internet oder Tippen Sie auf Aktualisieren und versuchen Sie es erneut",
        ),
    "please_write_feelings": MessageLookupByLibrary.simpleMessage(
      "Bitte schreiben Sie Ihre Gefühle",
    ),
    "plusBenefitActivityReminder": MessageLookupByLibrary.simpleMessage(
      "Aktivitäts- und Rückkehr-Erinnerungen",
    ),
    "plusBenefitActivitySort": MessageLookupByLibrary.simpleMessage(
      "Nach letzter Aktivität und Antwortrate sortieren",
    ),
    "plusBenefitAdvancedFilter": MessageLookupByLibrary.simpleMessage(
      "Erweiterte Filter: Land/Sprache/Zeitzone/Stadt",
    ),
    "plusBenefitAntiHarassment": MessageLookupByLibrary.simpleMessage(
      "Prioritäts-Schutz vor Belästigung und Gewichtungsschutz",
    ),
    "plusBenefitConflictAdvice": MessageLookupByLibrary.simpleMessage(
      "Konfliktpunkte und Beziehungsberatung",
    ),
    "plusBenefitDestinyPriority": MessageLookupByLibrary.simpleMessage(
      "Schicksals-Priorität in Empfehlungen und Likes",
    ),
    "plusBenefitDestinyPush": MessageLookupByLibrary.simpleMessage(
      "Benachrichtigungen über neue Schicksals-Matches",
    ),
    "plusBenefitDimensionBreakdown": MessageLookupByLibrary.simpleMessage(
      "4-Dimensionale Aufschlüsselung: Persönlichkeit/Kommunikation/Intimität/Grenzen",
    ),
    "plusBenefitHighMatchDisplay": MessageLookupByLibrary.simpleMessage(
      "Anzeige hoher Übereinstimmung mit Prozentsatz",
    ),
    "plusBenefitHistoryTranslation": MessageLookupByLibrary.simpleMessage(
      "Ein-Klick-Übersetzung des Nachrichtenverlaufs",
    ),
    "plusBenefitInterestFilter": MessageLookupByLibrary.simpleMessage(
      "Interessen- und Reiseplanfilter",
    ),
    "plusBenefitLikeReminder": MessageLookupByLibrary.simpleMessage(
      "Erinnerungen für Zurück-Likes und Lesebestätigung",
    ),
    "plusBenefitMatchScore": MessageLookupByLibrary.simpleMessage(
      "Visualisierung der Gesamtkompatibilitätsbewertung",
    ),
    "plusBenefitMessageTemplates": MessageLookupByLibrary.simpleMessage(
      "Schnelle Nachrichtenvorlagen (Komplimente/Einladungen/Plattformwechsel)",
    ),
    "plusBenefitOCRTranslation": MessageLookupByLibrary.simpleMessage(
      "Sofortige Bildübersetzung und Texterkennung",
    ),
    "plusBenefitRealTimeTranslation": MessageLookupByLibrary.simpleMessage(
      "Echtzeit-Übersetzung und -Polierung: mehrsprachige automatische Korrektur",
    ),
    "plusBenefitSmartOpener": MessageLookupByLibrary.simpleMessage(
      "Intelligente Eröffnungszeilen: 3 Hochkonvertierungsvorschläge pro Person",
    ),
    "plusBenefitStarGreeting": MessageLookupByLibrary.simpleMessage(
      "Sternen-Grußpaket: 10 tägliche Grüße",
    ),
    "plusBenefitSupportChannel": MessageLookupByLibrary.simpleMessage(
      "Beschleunigte Lösung von Abonnementproblemen",
    ),
    "plusBenefitTopicPool": MessageLookupByLibrary.simpleMessage(
      "Gesprächsthemen-Pool basierend auf Profilanalyse",
    ),
    "plusBenefitUnlockLikedMe": MessageLookupByLibrary.simpleMessage(
      "Klare Avatare und Tags in Gefällt mir freischalten",
    ),
    "plusDescTitle": MessageLookupByLibrary.simpleMessage("Plus-Beschreibung"),
    "plusFuncAIInterpretation": MessageLookupByLibrary.simpleMessage(
      "1000 simultane Übersetzungen/Tag",
    ),
    "plusFuncAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "Zena Tips - Dein Chat-Berater",
    ),
    "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage("5 DM pro Woche"),
    "plusFuncFilterMatchingCountries": MessageLookupByLibrary.simpleMessage(
      "Länder für die Verbindung filtern",
    ),
    "plusFuncUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "Unbegrenztes Liken",
    ),
    "plusFuncUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "Entsperren, um zu sehen, wer dein Teilen schätzt",
    ),
    "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3 Wünsche"),
    "plusMember": MessageLookupByLibrary.simpleMessage("Plus Mitglied"),
    "plusMembershipBenefits": MessageLookupByLibrary.simpleMessage(
      "Vorteile der Plus-Mitgliedschaft",
    ),
    "plusPerkDuoSnap": MessageLookupByLibrary.simpleMessage(
      "Duo Snap mit Plus",
    ),
    "practice_count": MessageLookupByLibrary.simpleMessage("Übungsanzahl"),
    "preference": MessageLookupByLibrary.simpleMessage("Präferenz"),
    "privacy": MessageLookupByLibrary.simpleMessage("Datenschutz"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Datenschutzrichtlinie",
    ),
    "productNotFound": MessageLookupByLibrary.simpleMessage(
      "Продукт не найден",
    ),
    "profileInfoTab": MessageLookupByLibrary.simpleMessage("Profil"),
    "profileNotShown": MessageLookupByLibrary.simpleMessage(
      "Sie haben ihr wahres Gesicht noch nicht gezeigt",
    ),
    "profileTip": MessageLookupByLibrary.simpleMessage(
      "✨ Completa il tuo profilo così le stelle possono conoscerti meglio, per un abbinamento più preciso",
    ),
    "psychological_healing": MessageLookupByLibrary.simpleMessage(
      "Psychologische Heilung",
    ),
    "purchaseFailed": MessageLookupByLibrary.simpleMessage(
      "Kauf Fehlgeschlagen",
    ),
    "purchasePending": MessageLookupByLibrary.simpleMessage("Kauf ausstehend"),
    "pushNotifications": MessageLookupByLibrary.simpleMessage(
      "Push-Benachrichtigungen",
    ),
    "quickActions": MessageLookupByLibrary.simpleMessage("Schnellaktionen"),
    "quote_1": MessageLookupByLibrary.simpleMessage(
      "Du strahlst heute wie ein Stern",
    ),
    "quote_10": MessageLookupByLibrary.simpleMessage(
      "Finde Antworten in den ruhigen Momenten",
    ),
    "quote_2": MessageLookupByLibrary.simpleMessage(
      "Vertraue dir selbst wie du den Sternen vertraust",
    ),
    "quote_3": MessageLookupByLibrary.simpleMessage(
      "Jeder ist eine einzigartige Konstellation",
    ),
    "quote_4": MessageLookupByLibrary.simpleMessage(
      "Die Energie des Universums ist mit dir",
    ),
    "quote_5": MessageLookupByLibrary.simpleMessage(
      "Akzeptiere dich so wie du jetzt bist",
    ),
    "quote_6": MessageLookupByLibrary.simpleMessage(
      "Jede Emotion verdient es gesehen zu werden",
    ),
    "quote_7": MessageLookupByLibrary.simpleMessage(
      "Lass die Sternenenergie durch dich fließen",
    ),
    "quote_8": MessageLookupByLibrary.simpleMessage(
      "Heute ist neu mit unendlichen Möglichkeiten",
    ),
    "quote_9": MessageLookupByLibrary.simpleMessage(
      "Deine Existenz ist ein Wunder an sich",
    ),
    "quotes_subtitle": MessageLookupByLibrary.simpleMessage(
      "Heilende Energie von den Sternen",
    ),
    "record_daily_status": MessageLookupByLibrary.simpleMessage(
      "Tagesstatus aufzeichnen",
    ),
    "record_today_hint": MessageLookupByLibrary.simpleMessage(
      "Was möchten Sie heute aufzeichnen?",
    ),
    "record_your_feelings": MessageLookupByLibrary.simpleMessage(
      "Zeichnen Sie Ihre Gefühle auf",
    ),
    "recorded_days": MessageLookupByLibrary.simpleMessage(
      "Aufgezeichnete Tage",
    ),
    "recorded_emotion": MessageLookupByLibrary.simpleMessage(
      "Aufgezeichnete Emotion",
    ),
    "relaxation_category": MessageLookupByLibrary.simpleMessage("Entspannung"),
    "remindUploadPhoto": MessageLookupByLibrary.simpleMessage(
      "📸 Ricorda loro di caricare foto, conoscetevi meglio",
    ),
    "report": MessageLookupByLibrary.simpleMessage("Melden"),
    "reportOptionGore": MessageLookupByLibrary.simpleMessage("Blut"),
    "reportOptionOther": MessageLookupByLibrary.simpleMessage("Andere"),
    "reportOptionPerAstroLearnlAttack": MessageLookupByLibrary.simpleMessage(
      "Persönlicher Angriff",
    ),
    "reportOptionPersonalAttack": MessageLookupByLibrary.simpleMessage(
      "Persönlicher Angriff",
    ),
    "reportOptionPornography": MessageLookupByLibrary.simpleMessage(
      "Pornografie",
    ),
    "reportOptionScam": MessageLookupByLibrary.simpleMessage("Betrug"),
    "requireYourRealPhoto": MessageLookupByLibrary.simpleMessage(
      "Wir brauchen Ihr echtes Foto",
    ),
    "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
      "Ausländer in deiner Nähe treffen",
    ),
    "sagittariusSign": MessageLookupByLibrary.simpleMessage("Schütze"),
    "save": MessageLookupByLibrary.simpleMessage("Speichern"),
    "save_failed": m9,
    "scorpioSign": MessageLookupByLibrary.simpleMessage("Skorpion"),
    "screenshotEvidence": MessageLookupByLibrary.simpleMessage(
      "Beweis-Screenshot",
    ),
    "seeProfile": MessageLookupByLibrary.simpleMessage("Profil ansehen"),
    "seeWhoLikeU": MessageLookupByLibrary.simpleMessage(
      "Sehen, wer dich schätzt",
    ),
    "selectBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Seleziona luogo di nascita",
    ),
    "selectBirthdayHint": MessageLookupByLibrary.simpleMessage(
      "Bitte wählen Sie Ihr Geburtsdatum um Ihr astrologisches Diagramm zu sehen",
    ),
    "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage(
      "Land auswählen",
    ),
    "selectLocationTitle": MessageLookupByLibrary.simpleMessage(
      "Standort auswählen",
    ),
    "select_duration_start": MessageLookupByLibrary.simpleMessage(
      "Wählen Sie die Dauer für den Meditationsbeginn",
    ),
    "select_meditation_duration": MessageLookupByLibrary.simpleMessage(
      "Wählen Sie die Meditationsdauer",
    ),
    "sendDm": MessageLookupByLibrary.simpleMessage("DM senden"),
    "sendDmRemark": MessageLookupByLibrary.simpleMessage("DM Nachricht senden"),
    "sendStarGreetingToUnlockAlbum": MessageLookupByLibrary.simpleMessage(
      "💫 Sende einen Sternengruß um das Album freizuschalten Weiter",
    ),
    "setDefault": MessageLookupByLibrary.simpleMessage(
      "Als Standard festlegen",
    ),
    "setInterestTags": MessageLookupByLibrary.simpleMessage(
      "Setzen Sie klare Interessens-Tags",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Einstellungen"),
    "showYourPerAstroLearnlity": MessageLookupByLibrary.simpleMessage(
      "Zeige deine Persönlichkeit",
    ),
    "showYourPersonality": MessageLookupByLibrary.simpleMessage(
      "Zeigen Sie Ihre Persönlichkeit",
    ),
    "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage(
      "Bald fertig",
    ),
    "sixMonths": MessageLookupByLibrary.simpleMessage("6 Monate"),
    "sleep_category": MessageLookupByLibrary.simpleMessage("Schlaf"),
    "speakSameLanguage": MessageLookupByLibrary.simpleMessage(
      "Ihr sprecht dieselbe Sprache",
    ),
    "spiritual_growth": MessageLookupByLibrary.simpleMessage(
      "Spirituelles Wachstum",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "startChat": MessageLookupByLibrary.simpleMessage("Chat starten"),
    "start_meditation": MessageLookupByLibrary.simpleMessage(
      "Meditation Starten",
    ),
    "startedChat": MessageLookupByLibrary.simpleMessage("Chat begonnen mit"),
    "status_saved": MessageLookupByLibrary.simpleMessage(
      "✅ Status gespeichert",
    ),
    "stop_meditation": MessageLookupByLibrary.simpleMessage(
      "Meditation Beenden",
    ),
    "streak_days": MessageLookupByLibrary.simpleMessage("Streak-Tage"),
    "streak_x_days": m10,
    "stress": MessageLookupByLibrary.simpleMessage("Stress"),
    "stress_index": MessageLookupByLibrary.simpleMessage("Stress-Index"),
    "stress_level": MessageLookupByLibrary.simpleMessage("Stresslevel"),
    "subPageSubtitleAIInterpretationDaily":
        MessageLookupByLibrary.simpleMessage(
          "1000 \nsimultane \nÜbersetzungen/Tag",
        ),
    "subPageSubtitleAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "Zena Tips - \nDein Chat-Berater",
    ),
    "subPageSubtitleDMWeekly": MessageLookupByLibrary.simpleMessage(
      "5 DM pro Woche",
    ),
    "subPageSubtitleFilterMatchingCountries":
        MessageLookupByLibrary.simpleMessage(
          "Länder für die \nVerbindung filtern",
        ),
    "subPageSubtitleUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "Unbegrenztes Liken",
    ),
    "subPageSubtitleUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "Entsperren, um zu sehen, \nwer dich schätzt",
    ),
    "subPageTitle": MessageLookupByLibrary.simpleMessage("Zena Plus holen"),
    "subscriptionAgreement": MessageLookupByLibrary.simpleMessage(
      "Nutzungsbedingungen",
    ),
    "subscriptionAgreementPrefix": m11,
    "subscriptionAgreementSuffix": MessageLookupByLibrary.simpleMessage(" zu."),
    "sunSignLabel": MessageLookupByLibrary.simpleMessage("Segno Solare"),
    "synastryAnalysis": MessageLookupByLibrary.simpleMessage("Synastrie"),
    "takeIt": MessageLookupByLibrary.simpleMessage("Benutzen"),
    "taurusSign": MessageLookupByLibrary.simpleMessage("Stier"),
    "termsOfService": MessageLookupByLibrary.simpleMessage(
      "Dienstleistungsbedingungen",
    ),
    "theKeyIsBalance": MessageLookupByLibrary.simpleMessage(
      "Der Schlüssel ist die Balance",
    ),
    "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
      "👆 Sie warten auf deine Antwort",
    ),
    "threeMonths": MessageLookupByLibrary.simpleMessage("3 Monate"),
    "toastHitDailyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👀Du hast dein Tageslimit erreicht",
    ),
    "toastHitWeeklyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👅Du hast dein Wochenlimit erreicht",
    ),
    "toggle_background_music": MessageLookupByLibrary.simpleMessage(
      "Hintergrundmusik Umschalten",
    ),
    "total_duration": MessageLookupByLibrary.simpleMessage("Gesamtdauer"),
    "unknownLocation": MessageLookupByLibrary.simpleMessage("Unbekannt"),
    "unlockHighMatchUsers": m12,
    "unlockUsersWithDestiny": m13,
    "unmissableSpecialOfferPrices": MessageLookupByLibrary.simpleMessage(
      "Unverzichtbare Sonderpreise",
    ),
    "unsupportedPlatform": MessageLookupByLibrary.simpleMessage(
      "Неподдерживаемая платформа",
    ),
    "upgradeForMoreRecommendations": MessageLookupByLibrary.simpleMessage(
      "Aggiorna a Premium per più raccomandazioni",
    ),
    "uploadQualityPhotos": MessageLookupByLibrary.simpleMessage(
      "Laden Sie hochwertige echte Fotos hoch",
    ),
    "uploadYourPhoto": MessageLookupByLibrary.simpleMessage(
      "Laden Sie Ihr Foto hoch",
    ),
    "uploadYourPhotoHint": MessageLookupByLibrary.simpleMessage(
      "Laden Sie Ihr bestes Foto hoch",
    ),
    "uploading": MessageLookupByLibrary.simpleMessage("Caricamento..."),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "Aktuelle Position verwenden",
    ),
    "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage(
      "Ein Foto machen",
    ),
    "userAvatarOptionGallery": MessageLookupByLibrary.simpleMessage(
      "Aus der Galerie auswählen",
    ),
    "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ein gutes Porträt hilft dir, dich mit mehr Zuhörern zu verbinden. Sei echt und benutze ein legitimes Foto von dir.",
    ),
    "userAvatarPageTitle": MessageLookupByLibrary.simpleMessage("Zeige dich"),
    "userAvatarUploadedLabel": MessageLookupByLibrary.simpleMessage(
      "Upload abgeschlossen!",
    ),
    "userBirthdayInputLabel": MessageLookupByLibrary.simpleMessage(
      "Geburtsdatum",
    ),
    "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Einmal bestätigt, kann die Staatsangehörigkeit nicht geändert werden",
    ),
    "userCitizenshipPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Staatsangehörigkeit",
    ),
    "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("Geschlecht"),
    "userGenderOptionFemale": MessageLookupByLibrary.simpleMessage("Weiblich"),
    "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("Männlich"),
    "userGenderOptionNonBinary": MessageLookupByLibrary.simpleMessage(
      "Nichtbinär",
    ),
    "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ihr Geschlecht wird nicht öffentlich angezeigt, es wird nur zur Unterstützung der Verbindung verwendet",
    ),
    "userInfoPageNamePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Eintreten",
    ),
    "userInfoPageTitle": MessageLookupByLibrary.simpleMessage(
      "Grundinformationen",
    ),
    "userNameInputLabel": MessageLookupByLibrary.simpleMessage("Name"),
    "userPhoneNumberPagePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Telefonnummer",
    ),
    "userPhoneNumberPagePrivacySuffix": MessageLookupByLibrary.simpleMessage(
      " zu",
    ),
    "userPhoneNumberPagePrivacyText": MessageLookupByLibrary.simpleMessage(
      "Datenschutzbestimmungen",
    ),
    "userPhoneNumberPageTermsAnd": MessageLookupByLibrary.simpleMessage(
      " und ",
    ),
    "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
      "Indem Sie auf \"Nächster Schritt\" tippen, stimmen Sie unseren ",
    ),
    "userPhoneNumberPageTermsText": MessageLookupByLibrary.simpleMessage(
      "Nutzungsbedingungen",
    ),
    "userPhoneNumberPageTitle": MessageLookupByLibrary.simpleMessage(
      "Geben Sie die Telefonnummer ein",
    ),
    "valuesCompatibility": MessageLookupByLibrary.simpleMessage("Werte"),
    "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage(
      "Geben Sie den Verifizierungscode ein",
    ),
    "viewAstroReport": MessageLookupByLibrary.simpleMessage(
      "Astro-Bericht anzeigen mit",
    ),
    "view_details": MessageLookupByLibrary.simpleMessage("Details Anzeigen"),
    "virgoSign": MessageLookupByLibrary.simpleMessage("Jungfrau"),
    "waning_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "Momento di luna calante, riposo e recupero sono importanti",
    ),
    "waning_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "La luna sta calando, buon momento per la riflessione e l\'organizzazione",
    ),
    "wannaHollaAt": MessageLookupByLibrary.simpleMessage(
      "Möchtest du teilen...",
    ),
    "warningCancelDisplayCity": MessageLookupByLibrary.simpleMessage(
      "Nach dem Schließen wird Ihre Stadt beim Pairing nicht angezeigt",
    ),
    "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
      "Ihr Konto wird in 14 Tagen automatisch gelöscht. Bitte denken Sie daran, im Geschäft Ihre aktuelle Abonnement zu kündigen, um zusätzliche Gebühren zu vermeiden.",
    ),
    "warningDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Wenn Sie Ihr Konto löschen, können Sie sich nicht mehr damit anmelden. Sind Sie sicher, dass Sie es löschen wollen?",
    ),
    "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
      "Externer Link. Überprüfen Sie, ob die Quelle vertrauenswürdig ist, bevor Sie darauf tippen, da unbekannte Links Betrügereien sein oder Daten stehlen können. Vorgehen Sie vorsichtig.",
    ),
    "warningTitleCaution": MessageLookupByLibrary.simpleMessage("Vorsicht"),
    "warningUnmatching": MessageLookupByLibrary.simpleMessage(
      "Nach dem Beenden des Teilens wird der gesamte Gesprächsverlauf gelöscht.",
    ),
    "waxing_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "La luna sta crescendo, l\'energia si sta accumulando gradualmente",
    ),
    "waxing_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "Luna piena in arrivo, le emozioni possono essere più sensibili",
    ),
    "whatsYourEmail": MessageLookupByLibrary.simpleMessage(
      "Wie lautet Ihre E-Mail?",
    ),
    "whoLIkesYou": MessageLookupByLibrary.simpleMessage(
      "Wer schätzt dein Teilen",
    ),
    "whoLikesU": MessageLookupByLibrary.simpleMessage("Wer dich schätzt"),
    "wishActivityAddTitle": MessageLookupByLibrary.simpleMessage(
      "Füge deinen Gedanken hinzu",
    ),
    "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Helfen, Begleiter zu finden",
    ),
    "wishActivityPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Willst du etwas machen?",
    ),
    "wishCityPickerSkipButton": m14,
    "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "wenn Sie dorthin gehen, Welche Städte möchten Sie besuchen?",
    ),
    "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Für welches Land interessierst du dich am meisten?",
    ),
    "wishCreationComplete": MessageLookupByLibrary.simpleMessage(
      "Dein Wunsch wurde erhalten",
    ),
    "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("Schon hier"),
    "wishDateOptionNotSure": MessageLookupByLibrary.simpleMessage(
      "Noch nicht sicher",
    ),
    "wishDateOptionRecent": MessageLookupByLibrary.simpleMessage(
      "Neulich, denke ich",
    ),
    "wishDateOptionYear": MessageLookupByLibrary.simpleMessage(
      "Innerhalb eines Jahres",
    ),
    "wishDatePickerSubtitle": m15,
    "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("Wann"),
    "wishList": MessageLookupByLibrary.simpleMessage("Wunschliste"),
    "wishes": MessageLookupByLibrary.simpleMessage("Wunsch"),
    "writeInterestingBio": MessageLookupByLibrary.simpleMessage(
      "Schreiben Sie eine interessante persönliche Biografie",
    ),
    "write_feelings_hint": MessageLookupByLibrary.simpleMessage(
      "Schreiben Sie auf, wie Sie sich fühlen...",
    ),
    "x_days": m16,
    "x_hours": m17,
    "x_times": m18,
    "youAreAClubMemberNow": MessageLookupByLibrary.simpleMessage(
      "Sie sind jetzt Clubmitglied",
    ),
    "youCanEditItAnytime": MessageLookupByLibrary.simpleMessage(
      "Du kannst es jederzeit bearbeiten",
    ),
    "youSeemCool": MessageLookupByLibrary.simpleMessage("Du wirkst cool"),
  };
}
