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

  static String m0(month, day) => "${month}/${day}";

  static String m1(x) => "${x} giorni all\'obiettivo di 30 giorni";

  static String m2(something) => "\"Sono interessato a ${something}!\"";

  static String m3(something) => "Sono molto interessato a ‘${something}’!";

  static String m4(lang) => "Basta scrivere in ${lang}";

  static String m5(gender) =>
      "Quale delle ${Intl.gender(gender, female: 'sue', male: 'sue', other: 'loro')} esperienze condivise risuona con te?";

  static String m6(minutes) => "${minutes} minuti";

  static String m7(month, day) => "${month}月${day}日";

  static String m8(score) => "Umore ${score}/10";

  static String m9(error) => "❌ Salvataggio fallito: ${error}";

  static String m10(x) => "🔥 ${x} giorni di fila!";

  static String m11(storeName) =>
      "Cliccando su \"Continua\" ti verranno addebitati dei costi, l\'abbonamento si rinnoverà automaticamente al prezzo del pacchetto e potrai cancellare dal ${storeName}. Continuando, accetti i nostri ";

  static String m12(count) =>
      "Sblocca per vedere ${count} utenti ad alta corrispondenza ✨";

  static String m13(count, destinyCount) =>
      "Sblocca ${count} utenti inclusi ${destinyCount} match del destino ⭐";

  static String m14(country) => "Saltare, Solo ${country}";

  static String m15(country) => "Hai in programma di andare in ${country}?";

  static String m16(x) => "${x} giorni";

  static String m17(x) => "${x} ore";

  static String m18(x) => "${x} volte";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aMonth": MessageLookupByLibrary.simpleMessage("1 mesi"),
    "aYear": MessageLookupByLibrary.simpleMessage("1 anno"),
    "about": MessageLookupByLibrary.simpleMessage("Su"),
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "active_days": MessageLookupByLibrary.simpleMessage("Giorni Attivi"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("Aggiungi Foto"),
    "age": MessageLookupByLibrary.simpleMessage("Età"),
    "aiCreatingFunGroupPics": MessageLookupByLibrary.simpleMessage(
      "AI che crea foto di gruppo divertenti",
    ),
    "allPeople": MessageLookupByLibrary.simpleMessage("Tutto"),
    "analyzingText": MessageLookupByLibrary.simpleMessage("Analyzing..."),
    "aquariusSign": MessageLookupByLibrary.simpleMessage("Acquario"),
    "ariesSign": MessageLookupByLibrary.simpleMessage("Ariete"),
    "ascendantSignLabel": MessageLookupByLibrary.simpleMessage(
      "Восходящий знак",
    ),
    "astroChartTab": MessageLookupByLibrary.simpleMessage("Grafico Astro"),
    "astroInfoIncompleteMessage": MessageLookupByLibrary.simpleMessage(
      "L\'altro utente non ha ancora completato le sue informazioni sulla posizione di nascita, quindi non possiamo generare un grafico astrologico. Si prega di attendere che completino le loro informazioni.",
    ),
    "astroLearnInterpretationOff": MessageLookupByLibrary.simpleMessage(
      "⭕ AstroLearn Interpretazione disattivata",
    ),
    "astroLearnRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
      "Raccomandazione di AstroLearn: Cooldown.\nCosa fare: Aspettare.\nSuggerimento: Guardare un film?",
    ),
    "astroLearnWillGenerateABioBasedOnInterests":
        MessageLookupByLibrary.simpleMessage(
          "AstroLearn genererà una biografia basata sui tuoi interessi",
        ),
    "astroReport": MessageLookupByLibrary.simpleMessage("Report astro"),
    "astro_calendar_title": MessageLookupByLibrary.simpleMessage(
      "Calendario di Guarigione Astrologica",
    ),
    "audio_1_desc": MessageLookupByLibrary.simpleMessage(
      "Trova la pace interiore sotto il cielo stellato silenzioso",
    ),
    "audio_1_title": MessageLookupByLibrary.simpleMessage(
      "Meditazione del Cielo Stellato",
    ),
    "audio_2_desc": MessageLookupByLibrary.simpleMessage(
      "Accendi il tuo coraggio e la tua vitalità interiori",
    ),
    "audio_2_title": MessageLookupByLibrary.simpleMessage(
      "Audio Energia dell\'Ariete",
    ),
    "audio_3_desc": MessageLookupByLibrary.simpleMessage(
      "Rilascia lo stress e trova il completo rilassamento",
    ),
    "audio_3_title": MessageLookupByLibrary.simpleMessage(
      "Guida al Rilassamento Profondo",
    ),
    "audio_4_desc": MessageLookupByLibrary.simpleMessage(
      "Bilancia le emozioni e trova l\'armonia interiore",
    ),
    "audio_4_title": MessageLookupByLibrary.simpleMessage(
      "Musica dell\'Equilibrio Emotivo",
    ),
    "avatarUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Aggiornamento avatar fallito",
    ),
    "average_mood": MessageLookupByLibrary.simpleMessage("Umore Medio"),
    "bio": MessageLookupByLibrary.simpleMessage("Introduzione"),
    "birthInfo": MessageLookupByLibrary.simpleMessage("Информация о рождении"),
    "birthPlace": MessageLookupByLibrary.simpleMessage("Место рождения"),
    "birthPlaceLabel": MessageLookupByLibrary.simpleMessage("Место рождения"),
    "birthTimeLabel": MessageLookupByLibrary.simpleMessage("Время рождения"),
    "birthday": MessageLookupByLibrary.simpleMessage("День рождения"),
    "block": MessageLookupByLibrary.simpleMessage("Bloccare"),
    "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
        MessageLookupByLibrary.simpleMessage(
          "Blocca questa perAstroLearn per non ricevere più messaggi da loro",
        ),
    "boostYourAppeal": MessageLookupByLibrary.simpleMessage("Fascino Su!"),
    "breakIce": MessageLookupByLibrary.simpleMessage(
      "🔨🔨🔨 Non fare caso a me🔨🔨🔨 Sto solo rompendo il ghiaccio🔨🔨🔨",
    ),
    "breathe_relax": MessageLookupByLibrary.simpleMessage(
      "Fai un respiro profondo e rilassati...",
    ),
    "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage(
      "Sei un membro Plus",
    ),
    "buttonAuthorize": MessageLookupByLibrary.simpleMessage("Autorizza"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Annullare"),
    "buttonChange": MessageLookupByLibrary.simpleMessage("Cambiare"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
    "buttonContinue": MessageLookupByLibrary.simpleMessage("Continua"),
    "buttonCopy": MessageLookupByLibrary.simpleMessage("Copiare"),
    "buttonDelete": MessageLookupByLibrary.simpleMessage("Cancellare"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Elimina account",
    ),
    "buttonDone": MessageLookupByLibrary.simpleMessage("Fatto"),
    "buttonEdit": MessageLookupByLibrary.simpleMessage("Modificare"),
    "buttonEditProfile": MessageLookupByLibrary.simpleMessage(
      "Modifica profilo",
    ),
    "buttonGenerate": MessageLookupByLibrary.simpleMessage("Generare"),
    "buttonGo": MessageLookupByLibrary.simpleMessage("Andare"),
    "buttonGotIt": MessageLookupByLibrary.simpleMessage("Capito"),
    "buttonHitAIInterpretationMaximumLimit":
        MessageLookupByLibrary.simpleMessage(
          "😪AstroLearn è stanca, 👇Tocca per ricaricarla!",
        ),
    "buttonJoinNow": MessageLookupByLibrary.simpleMessage("Unisciti Ora"),
    "buttonKeepAccount": MessageLookupByLibrary.simpleMessage(
      "Mantenere l\'account",
    ),
    "buttonManage": MessageLookupByLibrary.simpleMessage("Gestire"),
    "buttonNext": MessageLookupByLibrary.simpleMessage("Prossimo Passo"),
    "buttonOpenLink": MessageLookupByLibrary.simpleMessage("Apri Link"),
    "buttonPreview": MessageLookupByLibrary.simpleMessage("Anteprima"),
    "buttonPurchase": MessageLookupByLibrary.simpleMessage("Acquista"),
    "buttonRefresh": MessageLookupByLibrary.simpleMessage("Aggiornare"),
    "buttonResend": MessageLookupByLibrary.simpleMessage("Reinviare"),
    "buttonRestore": MessageLookupByLibrary.simpleMessage("Ripristinare"),
    "buttonSave": MessageLookupByLibrary.simpleMessage("Salvare"),
    "buttonSignOut": MessageLookupByLibrary.simpleMessage("Disconnettersi"),
    "buttonSubmit": MessageLookupByLibrary.simpleMessage("Inviare"),
    "buttonUnlockVipPerks": MessageLookupByLibrary.simpleMessage(
      "Sblocca i vantaggi VIP",
    ),
    "buttonUnmatch": MessageLookupByLibrary.simpleMessage(
      "Termina condivisione",
    ),
    "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("Disiscriviti"),
    "cancerSign": MessageLookupByLibrary.simpleMessage("Cancro"),
    "capricornSign": MessageLookupByLibrary.simpleMessage("Capricorno"),
    "catchMore": MessageLookupByLibrary.simpleMessage("Prendi di più"),
    "charmTips": MessageLookupByLibrary.simpleMessage(
      "Suggerimenti per il fascino",
    ),
    "chartPreview": MessageLookupByLibrary.simpleMessage("Anteprima Grafico"),
    "chat": MessageLookupByLibrary.simpleMessage("Chat"),
    "chatWithMatches": MessageLookupByLibrary.simpleMessage(
      "Chatta attivamente con gli utenti corrispondenti",
    ),
    "checkItOut": MessageLookupByLibrary.simpleMessage("Dagli un\'occhiata"),
    "checkOutTheirProfiles": MessageLookupByLibrary.simpleMessage(
      "Controlla i loro profili",
    ),
    "choosePlaceholder": MessageLookupByLibrary.simpleMessage("Scegliere"),
    "clickToSetBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы установить место рождения",
    ),
    "clickToSetBirthday": MessageLookupByLibrary.simpleMessage(
      "Нажмите, чтобы установить день рождения",
    ),
    "click_for_encouragement": MessageLookupByLibrary.simpleMessage(
      "Cliccami per incoraggiamento",
    ),
    "click_to_record_status": MessageLookupByLibrary.simpleMessage(
      "Clicca per registrare lo stato",
    ),
    "closeButtonText": MessageLookupByLibrary.simpleMessage("Закрыть"),
    "clubFeeJoking": MessageLookupByLibrary.simpleMessage(
      "Stavo scherzando! È gratis",
    ),
    "clubFeePrefix": MessageLookupByLibrary.simpleMessage(
      "Tariffa del club: \$99/mese",
    ),
    "clubPromotionContent": MessageLookupByLibrary.simpleMessage(
      "Unisciti al nostro club esclusivo per benefici fantastici",
    ),
    "clubPromotionTitle": MessageLookupByLibrary.simpleMessage(
      "Unisciti al Club",
    ),
    "commonLanguage": MessageLookupByLibrary.simpleMessage("Lingua principale"),
    "commonLanguageTitle": MessageLookupByLibrary.simpleMessage(
      "Lingue comunemente usate",
    ),
    "communicationCompatibility": MessageLookupByLibrary.simpleMessage(
      "Comunicazione",
    ),
    "compatibilityScore": MessageLookupByLibrary.simpleMessage("Compatibilità"),
    "completeAstroInfo": MessageLookupByLibrary.simpleMessage(
      "Completa informazioni astrologiche dettagliate",
    ),
    "completeAstroProfile": MessageLookupByLibrary.simpleMessage(
      "Completa il tuo profilo astro",
    ),
    "completeAstroProfileButton": MessageLookupByLibrary.simpleMessage(
      "Completa Profilo Astro",
    ),
    "completeBirthLocationInfo": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста",
    ),
    "completeProfile": MessageLookupByLibrary.simpleMessage(
      "Завершить Профиль",
    ),
    "confirmSelectLocation": MessageLookupByLibrary.simpleMessage(
      "Conferma selezione questa posizione",
    ),
    "continueWithPhone": MessageLookupByLibrary.simpleMessage(
      "Continua con telefono",
    ),
    "currentSelectedCoordinates": MessageLookupByLibrary.simpleMessage(
      "Coordinate attualmente selezionate",
    ),
    "current_emotion": MessageLookupByLibrary.simpleMessage("Emozione Attuale"),
    "daily_quote": MessageLookupByLibrary.simpleMessage("Citazione del Giorno"),
    "daily_quotes_title": MessageLookupByLibrary.simpleMessage(
      "Citazioni Quotidiane",
    ),
    "daily_status": MessageLookupByLibrary.simpleMessage("Stato Giornaliero"),
    "date_format_md": m0,
    "days_to_30_goal": m1,
    "deepAnalysisReportTitle": MessageLookupByLibrary.simpleMessage(
      "Отчет глубокого анализа ИИ",
    ),
    "deepSynastryAnalysis": MessageLookupByLibrary.simpleMessage(
      "Глубокий анализ",
    ),
    "deepSynastryRemark": MessageLookupByLibrary.simpleMessage(
      "Analisi Approfondita di Sinastria",
    ),
    "defaultBirthTime": MessageLookupByLibrary.simpleMessage(
      "12:00 (По умолчанию)",
    ),
    "deletePhoto": MessageLookupByLibrary.simpleMessage("Elimina Foto"),
    "deletePhotoContent": MessageLookupByLibrary.simpleMessage(
      "Sei sicuro di voler eliminare questa foto? Questa azione non può essere annullata.",
    ),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage(
      "Descrizione (opzionale)",
    ),
    "destinyMatch": MessageLookupByLibrary.simpleMessage("Match del Destino"),
    "diamondConsumeFailed": MessageLookupByLibrary.simpleMessage(
      "Consumo diamanti fallito",
    ),
    "diamondInsufficient": MessageLookupByLibrary.simpleMessage(
      "Diamanti non sono sufficienti",
    ),
    "diamondPack1": MessageLookupByLibrary.simpleMessage("Pacchetto Diamanti"),
    "diamondPack2": MessageLookupByLibrary.simpleMessage("Cassa Diamanti"),
    "diamondPack3": MessageLookupByLibrary.simpleMessage("Dono Diamanti"),
    "diamondPack4": MessageLookupByLibrary.simpleMessage(
      "Grande Pacchetto Diamanti",
    ),
    "diamondPack5": MessageLookupByLibrary.simpleMessage(
      "Pacchetto Diamanti Supremo",
    ),
    "diamondStore": MessageLookupByLibrary.simpleMessage("Negozio di Diamanti"),
    "diamondStoreSubtitle": MessageLookupByLibrary.simpleMessage(
      "Unlock funzionalità premium con diamanti",
    ),
    "diamondStoreTitle": MessageLookupByLibrary.simpleMessage(
      "Negozio di Diamanti",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Avvertenza"),
    "displayMyCity": MessageLookupByLibrary.simpleMessage(
      "Mostra la mia città",
    ),
    "dm": MessageLookupByLibrary.simpleMessage("DM"),
    "duoSnap": MessageLookupByLibrary.simpleMessage("Duo Snap"),
    "duosnapAnyway": MessageLookupByLibrary.simpleMessage("Duo Snap comunque"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Modifica Profilo"),
    "emotion_analysis": MessageLookupByLibrary.simpleMessage("Analisi Emotiva"),
    "emotion_angry": MessageLookupByLibrary.simpleMessage("😠 Arrabbiato"),
    "emotion_anxious": MessageLookupByLibrary.simpleMessage("😰 Ansioso"),
    "emotion_calm": MessageLookupByLibrary.simpleMessage("😌 Calmo"),
    "emotion_category": MessageLookupByLibrary.simpleMessage("Emozione"),
    "emotion_diary": MessageLookupByLibrary.simpleMessage(
      "Diario delle Emozioni",
    ),
    "emotion_diary_saved": MessageLookupByLibrary.simpleMessage(
      "✅ Diario delle emozioni salvato",
    ),
    "emotion_diary_title": MessageLookupByLibrary.simpleMessage(
      "Diario delle Emozioni",
    ),
    "emotion_distribution": MessageLookupByLibrary.simpleMessage(
      "Distribuzione delle Emozioni",
    ),
    "emotion_happy": MessageLookupByLibrary.simpleMessage("😊 Felice"),
    "emotion_management": MessageLookupByLibrary.simpleMessage(
      "Gestione delle Emozioni",
    ),
    "emotion_management_title": MessageLookupByLibrary.simpleMessage(
      "Gestione delle Emozioni",
    ),
    "emotion_records": MessageLookupByLibrary.simpleMessage(
      "Registri delle Emozioni",
    ),
    "emotion_sad": MessageLookupByLibrary.simpleMessage("😢 Triste"),
    "emotion_subtitle": MessageLookupByLibrary.simpleMessage(
      "Comprendi le tue emozioni e impara l\'autocura",
    ),
    "emotion_tip": MessageLookupByLibrary.simpleMessage(
      "Accettati nel momento presente, le emozioni scorrono come stelle e alla fine torneranno alla pace",
    ),
    "emotion_tired": MessageLookupByLibrary.simpleMessage("😴 Stanco"),
    "emotionalCompatibility": MessageLookupByLibrary.simpleMessage(
      "Emozionale",
    ),
    "emptyChatRoomMessage": MessageLookupByLibrary.simpleMessage(
      "Ваша приватная комната чата все еще пуста\nНо звезды знают, что правильный человек идет к вам",
    ),
    "energy": MessageLookupByLibrary.simpleMessage("Energia"),
    "energy_category": MessageLookupByLibrary.simpleMessage("Energia"),
    "energy_index": MessageLookupByLibrary.simpleMessage("Indice di Energia"),
    "energy_level": MessageLookupByLibrary.simpleMessage("Livello di Energia"),
    "enterBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Введите место рождения",
    ),
    "every_emotion_matters": MessageLookupByLibrary.simpleMessage(
      "Ogni emozione merita di essere vista e registrata",
    ),
    "exceptionAstroLearnContentFilterTips":
        MessageLookupByLibrary.simpleMessage(
          "Non inviato. AstroLearn non tradurrà parole proibite.",
        ),
    "exceptionAstroLearnOverloadedTips": MessageLookupByLibrary.simpleMessage(
      "AstroLearn è sovraccaricata, per favore riprova più tardi.",
    ),
    "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
      "Invio fallito, per favore riprova più tardi.",
    ),
    "fateOnTheWay": MessageLookupByLibrary.simpleMessage("Судьба в пути"),
    "feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
    "filter": MessageLookupByLibrary.simpleMessage("Filtro"),
    "findingFolksWhoShareYourInterests": MessageLookupByLibrary.simpleMessage(
      "Trovare persone che condividono i tuoi interessi",
    ),
    "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
      "AstroLearn sta trovando alcuni amici potenziali...",
    ),
    "first_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "Primo quarto di luna, buon momento per l\'azione e le decisioni",
    ),
    "friendsIntention": MessageLookupByLibrary.simpleMessage(
      "Ehi, penso che tu sia fantastico. Che ne dici di diventare amici?",
    ),
    "full_moon_insight": MessageLookupByLibrary.simpleMessage(
      "L\'energia della luna piena è più forte, perfetta per liberare le emozioni",
    ),
    "futureCompatibility": MessageLookupByLibrary.simpleMessage("Futuro"),
    "geminiSign": MessageLookupByLibrary.simpleMessage("Gemelli"),
    "getAstroLearnPlus": MessageLookupByLibrary.simpleMessage(
      "Ottenere AstroLearn Plus",
    ),
    "gifNotAllowed": MessageLookupByLibrary.simpleMessage(
      "GIF non è consentito",
    ),
    "goDiscover": MessageLookupByLibrary.simpleMessage("Иди Открывать"),
    "gotIt": MessageLookupByLibrary.simpleMessage("Capito"),
    "great_keep_going": MessageLookupByLibrary.simpleMessage(
      "Ottimo! Continua così ✨",
    ),
    "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
      "Ehi, indovina chi romperà il silenzio per primo?",
    ),
    "haveAstroLearnSayHi": MessageLookupByLibrary.simpleMessage(
      "Lascia che AstroLearn dica ciao",
    ),
    "healing_calendar_title": MessageLookupByLibrary.simpleMessage(
      "Calendario di Guarigione Astrale",
    ),
    "healing_category": MessageLookupByLibrary.simpleMessage("Guarigione"),
    "healing_count": MessageLookupByLibrary.simpleMessage(
      "Sessioni di Guarigione",
    ),
    "healing_data": MessageLookupByLibrary.simpleMessage("Dati di Guarigione"),
    "healing_music_title": MessageLookupByLibrary.simpleMessage(
      "Musica di Guarigione",
    ),
    "healing_sessions": MessageLookupByLibrary.simpleMessage(
      "Sessioni di Guarigione",
    ),
    "hereAstroLearnCookedUpForU": MessageLookupByLibrary.simpleMessage(
      "Questo è stato fatto da AstroLearn per te",
    ),
    "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
      "Cosa ne pensi dell\'interpretazione simultanea AI?",
    ),
    "iDigYourEnergy": MessageLookupByLibrary.simpleMessage(
      "Mi piace la tua energia!",
    ),
    "iLikeYourStyle": MessageLookupByLibrary.simpleMessage(
      "Mi piace il tuo stile!",
    ),
    "imInterestedSomething": m2,
    "imVeryInterestedInSomething": m3,
    "incompleteBirthdayInfo": MessageLookupByLibrary.simpleMessage(
      "Le informazioni sulla data di nascita dell\'utente sono incomplete",
    ),
    "infoIncompleteTitle": MessageLookupByLibrary.simpleMessage(
      "Informazione Incompleta",
    ),
    "intellectualCompatibility": MessageLookupByLibrary.simpleMessage(
      "Intellettuale",
    ),
    "interests": MessageLookupByLibrary.simpleMessage("Interessi"),
    "interpretationOff": MessageLookupByLibrary.simpleMessage(
      "Interpretazione Sincrona AI: Disattiva",
    ),
    "interpretationOn": MessageLookupByLibrary.simpleMessage(
      "Interpretazione Sincrona AI: Attiva",
    ),
    "issues": MessageLookupByLibrary.simpleMessage("Problemi"),
    "justNow": MessageLookupByLibrary.simpleMessage("Proprio ora"),
    "justSendALike": MessageLookupByLibrary.simpleMessage(
      "Condividi semplicemente la tua apprezzamento",
    ),
    "justTypeInYourLanguage": m4,
    "keep_it_up": MessageLookupByLibrary.simpleMessage(
      "Continua così! Stai andando alla grande ✨",
    ),
    "last_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "Ultimo quarto di luna, lascia andare il passato e preparati per nuovi inizi",
    ),
    "leoSign": MessageLookupByLibrary.simpleMessage("Leone"),
    "letAstroLearnSayHiForYou": MessageLookupByLibrary.simpleMessage(
      "Lascia che AstroLearn dica ciao per te",
    ),
    "libraSign": MessageLookupByLibrary.simpleMessage("Bilancia"),
    "lifestyleCompatibility": MessageLookupByLibrary.simpleMessage(
      "Stile di Vita",
    ),
    "lightAnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "Легкий анализ ИИ",
    ),
    "lightSynastryRemark": MessageLookupByLibrary.simpleMessage(
      "Analisi di Sinastria",
    ),
    "likeBack": MessageLookupByLibrary.simpleMessage("Mi piace indietro"),
    "likedBack": MessageLookupByLibrary.simpleMessage("Già mi piace indietro"),
    "likedPageMonetizeButton": MessageLookupByLibrary.simpleMessage(
      "Scopri la loro condivisione",
    ),
    "likedPageNoData": MessageLookupByLibrary.simpleMessage(
      "Stato: Ancora nessuna apprezzamento\n\nCosa fare: Inizia a condividere\n\nSuggerimento: Ritratti autentici\nStorie genuine\nInteressi condivisi connettono\n\nIntendo...\nCarica le tue foto reali\nCondividi la tua storia autentica\nScegli i tuoi interessi",
    ),
    "likedYou": MessageLookupByLibrary.simpleMessage(
      "Apprezza la tua condivisione",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Caricamento..."),
    "locationAuthorizeContent": MessageLookupByLibrary.simpleMessage(
      "Abbiamo bisogno della tua posizione per mostrarti persone vicine",
    ),
    "locationLocatedFailed": MessageLookupByLibrary.simpleMessage(
      "Impossibile ottenere posizione",
    ),
    "locationLocatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Posizionato alla posizione corrente",
    ),
    "locationPermissionRequestSubtitle": MessageLookupByLibrary.simpleMessage(
      "Abbiamo bisogno della tua posizione per migliorare la tua esperienza sociale",
    ),
    "locationPermissionRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Autorizza la posizione",
    ),
    "mapSelectedLocation": MessageLookupByLibrary.simpleMessage(
      "Posizione selezionata sulla mappa",
    ),
    "matchPageSelectIdeas": m5,
    "me": MessageLookupByLibrary.simpleMessage("Io"),
    "meditation_category": MessageLookupByLibrary.simpleMessage("Meditazione"),
    "meditation_count": MessageLookupByLibrary.simpleMessage(
      "Conteggio Meditazioni",
    ),
    "meditation_practice": MessageLookupByLibrary.simpleMessage(
      "Pratica di Meditazione",
    ),
    "meditation_practice_title": MessageLookupByLibrary.simpleMessage(
      "Pratica di Meditazione",
    ),
    "meditation_saved": MessageLookupByLibrary.simpleMessage(
      "✅ Registrazione meditazione salvata",
    ),
    "meditation_subtitle": MessageLookupByLibrary.simpleMessage(
      "Trova la pace interiore attraverso la meditazione astrale",
    ),
    "memberCenter": MessageLookupByLibrary.simpleMessage("Centro Membri"),
    "membersPerks": MessageLookupByLibrary.simpleMessage(
      "I membri ottengono vantaggi esclusivi",
    ),
    "minutes_duration": m6,
    "month": MessageLookupByLibrary.simpleMessage("Mese"),
    "month_day_format": m7,
    "mood": MessageLookupByLibrary.simpleMessage("Umore"),
    "mood_index": MessageLookupByLibrary.simpleMessage("Indice di Umore"),
    "mood_score": m8,
    "morePhotosBenefit": MessageLookupByLibrary.simpleMessage(
      "Più foto ci sono, più alta è la raccomandazione",
    ),
    "morePhotosMoreCharm": MessageLookupByLibrary.simpleMessage(
      "Più foto, Più fascino!",
    ),
    "music_subtitle": MessageLookupByLibrary.simpleMessage(
      "Audio astrale rilassante per mente e corpo",
    ),
    "myPhotos": MessageLookupByLibrary.simpleMessage("Le Mie Foto"),
    "myProfileTitle": MessageLookupByLibrary.simpleMessage("Il Mio Profilo"),
    "my_statistics": MessageLookupByLibrary.simpleMessage("Le Mie Statistiche"),
    "navigateToAstroProfile": MessageLookupByLibrary.simpleMessage(
      "Vai alla pagina del profilo astro",
    ),
    "nearby": MessageLookupByLibrary.simpleMessage("Vicino"),
    "newGameplay": MessageLookupByLibrary.simpleMessage("Nuovo gameplay"),
    "newMatch": MessageLookupByLibrary.simpleMessage("Nuova connessione!"),
    "new_moon_insight": MessageLookupByLibrary.simpleMessage(
      "Momento di luna nuova, perfetto per iniziare nuovi piani di guarigione",
    ),
    "nextBilingDate": MessageLookupByLibrary.simpleMessage(
      "Prossima data di pagamento",
    ),
    "noMessageTips": MessageLookupByLibrary.simpleMessage(
      "Stato: Nessun messaggio\n\nCosa fare: Trova ascoltatori\n\nSuggerimento: Condividi la tua autenticità",
    ),
    "noOneFoundYourCharm": MessageLookupByLibrary.simpleMessage(
      "Nessuno ha ancora trovato il tuo fascino",
    ),
    "noThanks": MessageLookupByLibrary.simpleMessage("No, grazie"),
    "no_audio": MessageLookupByLibrary.simpleMessage(
      "Nessun audio disponibile",
    ),
    "no_quotes": MessageLookupByLibrary.simpleMessage(
      "Nessuna citazione disponibile",
    ),
    "no_records_today": MessageLookupByLibrary.simpleMessage(
      "Nessun record per questo giorno",
    ),
    "notes": MessageLookupByLibrary.simpleMessage("Note"),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifiche"),
    "onboarding0": MessageLookupByLibrary.simpleMessage(
      "AstroLearn è come una base di casa per i cittadini del mondo",
    ),
    "onboarding1": MessageLookupByLibrary.simpleMessage(
      "Che tu sia a casa o in viaggio, incontra persone in tutto il mondo. E...",
    ),
    "onboarding2": MessageLookupByLibrary.simpleMessage(
      "Otterrai un superpotere:\nPadronanza delle lingue Nessuna barriera comunicativa",
    ),
    "onboarding3": MessageLookupByLibrary.simpleMessage(
      "Parla meno, ama di più. Ti aspetta un romantico leggendario",
    ),
    "onboardingWish": MessageLookupByLibrary.simpleMessage(
      "Perfavore, completa la tua lista dei\ndesideri per un abbinamento migliore",
    ),
    "oneLineToWin": MessageLookupByLibrary.simpleMessage(
      "Одна фраза, чтобы покорить",
    ),
    "oopsNoDataRightNow": MessageLookupByLibrary.simpleMessage(
      "Ops, nessun dato al momento",
    ),
    "peopleFromYourWishlistGetMoreRecommendations":
        MessageLookupByLibrary.simpleMessage(
          "Le impostazioni della tua lista dei desideri avranno un ruolo più grande",
        ),
    "permissionRequiredContent": MessageLookupByLibrary.simpleMessage(
      "Abbiamo bisogno di questo permesso per offrirti la migliore esperienza",
    ),
    "permissionRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Permesso Richiesto",
    ),
    "personaCompleteProfile": MessageLookupByLibrary.simpleMessage(
      "Completa profilo base",
    ),
    "personaCompleteProfileDesc": MessageLookupByLibrary.simpleMessage(
      "Завершите имя, день рождения, пол для разблокировки больше рекомендаций",
    ),
    "personaEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "Включить уведомления о сообщениях",
    ),
    "personaEnableNotificationsDesc": MessageLookupByLibrary.simpleMessage(
      "Не пропускайте совпадения и сообщения, взаимодействуйте вовремя",
    ),
    "personaForYou": MessageLookupByLibrary.simpleMessage("Для вас"),
    "personaShowCity": MessageLookupByLibrary.simpleMessage(
      "Покажите свой город",
    ),
    "personaShowCityDesc": MessageLookupByLibrary.simpleMessage(
      "Легче быть найденным местными пользователями",
    ),
    "personaUploadPhotos": MessageLookupByLibrary.simpleMessage(
      "Загрузите свои фото",
    ),
    "personaUploadPhotosDesc": MessageLookupByLibrary.simpleMessage(
      "Aggiungi almeno 2 foto chiare per aumentare l\'esposizione",
    ),
    "photoFromCamera": MessageLookupByLibrary.simpleMessage(
      "Scattare una foto",
    ),
    "photoFromGallery": MessageLookupByLibrary.simpleMessage(
      "Selezionare dalla galleria",
    ),
    "photoMightNotBeReal": MessageLookupByLibrary.simpleMessage(
      "Questa foto potrebbe non essere reale",
    ),
    "photos": MessageLookupByLibrary.simpleMessage("Foto"),
    "piscesSign": MessageLookupByLibrary.simpleMessage("Pesci"),
    "played_audio": MessageLookupByLibrary.simpleMessage("Audio riprodotto"),
    "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
        MessageLookupByLibrary.simpleMessage(
          "Si prega di controllare la propria connessione internet o Toccare per Aggiornare e riprovare",
        ),
    "please_write_feelings": MessageLookupByLibrary.simpleMessage(
      "Per favore scrivi i tuoi sentimenti",
    ),
    "plusBenefitActivityReminder": MessageLookupByLibrary.simpleMessage(
      "Promemoria di attività e ritorno",
    ),
    "plusBenefitActivitySort": MessageLookupByLibrary.simpleMessage(
      "Ordina per attività recente e tasso di risposta",
    ),
    "plusBenefitAdvancedFilter": MessageLookupByLibrary.simpleMessage(
      "Filtri avanzati: paese/lingua/fuso orario/città",
    ),
    "plusBenefitAntiHarassment": MessageLookupByLibrary.simpleMessage(
      "Protezione prioritaria contro le molestie e protezione del peso",
    ),
    "plusBenefitConflictAdvice": MessageLookupByLibrary.simpleMessage(
      "Punti di conflitto e consigli di relazione",
    ),
    "plusBenefitDestinyPriority": MessageLookupByLibrary.simpleMessage(
      "Esposizione prioritaria del destino in raccomandazioni e mi piace",
    ),
    "plusBenefitDestinyPush": MessageLookupByLibrary.simpleMessage(
      "Notifiche di arrivo di nuovo match del destino",
    ),
    "plusBenefitDimensionBreakdown": MessageLookupByLibrary.simpleMessage(
      "Scomposizione 4-dimensionale: personalità/comunicazione/intimità/confini",
    ),
    "plusBenefitHighMatchDisplay": MessageLookupByLibrary.simpleMessage(
      "Visualizzazione punteggio alto con percentuale",
    ),
    "plusBenefitHistoryTranslation": MessageLookupByLibrary.simpleMessage(
      "Traduzione della cronologia messaggi con un clic",
    ),
    "plusBenefitInterestFilter": MessageLookupByLibrary.simpleMessage(
      "Filtri di interesse e piano di viaggio",
    ),
    "plusBenefitLikeReminder": MessageLookupByLibrary.simpleMessage(
      "Promemoria per mi piace indietro e conferma di lettura",
    ),
    "plusBenefitMatchScore": MessageLookupByLibrary.simpleMessage(
      "Visualizzazione del punteggio di compatibilità complessivo",
    ),
    "plusBenefitMessageTemplates": MessageLookupByLibrary.simpleMessage(
      "Modelli di messaggio rapido (complimenti/inviti/cambio piattaforma)",
    ),
    "plusBenefitOCRTranslation": MessageLookupByLibrary.simpleMessage(
      "Traduzione istantanea di immagini e riconoscimento del testo",
    ),
    "plusBenefitRealTimeTranslation": MessageLookupByLibrary.simpleMessage(
      "Traduzione e lucidatura in tempo reale: correzione automatica multilingue",
    ),
    "plusBenefitSmartOpener": MessageLookupByLibrary.simpleMessage(
      "Linee di apertura intelligenti: 3 suggerimenti ad alta conversione per persona",
    ),
    "plusBenefitStarGreeting": MessageLookupByLibrary.simpleMessage(
      "Pacchetto saluto stellare: 10 saluti giornalieri",
    ),
    "plusBenefitSupportChannel": MessageLookupByLibrary.simpleMessage(
      "Risoluzione accelerata dei problemi di abbonamento",
    ),
    "plusBenefitTopicPool": MessageLookupByLibrary.simpleMessage(
      "Pool di argomenti di conversazione basato sull\'analisi del profilo",
    ),
    "plusBenefitUnlockLikedMe": MessageLookupByLibrary.simpleMessage(
      "Sblocca avatar e tag chiari in Mi piace",
    ),
    "plusDescTitle": MessageLookupByLibrary.simpleMessage("Descrizione Plus"),
    "plusFuncAIInterpretation": MessageLookupByLibrary.simpleMessage(
      "1000 interpretazioni simultanee/giorno",
    ),
    "plusFuncAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "AstroLearn Tips - Il tuo consulente chat",
    ),
    "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage(
      "5 DM alla settimana",
    ),
    "plusFuncFilterMatchingCountries": MessageLookupByLibrary.simpleMessage(
      "Filtrare i paesi di connessione",
    ),
    "plusFuncUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "Like illimitati",
    ),
    "plusFuncUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "Sblocca per vedere chi apprezza la tua condivisione",
    ),
    "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3 desideri"),
    "plusMember": MessageLookupByLibrary.simpleMessage("Membro Plus"),
    "plusMembershipBenefits": MessageLookupByLibrary.simpleMessage(
      "Vantaggi dell\'Iscrizione Plus",
    ),
    "plusPerkDuoSnap": MessageLookupByLibrary.simpleMessage(
      "Duo Snap con Plus",
    ),
    "practice_count": MessageLookupByLibrary.simpleMessage(
      "Conteggio Pratiche",
    ),
    "preference": MessageLookupByLibrary.simpleMessage("Preferenza"),
    "privacy": MessageLookupByLibrary.simpleMessage("Privacy"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Politica sulla privacy",
    ),
    "productNotFound": MessageLookupByLibrary.simpleMessage(
      "Product not found",
    ),
    "profileInfoTab": MessageLookupByLibrary.simpleMessage("Profil"),
    "profileNotShown": MessageLookupByLibrary.simpleMessage(
      "Non hanno ancora mostrato il loro vero volto",
    ),
    "profileTip": MessageLookupByLibrary.simpleMessage(
      "✨ Завершите свой профиль, чтобы звезды могли лучше узнать вас, для более точного сопоставления",
    ),
    "psychological_healing": MessageLookupByLibrary.simpleMessage(
      "Guarigione Psicologica",
    ),
    "purchaseFailed": MessageLookupByLibrary.simpleMessage("Acquisto Fallito"),
    "purchasePending": MessageLookupByLibrary.simpleMessage(
      "Acquisto in Corso",
    ),
    "pushNotifications": MessageLookupByLibrary.simpleMessage("Notifiche push"),
    "quickActions": MessageLookupByLibrary.simpleMessage("Azioni Rapide"),
    "quote_1": MessageLookupByLibrary.simpleMessage(
      "Oggi brilli come una stella",
    ),
    "quote_10": MessageLookupByLibrary.simpleMessage(
      "Trova le risposte nei momenti di quiete",
    ),
    "quote_2": MessageLookupByLibrary.simpleMessage(
      "Fidati di te stesso come ti fidi delle stelle",
    ),
    "quote_3": MessageLookupByLibrary.simpleMessage(
      "Ognuno è una costellazione unica",
    ),
    "quote_4": MessageLookupByLibrary.simpleMessage(
      "L\'energia dell\'universo è con te",
    ),
    "quote_5": MessageLookupByLibrary.simpleMessage("Accettati come sei ora"),
    "quote_6": MessageLookupByLibrary.simpleMessage(
      "Ogni emozione merita di essere vista",
    ),
    "quote_7": MessageLookupByLibrary.simpleMessage(
      "Lascia che l\'energia stellare fluisca attraverso di te",
    ),
    "quote_8": MessageLookupByLibrary.simpleMessage(
      "Oggi è nuovo con infinite possibilità",
    ),
    "quote_9": MessageLookupByLibrary.simpleMessage(
      "La tua esistenza è un miracolo di per sé",
    ),
    "quotes_subtitle": MessageLookupByLibrary.simpleMessage(
      "Energia guaritrice dalle stelle",
    ),
    "record_daily_status": MessageLookupByLibrary.simpleMessage(
      "Registra Stato Giornaliero",
    ),
    "record_today_hint": MessageLookupByLibrary.simpleMessage(
      "Cosa vorresti registrare oggi?",
    ),
    "record_your_feelings": MessageLookupByLibrary.simpleMessage(
      "Registra i tuoi sentimenti",
    ),
    "recorded_days": MessageLookupByLibrary.simpleMessage("Giorni Registrati"),
    "recorded_emotion": MessageLookupByLibrary.simpleMessage(
      "Emozione registrata",
    ),
    "relaxation_category": MessageLookupByLibrary.simpleMessage("Rilassamento"),
    "remindUploadPhoto": MessageLookupByLibrary.simpleMessage(
      "📸 Напомните им загрузить фото, узнайте друг друга лучше",
    ),
    "report": MessageLookupByLibrary.simpleMessage("Segnalare"),
    "reportOptionGore": MessageLookupByLibrary.simpleMessage("Gore"),
    "reportOptionOther": MessageLookupByLibrary.simpleMessage("Altro"),
    "reportOptionPerAstroLearnlAttack": MessageLookupByLibrary.simpleMessage(
      "Attacco perAstroLearnle",
    ),
    "reportOptionPersonalAttack": MessageLookupByLibrary.simpleMessage(
      "Attacco personale",
    ),
    "reportOptionPornography": MessageLookupByLibrary.simpleMessage(
      "Pornografia",
    ),
    "reportOptionScam": MessageLookupByLibrary.simpleMessage("Truffa"),
    "requireYourRealPhoto": MessageLookupByLibrary.simpleMessage(
      "Abbiamo bisogno della tua foto reale",
    ),
    "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
      "Incontrare stranieri vicino a te",
    ),
    "sagittariusSign": MessageLookupByLibrary.simpleMessage("Sagittario"),
    "save": MessageLookupByLibrary.simpleMessage("Salva"),
    "save_failed": m9,
    "scorpioSign": MessageLookupByLibrary.simpleMessage("Scorpione"),
    "screenshotEvidence": MessageLookupByLibrary.simpleMessage(
      "Prova dello screenshot",
    ),
    "seeProfile": MessageLookupByLibrary.simpleMessage("Vedi profilo"),
    "seeWhoLikeU": MessageLookupByLibrary.simpleMessage("Vedi chi ti apprezza"),
    "selectBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Выберите место рождения",
    ),
    "selectBirthdayHint": MessageLookupByLibrary.simpleMessage(
      "Seleziona la tua data di nascita per vedere il tuo grafico astrologico",
    ),
    "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage(
      "Seleziona Paese",
    ),
    "selectLocationTitle": MessageLookupByLibrary.simpleMessage(
      "Seleziona Posizione",
    ),
    "select_duration_start": MessageLookupByLibrary.simpleMessage(
      "Seleziona la durata per iniziare la meditazione",
    ),
    "select_meditation_duration": MessageLookupByLibrary.simpleMessage(
      "Seleziona la durata della meditazione",
    ),
    "sendDm": MessageLookupByLibrary.simpleMessage("Invia DM"),
    "sendDmRemark": MessageLookupByLibrary.simpleMessage("Invia Messaggio DM"),
    "sendStarGreetingToUnlockAlbum": MessageLookupByLibrary.simpleMessage(
      "💫 Invia un saluto stellare per sbloccare l\'album Continua",
    ),
    "setDefault": MessageLookupByLibrary.simpleMessage(
      "Imposta come predefinito",
    ),
    "setInterestTags": MessageLookupByLibrary.simpleMessage(
      "Imposta tag di interesse chiare",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Impostazioni"),
    "showYourPerAstroLearnlity": MessageLookupByLibrary.simpleMessage(
      "Mostra la tua perAstroLearnlità",
    ),
    "showYourPersonality": MessageLookupByLibrary.simpleMessage(
      "Mostra la tua personalità",
    ),
    "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage(
      "Quasi finito",
    ),
    "sixMonths": MessageLookupByLibrary.simpleMessage("6 mesi"),
    "sleep_category": MessageLookupByLibrary.simpleMessage("Sonno"),
    "speakSameLanguage": MessageLookupByLibrary.simpleMessage(
      "Parlate la stessa lingua",
    ),
    "spiritual_growth": MessageLookupByLibrary.simpleMessage(
      "Crescita Spirituale",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "startChat": MessageLookupByLibrary.simpleMessage("Inizia chat"),
    "start_meditation": MessageLookupByLibrary.simpleMessage(
      "Inizia Meditazione",
    ),
    "startedChat": MessageLookupByLibrary.simpleMessage(
      "Iniziato a chattare con",
    ),
    "status_saved": MessageLookupByLibrary.simpleMessage("✅ Stato salvato"),
    "stop_meditation": MessageLookupByLibrary.simpleMessage(
      "Ferma Meditazione",
    ),
    "streak_days": MessageLookupByLibrary.simpleMessage("Giorni Consecutivi"),
    "streak_x_days": m10,
    "stress": MessageLookupByLibrary.simpleMessage("Stress"),
    "stress_index": MessageLookupByLibrary.simpleMessage("Indice di Stress"),
    "stress_level": MessageLookupByLibrary.simpleMessage("Livello di Stress"),
    "subPageSubtitleAIInterpretationDaily":
        MessageLookupByLibrary.simpleMessage(
          "1000 \ninterpretazioni \nsimultanee/giorno",
        ),
    "subPageSubtitleAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "AstroLearn Tips - \nIl tuo consulente chat",
    ),
    "subPageSubtitleDMWeekly": MessageLookupByLibrary.simpleMessage(
      "5 DM alla settimana",
    ),
    "subPageSubtitleFilterMatchingCountries":
        MessageLookupByLibrary.simpleMessage(
          "Filtrare i paesi di \nconnessione",
        ),
    "subPageSubtitleUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "Like illimitati",
    ),
    "subPageSubtitleUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "Sblocca per vedere \nchi ti apprezza",
    ),
    "subPageTitle": MessageLookupByLibrary.simpleMessage(
      "Ottenere AstroLearn Plus",
    ),
    "subscriptionAgreement": MessageLookupByLibrary.simpleMessage(
      "Termini e Condizioni",
    ),
    "subscriptionAgreementPrefix": m11,
    "subscriptionAgreementSuffix": MessageLookupByLibrary.simpleMessage("."),
    "sunSignLabel": MessageLookupByLibrary.simpleMessage("Знак Солнца"),
    "synastryAnalysis": MessageLookupByLibrary.simpleMessage("Analisi"),
    "takeIt": MessageLookupByLibrary.simpleMessage("Usare"),
    "taurusSign": MessageLookupByLibrary.simpleMessage("Toro"),
    "termsOfService": MessageLookupByLibrary.simpleMessage(
      "Termini di servizio",
    ),
    "theKeyIsBalance": MessageLookupByLibrary.simpleMessage(
      "La chiave è l\'equilibrio",
    ),
    "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
      "👆 Stanno aspettando la tua risposta",
    ),
    "threeMonths": MessageLookupByLibrary.simpleMessage("3 mesi"),
    "toastHitDailyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👀Hai raggiunto il tuo limite giornaliero",
    ),
    "toastHitWeeklyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👅Hai raggiunto il tuo limite settimanale",
    ),
    "toggle_background_music": MessageLookupByLibrary.simpleMessage(
      "Attiva/Disattiva Musica di Sottofondo",
    ),
    "total_duration": MessageLookupByLibrary.simpleMessage("Durata Totale"),
    "unknownLocation": MessageLookupByLibrary.simpleMessage("Sconosciuto"),
    "unlockHighMatchUsers": m12,
    "unlockUsersWithDestiny": m13,
    "unmissableSpecialOfferPrices": MessageLookupByLibrary.simpleMessage(
      "Prezzi speciali imperdibili",
    ),
    "unsupportedPlatform": MessageLookupByLibrary.simpleMessage(
      "Unsupported platform",
    ),
    "upgradeForMoreRecommendations": MessageLookupByLibrary.simpleMessage(
      "Обновитесь до Premium для большего количества рекомендаций",
    ),
    "uploadQualityPhotos": MessageLookupByLibrary.simpleMessage(
      "Carica foto reali di alta qualità",
    ),
    "uploadYourPhoto": MessageLookupByLibrary.simpleMessage(
      "Carica la tua foto",
    ),
    "uploadYourPhotoHint": MessageLookupByLibrary.simpleMessage(
      "Carica la tua foto migliore",
    ),
    "uploading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "Usa posizione corrente",
    ),
    "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage(
      "Scattare una foto",
    ),
    "userAvatarOptionGallery": MessageLookupByLibrary.simpleMessage(
      "Selezionare dalla galleria",
    ),
    "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Un buon ritratto ti aiuta a connetterti con più ascoltatori. Sii reale e usa una foto legittima di te stesso.",
    ),
    "userAvatarPageTitle": MessageLookupByLibrary.simpleMessage(
      "Mostra te stesso",
    ),
    "userAvatarUploadedLabel": MessageLookupByLibrary.simpleMessage(
      "Caricamento completato!",
    ),
    "userBirthdayInputLabel": MessageLookupByLibrary.simpleMessage(
      "Data di nascita",
    ),
    "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Una volta confermato, la nazionalità non può essere cambiata",
    ),
    "userCitizenshipPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Nazionalità",
    ),
    "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("Genere"),
    "userGenderOptionFemale": MessageLookupByLibrary.simpleMessage("Femminile"),
    "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("Maschile"),
    "userGenderOptionNonBinary": MessageLookupByLibrary.simpleMessage(
      "Non binario",
    ),
    "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Il tuo genere non sarà mostrato pubblicamente, verrà utilizzato solo per aiutare nella connessione",
    ),
    "userInfoPageNamePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Inserire",
    ),
    "userInfoPageTitle": MessageLookupByLibrary.simpleMessage(
      "Informazioni di base",
    ),
    "userNameInputLabel": MessageLookupByLibrary.simpleMessage("Nome"),
    "userPhoneNumberPagePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Numero di Telefono",
    ),
    "userPhoneNumberPagePrivacySuffix": MessageLookupByLibrary.simpleMessage(
      " ",
    ),
    "userPhoneNumberPagePrivacyText": MessageLookupByLibrary.simpleMessage(
      "politica sulla privacy",
    ),
    "userPhoneNumberPageTermsAnd": MessageLookupByLibrary.simpleMessage(" e "),
    "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
      "Toccando \"Prossimo Passo\", accetti i nostri ",
    ),
    "userPhoneNumberPageTermsText": MessageLookupByLibrary.simpleMessage(
      "termini di servizio",
    ),
    "userPhoneNumberPageTitle": MessageLookupByLibrary.simpleMessage(
      "Inserisci il numero di telefono",
    ),
    "valuesCompatibility": MessageLookupByLibrary.simpleMessage("Valori"),
    "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage(
      "Inserisci il codice di verifica",
    ),
    "viewAstroReport": MessageLookupByLibrary.simpleMessage(
      "Vedi report astro con",
    ),
    "view_details": MessageLookupByLibrary.simpleMessage("Vedi Dettagli"),
    "virgoSign": MessageLookupByLibrary.simpleMessage("Vergine"),
    "waning_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "Momento di luna calante, riposo e recupero sono importanti",
    ),
    "waning_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "La luna sta calando, buon momento per la riflessione e l\'organizzazione",
    ),
    "wannaHollaAt": MessageLookupByLibrary.simpleMessage(
      "Ti piacerebbe condividere...",
    ),
    "warningCancelDisplayCity": MessageLookupByLibrary.simpleMessage(
      "Dopo la chiusura, la tua città non verrà visualizzata durante l\'abbinamento",
    ),
    "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
      "Il tuo account verrà automaticamente cancellato in 14 giorni. Ricorda di andare in negozio per cancellare il tuo abbonamento attuale per evitare spese aggiuntive.",
    ),
    "warningDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Se elimini il tuo account, non potrai più effettuare l\'accesso con esso. Sei sicuro di volerlo eliminare?",
    ),
    "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
      "Link esterno. Verifica che la fonte sia affidabile prima di cliccare, poiché i link sconosciuti possono essere truffe o rubare dati. Procedere con cautela.",
    ),
    "warningTitleCaution": MessageLookupByLibrary.simpleMessage("Attenzione"),
    "warningUnmatching": MessageLookupByLibrary.simpleMessage(
      "Dopo aver terminato la condivisione, tutta la cronologia delle conversazioni verrà cancellata.",
    ),
    "waxing_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "La luna sta crescendo, l\'energia si sta accumulando gradualmente",
    ),
    "waxing_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "Luna piena in arrivo, le emozioni possono essere più sensibili",
    ),
    "whatsYourEmail": MessageLookupByLibrary.simpleMessage(
      "Qual è la tua email?",
    ),
    "whoLIkesYou": MessageLookupByLibrary.simpleMessage(
      "Chi apprezza la tua condivisione",
    ),
    "whoLikesU": MessageLookupByLibrary.simpleMessage("Chi ti apprezza"),
    "wishActivityAddTitle": MessageLookupByLibrary.simpleMessage(
      "Aggiungi il tuo pensiero",
    ),
    "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Aiutarti a trovare compagni",
    ),
    "wishActivityPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Vuoi fare qualcosa?",
    ),
    "wishCityPickerSkipButton": m14,
    "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "se vai là, Quali città vuoi visitare?",
    ),
    "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage(
      "In quale paese sei più interessato?",
    ),
    "wishCreationComplete": MessageLookupByLibrary.simpleMessage(
      "Il tuo desiderio è stato ricevuto",
    ),
    "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("Già qui"),
    "wishDateOptionNotSure": MessageLookupByLibrary.simpleMessage(
      "Non sono ancora sicuro",
    ),
    "wishDateOptionRecent": MessageLookupByLibrary.simpleMessage(
      "Recentemente, credo",
    ),
    "wishDateOptionYear": MessageLookupByLibrary.simpleMessage("Entro un anno"),
    "wishDatePickerSubtitle": m15,
    "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("Quando"),
    "wishList": MessageLookupByLibrary.simpleMessage("Lista dei desideri"),
    "wishes": MessageLookupByLibrary.simpleMessage("Desiderio"),
    "writeInterestingBio": MessageLookupByLibrary.simpleMessage(
      "Scrivi una biografia personale interessante",
    ),
    "write_feelings_hint": MessageLookupByLibrary.simpleMessage(
      "Scrivi come ti senti...",
    ),
    "x_days": m16,
    "x_hours": m17,
    "x_times": m18,
    "youAreAClubMemberNow": MessageLookupByLibrary.simpleMessage(
      "Sei ora membro del club",
    ),
    "youCanEditItAnytime": MessageLookupByLibrary.simpleMessage(
      "Puoi modificarlo in qualsiasi momento",
    ),
    "youSeemCool": MessageLookupByLibrary.simpleMessage("Sembri figo"),
  };
}
