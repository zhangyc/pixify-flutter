// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_TW locale. All the
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
  String get localeName => 'zh_TW';

  static String m0(something) => "\"我對${something}感興趣\"";

  static String m1(something) => "我對「${something}」非常感興趣！";

  static String m2(lang) => "只需輸入${lang}";

  static String m3(gender) =>
      "你喜歡${Intl.gender(gender, female: '她', male: '他', other: '他們')}的哪個想法？";

  static String m4(storeName) =>
      "點擊“繼續”後你會被收取費用，您的訂閱將按對應套餐價格自動續訂，您可以通過${storeName}取消，繼續代表您同意我們的";

  static String m5(country) => "跳過，就${country}";

  static String m6(country) => "有計劃要去${country}嗎";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aMonth": MessageLookupByLibrary.simpleMessage("1個月"),
        "aYear": MessageLookupByLibrary.simpleMessage("1年"),
        "about": MessageLookupByLibrary.simpleMessage("關於"),
        "account": MessageLookupByLibrary.simpleMessage("帳戶"),
        "age": MessageLookupByLibrary.simpleMessage("年齡"),
        "allPeople": MessageLookupByLibrary.simpleMessage("所有人"),
        "bio": MessageLookupByLibrary.simpleMessage("簡介"),
        "block": MessageLookupByLibrary.simpleMessage("屏蔽"),
        "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
            MessageLookupByLibrary.simpleMessage("屏蔽此人以免收到他們的任何消息"),
        "breakIce":
            MessageLookupByLibrary.simpleMessage("🔨🔨🔨 別介意🔨🔨🔨 我在破冰🔨🔨🔨"),
        "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage("你是Plus會員"),
        "buttonCancel": MessageLookupByLibrary.simpleMessage("取消"),
        "buttonChange": MessageLookupByLibrary.simpleMessage("更改"),
        "buttonConfirm": MessageLookupByLibrary.simpleMessage("確認"),
        "buttonContinue": MessageLookupByLibrary.simpleMessage("繼續"),
        "buttonCopy": MessageLookupByLibrary.simpleMessage("複製"),
        "buttonDelete": MessageLookupByLibrary.simpleMessage("삭제"),
        "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("刪除帳戶"),
        "buttonDone": MessageLookupByLibrary.simpleMessage("完成"),
        "buttonEdit": MessageLookupByLibrary.simpleMessage("編輯"),
        "buttonEditProfile": MessageLookupByLibrary.simpleMessage("編輯資料"),
        "buttonGotIt": MessageLookupByLibrary.simpleMessage("明白了"),
        "buttonKeepAccount": MessageLookupByLibrary.simpleMessage("保留帳戶"),
        "buttonManage": MessageLookupByLibrary.simpleMessage("管理"),
        "buttonNext": MessageLookupByLibrary.simpleMessage("下一步"),
        "buttonOpenLink": MessageLookupByLibrary.simpleMessage("開啟連結"),
        "buttonPreview": MessageLookupByLibrary.simpleMessage("預覽"),
        "buttonRefresh": MessageLookupByLibrary.simpleMessage("刷新"),
        "buttonResend": MessageLookupByLibrary.simpleMessage("重新發送"),
        "buttonRestore": MessageLookupByLibrary.simpleMessage("恢復"),
        "buttonSave": MessageLookupByLibrary.simpleMessage("儲存"),
        "buttonSignOut": MessageLookupByLibrary.simpleMessage("登出"),
        "buttonSubmit": MessageLookupByLibrary.simpleMessage("提交"),
        "buttonUnmatch": MessageLookupByLibrary.simpleMessage("取消配對"),
        "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("取消訂閱"),
        "chat": MessageLookupByLibrary.simpleMessage("聊天"),
        "checkOutTheirProfiles":
            MessageLookupByLibrary.simpleMessage("查看他們的資料"),
        "choosePlaceholder": MessageLookupByLibrary.simpleMessage("選擇"),
        "commonLanguage": MessageLookupByLibrary.simpleMessage("主要語言"),
        "commonLanguageTitle": MessageLookupByLibrary.simpleMessage("常用語言"),
        "descriptionOptional": MessageLookupByLibrary.simpleMessage("描述（可選）"),
        "disclaimer": MessageLookupByLibrary.simpleMessage("免責聲明"),
        "displayMyCity": MessageLookupByLibrary.simpleMessage("顯示我的城市"),
        "dm": MessageLookupByLibrary.simpleMessage("超私訊"),
        "exceptionFailedToSendTips":
            MessageLookupByLibrary.simpleMessage("傳送失敗，請稍後再試。"),
        "exceptionSonaContentFilterTips":
            MessageLookupByLibrary.simpleMessage("未寄出。SONA不會翻譯違禁詞。"),
        "exceptionSonaOverloadedTips":
            MessageLookupByLibrary.simpleMessage("SONA過載，請稍後再試。"),
        "feedback": MessageLookupByLibrary.simpleMessage("反饋"),
        "filter": MessageLookupByLibrary.simpleMessage("過濾器"),
        "findingFolksWhoShareYourInterests":
            MessageLookupByLibrary.simpleMessage("找到與你有共同興趣的人"),
        "firstLandingLoadingTitle":
            MessageLookupByLibrary.simpleMessage("SONA正在尋找一些潜在的朋友..."),
        "friendsIntention":
            MessageLookupByLibrary.simpleMessage("嘿，我覺得你很棒。我們成為朋友怎麼樣？"),
        "getSonaPlus": MessageLookupByLibrary.simpleMessage("取得SONA Plus"),
        "guessWhoBreakSilence":
            MessageLookupByLibrary.simpleMessage("嘿，猜猜誰會先打破沉默？"),
        "haveSonaSayHi": MessageLookupByLibrary.simpleMessage("讓SONA打招呼"),
        "howDoUFeelAboutAI":
            MessageLookupByLibrary.simpleMessage("你覺得AI傳譯怎麼樣?"),
        "iDigYourEnergy": MessageLookupByLibrary.simpleMessage("你的活力很有吸引力！"),
        "iLikeYourStyle": MessageLookupByLibrary.simpleMessage("我中意你的風格！"),
        "imInterestedSomething": m0,
        "imVeryInterestedInSomething": m1,
        "interests": MessageLookupByLibrary.simpleMessage("관심사"),
        "interpretationOff": MessageLookupByLibrary.simpleMessage("AI傳譯：關"),
        "interpretationOn": MessageLookupByLibrary.simpleMessage("AI傳譯：開"),
        "justSendALike": MessageLookupByLibrary.simpleMessage("就是按讚"),
        "justTypeInYourLanguage": m2,
        "letSONASayHiForYou":
            MessageLookupByLibrary.simpleMessage("讓SONA代你打招呼"),
        "likedPageMonetizeButton":
            MessageLookupByLibrary.simpleMessage("查看他們的資料"),
        "likedPageNoData": MessageLookupByLibrary.simpleMessage(
            "狀態：姑且沒贊哦\n\n該做什麼：採取主動\n\n建議：\n多傳照片多加分\n寫下簡介顯真誠\n興趣選擇得\n同道中人"),
        "likedYou": MessageLookupByLibrary.simpleMessage("喜歡你"),
        "locationPermissionRequestSubtitle":
            MessageLookupByLibrary.simpleMessage("同城外國人尋找"),
        "locationPermissionRequestTitle":
            MessageLookupByLibrary.simpleMessage("位置授權"),
        "matchPageSelectIdeas": m3,
        "me": MessageLookupByLibrary.simpleMessage("我的"),
        "month": MessageLookupByLibrary.simpleMessage("月"),
        "morePhotosBenefit": MessageLookupByLibrary.simpleMessage("照片越多，推薦值越高"),
        "nearby": MessageLookupByLibrary.simpleMessage("附近"),
        "newMatch": MessageLookupByLibrary.simpleMessage("新配對！"),
        "nextBilingDate": MessageLookupByLibrary.simpleMessage("下次付費日"),
        "noMessageTips": MessageLookupByLibrary.simpleMessage(
            "狀態：暫無消息\n\n該做什麼：前往配對\n\n建議：製作棒棒的個人資料"),
        "notifications": MessageLookupByLibrary.simpleMessage("通知"),
        "oopsNoDataRightNow": MessageLookupByLibrary.simpleMessage("哎呀，現在沒有數據"),
        "peopleFromYourWishlistGetMoreRecommendations":
            MessageLookupByLibrary.simpleMessage("更多推薦來自你心願單的人"),
        "photos": MessageLookupByLibrary.simpleMessage("照片"),
        "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
            MessageLookupByLibrary.simpleMessage("請檢查網路或點擊刷新重試"),
        "plusFuncAIInterpretation":
            MessageLookupByLibrary.simpleMessage("每天1000條AI傳譯"),
        "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage("每週5次DM"),
        "plusFuncFilterMatchingCountries":
            MessageLookupByLibrary.simpleMessage("篩選配對的國家"),
        "plusFuncSonaTips":
            MessageLookupByLibrary.simpleMessage("SONA Tips - 你的聊天參謀"),
        "plusFuncUnlimitedLikes": MessageLookupByLibrary.simpleMessage("無限點讚"),
        "plusFuncUnlockWhoLikesU":
            MessageLookupByLibrary.simpleMessage("解鎖查看誰喜歡你"),
        "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3個心願"),
        "preference": MessageLookupByLibrary.simpleMessage("偏好"),
        "privacy": MessageLookupByLibrary.simpleMessage("隱私"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("隱私政策"),
        "pushNotifications": MessageLookupByLibrary.simpleMessage("推送通知"),
        "report": MessageLookupByLibrary.simpleMessage("舉報"),
        "reportOptionGore": MessageLookupByLibrary.simpleMessage("血腥"),
        "reportOptionOther": MessageLookupByLibrary.simpleMessage("其他"),
        "reportOptionPersonalAttack":
            MessageLookupByLibrary.simpleMessage("人身攻擊"),
        "reportOptionPornography": MessageLookupByLibrary.simpleMessage("色情"),
        "reportOptionScam": MessageLookupByLibrary.simpleMessage("詐騙"),
        "runningIntoForeignersNearYou":
            MessageLookupByLibrary.simpleMessage("優先展示附近的外國人"),
        "screenshotEvidence": MessageLookupByLibrary.simpleMessage("截圖證據"),
        "seeProfile": MessageLookupByLibrary.simpleMessage("查看個人資料"),
        "seeWhoLikeU": MessageLookupByLibrary.simpleMessage("看看誰喜歡你"),
        "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage("選擇國家"),
        "settings": MessageLookupByLibrary.simpleMessage("設定"),
        "showYourPersonality": MessageLookupByLibrary.simpleMessage("展現你的個性"),
        "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage("最後一步"),
        "sixMonths": MessageLookupByLibrary.simpleMessage("6個月"),
        "sonaInterpretationOff":
            MessageLookupByLibrary.simpleMessage("⭕ SONA傳譯已關閉"),
        "sonaRecommendationCooldown":
            MessageLookupByLibrary.simpleMessage("Sona推薦：冷卻\n怎麼辦：等待\n建議：看看電影？"),
        "speakSameLanguage":
            MessageLookupByLibrary.simpleMessage("🤝 同語無需譯,靈犀一點通"),
        "standard": MessageLookupByLibrary.simpleMessage("標準"),
        "subPageSubtitleAIInterpretationDaily":
            MessageLookupByLibrary.simpleMessage("每天1000條\nAI傳譯"),
        "subPageSubtitleDMWeekly":
            MessageLookupByLibrary.simpleMessage("每週5次DM"),
        "subPageSubtitleFilterMatchingCountries":
            MessageLookupByLibrary.simpleMessage("篩選配對的\n國家"),
        "subPageSubtitleSonaTips":
            MessageLookupByLibrary.simpleMessage("SONA Tips - \n你的聊天參謀"),
        "subPageSubtitleUnlimitedLikes":
            MessageLookupByLibrary.simpleMessage("無限點讚"),
        "subPageSubtitleUnlockWhoLikesU":
            MessageLookupByLibrary.simpleMessage("解鎖查看\n誰喜歡你"),
        "subPageTitle": MessageLookupByLibrary.simpleMessage("取得SONA Plus"),
        "subscriptionAgreement": MessageLookupByLibrary.simpleMessage("條款"),
        "subscriptionAgreementPrefix": m4,
        "subscriptionAgreementSuffix":
            MessageLookupByLibrary.simpleMessage("。"),
        "termsOfService": MessageLookupByLibrary.simpleMessage("服務條款"),
        "theKeyIsBalance": MessageLookupByLibrary.simpleMessage("關鍵是平衡"),
        "theyAreWaitingForYourReply":
            MessageLookupByLibrary.simpleMessage("👆 在等你的回答喲"),
        "threeMonths": MessageLookupByLibrary.simpleMessage("3個月"),
        "toastHitDailyMaximumLimit":
            MessageLookupByLibrary.simpleMessage("👀已達到今日限額"),
        "toastHitWeeklyMaximumLimit":
            MessageLookupByLibrary.simpleMessage("👅你已達到本週限額"),
        "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage("拍照"),
        "userAvatarOptionGallery":
            MessageLookupByLibrary.simpleMessage("從圖庫選擇"),
        "userAvatarPageSubtitle":
            MessageLookupByLibrary.simpleMessage("一張好的肖像可以讓你獲得更多的匹配。请使用真實照片。"),
        "userAvatarPageTitle": MessageLookupByLibrary.simpleMessage("展現你的自信"),
        "userAvatarUploadedLabel":
            MessageLookupByLibrary.simpleMessage("上傳搞定！"),
        "userBirthdayInputLabel": MessageLookupByLibrary.simpleMessage("出生日期"),
        "userCitizenshipPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("一旦確認，國籍無法更改"),
        "userCitizenshipPickerTitle":
            MessageLookupByLibrary.simpleMessage("國籍"),
        "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("性別"),
        "userGenderOptionFemale": MessageLookupByLibrary.simpleMessage("女性"),
        "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("男性"),
        "userGenderOptionNonBinary":
            MessageLookupByLibrary.simpleMessage("非二元性別"),
        "userGenderPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("您的性別不會公開顯示，僅用於幫助匹配"),
        "userInfoPageNamePlaceholder":
            MessageLookupByLibrary.simpleMessage("輸入"),
        "userInfoPageTitle": MessageLookupByLibrary.simpleMessage("基本資訊"),
        "userNameInputLabel": MessageLookupByLibrary.simpleMessage("名稱"),
        "userPhoneNumberPagePlaceholder":
            MessageLookupByLibrary.simpleMessage("電話號碼"),
        "userPhoneNumberPagePrivacySuffix":
            MessageLookupByLibrary.simpleMessage(""),
        "userPhoneNumberPagePrivacyText":
            MessageLookupByLibrary.simpleMessage("隱私政策"),
        "userPhoneNumberPageTermsAnd":
            MessageLookupByLibrary.simpleMessage("和"),
        "userPhoneNumberPageTermsPrefix":
            MessageLookupByLibrary.simpleMessage("點擊“下一步”，即表示您同意我們的"),
        "userPhoneNumberPageTermsText":
            MessageLookupByLibrary.simpleMessage("服務條款"),
        "userPhoneNumberPageTitle":
            MessageLookupByLibrary.simpleMessage("請輸入電話號碼"),
        "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage("輸入驗證碼"),
        "wannaHollaAt": MessageLookupByLibrary.simpleMessage("打個招呼吧！"),
        "warningCancelDisplayCity":
            MessageLookupByLibrary.simpleMessage("關閉後，你的城市不會在匹配時顯示"),
        "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
            "您的帳戶將在14天後自動刪除。請記得去商店取消您目前的訂閱，以避免額外的費用。"),
        "warningDeleteAccount":
            MessageLookupByLibrary.simpleMessage("如果您刪除帳戶，將無法再用它登入。您確定要刪除嗎？"),
        "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
            "外部連結。點擊前請確認來源可靠，因為不明連結可能是詐騙或竊取數據。謹慎行事。"),
        "warningTitleCaution": MessageLookupByLibrary.simpleMessage("注意"),
        "warningUnmatching":
            MessageLookupByLibrary.simpleMessage("取消配對後，你們之間的聊天內容都將被清除。"),
        "whoLIkesYou": MessageLookupByLibrary.simpleMessage("誰喜歡你"),
        "whoLikesU": MessageLookupByLibrary.simpleMessage("誰喜歡你"),
        "wishActivityAddTitle": MessageLookupByLibrary.simpleMessage("加入你的想法"),
        "wishActivityPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("幫你找到小夥伴"),
        "wishActivityPickerTitle":
            MessageLookupByLibrary.simpleMessage("有什麼特別想做的事嗎？"),
        "wishCityPickerSkipButton": m5,
        "wishCityPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("如果你去那裡，你想去哪些城市？"),
        "wishCountryPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("國家的人更有共鳴?"),
        "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage("哪個"),
        "wishCreationComplete":
            MessageLookupByLibrary.simpleMessage("已收到你的心願!"),
        "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("已經在這了"),
        "wishDateOptionNotSure": MessageLookupByLibrary.simpleMessage("還不確定喲"),
        "wishDateOptionRecent": MessageLookupByLibrary.simpleMessage("近期吧，大概"),
        "wishDateOptionYear": MessageLookupByLibrary.simpleMessage("一年內"),
        "wishDatePickerSubtitle": m6,
        "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("何時"),
        "wishList": MessageLookupByLibrary.simpleMessage("心願單"),
        "wishes": MessageLookupByLibrary.simpleMessage("心願"),
        "youSeemCool": MessageLookupByLibrary.simpleMessage("你看起來很酷。")
      };
}
