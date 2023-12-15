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
      "Which of ${Intl.gender(gender, female: 'her', male: 'his', other: 'their')} ideas do you like?";

  static String m4(country) => "Пропустить, Только ${country}";

  static String m5(country) => "Вы планируете поехать в ${country}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "age": MessageLookupByLibrary.simpleMessage("Возраст"),
        "block": MessageLookupByLibrary.simpleMessage("Блокировать"),
        "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
            MessageLookupByLibrary.simpleMessage(
                "Заблокируйте этого человека, чтобы не получать от него сообщения"),
        "breakIce": MessageLookupByLibrary.simpleMessage(
            "🔨🔨🔨 Не обращай на меня внимания🔨🔨🔨 Я просто разбиваю лед🔨🔨🔨"),
        "buttonCopy": MessageLookupByLibrary.simpleMessage("Копировать"),
        "buttonDelete": MessageLookupByLibrary.simpleMessage("Удалить"),
        "buttonOpenLink":
            MessageLookupByLibrary.simpleMessage("Открыть Ссылку"),
        "buttonResend": MessageLookupByLibrary.simpleMessage("Переслать"),
        "buttonUnmatch":
            MessageLookupByLibrary.simpleMessage("Отменить совпадение"),
        "cancelButton": MessageLookupByLibrary.simpleMessage("Отменить"),
        "chat": MessageLookupByLibrary.simpleMessage("Чат"),
        "checkOutTheirProfiles":
            MessageLookupByLibrary.simpleMessage("Проверьте их профили"),
        "choosePlaceholder": MessageLookupByLibrary.simpleMessage("Выбрать"),
        "commonLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Обычно используемые языки"),
        "descriptionOptional":
            MessageLookupByLibrary.simpleMessage("Описание (необязательно)"),
        "dm": MessageLookupByLibrary.simpleMessage("DM"),
        "doneButton": MessageLookupByLibrary.simpleMessage("Готово"),
        "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
            "Ошибка отправки, пожалуйста, попробуйте позже."),
        "exceptionSonaContentFilterTips": MessageLookupByLibrary.simpleMessage(
            "Не отправлено. SONA не будет переводить запрещенные слова."),
        "exceptionSonaOverloadedTips": MessageLookupByLibrary.simpleMessage(
            "SONA перегружена, пожалуйста, попробуйте позже."),
        "filter": MessageLookupByLibrary.simpleMessage("Фильтр"),
        "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
            "SONA ищет потенциальных друзей..."),
        "friendsIntention": MessageLookupByLibrary.simpleMessage(
            "Привет, я думаю, ты потрясающий. Давай подружимся?"),
        "gore": MessageLookupByLibrary.simpleMessage("Жестокость"),
        "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
            "Эй, угадай, кто первым нарушит молчание?"),
        "haveSonaSayHi":
            MessageLookupByLibrary.simpleMessage("Пусть SONA поздоровается"),
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
        "locationPermissionRequestSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "Найти иностранцев в том же городе"),
        "locationPermissionRequestTitle":
            MessageLookupByLibrary.simpleMessage("Авторизовать местоположение"),
        "matchPageSelectIdeas": m3,
        "nearby": MessageLookupByLibrary.simpleMessage("Рядом"),
        "newMatch": MessageLookupByLibrary.simpleMessage("Новое совпадение!"),
        "nextButton": MessageLookupByLibrary.simpleMessage("Следующий Шаг"),
        "noMessageTips": MessageLookupByLibrary.simpleMessage(
            "Статус: Нет сообщений\n\nПредложение: Перейти на страницу подбора пар\n\nПредложение: Создайте потрясающий профиль"),
        "oopsNoDataRightNow":
            MessageLookupByLibrary.simpleMessage("Ой, сейчас нет данных"),
        "other": MessageLookupByLibrary.simpleMessage("Другое"),
        "peopleFromYourWishlistGetMoreRecommendations":
            MessageLookupByLibrary.simpleMessage(
                "Настройки вашего списка желаний будут играть более значительную роль"),
        "personalAttack": MessageLookupByLibrary.simpleMessage("Личная атака"),
        "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Пожалуйста, проверьте ваш интернет или Нажмите для обновления и попробуйте снова"),
        "pornography": MessageLookupByLibrary.simpleMessage("Порнография"),
        "preference": MessageLookupByLibrary.simpleMessage("Предпочтение"),
        "refresh": MessageLookupByLibrary.simpleMessage("Обновить"),
        "report": MessageLookupByLibrary.simpleMessage("Сообщить"),
        "resendButton": MessageLookupByLibrary.simpleMessage("Переслать"),
        "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
            "Встреча с иностранцами рядом с вами"),
        "scam": MessageLookupByLibrary.simpleMessage("Мошенничество"),
        "screenshotEvidence":
            MessageLookupByLibrary.simpleMessage("Скриншот доказательства"),
        "seeProfile":
            MessageLookupByLibrary.simpleMessage("Посмотреть профиль"),
        "seeWhoLikeU":
            MessageLookupByLibrary.simpleMessage("Смотрите, кто вас любит"),
        "selectCountryPageTitle":
            MessageLookupByLibrary.simpleMessage("Выбрать Страну"),
        "signUpLastStepPageTitle":
            MessageLookupByLibrary.simpleMessage("Последний шаг"),
        "sonaInterpretationOff": MessageLookupByLibrary.simpleMessage(
            "⭕ SONA Interpretazione disattivata"),
        "sonaRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
            "Рекомендация Сона: Охлаждение.\nЧто делать: Ждать.\nПредложение: Посмотреть фильм?"),
        "speakSameLanguage":
            MessageLookupByLibrary.simpleMessage("Вы говорите на одном языке"),
        "submitButton": MessageLookupByLibrary.simpleMessage("Отправить"),
        "theyAreWaitingForYourReply":
            MessageLookupByLibrary.simpleMessage("👆 Они ждут твоего ответа"),
        "userAvatarOptionCamera":
            MessageLookupByLibrary.simpleMessage("Сфотографировать"),
        "userAvatarOptionGallery":
            MessageLookupByLibrary.simpleMessage("Из галереи выбрать"),
        "userAvatarPageChangeButton":
            MessageLookupByLibrary.simpleMessage("Изменить"),
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
            MessageLookupByLibrary.simpleMessage(""),
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
        "wishCityPickerSkipButton": m4,
        "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "если вы туда поедете, Какие города вы хотите посетить?"),
        "wishCountryPickerSubtitle": MessageLookupByLibrary.simpleMessage(
            "страны у вас лучше всего складываются отношения?"),
        "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage("Какой"),
        "wishCreationComplete":
            MessageLookupByLibrary.simpleMessage("Ваше желание получено"),
        "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("Уже здесь"),
        "wishDateOptionNotSure":
            MessageLookupByLibrary.simpleMessage("Ещё не уверен"),
        "wishDateOptionRecent":
            MessageLookupByLibrary.simpleMessage("Недавно, наверное"),
        "wishDateOptionYear":
            MessageLookupByLibrary.simpleMessage("В течение года"),
        "wishDatePickerSubtitle": m5,
        "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("Когда"),
        "wishList": MessageLookupByLibrary.simpleMessage("Список желаний"),
        "wishes": MessageLookupByLibrary.simpleMessage("Желание"),
        "youSeemCool": MessageLookupByLibrary.simpleMessage("Кажешься крутым")
      };
}
