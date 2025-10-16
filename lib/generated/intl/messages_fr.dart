// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(month, day) => "${month}/${day}";

  static String m1(x) => "${x} jours jusqu\'à l\'objectif de 30 jours";

  static String m2(error) =>
      "Horoskop-Analyse konnte nicht abgerufen werden: ${error}";

  static String m3(something) => "\"Je m\'intéresse à ${something}!\"";

  static String m4(something) => "Je suis très intéressé par ‘${something}’!";

  static String m5(lang) => "Tapez simplement en ${lang}";

  static String m6(gender) =>
      "Quelle de ${Intl.gender(gender, female: 'ses', male: 'ses', other: 'leurs')} expériences partagées résonne avec vous ?";

  static String m7(minutes) => "${minutes} minutes";

  static String m8(month, day) => "${month}月${day}日";

  static String m9(score) => "Humeur ${score}/10";

  static String m10(error) =>
      "Mondphasen-Analyse konnte nicht abgerufen werden: ${error}";

  static String m11(error) => "❌ Échec de l\'enregistrement : ${error}";

  static String m12(x) => "🔥 ${x} jours d\'affilée !";

  static String m13(storeName) =>
      "En appuyant sur \"Continuer\", vous serez facturé, votre abonnement sera automatiquement renouvelé au même prix et pour la même durée jusqu\'à son annulation via les paramètres du ${storeName}, et vous acceptez nos ";

  static String m14(count) =>
      "Débloquer pour voir ${count} utilisateurs à forte correspondance ✨";

  static String m15(count, destinyCount) =>
      "Débloquer ${count} utilisateurs dont ${destinyCount} correspondances du destin ⭐";

  static String m16(country) => "Passer, Juste ${country}";

  static String m17(country) => "Prévoyez-vous d\'aller au ${country}?";

  static String m18(x) => "${x} jours";

  static String m19(x) => "${x} heures";

  static String m20(x) => "${x} fois";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aMonth": MessageLookupByLibrary.simpleMessage("1 mois"),
    "aYear": MessageLookupByLibrary.simpleMessage("1 an"),
    "about": MessageLookupByLibrary.simpleMessage("À propos"),
    "account": MessageLookupByLibrary.simpleMessage("Compte"),
    "active_days": MessageLookupByLibrary.simpleMessage("Jours Actifs"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("Ajouter une Photo"),
    "age": MessageLookupByLibrary.simpleMessage("Âge"),
    "aiCreatingFunGroupPics": MessageLookupByLibrary.simpleMessage(
      "IA créant des photos de groupe amusantes",
    ),
    "allPeople": MessageLookupByLibrary.simpleMessage("Tout"),
    "analyzingDailyHoroscope": MessageLookupByLibrary.simpleMessage(
      "Tägliches Horoskop wird analysiert...",
    ),
    "analyzingMoonPhase": MessageLookupByLibrary.simpleMessage(
      "Mondphasen-Energie wird analysiert...",
    ),
    "analyzingText": MessageLookupByLibrary.simpleMessage("Analizzando..."),
    "aquariusSign": MessageLookupByLibrary.simpleMessage("Verseau"),
    "ariesSign": MessageLookupByLibrary.simpleMessage("Bélier"),
    "ascendantSignLabel": MessageLookupByLibrary.simpleMessage(
      "Aufsteigendes Zeichen",
    ),
    "astroChartTab": MessageLookupByLibrary.simpleMessage("Graphique Astro"),
    "astroInfoIncompleteMessage": MessageLookupByLibrary.simpleMessage(
      "L\'autre utilisateur n\'a pas encore terminé ses informations de lieu de naissance, nous ne pouvons donc pas générer un graphique astrologique. Veuillez attendre qu\'ils terminent leurs informations.",
    ),
    "astroLearnInterpretationOff": MessageLookupByLibrary.simpleMessage(
      "⭕ Zena Interprétation désactivée",
    ),
    "astroLearnRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
      "Recommandation de Zena : Refroidissement.\nQue faire : Attendre.\nSuggestion : Regarder un film ?",
    ),
    "astroLearnWillGenerateABioBasedOnInterests":
        MessageLookupByLibrary.simpleMessage(
          "Zena générera une biographie basée sur vos intérêts",
        ),
    "astroReport": MessageLookupByLibrary.simpleMessage("Rapport astro"),
    "astro_calendar_title": MessageLookupByLibrary.simpleMessage(
      "Calendrier de Guérison Astrologique",
    ),
    "audio_1_desc": MessageLookupByLibrary.simpleMessage(
      "Trouvez la paix intérieure sous le ciel étoilé silencieux",
    ),
    "audio_1_title": MessageLookupByLibrary.simpleMessage(
      "Méditation du Ciel Étoilé",
    ),
    "audio_2_desc": MessageLookupByLibrary.simpleMessage(
      "Allumez votre courage et votre vitalité intérieurs",
    ),
    "audio_2_title": MessageLookupByLibrary.simpleMessage(
      "Audio d\'Énergie du Bélier",
    ),
    "audio_3_desc": MessageLookupByLibrary.simpleMessage(
      "Libérez le stress et trouvez une relaxation complète",
    ),
    "audio_3_title": MessageLookupByLibrary.simpleMessage(
      "Guide de Relaxation Profonde",
    ),
    "audio_4_desc": MessageLookupByLibrary.simpleMessage(
      "Équilibrez les émotions et trouvez l\'harmonie intérieure",
    ),
    "audio_4_title": MessageLookupByLibrary.simpleMessage(
      "Musique d\'Équilibre Émotionnel",
    ),
    "avatarUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la mise à jour de l\'avatar",
    ),
    "average_mood": MessageLookupByLibrary.simpleMessage("Humeur Moyenne"),
    "bio": MessageLookupByLibrary.simpleMessage("Introduction"),
    "birthInfo": MessageLookupByLibrary.simpleMessage("Geburtsinformationen"),
    "birthPlace": MessageLookupByLibrary.simpleMessage("Geburtsort"),
    "birthPlaceLabel": MessageLookupByLibrary.simpleMessage("Geburtsort"),
    "birthTimeLabel": MessageLookupByLibrary.simpleMessage("Geburtszeit"),
    "birthday": MessageLookupByLibrary.simpleMessage("Geburtstag"),
    "block": MessageLookupByLibrary.simpleMessage("Bloquer"),
    "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
        MessageLookupByLibrary.simpleMessage(
          "Bloquez cette personne pour ne plus recevoir de messages d\'elle",
        ),
    "boostYourAppeal": MessageLookupByLibrary.simpleMessage("Charme Haut"),
    "breakIce": MessageLookupByLibrary.simpleMessage(
      "🔨🔨🔨 Ne fais pas attention à moi🔨🔨🔨 Je brise juste la glace🔨🔨🔨",
    ),
    "breathe_relax": MessageLookupByLibrary.simpleMessage(
      "Respirez profondément et détendez-vous...",
    ),
    "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage(
      "Tu es membre Plus",
    ),
    "buttonAuthorize": MessageLookupByLibrary.simpleMessage("Autoriser"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "buttonChange": MessageLookupByLibrary.simpleMessage("Changer"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Bestätigen"),
    "buttonContinue": MessageLookupByLibrary.simpleMessage("Continuer"),
    "buttonCopy": MessageLookupByLibrary.simpleMessage("Copier"),
    "buttonDelete": MessageLookupByLibrary.simpleMessage("Supprimer"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Supprimer le compte",
    ),
    "buttonDone": MessageLookupByLibrary.simpleMessage("Fait"),
    "buttonEdit": MessageLookupByLibrary.simpleMessage("Éditer"),
    "buttonEditProfile": MessageLookupByLibrary.simpleMessage(
      "Modifier le profil",
    ),
    "buttonGenerate": MessageLookupByLibrary.simpleMessage("Générer"),
    "buttonGo": MessageLookupByLibrary.simpleMessage("Aller"),
    "buttonGotIt": MessageLookupByLibrary.simpleMessage("Compris"),
    "buttonHitAIInterpretationMaximumLimit":
        MessageLookupByLibrary.simpleMessage(
          "😪Zena est fatiguée, 👇Tapez pour la recharger!",
        ),
    "buttonJoinNow": MessageLookupByLibrary.simpleMessage(
      "Rejoignez Maintenant",
    ),
    "buttonKeepAccount": MessageLookupByLibrary.simpleMessage(
      "Garder le compte",
    ),
    "buttonManage": MessageLookupByLibrary.simpleMessage("Gérer"),
    "buttonNext": MessageLookupByLibrary.simpleMessage("Prochaine Étape"),
    "buttonOpenLink": MessageLookupByLibrary.simpleMessage("Ouvrir le Lien"),
    "buttonPreview": MessageLookupByLibrary.simpleMessage("Aperçu"),
    "buttonPurchase": MessageLookupByLibrary.simpleMessage("Acheter"),
    "buttonRefresh": MessageLookupByLibrary.simpleMessage("Actualiser"),
    "buttonResend": MessageLookupByLibrary.simpleMessage("Renvoyer"),
    "buttonRestore": MessageLookupByLibrary.simpleMessage("Restaurer"),
    "buttonSave": MessageLookupByLibrary.simpleMessage("Sauvegarder"),
    "buttonSignOut": MessageLookupByLibrary.simpleMessage("Se déconnecter"),
    "buttonSubmit": MessageLookupByLibrary.simpleMessage("Soumettre"),
    "buttonUnlockVipPerks": MessageLookupByLibrary.simpleMessage(
      "Débloquer les avantages VIP",
    ),
    "buttonUnmatch": MessageLookupByLibrary.simpleMessage(
      "Terminer le partage",
    ),
    "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("Se désabonner"),
    "cancerSign": MessageLookupByLibrary.simpleMessage("Cancer"),
    "capricornSign": MessageLookupByLibrary.simpleMessage("Capricorne"),
    "catchMore": MessageLookupByLibrary.simpleMessage("Attrapez plus"),
    "charmTips": MessageLookupByLibrary.simpleMessage("Conseils de charme"),
    "chartPreview": MessageLookupByLibrary.simpleMessage("Aperçu du Graphique"),
    "chat": MessageLookupByLibrary.simpleMessage("Chat"),
    "chatWithMatches": MessageLookupByLibrary.simpleMessage(
      "Chattez activement avec les utilisateurs correspondants",
    ),
    "checkItOut": MessageLookupByLibrary.simpleMessage("Regardez"),
    "checkOutTheirProfiles": MessageLookupByLibrary.simpleMessage(
      "Vérifiez leurs profils",
    ),
    "choosePlaceholder": MessageLookupByLibrary.simpleMessage("Choisir"),
    "clickToSetBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Klicken Sie, um den Geburtsort festzulegen",
    ),
    "clickToSetBirthday": MessageLookupByLibrary.simpleMessage(
      "Klicken Sie, um den Geburtstag festzulegen",
    ),
    "click_for_encouragement": MessageLookupByLibrary.simpleMessage(
      "Cliquez pour encouragement",
    ),
    "click_to_record_status": MessageLookupByLibrary.simpleMessage(
      "Cliquez pour enregistrer le statut",
    ),
    "closeButtonText": MessageLookupByLibrary.simpleMessage("Schließen"),
    "clubFeeJoking": MessageLookupByLibrary.simpleMessage(
      "C\'est une blague ! C\'est gratuit",
    ),
    "clubFeePrefix": MessageLookupByLibrary.simpleMessage(
      "Frais du club : 99\$/mois",
    ),
    "clubPromotionContent": MessageLookupByLibrary.simpleMessage(
      "Rejoignez notre club exclusif pour des avantages incroyables",
    ),
    "clubPromotionTitle": MessageLookupByLibrary.simpleMessage(
      "Rejoignez le Club",
    ),
    "commonLanguage": MessageLookupByLibrary.simpleMessage("Langue principale"),
    "commonLanguageTitle": MessageLookupByLibrary.simpleMessage(
      "Langues couramment utilisées",
    ),
    "communicationCompatibility": MessageLookupByLibrary.simpleMessage(
      "Communication",
    ),
    "compatibilityScore": MessageLookupByLibrary.simpleMessage("Compatibilité"),
    "completeAstroInfo": MessageLookupByLibrary.simpleMessage(
      "Complétez les informations astrologiques détaillées",
    ),
    "completeAstroProfile": MessageLookupByLibrary.simpleMessage(
      "Complétez votre profil astro",
    ),
    "completeAstroProfileButton": MessageLookupByLibrary.simpleMessage(
      "Compléter le Profil Astro",
    ),
    "completeBirthLocationInfo": MessageLookupByLibrary.simpleMessage(
      "Vervollständigen Sie Ihre Geburtsort-Informationen",
    ),
    "completeProfile": MessageLookupByLibrary.simpleMessage(
      "Profil vervollständigen",
    ),
    "confirmSelectLocation": MessageLookupByLibrary.simpleMessage(
      "Confirmer la sélection de cet emplacement",
    ),
    "continueWithPhone": MessageLookupByLibrary.simpleMessage(
      "Continuer avec le téléphone",
    ),
    "currentSelectedCoordinates": MessageLookupByLibrary.simpleMessage(
      "Coordonnées sélectionnées actuelles",
    ),
    "current_emotion": MessageLookupByLibrary.simpleMessage("Émotion Actuelle"),
    "dailyHoroscope": MessageLookupByLibrary.simpleMessage(
      "Tägliches Horoskop",
    ),
    "dailyHoroscopeAnalysis": MessageLookupByLibrary.simpleMessage(
      "Tägliche Horoskop-Analyse",
    ),
    "dailyHoroscopeAnalysisRemark": MessageLookupByLibrary.simpleMessage(
      "Tägliche Horoskop-Analyse",
    ),
    "dailyHoroscopeTitle": MessageLookupByLibrary.simpleMessage(
      "Tägliches Horoskop",
    ),
    "daily_quote": MessageLookupByLibrary.simpleMessage("Citation du Jour"),
    "daily_quotes_title": MessageLookupByLibrary.simpleMessage(
      "Citations Quotidiennes",
    ),
    "daily_status": MessageLookupByLibrary.simpleMessage("Statut Quotidien"),
    "date_format_md": m0,
    "days_to_30_goal": m1,
    "deepAnalysisReportTitle": MessageLookupByLibrary.simpleMessage(
      "Tiefe KI-Analyse-Bericht",
    ),
    "deepSynastryAnalysis": MessageLookupByLibrary.simpleMessage(
      "Tiefe Analyse",
    ),
    "deepSynastryRemark": MessageLookupByLibrary.simpleMessage(
      "Analyse Approfondie de Synastrie",
    ),
    "defaultBirthTime": MessageLookupByLibrary.simpleMessage(
      "12:00 (Standard)",
    ),
    "deletePhoto": MessageLookupByLibrary.simpleMessage("Supprimer la Photo"),
    "deletePhotoContent": MessageLookupByLibrary.simpleMessage(
      "Êtes-vous sûr de vouloir supprimer cette photo ? Cette action ne peut pas être annulée.",
    ),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage(
      "Description (facultative)",
    ),
    "destinyMatch": MessageLookupByLibrary.simpleMessage("Match du Destin"),
    "diamondConsumeFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de la consommation de diamants",
    ),
    "diamondInsufficient": MessageLookupByLibrary.simpleMessage(
      "Diamants n\'est pas assez",
    ),
    "diamondPack1": MessageLookupByLibrary.simpleMessage("Pack Diamants"),
    "diamondPack2": MessageLookupByLibrary.simpleMessage("Coffre Diamants"),
    "diamondPack3": MessageLookupByLibrary.simpleMessage("Cadeau Diamants"),
    "diamondPack4": MessageLookupByLibrary.simpleMessage("Pack Diamants Grand"),
    "diamondPack5": MessageLookupByLibrary.simpleMessage(
      "Pack Diamants Suprême",
    ),
    "diamondStore": MessageLookupByLibrary.simpleMessage("Boutique Diamants"),
    "diamondStoreSubtitle": MessageLookupByLibrary.simpleMessage(
      "Débloquez les fonctionnalités premium avec des diamants",
    ),
    "diamondStoreTitle": MessageLookupByLibrary.simpleMessage(
      "Boutique Diamants",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Avertissement"),
    "displayMyCity": MessageLookupByLibrary.simpleMessage("Afficher ma ville"),
    "dm": MessageLookupByLibrary.simpleMessage("DM"),
    "duoSnap": MessageLookupByLibrary.simpleMessage("Duo Snap"),
    "duosnapAnyway": MessageLookupByLibrary.simpleMessage(
      "Duo Snap quand même",
    ),
    "editProfile": MessageLookupByLibrary.simpleMessage("Modifier le Profil"),
    "emotion_analysis": MessageLookupByLibrary.simpleMessage(
      "Analyse Émotionnelle",
    ),
    "emotion_angry": MessageLookupByLibrary.simpleMessage("😠 En colère"),
    "emotion_anxious": MessageLookupByLibrary.simpleMessage("😰 Anxieux"),
    "emotion_calm": MessageLookupByLibrary.simpleMessage("😌 Calme"),
    "emotion_category": MessageLookupByLibrary.simpleMessage("Émotion"),
    "emotion_diary": MessageLookupByLibrary.simpleMessage(
      "Journal des Émotions",
    ),
    "emotion_diary_saved": MessageLookupByLibrary.simpleMessage(
      "✅ Journal des émotions sauvegardé",
    ),
    "emotion_diary_title": MessageLookupByLibrary.simpleMessage(
      "Journal des Émotions",
    ),
    "emotion_distribution": MessageLookupByLibrary.simpleMessage(
      "Distribution des Émotions",
    ),
    "emotion_happy": MessageLookupByLibrary.simpleMessage("😊 Heureux"),
    "emotion_management": MessageLookupByLibrary.simpleMessage(
      "Gestion des Émotions",
    ),
    "emotion_management_title": MessageLookupByLibrary.simpleMessage(
      "Gestion des Émotions",
    ),
    "emotion_records": MessageLookupByLibrary.simpleMessage(
      "Enregistrements d\'Émotions",
    ),
    "emotion_sad": MessageLookupByLibrary.simpleMessage("😢 Triste"),
    "emotion_subtitle": MessageLookupByLibrary.simpleMessage(
      "Comprendre vos émotions et apprendre l\'auto-soin",
    ),
    "emotion_tip": MessageLookupByLibrary.simpleMessage(
      "Acceptez-vous dans le moment présent, les émotions coulent comme des étoiles et finiront par retourner à la paix",
    ),
    "emotion_tired": MessageLookupByLibrary.simpleMessage("😴 Fatigué"),
    "emotionalCompatibility": MessageLookupByLibrary.simpleMessage(
      "Émotionnel",
    ),
    "emptyChatRoomMessage": MessageLookupByLibrary.simpleMessage(
      "Ihr privater Chatraum ist noch leer\nAber die Sterne wissen, die richtige Person kommt zu Ihnen",
    ),
    "energy": MessageLookupByLibrary.simpleMessage("Énergie"),
    "energy_category": MessageLookupByLibrary.simpleMessage("Énergie"),
    "energy_index": MessageLookupByLibrary.simpleMessage("Indice d\'Énergie"),
    "energy_level": MessageLookupByLibrary.simpleMessage("Niveau d\'Énergie"),
    "enterBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Geburtsort eingeben",
    ),
    "every_emotion_matters": MessageLookupByLibrary.simpleMessage(
      "Chaque émotion mérite d\'être vue et enregistrée",
    ),
    "exceptionAstroLearnContentFilterTips":
        MessageLookupByLibrary.simpleMessage(
          "Non envoyé. Zena ne traduira pas les mots interdits.",
        ),
    "exceptionAstroLearnOverloadedTips": MessageLookupByLibrary.simpleMessage(
      "Zena est surchargée, veuillez réessayer plus tard.",
    ),
    "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
      "Échec de l\'envoi, veuillez réessayer plus tard.",
    ),
    "fateOnTheWay": MessageLookupByLibrary.simpleMessage(
      "Das Schicksal ist unterwegs",
    ),
    "feedback": MessageLookupByLibrary.simpleMessage("Rétroaction"),
    "filter": MessageLookupByLibrary.simpleMessage("Filtre"),
    "findingFolksWhoShareYourInterests": MessageLookupByLibrary.simpleMessage(
      "Trouver des personnes qui partagent vos intérêts",
    ),
    "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
      "Zena recherche des amis potentiels...",
    ),
    "first_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "Erstes Viertel, gute Zeit für Aktion und Entscheidungen",
    ),
    "friendsIntention": MessageLookupByLibrary.simpleMessage(
      "Hé, je pense que tu es génial. Ça te dirait qu\'on devienne amis ?",
    ),
    "full_moon_insight": MessageLookupByLibrary.simpleMessage(
      "Vollmond-Energie ist am stärksten, perfekt zum Freisetzen von Emotionen",
    ),
    "futureCompatibility": MessageLookupByLibrary.simpleMessage("Avenir"),
    "geminiSign": MessageLookupByLibrary.simpleMessage("Gémeaux"),
    "getAstroLearnPlus": MessageLookupByLibrary.simpleMessage(
      "Obtenir Zena Plus",
    ),
    "gifNotAllowed": MessageLookupByLibrary.simpleMessage(
      "GIF n\'est pas autorisé",
    ),
    "goDiscover": MessageLookupByLibrary.simpleMessage("Geh Entdecken"),
    "gotIt": MessageLookupByLibrary.simpleMessage("Compris"),
    "great_keep_going": MessageLookupByLibrary.simpleMessage(
      "Excellent ! Continue comme ça ✨",
    ),
    "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
      "Hé, devine qui va briser le silence en premier ?",
    ),
    "haveAstroLearnSayHi": MessageLookupByLibrary.simpleMessage(
      "Laissez Zena dire bonjour",
    ),
    "healing_calendar_title": MessageLookupByLibrary.simpleMessage(
      "Calendrier de Guérison Astral",
    ),
    "healing_category": MessageLookupByLibrary.simpleMessage("Guérison"),
    "healing_count": MessageLookupByLibrary.simpleMessage(
      "Séances de Guérison",
    ),
    "healing_data": MessageLookupByLibrary.simpleMessage("Données de Guérison"),
    "healing_music_title": MessageLookupByLibrary.simpleMessage(
      "Musique de Guérison",
    ),
    "healing_sessions": MessageLookupByLibrary.simpleMessage(
      "Séances de Guérison",
    ),
    "hereAstroLearnCookedUpForU": MessageLookupByLibrary.simpleMessage(
      "Ceci est fait par Zena pour vous",
    ),
    "horoscopeAnalysisError": m2,
    "horoscopeFetchFailed": MessageLookupByLibrary.simpleMessage(
      "Abrufen des Horoskops fehlgeschlagen",
    ),
    "horoscopeRemark": MessageLookupByLibrary.simpleMessage(
      "Tägliche Horoskop-Analyse",
    ),
    "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
      "Que pensez-vous de l\'interprétation simultanée par IA?",
    ),
    "iDigYourEnergy": MessageLookupByLibrary.simpleMessage(
      "J\'adore ton énergie !",
    ),
    "iLikeYourStyle": MessageLookupByLibrary.simpleMessage(
      "J\'aime ton style !",
    ),
    "imInterestedSomething": m3,
    "imVeryInterestedInSomething": m4,
    "incompleteBirthdayInfo": MessageLookupByLibrary.simpleMessage(
      "Les informations de date de naissance de l\'utilisateur sont incomplètes",
    ),
    "infoIncompleteTitle": MessageLookupByLibrary.simpleMessage(
      "Informations Incomplètes",
    ),
    "intellectualCompatibility": MessageLookupByLibrary.simpleMessage(
      "Intellectuel",
    ),
    "interests": MessageLookupByLibrary.simpleMessage("Intérêts"),
    "interpretationOff": MessageLookupByLibrary.simpleMessage(
      "Interprétation Synchrone IA : Désactivée",
    ),
    "interpretationOn": MessageLookupByLibrary.simpleMessage(
      "Interprétation Synchrone IA : Activée",
    ),
    "issues": MessageLookupByLibrary.simpleMessage("Problèmes"),
    "justNow": MessageLookupByLibrary.simpleMessage("À l\'instant"),
    "justSendALike": MessageLookupByLibrary.simpleMessage(
      "Partagez simplement votre appréciation",
    ),
    "justTypeInYourLanguage": m5,
    "keep_it_up": MessageLookupByLibrary.simpleMessage(
      "Continuez comme ça ! Vous vous en sortez très bien ✨",
    ),
    "last_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "Letztes Viertel, lassen Sie die Vergangenheit los und bereiten Sie sich auf neue Anfänge vor",
    ),
    "leoSign": MessageLookupByLibrary.simpleMessage("Le Lion"),
    "letAstroLearnSayHiForYou": MessageLookupByLibrary.simpleMessage(
      "Laissez Zena vous saluer",
    ),
    "libraSign": MessageLookupByLibrary.simpleMessage("Balance"),
    "lifestyleCompatibility": MessageLookupByLibrary.simpleMessage(
      "Style de Vie",
    ),
    "lightAnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "Leichte KI-Analyse",
    ),
    "lightSynastryRemark": MessageLookupByLibrary.simpleMessage(
      "Analyse de Synastrie",
    ),
    "likeBack": MessageLookupByLibrary.simpleMessage("Like en retour"),
    "likedBack": MessageLookupByLibrary.simpleMessage("Déjà liké en retour"),
    "likedPageMonetizeButton": MessageLookupByLibrary.simpleMessage(
      "Apprenez leur partage",
    ),
    "likedPageNoData": MessageLookupByLibrary.simpleMessage(
      "Statut : Pas encore d\'appréciations\n\nQue faire : Commencer à partager\n\nSuggestion :\nPortraits authentiques\nHistoires genuines\nIntérêts partagés connectent\n\nJe veux dire...\nTéléchargez vos vraies photos\nPartagez votre histoire authentique\nChoisissez vos intérêts",
    ),
    "likedYou": MessageLookupByLibrary.simpleMessage("Aprecie votre partage"),
    "loading": MessageLookupByLibrary.simpleMessage("Chargement..."),
    "locationAuthorizeContent": MessageLookupByLibrary.simpleMessage(
      "Nous avons besoin de votre localisation pour vous montrer des personnes à proximité",
    ),
    "locationLocatedFailed": MessageLookupByLibrary.simpleMessage(
      "Échec de l\'obtention de l\'emplacement",
    ),
    "locationLocatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Localisé à la position actuelle",
    ),
    "locationPermissionRequestSubtitle": MessageLookupByLibrary.simpleMessage(
      "Nous avons besoin de votre localisation pour améliorer votre expérience sociale",
    ),
    "locationPermissionRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Autoriser l\'emplacement",
    ),
    "mapSelectedLocation": MessageLookupByLibrary.simpleMessage(
      "Emplacement sélectionné sur la carte",
    ),
    "matchPageSelectIdeas": m6,
    "me": MessageLookupByLibrary.simpleMessage("Moi"),
    "meditation_category": MessageLookupByLibrary.simpleMessage("Méditation"),
    "meditation_count": MessageLookupByLibrary.simpleMessage(
      "Nombre de Méditations",
    ),
    "meditation_practice": MessageLookupByLibrary.simpleMessage(
      "Pratique de Méditation",
    ),
    "meditation_practice_title": MessageLookupByLibrary.simpleMessage(
      "Pratique de Méditation",
    ),
    "meditation_saved": MessageLookupByLibrary.simpleMessage(
      "✅ Enregistrement de méditation sauvegardé",
    ),
    "meditation_subtitle": MessageLookupByLibrary.simpleMessage(
      "Trouvez la paix intérieure par la méditation astrale",
    ),
    "memberCenter": MessageLookupByLibrary.simpleMessage("Centre Membre"),
    "membersPerks": MessageLookupByLibrary.simpleMessage(
      "Les membres obtiennent des avantages exclusifs",
    ),
    "minutes_duration": m7,
    "month": MessageLookupByLibrary.simpleMessage("Mois"),
    "month_day_format": m8,
    "mood": MessageLookupByLibrary.simpleMessage("Humeur"),
    "mood_index": MessageLookupByLibrary.simpleMessage("Indice d\'Humeur"),
    "mood_score": m9,
    "moonPhaseAnalysis": MessageLookupByLibrary.simpleMessage(
      "Mondphasen-Analyse",
    ),
    "moonPhaseAnalysisError": m10,
    "moonPhaseAnalysisRemark": MessageLookupByLibrary.simpleMessage(
      "Mondphasen-Energie-Analyse",
    ),
    "moonPhaseAnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "Mondphasen-Energie-Analyse",
    ),
    "moonPhaseEnergy": MessageLookupByLibrary.simpleMessage(
      "Mondphasen-Energie",
    ),
    "moonPhaseFetchFailed": MessageLookupByLibrary.simpleMessage(
      "Abrufen der Mondphase fehlgeschlagen",
    ),
    "moonPhaseRemark": MessageLookupByLibrary.simpleMessage(
      "Mondphasen-Energie-Analyse",
    ),
    "morePhotosBenefit": MessageLookupByLibrary.simpleMessage(
      "Plus il y a de photos, plus la recommandation est élevée",
    ),
    "morePhotosMoreCharm": MessageLookupByLibrary.simpleMessage(
      "Plus de photos, Plus de charme!",
    ),
    "music_subtitle": MessageLookupByLibrary.simpleMessage(
      "Audio astral relaxant pour l\'esprit et le corps",
    ),
    "myPhotos": MessageLookupByLibrary.simpleMessage("Mes Photos"),
    "myProfileTitle": MessageLookupByLibrary.simpleMessage("Mon Profil"),
    "my_statistics": MessageLookupByLibrary.simpleMessage("Mes Statistiques"),
    "navigateToAstroProfile": MessageLookupByLibrary.simpleMessage(
      "Aller à la page de profil astro",
    ),
    "nearby": MessageLookupByLibrary.simpleMessage("À proximité"),
    "newGameplay": MessageLookupByLibrary.simpleMessage("Nouveau gameplay"),
    "newMatch": MessageLookupByLibrary.simpleMessage("Nouvelle connexion !"),
    "new_moon_insight": MessageLookupByLibrary.simpleMessage(
      "Neumond-Moment, perfekt für neue Heilungspläne",
    ),
    "nextBilingDate": MessageLookupByLibrary.simpleMessage(
      "Prochaine date de paiement",
    ),
    "noMessageTips": MessageLookupByLibrary.simpleMessage(
      "Statut : Pas de messages\n\nQue faire : Trouver des auditeurs\n\nSuggestion : Partagez votre authenticité",
    ),
    "noOneFoundYourCharm": MessageLookupByLibrary.simpleMessage(
      "Personne n\'a encore trouvé votre charme",
    ),
    "noThanks": MessageLookupByLibrary.simpleMessage("Non, merci"),
    "no_audio": MessageLookupByLibrary.simpleMessage("Pas d\'audio disponible"),
    "no_quotes": MessageLookupByLibrary.simpleMessage(
      "Pas de citations disponibles",
    ),
    "no_records_today": MessageLookupByLibrary.simpleMessage(
      "Aucun enregistrement pour ce jour",
    ),
    "notes": MessageLookupByLibrary.simpleMessage("Notes"),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "onboarding0": MessageLookupByLibrary.simpleMessage(
      "Zena est comme une base d\'accueil pour les citoyens du monde",
    ),
    "onboarding1": MessageLookupByLibrary.simpleMessage(
      "Que vous soyez chez vous ou en route, rencontrez des gens du monde entier. Et...",
    ),
    "onboarding2": MessageLookupByLibrary.simpleMessage(
      "Vous obtiendrez un superpouvoir :\nMaîtrise des langues Plus de barrières à la communication",
    ),
    "onboarding3": MessageLookupByLibrary.simpleMessage(
      "Parle moins, aime plus. Une romance légendaire t\'attend",
    ),
    "onboardingWish": MessageLookupByLibrary.simpleMessage(
      "Veuillez compléter la liste de\nsouhaits pour obtenir un match plus idéal",
    ),
    "oneLineToWin": MessageLookupByLibrary.simpleMessage(
      "Ein Satz, um sie zu überzeugen",
    ),
    "oopsNoDataRightNow": MessageLookupByLibrary.simpleMessage(
      "Oups, pas de données pour l\'instant",
    ),
    "peopleFromYourWishlistGetMoreRecommendations":
        MessageLookupByLibrary.simpleMessage(
          "Les paramètres de votre liste de souhaits joueront un rôle plus important",
        ),
    "permissionRequiredContent": MessageLookupByLibrary.simpleMessage(
      "Nous avons besoin de cette autorisation pour vous offrir la meilleure expérience",
    ),
    "permissionRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Permission Requise",
    ),
    "personaCompleteProfile": MessageLookupByLibrary.simpleMessage(
      "Compléter le profil de base",
    ),
    "personaCompleteProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Namen, Geburtstag, Geschlecht vervollständigen für mehr Empfehlungen",
    ),
    "personaEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "Nachrichtenbenachrichtigungen aktivieren",
    ),
    "personaEnableNotificationsDesc": MessageLookupByLibrary.simpleMessage(
      "Verpassen Sie keine Matches und Nachrichten, interagieren Sie rechtzeitig",
    ),
    "personaForYou": MessageLookupByLibrary.simpleMessage("Für dich"),
    "personaShowCity": MessageLookupByLibrary.simpleMessage(
      "Zeige deine Stadt",
    ),
    "personaShowCityDesc": MessageLookupByLibrary.simpleMessage(
      "Einfacher von lokalen Benutzern entdeckt zu werden",
    ),
    "personaUploadPhotos": MessageLookupByLibrary.simpleMessage(
      "Ihre Fotos hochladen",
    ),
    "personaUploadPhotosDesc": MessageLookupByLibrary.simpleMessage(
      "Fügen Sie mindestens 2 klare Fotos hinzu",
    ),
    "photoFromCamera": MessageLookupByLibrary.simpleMessage(
      "Prendre une photo",
    ),
    "photoFromGallery": MessageLookupByLibrary.simpleMessage(
      "Sélectionner dans la galerie",
    ),
    "photoMightNotBeReal": MessageLookupByLibrary.simpleMessage(
      "Cette photo pourrait ne pas être réelle",
    ),
    "photos": MessageLookupByLibrary.simpleMessage("Photos"),
    "piscesSign": MessageLookupByLibrary.simpleMessage("Poissons"),
    "played_audio": MessageLookupByLibrary.simpleMessage("Audio lu"),
    "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
        MessageLookupByLibrary.simpleMessage(
          "Veuillez vérifier votre internet ou Appuyez pour Rafraîchir et réessayer",
        ),
    "please_write_feelings": MessageLookupByLibrary.simpleMessage(
      "Veuillez écrire vos sentiments",
    ),
    "plusBenefitActivityReminder": MessageLookupByLibrary.simpleMessage(
      "Rappels d\'activité et de retour",
    ),
    "plusBenefitActivitySort": MessageLookupByLibrary.simpleMessage(
      "Trier par activité récente et taux de réponse",
    ),
    "plusBenefitAdvancedFilter": MessageLookupByLibrary.simpleMessage(
      "Filtres avancés: pays/langue/fuseau horaire/ville",
    ),
    "plusBenefitAntiHarassment": MessageLookupByLibrary.simpleMessage(
      "Protection prioritaire contre le harcèlement et protection du poids",
    ),
    "plusBenefitConflictAdvice": MessageLookupByLibrary.simpleMessage(
      "Points de conflit et conseils relationnels",
    ),
    "plusBenefitDestinyPriority": MessageLookupByLibrary.simpleMessage(
      "Exposition prioritaire du destin dans les recommandations et likes",
    ),
    "plusBenefitDestinyPush": MessageLookupByLibrary.simpleMessage(
      "Notifications d\'arrivée de nouvelle correspondance du destin",
    ),
    "plusBenefitDimensionBreakdown": MessageLookupByLibrary.simpleMessage(
      "Décomposition en 4 dimensions: personnalité/communication/intimité/frontières",
    ),
    "plusBenefitHighMatchDisplay": MessageLookupByLibrary.simpleMessage(
      "Affichage du score de correspondance élevé avec pourcentage",
    ),
    "plusBenefitHistoryTranslation": MessageLookupByLibrary.simpleMessage(
      "Traduction de l\'historique des messages en un clic",
    ),
    "plusBenefitInterestFilter": MessageLookupByLibrary.simpleMessage(
      "Filtres d\'intérêt et plan de voyage",
    ),
    "plusBenefitLikeReminder": MessageLookupByLibrary.simpleMessage(
      "Rappels de j\'aime en retour et accusé de réception",
    ),
    "plusBenefitMatchScore": MessageLookupByLibrary.simpleMessage(
      "Visualisation du score global de compatibilité",
    ),
    "plusBenefitMessageTemplates": MessageLookupByLibrary.simpleMessage(
      "Modèles de message rapide (compliments/invitations/changement de plateforme)",
    ),
    "plusBenefitOCRTranslation": MessageLookupByLibrary.simpleMessage(
      "Traduction instantanée d\'image et reconnaissance de texte",
    ),
    "plusBenefitRealTimeTranslation": MessageLookupByLibrary.simpleMessage(
      "Traduction et polissage en temps réel: correction automatique multilingue",
    ),
    "plusBenefitSmartOpener": MessageLookupByLibrary.simpleMessage(
      "Lignes d\'ouverture intelligentes: 3 suggestions de conversion élevée par personne",
    ),
    "plusBenefitStarGreeting": MessageLookupByLibrary.simpleMessage(
      "Paquet de salutation stellaire: 10 salutations quotidiennes",
    ),
    "plusBenefitSupportChannel": MessageLookupByLibrary.simpleMessage(
      "Canal d\'accélération pour les problèmes d\'abonnement",
    ),
    "plusBenefitTopicPool": MessageLookupByLibrary.simpleMessage(
      "Piscine de sujets de conversation basée sur l\'analyse de profil",
    ),
    "plusBenefitUnlockLikedMe": MessageLookupByLibrary.simpleMessage(
      "Débloquer avatars et étiquettes claires dans M\'a aimé",
    ),
    "plusDescTitle": MessageLookupByLibrary.simpleMessage("Description Plus"),
    "plusFuncAIInterpretation": MessageLookupByLibrary.simpleMessage(
      "1000 interprétations simultanées/jour",
    ),
    "plusFuncAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "Zena Tips - Ton conseiller de chat",
    ),
    "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage(
      "5 DM par semaine",
    ),
    "plusFuncFilterMatchingCountries": MessageLookupByLibrary.simpleMessage(
      "Filtrer les pays correspondants",
    ),
    "plusFuncUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "Likes illimités",
    ),
    "plusFuncUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "Libérer pour voir qui apprécie votre partage",
    ),
    "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3 souhaits"),
    "plusMember": MessageLookupByLibrary.simpleMessage("Membre Plus"),
    "plusMembershipBenefits": MessageLookupByLibrary.simpleMessage(
      "Avantages de l\'Abonnement Plus",
    ),
    "plusPerkDuoSnap": MessageLookupByLibrary.simpleMessage(
      "Duo Snap avec Plus",
    ),
    "practice_count": MessageLookupByLibrary.simpleMessage(
      "Nombre de Pratiques",
    ),
    "preference": MessageLookupByLibrary.simpleMessage("Préférence"),
    "privacy": MessageLookupByLibrary.simpleMessage("Confidentialité"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Politique de confidentialité",
    ),
    "productNotFound": MessageLookupByLibrary.simpleMessage(
      "Prodotto non trovato",
    ),
    "profileInfoTab": MessageLookupByLibrary.simpleMessage("Profil"),
    "profileNotShown": MessageLookupByLibrary.simpleMessage(
      "Ils n\'ont pas encore montré leur vrai visage",
    ),
    "profileTip": MessageLookupByLibrary.simpleMessage(
      "✨ Vervollständigen Sie Ihr Profil, damit die Sterne Sie besser kennen können, für eine genauere Zuordnung",
    ),
    "psychological_healing": MessageLookupByLibrary.simpleMessage(
      "Guérison Psychologique",
    ),
    "purchaseFailed": MessageLookupByLibrary.simpleMessage("Achat Échoué"),
    "purchasePending": MessageLookupByLibrary.simpleMessage("Achat en Cours"),
    "pushNotifications": MessageLookupByLibrary.simpleMessage(
      "Notifications push",
    ),
    "quickActions": MessageLookupByLibrary.simpleMessage("Actions Rapides"),
    "quote_1": MessageLookupByLibrary.simpleMessage(
      "Vous brillez comme une étoile aujourd\'hui",
    ),
    "quote_10": MessageLookupByLibrary.simpleMessage(
      "Trouvez les réponses dans les moments calmes",
    ),
    "quote_2": MessageLookupByLibrary.simpleMessage(
      "Faites-vous confiance comme vous faites confiance aux étoiles",
    ),
    "quote_3": MessageLookupByLibrary.simpleMessage(
      "Chacun est une constellation unique",
    ),
    "quote_4": MessageLookupByLibrary.simpleMessage(
      "L\'énergie de l\'univers est avec vous",
    ),
    "quote_5": MessageLookupByLibrary.simpleMessage(
      "Acceptez-vous tel que vous êtes maintenant",
    ),
    "quote_6": MessageLookupByLibrary.simpleMessage(
      "Chaque émotion mérite d\'être vue",
    ),
    "quote_7": MessageLookupByLibrary.simpleMessage(
      "Laissez l\'énergie stellaire couler à travers vous",
    ),
    "quote_8": MessageLookupByLibrary.simpleMessage(
      "Aujourd\'hui est nouveau avec des possibilités infinies",
    ),
    "quote_9": MessageLookupByLibrary.simpleMessage(
      "Votre existence est un miracle en soi",
    ),
    "quotes_subtitle": MessageLookupByLibrary.simpleMessage(
      "Énergie guérissante des étoiles",
    ),
    "record_daily_status": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le Statut Quotidien",
    ),
    "record_today_hint": MessageLookupByLibrary.simpleMessage(
      "Que souhaitez-vous enregistrer aujourd\'hui?",
    ),
    "record_your_feelings": MessageLookupByLibrary.simpleMessage(
      "Enregistrez vos sentiments",
    ),
    "recorded_days": MessageLookupByLibrary.simpleMessage("Jours Enregistrés"),
    "recorded_emotion": MessageLookupByLibrary.simpleMessage(
      "Émotion enregistrée",
    ),
    "relaxation_category": MessageLookupByLibrary.simpleMessage("Relaxation"),
    "remindUploadPhoto": MessageLookupByLibrary.simpleMessage(
      "📸 Erinnern Sie sie daran, Fotos hochzuladen, lernen Sie sich besser kennen",
    ),
    "report": MessageLookupByLibrary.simpleMessage("Signaler"),
    "reportOptionGore": MessageLookupByLibrary.simpleMessage("Gore"),
    "reportOptionOther": MessageLookupByLibrary.simpleMessage("Autre"),
    "reportOptionPerAstroLearnlAttack": MessageLookupByLibrary.simpleMessage(
      "Attaque personnelle",
    ),
    "reportOptionPersonalAttack": MessageLookupByLibrary.simpleMessage(
      "Attaque personnelle",
    ),
    "reportOptionPornography": MessageLookupByLibrary.simpleMessage(
      "Pornographie",
    ),
    "reportOptionScam": MessageLookupByLibrary.simpleMessage("Arnaque"),
    "requireYourRealPhoto": MessageLookupByLibrary.simpleMessage(
      "Nous avons besoin de votre vraie photo",
    ),
    "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
      "Rencontrer des étrangers près de chez vous",
    ),
    "sagittariusSign": MessageLookupByLibrary.simpleMessage("Sagittaire"),
    "save": MessageLookupByLibrary.simpleMessage("Enregistrer"),
    "save_failed": m11,
    "scorpioSign": MessageLookupByLibrary.simpleMessage("Scorpion"),
    "screenshotEvidence": MessageLookupByLibrary.simpleMessage(
      "Preuve par capture d\'écran",
    ),
    "seeProfile": MessageLookupByLibrary.simpleMessage("Voir le profil"),
    "seeWhoLikeU": MessageLookupByLibrary.simpleMessage(
      "Voir qui vous apprécie",
    ),
    "selectBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Geburtsort auswählen",
    ),
    "selectBirthdayHint": MessageLookupByLibrary.simpleMessage(
      "Selecione a sua data de nascimento para ver o seu gráfico astrológico",
    ),
    "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage(
      "Sélectionner le Pays",
    ),
    "selectLocationTitle": MessageLookupByLibrary.simpleMessage(
      "Sélectionner l\'Emplacement",
    ),
    "select_duration_start": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez la durée pour commencer la méditation",
    ),
    "select_meditation_duration": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez la durée de méditation",
    ),
    "sendDm": MessageLookupByLibrary.simpleMessage("Envoyer DM"),
    "sendDmRemark": MessageLookupByLibrary.simpleMessage("Envoyer Message DM"),
    "sendStarGreetingToUnlockAlbum": MessageLookupByLibrary.simpleMessage(
      "💫 Envoyez un salut stellaire pour débloquer l\'album Continuer",
    ),
    "setDefault": MessageLookupByLibrary.simpleMessage("Définir par défaut"),
    "setInterestTags": MessageLookupByLibrary.simpleMessage(
      "Définissez des tags d\'intérêt clairs",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "showYourPerAstroLearnlity": MessageLookupByLibrary.simpleMessage(
      "Montre ta personnalité",
    ),
    "showYourPersonality": MessageLookupByLibrary.simpleMessage(
      "Montrez votre personnalité",
    ),
    "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage(
      "Presque fini",
    ),
    "sixMonths": MessageLookupByLibrary.simpleMessage("6 mois"),
    "sleep_category": MessageLookupByLibrary.simpleMessage("Sommeil"),
    "speakSameLanguage": MessageLookupByLibrary.simpleMessage(
      "Vous parlez la même langue",
    ),
    "spiritual_growth": MessageLookupByLibrary.simpleMessage(
      "Croissance Spirituelle",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "startChat": MessageLookupByLibrary.simpleMessage("Commencer le chat"),
    "start_meditation": MessageLookupByLibrary.simpleMessage(
      "Commencer la Méditation",
    ),
    "startedChat": MessageLookupByLibrary.simpleMessage(
      "A commencé à chatter avec",
    ),
    "status_saved": MessageLookupByLibrary.simpleMessage("✅ Statut enregistré"),
    "stop_meditation": MessageLookupByLibrary.simpleMessage(
      "Arrêter la Méditation",
    ),
    "streak_days": MessageLookupByLibrary.simpleMessage("Jours Consécutifs"),
    "streak_x_days": m12,
    "stress": MessageLookupByLibrary.simpleMessage("Stress"),
    "stress_index": MessageLookupByLibrary.simpleMessage("Indice de Stress"),
    "stress_level": MessageLookupByLibrary.simpleMessage("Niveau de Stress"),
    "subPageSubtitleAIInterpretationDaily":
        MessageLookupByLibrary.simpleMessage(
          "1000 \ninterprétations \nsimultanées/jour",
        ),
    "subPageSubtitleAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "Zena Tips - \nTon conseiller de chat",
    ),
    "subPageSubtitleDMWeekly": MessageLookupByLibrary.simpleMessage(
      "5 DM par semaine",
    ),
    "subPageSubtitleFilterMatchingCountries":
        MessageLookupByLibrary.simpleMessage("Filtrer les pays de \nconnexion"),
    "subPageSubtitleUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "Likes illimités",
    ),
    "subPageSubtitleUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "Libérer pour voir \nqui vous apprécie",
    ),
    "subPageTitle": MessageLookupByLibrary.simpleMessage("Obtenir Zena Plus"),
    "subscriptionAgreement": MessageLookupByLibrary.simpleMessage(
      "Conditions Générales",
    ),
    "subscriptionAgreementPrefix": m13,
    "subscriptionAgreementSuffix": MessageLookupByLibrary.simpleMessage(" ."),
    "sunSignLabel": MessageLookupByLibrary.simpleMessage("Sonnenzeichen"),
    "synastryAnalysis": MessageLookupByLibrary.simpleMessage("Analyse"),
    "takeIt": MessageLookupByLibrary.simpleMessage("Utiliser"),
    "taurusSign": MessageLookupByLibrary.simpleMessage("Taureau"),
    "termsOfService": MessageLookupByLibrary.simpleMessage(
      "Conditions de Service",
    ),
    "theKeyIsBalance": MessageLookupByLibrary.simpleMessage(
      "La clé est l\'équilibre",
    ),
    "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
      "👆 Ils attendent ta réponse",
    ),
    "threeMonths": MessageLookupByLibrary.simpleMessage("3 mois"),
    "toastHitDailyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👀Tu as atteint ta limite quotidienne",
    ),
    "toastHitWeeklyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👅Tu as atteint ta limite hebdomadaire",
    ),
    "toggle_background_music": MessageLookupByLibrary.simpleMessage(
      "Basculer la Musique de Fond",
    ),
    "total_duration": MessageLookupByLibrary.simpleMessage("Durée Totale"),
    "unknownLocation": MessageLookupByLibrary.simpleMessage("Inconnu"),
    "unlockDailyHoroscope": MessageLookupByLibrary.simpleMessage(
      "Entsperren Sie das detaillierte Sternzeichen-Horoskop",
    ),
    "unlockHighMatchUsers": m14,
    "unlockMoonPhaseInsight": MessageLookupByLibrary.simpleMessage(
      "Entsperren Sie die Energie-Einsicht der heutigen Mondphase",
    ),
    "unlockUsersWithDestiny": m15,
    "unmissableSpecialOfferPrices": MessageLookupByLibrary.simpleMessage(
      "Prix spéciaux incontournables",
    ),
    "unsupportedPlatform": MessageLookupByLibrary.simpleMessage(
      "Piattaforma non supportata",
    ),
    "upgradeForMoreRecommendations": MessageLookupByLibrary.simpleMessage(
      "Upgrade auf Premium für mehr Empfehlungen",
    ),
    "uploadQualityPhotos": MessageLookupByLibrary.simpleMessage(
      "Chargez des photos réelles de haute qualité",
    ),
    "uploadYourPhoto": MessageLookupByLibrary.simpleMessage(
      "Chargez votre photo",
    ),
    "uploadYourPhotoHint": MessageLookupByLibrary.simpleMessage(
      "Chargez votre meilleure photo",
    ),
    "uploading": MessageLookupByLibrary.simpleMessage("Wird hochgeladen..."),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "Utiliser la position actuelle",
    ),
    "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage(
      "Prendre une photo",
    ),
    "userAvatarOptionGallery": MessageLookupByLibrary.simpleMessage(
      "Sélectionner dans la galerie",
    ),
    "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Un bon portrait vous aide à vous connecter avec plus d\'auditeurs. Soyez réel et utilisez une photo légitime de vous-même.",
    ),
    "userAvatarPageTitle": MessageLookupByLibrary.simpleMessage("Montrez-vous"),
    "userAvatarUploadedLabel": MessageLookupByLibrary.simpleMessage(
      "Téléchargement terminé !",
    ),
    "userBirthdayInputLabel": MessageLookupByLibrary.simpleMessage(
      "Date de naissance",
    ),
    "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Une fois confirmé, la nationalité ne peut être changée",
    ),
    "userCitizenshipPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Nationalité",
    ),
    "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("Genre"),
    "userGenderOptionFemale": MessageLookupByLibrary.simpleMessage("Féminin"),
    "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("Masculin"),
    "userGenderOptionNonBinary": MessageLookupByLibrary.simpleMessage(
      "Non binaire",
    ),
    "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Votre genre ne sera pas affiché publiquement, il sera utilisé uniquement pour aider à la connexion",
    ),
    "userInfoPageNamePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Entrer",
    ),
    "userInfoPageTitle": MessageLookupByLibrary.simpleMessage(
      "Information de base",
    ),
    "userNameInputLabel": MessageLookupByLibrary.simpleMessage("Nom"),
    "userPhoneNumberPagePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Numéro de Téléphone",
    ),
    "userPhoneNumberPagePrivacySuffix": MessageLookupByLibrary.simpleMessage(
      " ",
    ),
    "userPhoneNumberPagePrivacyText": MessageLookupByLibrary.simpleMessage(
      "politique de confidentialité",
    ),
    "userPhoneNumberPageTermsAnd": MessageLookupByLibrary.simpleMessage(" et "),
    "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
      "En appuyant sur \"Étape Suivante\", vous acceptez nos ",
    ),
    "userPhoneNumberPageTermsText": MessageLookupByLibrary.simpleMessage(
      "conditions de service",
    ),
    "userPhoneNumberPageTitle": MessageLookupByLibrary.simpleMessage(
      "Entrez le numéro de téléphone",
    ),
    "valuesCompatibility": MessageLookupByLibrary.simpleMessage("Valeurs"),
    "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage(
      "Entrez le code de vérification",
    ),
    "viewAstroReport": MessageLookupByLibrary.simpleMessage(
      "Voir rapport astro avec",
    ),
    "view_details": MessageLookupByLibrary.simpleMessage("Voir les Détails"),
    "virgoSign": MessageLookupByLibrary.simpleMessage("Vierge"),
    "waning_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "Abnehmender Halbmond-Moment, Ruhe und Erholung sind wichtig",
    ),
    "waning_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "Der Mond nimmt ab, gute Zeit für Reflexion und Organisation",
    ),
    "wannaHollaAt": MessageLookupByLibrary.simpleMessage(
      "Souhaiteriez-vous partager...",
    ),
    "warningCancelDisplayCity": MessageLookupByLibrary.simpleMessage(
      "Après la fermeture, votre ville ne sera pas affichée lors de l\'appariement",
    ),
    "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
      "Votre compte sera automatiquement supprimé dans 14 jours. N\'oubliez pas de vous rendre en magasin pour annuler votre abonnement actuel afin d\'éviter des frais supplémentaires.",
    ),
    "warningDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Si vous supprimez votre compte, vous ne pourrez plus vous connecter avec. Êtes-vous sûr de vouloir supprimer ?",
    ),
    "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
      "Lien externe. Vérifiez si la source est fiable avant de cliquer, car les liens inconnus peuvent être des arnaques ou voler des données. Procédez avec prudence.",
    ),
    "warningTitleCaution": MessageLookupByLibrary.simpleMessage("Prudence"),
    "warningUnmatching": MessageLookupByLibrary.simpleMessage(
      "Après avoir terminé le partage, tout l\'historique des conversations sera supprimé.",
    ),
    "waxing_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "Der Mond nimmt zu, die Energie sammelt sich allmählich an",
    ),
    "waxing_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "Vollmond naht, Emotionen können empfindlicher sein",
    ),
    "whatsYourEmail": MessageLookupByLibrary.simpleMessage(
      "Quel est votre email ?",
    ),
    "whoLIkesYou": MessageLookupByLibrary.simpleMessage(
      "Qui apprécie votre partage",
    ),
    "whoLikesU": MessageLookupByLibrary.simpleMessage("Qui vous apprécie"),
    "wishActivityAddTitle": MessageLookupByLibrary.simpleMessage(
      "Ajoutez votre pensée",
    ),
    "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Aider à trouver des compagnons",
    ),
    "wishActivityPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Tu veux faire quelque chose ?",
    ),
    "wishCityPickerSkipButton": m16,
    "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "si vous y allez, Quelles villes souhaitez-vous visiter ?",
    ),
    "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Quel pays vous intéresse le plus ?",
    ),
    "wishCreationComplete": MessageLookupByLibrary.simpleMessage(
      "Ton souhait a été reçu",
    ),
    "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("Déjà ici"),
    "wishDateOptionNotSure": MessageLookupByLibrary.simpleMessage(
      "Pas encore sûr",
    ),
    "wishDateOptionRecent": MessageLookupByLibrary.simpleMessage(
      "Récemment, je suppose",
    ),
    "wishDateOptionYear": MessageLookupByLibrary.simpleMessage("Dans un an"),
    "wishDatePickerSubtitle": m17,
    "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("Quand"),
    "wishList": MessageLookupByLibrary.simpleMessage("Liste de souhaits"),
    "wishes": MessageLookupByLibrary.simpleMessage("Souhait"),
    "writeInterestingBio": MessageLookupByLibrary.simpleMessage(
      "Écrivez une biographie personnelle intéressante",
    ),
    "write_feelings_hint": MessageLookupByLibrary.simpleMessage(
      "Écrivez ce que vous ressentez...",
    ),
    "x_days": m18,
    "x_hours": m19,
    "x_times": m20,
    "youAreAClubMemberNow": MessageLookupByLibrary.simpleMessage(
      "Vous êtes maintenant membre du club",
    ),
    "youCanEditItAnytime": MessageLookupByLibrary.simpleMessage(
      "Tu peux le modifier à tout moment",
    ),
    "youSeemCool": MessageLookupByLibrary.simpleMessage("Tu as l\'air cool"),
  };
}
