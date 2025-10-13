// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(something) => "\"Меня интересует ${something}!\"";

  static String m1(something) => "Меня очень интересует ‘${something}’!";

  static String m2(lang) => "Просто печатайте на ${lang}";

  static String m3(gender) =>
      "Какая из ${Intl.gender(gender, female: 'её', male: 'его', other: 'их')}  идей вам нравится?";

  static String m4(storeName) =>
      "При нажатии \"Продолжить\" взимается плата, подписка продлевается автоматически, Вы можете отменить через ${storeName}. Продолжая, вы соглашаетесь с нашими ";

  static String m5(count) =>
      "Разблокировать для просмотра ${count} высокосовместимых пользователей ✨";

  static String m6(count, destinyCount) =>
      "Разблокировать ${count} пользователей, включая ${destinyCount} судьбоносных совпадений ⭐";

  static String m7(country) => "Пропустить, Только ${country}";

  static String m8(country) => "Вы планируете поехать в ${country}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aMonth": MessageLookupByLibrary.simpleMessage("1 месяцев"),
    "aYear": MessageLookupByLibrary.simpleMessage("1 год"),
    "about": MessageLookupByLibrary.simpleMessage("О"),
    "account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("Добавить Фото"),
    "age": MessageLookupByLibrary.simpleMessage("Возраст"),
    "aiCreatingFunGroupPics": MessageLookupByLibrary.simpleMessage(
      "ИИ создает веселые групповые фото",
    ),
    "allPeople": MessageLookupByLibrary.simpleMessage("Все"),
    "analyzingText": MessageLookupByLibrary.simpleMessage("Analyzing..."),
    "aquariusSign": MessageLookupByLibrary.simpleMessage("Водолей"),
    "ariesSign": MessageLookupByLibrary.simpleMessage("Овен"),
    "ascendantSignLabel": MessageLookupByLibrary.simpleMessage(
      "Ascendant Sign",
    ),
    "astroChartTab": MessageLookupByLibrary.simpleMessage(
      "Астрологическая Карта",
    ),
    "astroInfoIncompleteMessage": MessageLookupByLibrary.simpleMessage(
      "Другой пользователь еще не завершил информацию о месте рождения, поэтому мы не можем сгенерировать астрологическую карту. Пожалуйста, подождите, пока они завершат свою информацию.",
    ),
    "astroPairInterpretationOff": MessageLookupByLibrary.simpleMessage(
      "⭕ AstroPair Interpretazione disattivata",
    ),
    "astroPairRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
      "Рекомендация Сона: Охлаждение.\nЧто делать: Ждать.\nПредложение: Посмотреть фильм?",
    ),
    "astroPairWillGenerateABioBasedOnInterests":
        MessageLookupByLibrary.simpleMessage(
          "AstroPair создаст биографию, основанную на ваших интересах",
        ),
    "astroReport": MessageLookupByLibrary.simpleMessage(
      "Астрологический отчет",
    ),
    "avatarUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось обновить аватар",
    ),
    "bio": MessageLookupByLibrary.simpleMessage("Введение"),
    "birthInfo": MessageLookupByLibrary.simpleMessage("Birth Information"),
    "birthPlace": MessageLookupByLibrary.simpleMessage("Birth Place"),
    "birthPlaceLabel": MessageLookupByLibrary.simpleMessage("Birth Place"),
    "birthTimeLabel": MessageLookupByLibrary.simpleMessage("Birth Time"),
    "birthday": MessageLookupByLibrary.simpleMessage("Birthday"),
    "block": MessageLookupByLibrary.simpleMessage("Блокировать"),
    "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
        MessageLookupByLibrary.simpleMessage(
          "Заблокируйте этого человека, чтобы не получать от него сообщения",
        ),
    "boostYourAppeal": MessageLookupByLibrary.simpleMessage("Прелесть Вверх!"),
    "breakIce": MessageLookupByLibrary.simpleMessage(
      "🔨🔨🔨 Не обращай на меня внимания🔨🔨🔨 Я просто разбиваю лед🔨🔨🔨",
    ),
    "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage(
      "Вы Plus участник",
    ),
    "buttonAuthorize": MessageLookupByLibrary.simpleMessage("Авторизовать"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("Отменить"),
    "buttonChange": MessageLookupByLibrary.simpleMessage("Изменить"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "buttonContinue": MessageLookupByLibrary.simpleMessage("Продолжить"),
    "buttonCopy": MessageLookupByLibrary.simpleMessage("Копировать"),
    "buttonDelete": MessageLookupByLibrary.simpleMessage("Удалить"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Удалить аккаунт",
    ),
    "buttonDone": MessageLookupByLibrary.simpleMessage("Готово"),
    "buttonEdit": MessageLookupByLibrary.simpleMessage("Редактировать"),
    "buttonEditProfile": MessageLookupByLibrary.simpleMessage(
      "Редактировать профиль",
    ),
    "buttonGenerate": MessageLookupByLibrary.simpleMessage("Генерировать"),
    "buttonGo": MessageLookupByLibrary.simpleMessage("Идти"),
    "buttonGotIt": MessageLookupByLibrary.simpleMessage("Понял"),
    "buttonHitAIInterpretationMaximumLimit":
        MessageLookupByLibrary.simpleMessage(
          "😪AstroPair устала, 👇жми, чтоб зарядить!",
        ),
    "buttonJoinNow": MessageLookupByLibrary.simpleMessage(
      "Присоединиться сейчас",
    ),
    "buttonKeepAccount": MessageLookupByLibrary.simpleMessage(
      "Сохранить аккаунт",
    ),
    "buttonManage": MessageLookupByLibrary.simpleMessage("Управлять"),
    "buttonNext": MessageLookupByLibrary.simpleMessage("Следующий Шаг"),
    "buttonOpenLink": MessageLookupByLibrary.simpleMessage("Открыть Ссылку"),
    "buttonPreview": MessageLookupByLibrary.simpleMessage("Предпросмотр"),
    "buttonPurchase": MessageLookupByLibrary.simpleMessage("Купить"),
    "buttonRefresh": MessageLookupByLibrary.simpleMessage("Обновить"),
    "buttonResend": MessageLookupByLibrary.simpleMessage("Переслать"),
    "buttonRestore": MessageLookupByLibrary.simpleMessage("Восстановить"),
    "buttonSave": MessageLookupByLibrary.simpleMessage("Сохранить"),
    "buttonSignOut": MessageLookupByLibrary.simpleMessage("Выйти"),
    "buttonSubmit": MessageLookupByLibrary.simpleMessage("Отправить"),
    "buttonUnlockVipPerks": MessageLookupByLibrary.simpleMessage(
      "Разблокировать VIP привилегии",
    ),
    "buttonUnmatch": MessageLookupByLibrary.simpleMessage(
      "Отменить совпадение",
    ),
    "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("Отписаться"),
    "cancerSign": MessageLookupByLibrary.simpleMessage("Рак"),
    "capricornSign": MessageLookupByLibrary.simpleMessage("Козерог"),
    "catchMore": MessageLookupByLibrary.simpleMessage("Поймайте больше"),
    "charmTips": MessageLookupByLibrary.simpleMessage("Советы по очарованию"),
    "chartPreview": MessageLookupByLibrary.simpleMessage(
      "Предварительный Просмотр Графика",
    ),
    "chat": MessageLookupByLibrary.simpleMessage("Чат"),
    "chatWithMatches": MessageLookupByLibrary.simpleMessage(
      "Активно общайтесь с подходящими пользователями",
    ),
    "checkItOut": MessageLookupByLibrary.simpleMessage("Посмотрите"),
    "checkOutTheirProfiles": MessageLookupByLibrary.simpleMessage(
      "Проверьте их профили",
    ),
    "choosePlaceholder": MessageLookupByLibrary.simpleMessage("Выбрать"),
    "clickToSetBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Click to set birth place",
    ),
    "clickToSetBirthday": MessageLookupByLibrary.simpleMessage(
      "Click to set birthday",
    ),
    "closeButtonText": MessageLookupByLibrary.simpleMessage("Close"),
    "clubFeeJoking": MessageLookupByLibrary.simpleMessage(
      "Шутка! Это бесплатно",
    ),
    "clubFeePrefix": MessageLookupByLibrary.simpleMessage(
      "Взнос клуба: \$99/месяц",
    ),
    "clubPromotionContent": MessageLookupByLibrary.simpleMessage(
      "Присоединяйтесь к нашему эксклюзивному клубу за удивительными преимуществами",
    ),
    "clubPromotionTitle": MessageLookupByLibrary.simpleMessage(
      "Присоединяйтесь к клубу",
    ),
    "commonLanguage": MessageLookupByLibrary.simpleMessage("Основной язык"),
    "commonLanguageTitle": MessageLookupByLibrary.simpleMessage(
      "Обычно используемые языки",
    ),
    "communicationCompatibility": MessageLookupByLibrary.simpleMessage(
      "Общение",
    ),
    "compatibilityScore": MessageLookupByLibrary.simpleMessage("Совместимость"),
    "completeAstroInfo": MessageLookupByLibrary.simpleMessage(
      "Завершите подробную астрологическую информацию",
    ),
    "completeAstroProfile": MessageLookupByLibrary.simpleMessage(
      "Завершите свой астрологический профиль",
    ),
    "completeAstroProfileButton": MessageLookupByLibrary.simpleMessage(
      "Завершить астрологический профиль",
    ),
    "completeBirthLocationInfo": MessageLookupByLibrary.simpleMessage(
      " заполните информацию о месте рождения",
    ),
    "completeProfile": MessageLookupByLibrary.simpleMessage(
      "Завершити Профіль",
    ),
    "confirmSelectLocation": MessageLookupByLibrary.simpleMessage(
      "Подтвердить выбор этого местоположения",
    ),
    "continueWithPhone": MessageLookupByLibrary.simpleMessage(
      "Продолжить с телефоном",
    ),
    "currentSelectedCoordinates": MessageLookupByLibrary.simpleMessage(
      "Текущие выбранные координаты",
    ),
    "deepAnalysisReportTitle": MessageLookupByLibrary.simpleMessage(
      "Deep AI Analysis Report",
    ),
    "deepSynastryAnalysis": MessageLookupByLibrary.simpleMessage(
      "Deep Analysis",
    ),
    "deepSynastryRemark": MessageLookupByLibrary.simpleMessage(
      "Глубокий Анализ Синастрии",
    ),
    "defaultBirthTime": MessageLookupByLibrary.simpleMessage("12:00 (Default)"),
    "deletePhoto": MessageLookupByLibrary.simpleMessage("Удалить Фото"),
    "deletePhotoContent": MessageLookupByLibrary.simpleMessage(
      "Вы уверены, что хотите удалить это фото? Это действие нельзя отменить.",
    ),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage(
      "Описание (необязательно)",
    ),
    "destinyMatch": MessageLookupByLibrary.simpleMessage(
      "Судьбоносное совпадение",
    ),
    "diamondConsumeFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось потратить бриллианты",
    ),
    "diamondInsufficient": MessageLookupByLibrary.simpleMessage(
      "Бриллианты не хватает",
    ),
    "diamondPack1": MessageLookupByLibrary.simpleMessage("Алмазный Пакет"),
    "diamondPack2": MessageLookupByLibrary.simpleMessage("Алмазный Сундук"),
    "diamondPack3": MessageLookupByLibrary.simpleMessage("Алмазный Подарок"),
    "diamondPack4": MessageLookupByLibrary.simpleMessage(
      "Большой Алмазный Пакет",
    ),
    "diamondPack5": MessageLookupByLibrary.simpleMessage(
      "Высший Алмазный Пакет",
    ),
    "diamondStore": MessageLookupByLibrary.simpleMessage("Магазин Бриллиантов"),
    "diamondStoreSubtitle": MessageLookupByLibrary.simpleMessage(
      "Разблокируйте премиум-функции бриллиантами",
    ),
    "diamondStoreTitle": MessageLookupByLibrary.simpleMessage(
      "Магазин Бриллиантов",
    ),
    "disclaimer": MessageLookupByLibrary.simpleMessage(
      "Отказ от ответственности",
    ),
    "displayMyCity": MessageLookupByLibrary.simpleMessage("Показать мой город"),
    "dm": MessageLookupByLibrary.simpleMessage("DM"),
    "duoSnap": MessageLookupByLibrary.simpleMessage("Дуо Снап"),
    "duosnapAnyway": MessageLookupByLibrary.simpleMessage(
      "Дуо Снап в любом случае",
    ),
    "editProfile": MessageLookupByLibrary.simpleMessage(
      "Редактировать Профиль",
    ),
    "emotionalCompatibility": MessageLookupByLibrary.simpleMessage(
      "Эмоциональный",
    ),
    "emptyChatRoomMessage": MessageLookupByLibrary.simpleMessage(
      "Ваша приватна кімната чату все ще порожня\nАле зірки знають, що правильна людина йде до вас",
    ),
    "enterBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Enter birth place",
    ),
    "exceptionAstroPairContentFilterTips": MessageLookupByLibrary.simpleMessage(
      "Не отправлено. AstroPair не будет переводить запрещенные слова.",
    ),
    "exceptionAstroPairOverloadedTips": MessageLookupByLibrary.simpleMessage(
      "AstroPair перегружена, пожалуйста, попробуйте позже.",
    ),
    "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
      "Ошибка отправки, пожалуйста, попробуйте позже.",
    ),
    "fateOnTheWay": MessageLookupByLibrary.simpleMessage("Доля в дорозі"),
    "feedback": MessageLookupByLibrary.simpleMessage("Обратная связь"),
    "filter": MessageLookupByLibrary.simpleMessage("Фильтр"),
    "findingFolksWhoShareYourInterests": MessageLookupByLibrary.simpleMessage(
      "Находить людей, которые разделяют ваши интересы",
    ),
    "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
      "AstroPair ищет потенциальных друзей...",
    ),
    "friendsIntention": MessageLookupByLibrary.simpleMessage(
      "Привет, я думаю, ты потрясающий. Давай подружимся?",
    ),
    "futureCompatibility": MessageLookupByLibrary.simpleMessage("Будущее"),
    "geminiSign": MessageLookupByLibrary.simpleMessage("Близнецы"),
    "getAstroPairPlus": MessageLookupByLibrary.simpleMessage(
      "Получить AstroPair Plus",
    ),
    "gifNotAllowed": MessageLookupByLibrary.simpleMessage("GIF не разрешен"),
    "goDiscover": MessageLookupByLibrary.simpleMessage("Йди Відкривати"),
    "gotIt": MessageLookupByLibrary.simpleMessage("Понял"),
    "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
      "Эй, угадай, кто первым нарушит молчание?",
    ),
    "haveAstroPairSayHi": MessageLookupByLibrary.simpleMessage(
      "Пусть AstroPair поздоровается",
    ),
    "hereAstroPairCookedUpForU": MessageLookupByLibrary.simpleMessage(
      "Это специально сделано AstroPair для вас",
    ),
    "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
      "Что вы думаете об одновременном переводе AI?",
    ),
    "iDigYourEnergy": MessageLookupByLibrary.simpleMessage(
      "Твоя энергия мне очень нравится!",
    ),
    "iLikeYourStyle": MessageLookupByLibrary.simpleMessage(
      "Мне нравится твой стиль!",
    ),
    "imInterestedSomething": m0,
    "imVeryInterestedInSomething": m1,
    "incompleteBirthdayInfo": MessageLookupByLibrary.simpleMessage(
      "Информация о дне рождения пользователя неполная",
    ),
    "infoIncompleteTitle": MessageLookupByLibrary.simpleMessage(
      "Информация Неполная",
    ),
    "intellectualCompatibility": MessageLookupByLibrary.simpleMessage(
      "Интеллектуальный",
    ),
    "interests": MessageLookupByLibrary.simpleMessage("Интересы"),
    "interpretationOff": MessageLookupByLibrary.simpleMessage(
      "Синхронный перевод ИИ: Выключен",
    ),
    "interpretationOn": MessageLookupByLibrary.simpleMessage(
      "Синхронный перевод ИИ: Включен",
    ),
    "issues": MessageLookupByLibrary.simpleMessage("Проблемы"),
    "justNow": MessageLookupByLibrary.simpleMessage("Только что"),
    "justSendALike": MessageLookupByLibrary.simpleMessage(
      "Просто отправьте лайк",
    ),
    "justTypeInYourLanguage": m2,
    "leoSign": MessageLookupByLibrary.simpleMessage("Лев"),
    "letAstroPairSayHiForYou": MessageLookupByLibrary.simpleMessage(
      "Пусть AstroPair поздоровается за вас",
    ),
    "libraSign": MessageLookupByLibrary.simpleMessage("Весы"),
    "lifestyleCompatibility": MessageLookupByLibrary.simpleMessage(
      "Образ Жизни",
    ),
    "lightAnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "Light AI Analysis",
    ),
    "lightSynastryRemark": MessageLookupByLibrary.simpleMessage(
      "Анализ Синастрии",
    ),
    "likeBack": MessageLookupByLibrary.simpleMessage("Лайк в ответ"),
    "likedBack": MessageLookupByLibrary.simpleMessage("Уже лайкнул в ответ"),
    "likedPageMonetizeButton": MessageLookupByLibrary.simpleMessage(
      "Проверьте их профили",
    ),
    "likedPageNoData": MessageLookupByLibrary.simpleMessage(
      "Статус: Пока нет лайков\n\nЧто делать: Проявите инициативу\n\nПредложение: Загрузите ваши удовлетворительные фотографии\nНапишите подлинную биографию\nВыберите свои интересы",
    ),
    "likedYou": MessageLookupByLibrary.simpleMessage("Тебе нравился"),
    "loading": MessageLookupByLibrary.simpleMessage("Загрузка..."),
    "locationAuthorizeContent": MessageLookupByLibrary.simpleMessage(
      "Нам нужно ваше местоположение, чтобы показать вам людей поблизости",
    ),
    "locationLocatedFailed": MessageLookupByLibrary.simpleMessage(
      "Не удалось получить местоположение",
    ),
    "locationLocatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Расположен в текущей позиции",
    ),
    "locationPermissionRequestSubtitle": MessageLookupByLibrary.simpleMessage(
      "Нам нужно ваше местоположение, чтобы улучшить ваш социальный опыт",
    ),
    "locationPermissionRequestTitle": MessageLookupByLibrary.simpleMessage(
      "Авторизовать местоположение",
    ),
    "mapSelectedLocation": MessageLookupByLibrary.simpleMessage(
      "Местоположение, выбранное на карте",
    ),
    "matchPageSelectIdeas": m3,
    "me": MessageLookupByLibrary.simpleMessage("Я"),
    "memberCenter": MessageLookupByLibrary.simpleMessage("Центр Участников"),
    "membersPerks": MessageLookupByLibrary.simpleMessage(
      "Участники получают эксклюзивные привилегии",
    ),
    "month": MessageLookupByLibrary.simpleMessage("Месяц"),
    "morePhotosBenefit": MessageLookupByLibrary.simpleMessage(
      "Чем больше фотографий, тем выше рекомендация",
    ),
    "morePhotosMoreCharm": MessageLookupByLibrary.simpleMessage(
      "Больше фото, Больше очарования!",
    ),
    "myPhotos": MessageLookupByLibrary.simpleMessage("Мои Фото"),
    "myProfileTitle": MessageLookupByLibrary.simpleMessage("Мой Профиль"),
    "navigateToAstroProfile": MessageLookupByLibrary.simpleMessage(
      "Перейти на страницу астрологического профиля",
    ),
    "nearby": MessageLookupByLibrary.simpleMessage("Рядом"),
    "newGameplay": MessageLookupByLibrary.simpleMessage("Новый геймплей"),
    "newMatch": MessageLookupByLibrary.simpleMessage("Новое совпадение!"),
    "nextBilingDate": MessageLookupByLibrary.simpleMessage(
      "Следующая дата оплаты",
    ),
    "noMessageTips": MessageLookupByLibrary.simpleMessage(
      "Статус: Нет сообщений\n\nПредложение: Перейти на страницу подбора пар\n\nПредложение: Создайте потрясающий профиль",
    ),
    "noOneFoundYourCharm": MessageLookupByLibrary.simpleMessage(
      "Никто еще не нашел вашего очарования",
    ),
    "noThanks": MessageLookupByLibrary.simpleMessage("Нет, спасибо"),
    "notifications": MessageLookupByLibrary.simpleMessage("Уведомления"),
    "onboarding0": MessageLookupByLibrary.simpleMessage(
      "AstroPair подобно домашней базе для граждан мира",
    ),
    "onboarding1": MessageLookupByLibrary.simpleMessage(
      "Независимо от того, дома вы или в пути, встречайте людей со всего мира. И...",
    ),
    "onboarding2": MessageLookupByLibrary.simpleMessage(
      "Вы получите суперспособность:\nВладение языками Больше никаких барьеров в общении",
    ),
    "onboarding3": MessageLookupByLibrary.simpleMessage(
      "Меньше говори, больше люби. Легендарный роман ждет тебя",
    ),
    "onboardingWish": MessageLookupByLibrary.simpleMessage(
      "Заполните список желаний\nдля лучшего совпадения",
    ),
    "oneLineToWin": MessageLookupByLibrary.simpleMessage(
      "Одна фраза, чтобы покорить",
    ),
    "oopsNoDataRightNow": MessageLookupByLibrary.simpleMessage(
      "Ой, сейчас нет данных",
    ),
    "peopleFromYourWishlistGetMoreRecommendations":
        MessageLookupByLibrary.simpleMessage(
          "Настройки вашего списка желаний будут играть более значительную роль",
        ),
    "permissionRequiredContent": MessageLookupByLibrary.simpleMessage(
      "Нам нужно это разрешение чтобы предоставить вам лучший опыт",
    ),
    "permissionRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Требуется разрешение",
    ),
    "personaCompleteProfile": MessageLookupByLibrary.simpleMessage(
      "Завершить базовый профиль",
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
      "Добавьте хотя бы 2 четких фото для увеличения видимости",
    ),
    "photoFromCamera": MessageLookupByLibrary.simpleMessage("Сфотографировать"),
    "photoFromGallery": MessageLookupByLibrary.simpleMessage(
      "Из галереи выбрать",
    ),
    "photoMightNotBeReal": MessageLookupByLibrary.simpleMessage(
      "Это фото может быть не настоящим",
    ),
    "photos": MessageLookupByLibrary.simpleMessage("Фотографии"),
    "piscesSign": MessageLookupByLibrary.simpleMessage("Рыбы"),
    "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
        MessageLookupByLibrary.simpleMessage(
          "Пожалуйста, проверьте ваш интернет или Нажмите для обновления и попробуйте снова",
        ),
    "plusBenefitActivityReminder": MessageLookupByLibrary.simpleMessage(
      "Напоминания об активности и возвращении",
    ),
    "plusBenefitActivitySort": MessageLookupByLibrary.simpleMessage(
      "Сортировка по недавней активности и частоте ответов",
    ),
    "plusBenefitAdvancedFilter": MessageLookupByLibrary.simpleMessage(
      "Расширенные фильтры: страна/язык/часовой пояс/город",
    ),
    "plusBenefitAntiHarassment": MessageLookupByLibrary.simpleMessage(
      "Приоритетная защита от домогательств и защита веса",
    ),
    "plusBenefitConflictAdvice": MessageLookupByLibrary.simpleMessage(
      "Точки конфликта и советы по отношениям",
    ),
    "plusBenefitDestinyPriority": MessageLookupByLibrary.simpleMessage(
      "Приоритетное отображение судьбы в рекомендациях и лайках",
    ),
    "plusBenefitDestinyPush": MessageLookupByLibrary.simpleMessage(
      "Уведомления о прибытии новых судьбоносных совпадений",
    ),
    "plusBenefitDimensionBreakdown": MessageLookupByLibrary.simpleMessage(
      "4-мерная разбивка: личность/общение/близость/границы",
    ),
    "plusBenefitHighMatchDisplay": MessageLookupByLibrary.simpleMessage(
      "Отображение высокого совпадения с процентом",
    ),
    "plusBenefitHistoryTranslation": MessageLookupByLibrary.simpleMessage(
      "Перевод истории сообщений одним кликом",
    ),
    "plusBenefitInterestFilter": MessageLookupByLibrary.simpleMessage(
      "Фильтры интересов и планов путешествий",
    ),
    "plusBenefitLikeReminder": MessageLookupByLibrary.simpleMessage(
      "Напоминания о взаимных лайках и подтверждении прочтения",
    ),
    "plusBenefitMatchScore": MessageLookupByLibrary.simpleMessage(
      "Визуализация общего балла совместимости",
    ),
    "plusBenefitMessageTemplates": MessageLookupByLibrary.simpleMessage(
      "Шаблоны быстрых сообщений (комплименты/приглашения/смена платформы)",
    ),
    "plusBenefitOCRTranslation": MessageLookupByLibrary.simpleMessage(
      "Мгновенный перевод изображений и распознавание текста",
    ),
    "plusBenefitRealTimeTranslation": MessageLookupByLibrary.simpleMessage(
      "Перевод и полировка в реальном времени: многоязычная автоматическая коррекция",
    ),
    "plusBenefitSmartOpener": MessageLookupByLibrary.simpleMessage(
      "Умные открывающие фразы: 3 предложения высокой конверсии на человека",
    ),
    "plusBenefitStarGreeting": MessageLookupByLibrary.simpleMessage(
      "Пакет звездных приветствий: 10 ежедневных приветствий",
    ),
    "plusBenefitSupportChannel": MessageLookupByLibrary.simpleMessage(
      "Ускоренное решение проблем с подпиской",
    ),
    "plusBenefitTopicPool": MessageLookupByLibrary.simpleMessage(
      "Пул тем разговора на основе анализа профиля",
    ),
    "plusBenefitUnlockLikedMe": MessageLookupByLibrary.simpleMessage(
      "Разблокировать четкие аватары и теги в Понравилось",
    ),
    "plusDescTitle": MessageLookupByLibrary.simpleMessage("Описание Плюс"),
    "plusFuncAIInterpretation": MessageLookupByLibrary.simpleMessage(
      "1000 синхронных переводов/день",
    ),
    "plusFuncAstroPairTips": MessageLookupByLibrary.simpleMessage(
      "AstroPair Tips - Твой советник по чату",
    ),
    "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage("5 DM в неделю"),
    "plusFuncFilterMatchingCountries": MessageLookupByLibrary.simpleMessage(
      "Фильтровать страны для совпадений",
    ),
    "plusFuncUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "Неограниченные лайки",
    ),
    "plusFuncUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "Разблокировать, чтобы увидеть, кто вас любит",
    ),
    "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3 желания"),
    "plusMember": MessageLookupByLibrary.simpleMessage("Plus Пользователь"),
    "plusMembershipBenefits": MessageLookupByLibrary.simpleMessage(
      "Преимущества подписки Plus",
    ),
    "plusPerkDuoSnap": MessageLookupByLibrary.simpleMessage("Дуо Снап с Плюс"),
    "preference": MessageLookupByLibrary.simpleMessage("Предпочтение"),
    "privacy": MessageLookupByLibrary.simpleMessage("Конфиденциальность"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Политика конфиденциальности",
    ),
    "productNotFound": MessageLookupByLibrary.simpleMessage(
      "Product not found",
    ),
    "profileInfoTab": MessageLookupByLibrary.simpleMessage("Профиль"),
    "profileNotShown": MessageLookupByLibrary.simpleMessage(
      "Они еще не показали свое настоящее лицо",
    ),
    "profileTip": MessageLookupByLibrary.simpleMessage(
      "✨ Завершіть свій профіль, щоб зірки могли краще вас знати, для більш точного співставлення",
    ),
    "purchaseFailed": MessageLookupByLibrary.simpleMessage(
      "Покупка Не Удалась",
    ),
    "purchasePending": MessageLookupByLibrary.simpleMessage(
      "Покупка Ожидает Обработки",
    ),
    "pushNotifications": MessageLookupByLibrary.simpleMessage(
      "Пуш-уведомления",
    ),
    "quickActions": MessageLookupByLibrary.simpleMessage("Быстрые Действия"),
    "remindUploadPhoto": MessageLookupByLibrary.simpleMessage(
      "📸 Нагадайте їм завантажити фото, дізнайтеся один одного краще",
    ),
    "report": MessageLookupByLibrary.simpleMessage("Сообщить"),
    "reportOptionGore": MessageLookupByLibrary.simpleMessage("Жестокость"),
    "reportOptionOther": MessageLookupByLibrary.simpleMessage("Другое"),
    "reportOptionPerAstroPairlAttack": MessageLookupByLibrary.simpleMessage(
      "Личная атака",
    ),
    "reportOptionPersonalAttack": MessageLookupByLibrary.simpleMessage(
      "Личная атака",
    ),
    "reportOptionPornography": MessageLookupByLibrary.simpleMessage(
      "Порнография",
    ),
    "reportOptionScam": MessageLookupByLibrary.simpleMessage("Мошенничество"),
    "requireYourRealPhoto": MessageLookupByLibrary.simpleMessage(
      "Нам нужна ваша настоящая фотография",
    ),
    "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
      "Встреча с иностранцами рядом с вами",
    ),
    "sagittariusSign": MessageLookupByLibrary.simpleMessage("Стрелец"),
    "scorpioSign": MessageLookupByLibrary.simpleMessage("Скорпион"),
    "screenshotEvidence": MessageLookupByLibrary.simpleMessage(
      "Скриншот доказательства",
    ),
    "seeProfile": MessageLookupByLibrary.simpleMessage("Посмотреть профиль"),
    "seeWhoLikeU": MessageLookupByLibrary.simpleMessage(
      "Смотрите, кто вас любит",
    ),
    "selectBirthPlace": MessageLookupByLibrary.simpleMessage(
      "Select Birth Place",
    ),
    "selectBirthdayHint": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста выберите дату рождения чтобы просмотреть вашу астрологическую карту",
    ),
    "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage(
      "Выбрать Страну",
    ),
    "selectLocationTitle": MessageLookupByLibrary.simpleMessage(
      "Выбрать Местоположение",
    ),
    "sendDm": MessageLookupByLibrary.simpleMessage("Отправить ЛС"),
    "sendDmRemark": MessageLookupByLibrary.simpleMessage(
      "Отправить DM Сообщение",
    ),
    "sendStarGreetingToUnlockAlbum": MessageLookupByLibrary.simpleMessage(
      "💫 Отправьте звездное приветствие чтобы разблокировать альбом Продолжить",
    ),
    "setDefault": MessageLookupByLibrary.simpleMessage(
      "Установить по умолчанию",
    ),
    "setInterestTags": MessageLookupByLibrary.simpleMessage(
      "Установите четкие теги интересов",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "showYourPerAstroPairlity": MessageLookupByLibrary.simpleMessage(
      "Покажите вашу индивидуальность",
    ),
    "showYourPersonality": MessageLookupByLibrary.simpleMessage(
      "Покажите свою личность",
    ),
    "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage(
      "Скоро будет готово",
    ),
    "sixMonths": MessageLookupByLibrary.simpleMessage("6 месяцев"),
    "speakSameLanguage": MessageLookupByLibrary.simpleMessage(
      "Вы говорите на одном языке",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("Стандарт"),
    "startChat": MessageLookupByLibrary.simpleMessage("Начать чат"),
    "startedChat": MessageLookupByLibrary.simpleMessage("Начал чат с"),
    "subPageSubtitleAIInterpretationDaily":
        MessageLookupByLibrary.simpleMessage(
          "1000 \nсинхронных \nпереводов/день",
        ),
    "subPageSubtitleAstroPairTips": MessageLookupByLibrary.simpleMessage(
      "AstroPair Tips - \nТвой советник по чату",
    ),
    "subPageSubtitleDMWeekly": MessageLookupByLibrary.simpleMessage(
      "5 DM в неделю",
    ),
    "subPageSubtitleFilterMatchingCountries":
        MessageLookupByLibrary.simpleMessage(
          "Фильтровать \nстраны для совпадений",
        ),
    "subPageSubtitleUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "Неограниченные лайки",
    ),
    "subPageSubtitleUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "Разблокировать, \nчтобы увидеть, кто вас любит",
    ),
    "subPageTitle": MessageLookupByLibrary.simpleMessage(
      "Получить AstroPair Plus",
    ),
    "subscriptionAgreement": MessageLookupByLibrary.simpleMessage(
      "Условиями использования",
    ),
    "subscriptionAgreementPrefix": m4,
    "subscriptionAgreementSuffix": MessageLookupByLibrary.simpleMessage("."),
    "sunSignLabel": MessageLookupByLibrary.simpleMessage("Sun Sign"),
    "synastryAnalysis": MessageLookupByLibrary.simpleMessage("Синастрия"),
    "takeIt": MessageLookupByLibrary.simpleMessage("Использовать"),
    "taurusSign": MessageLookupByLibrary.simpleMessage("Телец"),
    "termsOfService": MessageLookupByLibrary.simpleMessage(
      "Условия обслуживания",
    ),
    "theKeyIsBalance": MessageLookupByLibrary.simpleMessage(
      "Ключ - это баланс",
    ),
    "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
      "👆 Они ждут твоего ответа",
    ),
    "threeMonths": MessageLookupByLibrary.simpleMessage("3 месяцев"),
    "toastHitDailyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👀достигли своего дневного лимита",
    ),
    "toastHitWeeklyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👅достигли своего недельного лимита",
    ),
    "unknownLocation": MessageLookupByLibrary.simpleMessage("Неизвестно"),
    "unlockHighMatchUsers": m5,
    "unlockUsersWithDestiny": m6,
    "unmissableSpecialOfferPrices": MessageLookupByLibrary.simpleMessage(
      "Незабываемые специальные цены",
    ),
    "unsupportedPlatform": MessageLookupByLibrary.simpleMessage(
      "Unsupported platform",
    ),
    "upgradeForMoreRecommendations": MessageLookupByLibrary.simpleMessage(
      "Оновіться до Premium для більшої кількості рекомендацій",
    ),
    "uploadQualityPhotos": MessageLookupByLibrary.simpleMessage(
      "Загрузите качественные настоящие фотографии",
    ),
    "uploadYourPhoto": MessageLookupByLibrary.simpleMessage(
      "Загрузите ваше фото",
    ),
    "uploadYourPhotoHint": MessageLookupByLibrary.simpleMessage(
      "Загрузите ваше лучшее фото",
    ),
    "uploading": MessageLookupByLibrary.simpleMessage("Завантаження..."),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage(
      "Использовать текущее местоположение",
    ),
    "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage(
      "Сфотографировать",
    ),
    "userAvatarOptionGallery": MessageLookupByLibrary.simpleMessage(
      "Из галереи выбрать",
    ),
    "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Хороший портрет принесет вам больше совпадений.  ",
    ),
    "userAvatarPageTitle": MessageLookupByLibrary.simpleMessage("Покажи себя"),
    "userAvatarUploadedLabel": MessageLookupByLibrary.simpleMessage(
      "Загрузка завершена!",
    ),
    "userBirthdayInputLabel": MessageLookupByLibrary.simpleMessage(
      "Дата рождения",
    ),
    "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "После подтверждения национальность изменить нельзя",
    ),
    "userCitizenshipPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Национальность",
    ),
    "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("Пол"),
    "userGenderOptionFemale": MessageLookupByLibrary.simpleMessage("Женский"),
    "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("Мужской"),
    "userGenderOptionNonBinary": MessageLookupByLibrary.simpleMessage(
      "Небинарный",
    ),
    "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Ваш пол не будет публично показан, он будет использоваться только для помощи в подборе",
    ),
    "userInfoPageNamePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Войти",
    ),
    "userInfoPageTitle": MessageLookupByLibrary.simpleMessage(
      "Основная информация",
    ),
    "userNameInputLabel": MessageLookupByLibrary.simpleMessage("Имя"),
    "userPhoneNumberPagePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Номер Телефона",
    ),
    "userPhoneNumberPagePrivacySuffix": MessageLookupByLibrary.simpleMessage(
      " ",
    ),
    "userPhoneNumberPagePrivacyText": MessageLookupByLibrary.simpleMessage(
      "политикой конфиденциальности",
    ),
    "userPhoneNumberPageTermsAnd": MessageLookupByLibrary.simpleMessage(" и "),
    "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
      "Нажимая «Следующий Шаг», вы соглашаетесь с нашими ",
    ),
    "userPhoneNumberPageTermsText": MessageLookupByLibrary.simpleMessage(
      "условиями обслуживания",
    ),
    "userPhoneNumberPageTitle": MessageLookupByLibrary.simpleMessage(
      "Введи номер телефона",
    ),
    "valuesCompatibility": MessageLookupByLibrary.simpleMessage("Ценности"),
    "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage(
      "Введите код подтверждения",
    ),
    "viewAstroReport": MessageLookupByLibrary.simpleMessage(
      "Посмотреть астрологический отчет с",
    ),
    "virgoSign": MessageLookupByLibrary.simpleMessage("Дева"),
    "wannaHollaAt": MessageLookupByLibrary.simpleMessage("Скажи привет!"),
    "warningCancelDisplayCity": MessageLookupByLibrary.simpleMessage(
      "Закрытие после этого, ваш город не будет отображаться во время сопоставления",
    ),
    "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
      "Ваш аккаунт будет автоматически удален через 14 дней. Пожалуйста, не забудьте посетить магазин, чтобы отменить вашу текущую подписку и избежать дополнительных расходов.",
    ),
    "warningDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "Если вы удалите свой аккаунт, вы больше не сможете войти в систему с его помощью. Вы уверены, что хотите удалить?",
    ),
    "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
      "Внешняя ссылка. Проверьте, можно ли доверять источнику перед нажатием, так как неизвестные ссылки могут быть мошенничеством или красть данные. Процедите с осторожностью.",
    ),
    "warningTitleCaution": MessageLookupByLibrary.simpleMessage("Осторожно"),
    "warningUnmatching": MessageLookupByLibrary.simpleMessage(
      "После отмены сопряжения весь история чата будет удалена.",
    ),
    "whatsYourEmail": MessageLookupByLibrary.simpleMessage(
      "Какой у вас email?",
    ),
    "whoLIkesYou": MessageLookupByLibrary.simpleMessage("Кто тебя любит"),
    "whoLikesU": MessageLookupByLibrary.simpleMessage("Кто тебя любит"),
    "wishActivityAddTitle": MessageLookupByLibrary.simpleMessage(
      "Добавьте вашу мысль",
    ),
    "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "Помочь вам найти компаньонов",
    ),
    "wishActivityPickerTitle": MessageLookupByLibrary.simpleMessage(
      "Хочешь сделать что-нибудь?",
    ),
    "wishCityPickerSkipButton": m7,
    "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "если вы туда поедете, Какие города вы хотите посетить?",
    ),
    "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage(
      "За какую страну вы больше всего интересуетесь?",
    ),
    "wishCreationComplete": MessageLookupByLibrary.simpleMessage(
      "Ваше желание получено",
    ),
    "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("Уже здесь"),
    "wishDateOptionNotSure": MessageLookupByLibrary.simpleMessage(
      "Ещё не уверен",
    ),
    "wishDateOptionRecent": MessageLookupByLibrary.simpleMessage(
      "Недавно, наверное",
    ),
    "wishDateOptionYear": MessageLookupByLibrary.simpleMessage(
      "В течение года",
    ),
    "wishDatePickerSubtitle": m8,
    "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("Когда"),
    "wishList": MessageLookupByLibrary.simpleMessage("Список желаний"),
    "wishes": MessageLookupByLibrary.simpleMessage("Желание"),
    "writeInterestingBio": MessageLookupByLibrary.simpleMessage(
      "Напишите интересную личную биографию",
    ),
    "youAreAClubMemberNow": MessageLookupByLibrary.simpleMessage(
      "Теперь вы член клуба",
    ),
    "youCanEditItAnytime": MessageLookupByLibrary.simpleMessage(
      "Вы можете редактировать это в любое время",
    ),
    "youSeemCool": MessageLookupByLibrary.simpleMessage("Кажешься крутым"),
  };
}
