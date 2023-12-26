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

  static String m5(country) => "Пропустить, Только ${country}";

  static String m6(country) => "Вы планируете поехать в ${country}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aMonth": MessageLookupByLibrary.simpleMessage("1 месяцев"),
        "aYear": MessageLookupByLibrary.simpleMessage("1 год"),
        "about": MessageLookupByLibrary.simpleMessage("О"),
        "account": MessageLookupByLibrary.simpleMessage("Аккаунт"),
        "age": MessageLookupByLibrary.simpleMessage("Возраст"),
        "allPeople": MessageLookupByLibrary.simpleMessage("Все"),
        "bio": MessageLookupByLibrary.simpleMessage("Введение"),
        "block": MessageLookupByLibrary.simpleMessage("Блокировать"),
        "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
            MessageLookupByLibrary.simpleMessage(
                "Заблокируйте этого человека, чтобы не получать от него сообщения"),
        "boostYourAppeal":
            MessageLookupByLibrary.simpleMessage("Прелесть Вверх!"),
        "breakIce": MessageLookupByLibrary.simpleMessage(
            "🔨🔨🔨 Не обращай на меня внимания🔨🔨🔨 Я просто разбиваю лед🔨🔨🔨"),
        "buttonAlreadyPlus":
            MessageLookupByLibrary.simpleMessage("Вы Plus участник"),
        "buttonCancel": MessageLookupByLibrary.simpleMessage("Отменить"),
        "buttonChange": MessageLookupByLibrary.simpleMessage("Изменить"),
        "buttonConfirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
        "buttonContinue": MessageLookupByLibrary.simpleMessage("Продолжить"),
        "buttonCopy": MessageLookupByLibrary.simpleMessage("Копировать"),
        "buttonDelete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "buttonDeleteAccount":
            MessageLookupByLibrary.simpleMessage("Удалить аккаунт"),
        "buttonDone": MessageLookupByLibrary.simpleMessage("Готово"),
        "buttonEdit": MessageLookupByLibrary.simpleMessage("Редактировать"),
        "buttonEditProfile":
            MessageLookupByLibrary.simpleMessage("Редактировать профиль"),
        "buttonGenerate": MessageLookupByLibrary.simpleMessage("Генерировать"),
        "buttonGotIt": MessageLookupByLibrary.simpleMessage("Понял"),
        "buttonHitAIInterpretationMaximumLimit":
            MessageLookupByLibrary.simpleMessage(
                "😪SONA устала, 👇жми, чтоб зарядить!"),
        "buttonKeepAccount":
            MessageLookupByLibrary.simpleMessage("Сохранить аккаунт"),
        "buttonManage": MessageLookupByLibrary.simpleMessage("Управлять"),
        "buttonNext": MessageLookupByLibrary.simpleMessage("Следующий Шаг"),
        "buttonOpenLink":
            MessageLookupByLibrary.simpleMessage("Открыть Ссылку"),
        "buttonPreview": MessageLookupByLibrary.simpleMessage("Предпросмотр"),
        "buttonRefresh": MessageLookupByLibrary.simpleMessage("Обновить"),
        "buttonResend": MessageLookupByLibrary.simpleMessage("Переслать"),
        "buttonRestore": MessageLookupByLibrary.simpleMessage("Восстановить"),
        "buttonSave": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "buttonSignOut": MessageLookupByLibrary.simpleMessage("Выйти"),
        "buttonSubmit": MessageLookupByLibrary.simpleMessage("Отправить"),
        "buttonUnmatch":
            MessageLookupByLibrary.simpleMessage("Отменить совпадение"),
        "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("Отписаться"),
        "chat": MessageLookupByLibrary.simpleMessage("Чат"),
        "checkOutTheirProfiles":
            MessageLookupByLibrary.simpleMessage("Проверьте их профили"),
        "choosePlaceholder": MessageLookupByLibrary.simpleMessage("Выбрать"),
        "commonLanguage": MessageLookupByLibrary.simpleMessage("Основной язык"),
        "commonLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Обычно используемые языки"),
        "descriptionOptional":
            MessageLookupByLibrary.simpleMessage("Описание (необязательно)"),
        "disclaimer":
            MessageLookupByLibrary.simpleMessage("Отказ от ответственности"),
        "displayMyCity":
            MessageLookupByLibrary.simpleMessage("Показать мой город"),
        "dm": MessageLookupByLibrary.simpleMessage("DM"),
        "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
            "Ошибка отправки, пожалуйста, попробуйте позже."),
        "exceptionSonaContentFilterTips": MessageLookupByLibrary.simpleMessage(
            "Не отправлено. SONA не будет переводить запрещенные слова."),
        "exceptionSonaOverloadedTips": MessageLookupByLibrary.simpleMessage(
            "SONA перегружена, пожалуйста, попробуйте позже."),
        "feedback": MessageLookupByLibrary.simpleMessage("Обратная связь"),
        "filter": MessageLookupByLibrary.simpleMessage("Фильтр"),
        "findingFolksWhoShareYourInterests":
            MessageLookupByLibrary.simpleMessage(
                "Находить людей, которые разделяют ваши интересы"),
        "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
            "SONA ищет потенциальных друзей..."),
        "friendsIntention": MessageLookupByLibrary.simpleMessage(
            "Привет, я думаю, ты потрясающий. Давай подружимся?"),
        "getSonaPlus":
            MessageLookupByLibrary.simpleMessage("Получить SONA Plus"),
        "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
            "Эй, угадай, кто первым нарушит молчание?"),
        "haveSonaSayHi":
            MessageLookupByLibrary.simpleMessage("Пусть SONA поздоровается"),
        "hereSonaCookedUpForU": MessageLookupByLibrary.simpleMessage(
            "Это специально сделано SONA для вас"),
        "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
            "Что вы думаете об одновременном переводе AI?"),
        "iDigYourEnergy": MessageLookupByLibrary.simpleMessage(
            "Твоя энергия мне очень нравится!"),
        "iLikeYourStyle":
            MessageLookupByLibrary.simpleMessage("Мне нравится твой стиль!"),
        "imInterestedSomething": m0,
        "imVeryInterestedInSomething": m1,
        "interests": MessageLookupByLibrary.simpleMessage("Интересы"),
        "interpretationOff": MessageLookupByLibrary.simpleMessage(
            "Синхронный перевод ИИ: Выключен"),
        "interpretationOn": MessageLookupByLibrary.simpleMessage(
            "Синхронный перевод ИИ: Включен"),
        "justSendALike":
            MessageLookupByLibrary.simpleMessage("Просто отправьте лайк"),
        "justTypeInYourLanguage": m2,
        "letSONASayHiForYou": MessageLookupByLibrary.simpleMessage(
            "Пусть SONA поздоровается за вас"),
        "likedPageMonetizeButton":
            MessageLookupByLibrary.simpleMessage("Проверьте их профили"),
        "likedPageNoData": MessageLookupByLibrary.simpleMessage(
            "Статус: Пока нет лайков\n\nЧто делать: Проявите инициативу\n\nПредложение: Загрузите ваши удовлетворительные фотографии\nНапишите подлинную биографию\nВыберите свои интересы"),
        "likedYou": MessageLookupByLibrary.simpleMessage("Тебе нравился"),
        "locationPermissionRequestSubtitle": MessageLookupByLibrary.simpleMessage(
            "Нам нужно ваше местоположение, чтобы улучшить ваш социальный опыт"),
        "locationPermissionRequestTitle":
            MessageLookupByLibrary.simpleMessage("Авторизовать местоположение"),
        "matchPageSelectIdeas": m3,
        "me": MessageLookupByLibrary.simpleMessage("Я"),
        "month": MessageLookupByLibrary.simpleMessage("Месяц"),
        "morePhotosBenefit": MessageLookupByLibrary.simpleMessage(
            "Чем больше фотографий, тем выше рекомендация"),
        "morePhotosMoreCharm": MessageLookupByLibrary.simpleMessage(
            "Больше фото, Больше очарования!"),
        "nearby": MessageLookupByLibrary.simpleMessage("Рядом"),
        "newMatch": MessageLookupByLibrary.simpleMessage("Новое совпадение!"),
        "nextBilingDate":
            MessageLookupByLibrary.simpleMessage("Следующая дата оплаты"),
        "noMessageTips": MessageLookupByLibrary.simpleMessage(
            "Статус: Нет сообщений\n\nПредложение: Перейти на страницу подбора пар\n\nПредложение: Создайте потрясающий профиль"),
        "noThanks": MessageLookupByLibrary.simpleMessage("Нет, спасибо"),
        "notifications": MessageLookupByLibrary.simpleMessage("Уведомления"),
        "onboarding0": MessageLookupByLibrary.simpleMessage(
            "SONA подобно домашней базе для граждан мира"),
        "onboarding1": MessageLookupByLibrary.simpleMessage(
            "Независимо от того, дома вы или в пути, встречайте людей со всего мира. И..."),
        "onboarding2": MessageLookupByLibrary.simpleMessage(
            "Вы получите суперспособность:\nВладение языками Больше никаких барьеров в общении"),
        "onboarding3": MessageLookupByLibrary.simpleMessage(
            "Меньше говори, больше люби. Легендарный роман ждет тебя"),
        "onboardingWish": MessageLookupByLibrary.simpleMessage(
            "Заполните список желаний\nдля лучшего совпадения"),
        "oopsNoDataRightNow":
            MessageLookupByLibrary.simpleMessage("Ой, сейчас нет данных"),
        "peopleFromYourWishlistGetMoreRecommendations":
            MessageLookupByLibrary.simpleMessage(
                "Настройки вашего списка желаний будут играть более значительную роль"),
        "photoFromCamera":
            MessageLookupByLibrary.simpleMessage("Сфотографировать"),
        "photoFromGallery":
            MessageLookupByLibrary.simpleMessage("Из галереи выбрать"),
        "photos": MessageLookupByLibrary.simpleMessage("Фотографии"),
        "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Пожалуйста, проверьте ваш интернет или Нажмите для обновления и попробуйте снова"),
        "plusFuncAIInterpretation": MessageLookupByLibrary.simpleMessage(
            "1000 синхронных переводов/день"),
        "plusFuncDMPerWeek":
            MessageLookupByLibrary.simpleMessage("5 DM в неделю"),
        "plusFuncFilterMatchingCountries": MessageLookupByLibrary.simpleMessage(
            "Фильтровать страны для совпадений"),
        "plusFuncSonaTips": MessageLookupByLibrary.simpleMessage(
            "SONA Tips - Твой советник по чату"),
        "plusFuncUnlimitedLikes":
            MessageLookupByLibrary.simpleMessage("Неограниченные лайки"),
        "plusFuncUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
            "Разблокировать, чтобы увидеть, кто вас любит"),
        "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3 желания"),
        "preference": MessageLookupByLibrary.simpleMessage("Предпочтение"),
        "privacy": MessageLookupByLibrary.simpleMessage("Конфиденциальность"),
        "privacyPolicy":
            MessageLookupByLibrary.simpleMessage("Политика конфиденциальности"),
        "pushNotifications":
            MessageLookupByLibrary.simpleMessage("Пуш-уведомления"),
        "report": MessageLookupByLibrary.simpleMessage("Сообщить"),
        "reportOptionGore": MessageLookupByLibrary.simpleMessage("Жестокость"),
        "reportOptionOther": MessageLookupByLibrary.simpleMessage("Другое"),
        "reportOptionPersonalAttack":
            MessageLookupByLibrary.simpleMessage("Личная атака"),
        "reportOptionPornography":
            MessageLookupByLibrary.simpleMessage("Порнография"),
        "reportOptionScam":
            MessageLookupByLibrary.simpleMessage("Мошенничество"),
        "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
            "Встреча с иностранцами рядом с вами"),
        "screenshotEvidence":
            MessageLookupByLibrary.simpleMessage("Скриншот доказательства"),
        "seeProfile":
            MessageLookupByLibrary.simpleMessage("Посмотреть профиль"),
        "seeWhoLikeU":
            MessageLookupByLibrary.simpleMessage("Смотрите, кто вас любит"),
        "selectCountryPageTitle":
            MessageLookupByLibrary.simpleMessage("Страна или регион"),
        "setDefault":
            MessageLookupByLibrary.simpleMessage("Установить по умолчанию"),
        "settings": MessageLookupByLibrary.simpleMessage("Настройки"),
        "showYourPersonality": MessageLookupByLibrary.simpleMessage(
            "Покажите вашу индивидуальность"),
        "signUpLastStepPageTitle":
            MessageLookupByLibrary.simpleMessage("Скоро будет готово"),
        "sixMonths": MessageLookupByLibrary.simpleMessage("6 месяцев"),
        "sonaInterpretationOff": MessageLookupByLibrary.simpleMessage(
            "⭕ SONA Interpretazione disattivata"),
        "sonaRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
            "Рекомендация Сона: Охлаждение.\nЧто делать: Ждать.\nПредложение: Посмотреть фильм?"),
        "sonaWillGenerateABioBasedOnInterests":
            MessageLookupByLibrary.simpleMessage(
                "SONA создаст биографию, основанную на ваших интересах"),
        "speakSameLanguage":
            MessageLookupByLibrary.simpleMessage("Вы говорите на одном языке"),
        "standard": MessageLookupByLibrary.simpleMessage("Стандарт"),
        "subPageSubtitleAIInterpretationDaily":
            MessageLookupByLibrary.simpleMessage(
                "1000 \nсинхронных \nпереводов/день"),
        "subPageSubtitleDMWeekly":
            MessageLookupByLibrary.simpleMessage("5 DM в неделю"),
        "subPageSubtitleFilterMatchingCountries":
            MessageLookupByLibrary.simpleMessage(
                "Фильтровать \nстраны для совпадений"),
        "subPageSubtitleSonaTips": MessageLookupByLibrary.simpleMessage(
            "SONA Tips - \nТвой советник по чату"),
        "subPageSubtitleUnlimitedLikes":
            MessageLookupByLibrary.simpleMessage("Неограниченные лайки"),
        "subPageSubtitleUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
            "Разблокировать, \nчтобы увидеть, кто вас любит"),
        "subPageTitle":
            MessageLookupByLibrary.simpleMessage("Получить SONA Plus"),
        "subscriptionAgreement":
            MessageLookupByLibrary.simpleMessage("Условиями использования"),
        "subscriptionAgreementPrefix": m4,
        "subscriptionAgreementSuffix":
            MessageLookupByLibrary.simpleMessage("."),
        "takeIt": MessageLookupByLibrary.simpleMessage("Использовать"),
        "termsOfService":
            MessageLookupByLibrary.simpleMessage("Условия обслуживания"),
        "theKeyIsBalance":
            MessageLookupByLibrary.simpleMessage("Ключ - это баланс"),
        "theyAreWaitingForYourReply":
            MessageLookupByLibrary.simpleMessage("👆 Они ждут твоего ответа"),
        "threeMonths": MessageLookupByLibrary.simpleMessage("3 месяцев"),
        "toastHitDailyMaximumLimit": MessageLookupByLibrary.simpleMessage(
            "👀достигли своего дневного лимита"),
        "toastHitWeeklyMaximumLimit": MessageLookupByLibrary.simpleMessage(
            "👅достигли своего недельного лимита"),
        "userAvatarOptionCamera":
            MessageLookupByLibrary.simpleMessage("Сфотографировать"),
        "userAvatarOptionGallery":
            MessageLookupByLibrary.simpleMessage("Из галереи выбрать"),
        "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
            "Хороший портрет принесет вам больше совпадений.  "),
        "userAvatarPageTitle":
            MessageLookupByLibrary.simpleMessage("Покажи себя"),
        "userAvatarUploadedLabel":
            MessageLookupByLibrary.simpleMessage("Загрузка завершена!"),
        "userBirthdayInputLabel":
            MessageLookupByLibrary.simpleMessage("Дата рождения"),
        "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "После подтверждения национальность изменить нельзя"),
        "userCitizenshipPickerTitle":
            MessageLookupByLibrary.simpleMessage("Национальность"),
        "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("Пол"),
        "userGenderOptionFemale":
            MessageLookupByLibrary.simpleMessage("Женский"),
        "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("Мужской"),
        "userGenderOptionNonBinary":
            MessageLookupByLibrary.simpleMessage("Небинарный"),
        "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Ваш пол не будет публично показан, он будет использоваться только для помощи в подборе"),
        "userInfoPageNamePlaceholder":
            MessageLookupByLibrary.simpleMessage("Войти"),
        "userInfoPageTitle":
            MessageLookupByLibrary.simpleMessage("Основная информация"),
        "userNameInputLabel": MessageLookupByLibrary.simpleMessage("Имя"),
        "userPhoneNumberPagePlaceholder":
            MessageLookupByLibrary.simpleMessage("Номер Телефона"),
        "userPhoneNumberPagePrivacySuffix":
            MessageLookupByLibrary.simpleMessage(" "),
        "userPhoneNumberPagePrivacyText": MessageLookupByLibrary.simpleMessage(
            "политикой конфиденциальности"),
        "userPhoneNumberPageTermsAnd":
            MessageLookupByLibrary.simpleMessage(" и "),
        "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
            "Нажимая «Следующий Шаг», вы соглашаетесь с нашими "),
        "userPhoneNumberPageTermsText":
            MessageLookupByLibrary.simpleMessage("условиями обслуживания"),
        "userPhoneNumberPageTitle":
            MessageLookupByLibrary.simpleMessage("Введи номер телефона"),
        "verifyCodePageTitle":
            MessageLookupByLibrary.simpleMessage("Введите код подтверждения"),
        "wannaHollaAt": MessageLookupByLibrary.simpleMessage("Скажи привет!"),
        "warningCancelDisplayCity": MessageLookupByLibrary.simpleMessage(
            "Закрытие после этого, ваш город не будет отображаться во время сопоставления"),
        "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
            "Ваш аккаунт будет автоматически удален через 14 дней. Пожалуйста, не забудьте посетить магазин, чтобы отменить вашу текущую подписку и избежать дополнительных расходов."),
        "warningDeleteAccount": MessageLookupByLibrary.simpleMessage(
            "Если вы удалите свой аккаунт, вы больше не сможете войти в систему с его помощью. Вы уверены, что хотите удалить?"),
        "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
            "Внешняя ссылка. Проверьте, можно ли доверять источнику перед нажатием, так как неизвестные ссылки могут быть мошенничеством или красть данные. Процедите с осторожностью."),
        "warningTitleCaution":
            MessageLookupByLibrary.simpleMessage("Осторожно"),
        "warningUnmatching": MessageLookupByLibrary.simpleMessage(
            "После отмены сопряжения весь история чата будет удалена."),
        "whoLIkesYou": MessageLookupByLibrary.simpleMessage("Кто тебя любит"),
        "whoLikesU": MessageLookupByLibrary.simpleMessage("Кто тебя любит"),
        "wishActivityAddTitle":
            MessageLookupByLibrary.simpleMessage("Добавьте вашу мысль"),
        "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "Помочь вам найти компаньонов"),
        "wishActivityPickerTitle":
            MessageLookupByLibrary.simpleMessage("Хочешь сделать что-нибудь?"),
        "wishCityPickerSkipButton": m5,
        "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "если вы туда поедете, Какие города вы хотите посетить?"),
        "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage(
            "За какую страну вы больше всего интересуетесь?"),
        "wishCreationComplete":
            MessageLookupByLibrary.simpleMessage("Ваше желание получено"),
        "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("Уже здесь"),
        "wishDateOptionNotSure":
            MessageLookupByLibrary.simpleMessage("Ещё не уверен"),
        "wishDateOptionRecent":
            MessageLookupByLibrary.simpleMessage("Недавно, наверное"),
        "wishDateOptionYear":
            MessageLookupByLibrary.simpleMessage("В течение года"),
        "wishDatePickerSubtitle": m6,
        "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("Когда"),
        "wishList": MessageLookupByLibrary.simpleMessage("Список желаний"),
        "wishes": MessageLookupByLibrary.simpleMessage("Желание"),
        "youCanEditItAnytime": MessageLookupByLibrary.simpleMessage(
            "Вы можете редактировать это в любое время"),
        "youSeemCool": MessageLookupByLibrary.simpleMessage("Кажешься крутым")
      };
}
