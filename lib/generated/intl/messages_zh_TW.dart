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

  static String m0(month, day) => "${month}月${day}日";

  static String m1(x) => "距離30天目標還有 ${x} 次";

  static String m2(error) => "獲取運勢失敗: ${error}";

  static String m3(something) => "\"我對${something}感興趣\"";

  static String m4(something) => "我對「${something}」非常感興趣！";

  static String m5(lang) => "只需輸入${lang}";

  static String m6(gender) =>
      "${Intl.gender(gender, female: '她', male: '他', other: '他們')}的哪些分享經歷讓你有共鳴？";

  static String m7(minutes) => "${minutes} 分鐘";

  static String m8(month, day) => "${month}月${day}日";

  static String m9(score) => "心情 ${score}/10";

  static String m10(error) => "獲取月相解讀失敗: ${error}";

  static String m11(error) => "❌ 保存失敗：${error}";

  static String m12(x) => "🔥 連續記錄 ${x} 天！";

  static String m13(storeName) =>
      "點擊“繼續”後你會被收取費用，您的訂閱將按對應套餐價格自動續訂，您可以通過${storeName}取消，繼續代表您同意我們的";

  static String m14(count) => "解鎖查看${count}個高匹配用戶 ✨";

  static String m15(count, destinyCount) =>
      "解鎖${count}個用戶，包含${destinyCount}個命定匹配 ⭐";

  static String m16(country) => "跳過，就${country}";

  static String m17(country) => "有計劃要去${country}嗎";

  static String m18(x) => "${x}天";

  static String m19(x) => "${x}小時";

  static String m20(x) => "${x}次";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aMonth": MessageLookupByLibrary.simpleMessage("1個月"),
    "aYear": MessageLookupByLibrary.simpleMessage("1年"),
    "about": MessageLookupByLibrary.simpleMessage("關於"),
    "account": MessageLookupByLibrary.simpleMessage("帳戶"),
    "active_days": MessageLookupByLibrary.simpleMessage("活躍天數"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("添加照片"),
    "age": MessageLookupByLibrary.simpleMessage("年齡"),
    "aiCreatingFunGroupPics": MessageLookupByLibrary.simpleMessage(
      "AI正在創建有趣的群組照片",
    ),
    "allPeople": MessageLookupByLibrary.simpleMessage("所有人"),
    "analyzingDailyHoroscope": MessageLookupByLibrary.simpleMessage(
      "正在解讀今日運勢...",
    ),
    "analyzingMoonPhase": MessageLookupByLibrary.simpleMessage("正在解讀月相能量..."),
    "analyzingText": MessageLookupByLibrary.simpleMessage("กำลังวิเคราะห์..."),
    "aquariusSign": MessageLookupByLibrary.simpleMessage("水瓶座"),
    "ariesSign": MessageLookupByLibrary.simpleMessage("白羊座"),
    "ascendantSignLabel": MessageLookupByLibrary.simpleMessage("승천 별자리"),
    "astroChartTab": MessageLookupByLibrary.simpleMessage("星盤"),
    "astroInfoIncompleteMessage": MessageLookupByLibrary.simpleMessage(
      "對方尚未完善出生地資訊，暫時無法生成星盤分析。請期待對方完善資訊後查看。",
    ),
    "astroLearnInterpretationOff": MessageLookupByLibrary.simpleMessage(
      "⭕ Zena傳譯已關閉",
    ),
    "astroLearnRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
      "Zena推薦：冷卻\n怎麼辦：等待\n建議：看看電影？",
    ),
    "astroLearnWillGenerateABioBasedOnInterests":
        MessageLookupByLibrary.simpleMessage("Zena會根據你的興趣生成一份簡介"),
    "astroReport": MessageLookupByLibrary.simpleMessage("合盤"),
    "astro_calendar_title": MessageLookupByLibrary.simpleMessage("星盤療癒日曆"),
    "audio_1_desc": MessageLookupByLibrary.simpleMessage("在寧靜的星空下，找到內心的平靜"),
    "audio_1_title": MessageLookupByLibrary.simpleMessage("星空冥想曲"),
    "audio_2_desc": MessageLookupByLibrary.simpleMessage("激發你內在的勇氣與活力"),
    "audio_2_title": MessageLookupByLibrary.simpleMessage("白羊座能量音頻"),
    "audio_3_desc": MessageLookupByLibrary.simpleMessage("釋放壓力，讓身心完全放鬆"),
    "audio_3_title": MessageLookupByLibrary.simpleMessage("深度放鬆引導"),
    "audio_4_desc": MessageLookupByLibrary.simpleMessage("平衡情緒，找回內心的和諧"),
    "audio_4_title": MessageLookupByLibrary.simpleMessage("情緒平衡音樂"),
    "avatarUpdateFailed": MessageLookupByLibrary.simpleMessage("頭像更新失敗"),
    "average_mood": MessageLookupByLibrary.simpleMessage("平均心情"),
    "bio": MessageLookupByLibrary.simpleMessage("簡介"),
    "birthInfo": MessageLookupByLibrary.simpleMessage("출생 정보"),
    "birthPlace": MessageLookupByLibrary.simpleMessage("출생지"),
    "birthPlaceLabel": MessageLookupByLibrary.simpleMessage("출생지"),
    "birthTimeLabel": MessageLookupByLibrary.simpleMessage("출생 시간"),
    "birthday": MessageLookupByLibrary.simpleMessage("생일"),
    "block": MessageLookupByLibrary.simpleMessage("屏蔽"),
    "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
        MessageLookupByLibrary.simpleMessage("屏蔽此人以免收到他們的任何消息"),
    "boostYourAppeal": MessageLookupByLibrary.simpleMessage("魅力UP!"),
    "breakIce": MessageLookupByLibrary.simpleMessage(
      "🔨🔨🔨 別介意🔨🔨🔨 我在破冰🔨🔨🔨",
    ),
    "breathe_relax": MessageLookupByLibrary.simpleMessage("深呼吸，放鬆身心..."),
    "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage("你是Plus會員"),
    "buttonAuthorize": MessageLookupByLibrary.simpleMessage("授權"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("取消"),
    "buttonChange": MessageLookupByLibrary.simpleMessage("更改"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("확인"),
    "buttonContinue": MessageLookupByLibrary.simpleMessage("繼續"),
    "buttonCopy": MessageLookupByLibrary.simpleMessage("複製"),
    "buttonDelete": MessageLookupByLibrary.simpleMessage("刪除"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("刪除帳戶"),
    "buttonDone": MessageLookupByLibrary.simpleMessage("完成"),
    "buttonEdit": MessageLookupByLibrary.simpleMessage("編輯"),
    "buttonEditProfile": MessageLookupByLibrary.simpleMessage("編輯資料"),
    "buttonGenerate": MessageLookupByLibrary.simpleMessage("生成"),
    "buttonGo": MessageLookupByLibrary.simpleMessage("開始"),
    "buttonGotIt": MessageLookupByLibrary.simpleMessage("明白了"),
    "buttonHitAIInterpretationMaximumLimit":
        MessageLookupByLibrary.simpleMessage("😪Zena累了，👇點擊給她加油！"),
    "buttonJoinNow": MessageLookupByLibrary.simpleMessage("立即加入"),
    "buttonKeepAccount": MessageLookupByLibrary.simpleMessage("保留帳戶"),
    "buttonManage": MessageLookupByLibrary.simpleMessage("管理"),
    "buttonNext": MessageLookupByLibrary.simpleMessage("下一步"),
    "buttonOpenLink": MessageLookupByLibrary.simpleMessage("開啟連結"),
    "buttonPreview": MessageLookupByLibrary.simpleMessage("預覽"),
    "buttonPurchase": MessageLookupByLibrary.simpleMessage("購買"),
    "buttonRefresh": MessageLookupByLibrary.simpleMessage("刷新"),
    "buttonResend": MessageLookupByLibrary.simpleMessage("重新發送"),
    "buttonRestore": MessageLookupByLibrary.simpleMessage("恢復"),
    "buttonSave": MessageLookupByLibrary.simpleMessage("儲存"),
    "buttonSignOut": MessageLookupByLibrary.simpleMessage("登出"),
    "buttonSubmit": MessageLookupByLibrary.simpleMessage("提交"),
    "buttonUnlockVipPerks": MessageLookupByLibrary.simpleMessage("解鎖VIP特權"),
    "buttonUnmatch": MessageLookupByLibrary.simpleMessage("結束分享"),
    "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("取消訂閱"),
    "cancerSign": MessageLookupByLibrary.simpleMessage("巨蟹座"),
    "capricornSign": MessageLookupByLibrary.simpleMessage("摩羯座"),
    "catchMore": MessageLookupByLibrary.simpleMessage("抓住更多"),
    "charmTips": MessageLookupByLibrary.simpleMessage("提升魅力小貼士"),
    "chartPreview": MessageLookupByLibrary.simpleMessage("星盤預覽"),
    "chat": MessageLookupByLibrary.simpleMessage("聊天"),
    "chatWithMatches": MessageLookupByLibrary.simpleMessage("主動與匹配的用戶聊天"),
    "checkItOut": MessageLookupByLibrary.simpleMessage("來看看"),
    "checkOutTheirProfiles": MessageLookupByLibrary.simpleMessage("查看他們的資料"),
    "choosePlaceholder": MessageLookupByLibrary.simpleMessage("選擇"),
    "clickToSetBirthPlace": MessageLookupByLibrary.simpleMessage(
      "출생지 설정을 클릭하세요",
    ),
    "clickToSetBirthday": MessageLookupByLibrary.simpleMessage("생일 설정을 클릭하세요"),
    "click_for_encouragement": MessageLookupByLibrary.simpleMessage("點擊我獲得鼓勵"),
    "click_to_record_status": MessageLookupByLibrary.simpleMessage("點擊記錄今日狀態"),
    "closeButtonText": MessageLookupByLibrary.simpleMessage("닫기"),
    "clubFeeJoking": MessageLookupByLibrary.simpleMessage("開玩笑！免費的"),
    "clubFeePrefix": MessageLookupByLibrary.simpleMessage("俱樂部費用：\$99/月"),
    "clubPromotionContent": MessageLookupByLibrary.simpleMessage(
      "加入我們的專屬俱樂部享受精彩福利",
    ),
    "clubPromotionTitle": MessageLookupByLibrary.simpleMessage("加入俱樂部"),
    "commonLanguage": MessageLookupByLibrary.simpleMessage("主要語言"),
    "commonLanguageTitle": MessageLookupByLibrary.simpleMessage("常用語言"),
    "communicationCompatibility": MessageLookupByLibrary.simpleMessage("溝通"),
    "compatibilityScore": MessageLookupByLibrary.simpleMessage("契合度"),
    "completeAstroInfo": MessageLookupByLibrary.simpleMessage("完善詳細的星盤資訊"),
    "completeAstroProfile": MessageLookupByLibrary.simpleMessage("完善你的星盤資料"),
    "completeAstroProfileButton": MessageLookupByLibrary.simpleMessage(
      "完善星盤資料",
    ),
    "completeBirthLocationInfo": MessageLookupByLibrary.simpleMessage(
      "출생지 정보를 완성하세요",
    ),
    "completeProfile": MessageLookupByLibrary.simpleMessage("完善資料"),
    "confirmSelectLocation": MessageLookupByLibrary.simpleMessage("確認選擇此地點"),
    "continueWithPhone": MessageLookupByLibrary.simpleMessage("使用手機繼續"),
    "currentSelectedCoordinates": MessageLookupByLibrary.simpleMessage(
      "當前選擇的座標",
    ),
    "current_emotion": MessageLookupByLibrary.simpleMessage("此刻的情緒"),
    "dailyHoroscope": MessageLookupByLibrary.simpleMessage("每日運勢"),
    "dailyHoroscopeAnalysis": MessageLookupByLibrary.simpleMessage("每日運勢分析"),
    "dailyHoroscopeAnalysisRemark": MessageLookupByLibrary.simpleMessage(
      "每日運勢解讀",
    ),
    "dailyHoroscopeTitle": MessageLookupByLibrary.simpleMessage("每日運勢"),
    "daily_quote": MessageLookupByLibrary.simpleMessage("今日心語"),
    "daily_quotes_title": MessageLookupByLibrary.simpleMessage("每日心語"),
    "daily_status": MessageLookupByLibrary.simpleMessage("每日狀態"),
    "date_format_md": m0,
    "days_to_30_goal": m1,
    "deepAnalysisReportTitle": MessageLookupByLibrary.simpleMessage(
      "심층 AI 분석 보고서",
    ),
    "deepSynastryAnalysis": MessageLookupByLibrary.simpleMessage("심층 분석"),
    "deepSynastryRemark": MessageLookupByLibrary.simpleMessage("深度合盤分析"),
    "defaultBirthTime": MessageLookupByLibrary.simpleMessage("12:00 (기본)"),
    "deletePhoto": MessageLookupByLibrary.simpleMessage("刪除照片"),
    "deletePhotoContent": MessageLookupByLibrary.simpleMessage(
      "確定要刪除這張照片嗎？此操作無法撤銷。",
    ),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage("描述（可選）"),
    "destinyMatch": MessageLookupByLibrary.simpleMessage("命定"),
    "diamondConsumeFailed": MessageLookupByLibrary.simpleMessage("鑽石消費失敗"),
    "diamondInsufficient": MessageLookupByLibrary.simpleMessage("钻石不足"),
    "diamondPack1": MessageLookupByLibrary.simpleMessage("鑽石禮包"),
    "diamondPack2": MessageLookupByLibrary.simpleMessage("鑽石寶箱"),
    "diamondPack3": MessageLookupByLibrary.simpleMessage("鑽石豪禮"),
    "diamondPack4": MessageLookupByLibrary.simpleMessage("鑽石大禮包"),
    "diamondPack5": MessageLookupByLibrary.simpleMessage("鑽石至尊禮包"),
    "diamondStore": MessageLookupByLibrary.simpleMessage("鑽石商店"),
    "diamondStoreSubtitle": MessageLookupByLibrary.simpleMessage("解鎖鑽石商店特權功能"),
    "diamondStoreTitle": MessageLookupByLibrary.simpleMessage("鑽石商店"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("免責聲明"),
    "displayMyCity": MessageLookupByLibrary.simpleMessage("顯示我的城市"),
    "dm": MessageLookupByLibrary.simpleMessage("超私訊"),
    "duoSnap": MessageLookupByLibrary.simpleMessage("雙人快照"),
    "duosnapAnyway": MessageLookupByLibrary.simpleMessage("無論如何都要雙人快照"),
    "editProfile": MessageLookupByLibrary.simpleMessage("編輯資料"),
    "emotion_analysis": MessageLookupByLibrary.simpleMessage("情緒分析"),
    "emotion_angry": MessageLookupByLibrary.simpleMessage("😠 憤怒"),
    "emotion_anxious": MessageLookupByLibrary.simpleMessage("😰 焦慮"),
    "emotion_calm": MessageLookupByLibrary.simpleMessage("😌 平靜"),
    "emotion_category": MessageLookupByLibrary.simpleMessage("情緒"),
    "emotion_diary": MessageLookupByLibrary.simpleMessage("情緒日記"),
    "emotion_diary_saved": MessageLookupByLibrary.simpleMessage("✅ 情緒日記已保存"),
    "emotion_diary_title": MessageLookupByLibrary.simpleMessage("情緒日記"),
    "emotion_distribution": MessageLookupByLibrary.simpleMessage("情緒分布"),
    "emotion_happy": MessageLookupByLibrary.simpleMessage("😊 開心"),
    "emotion_management": MessageLookupByLibrary.simpleMessage("情緒管理"),
    "emotion_management_title": MessageLookupByLibrary.simpleMessage("情緒管理"),
    "emotion_records": MessageLookupByLibrary.simpleMessage("情緒記錄"),
    "emotion_sad": MessageLookupByLibrary.simpleMessage("😢 難過"),
    "emotion_subtitle": MessageLookupByLibrary.simpleMessage("了解你的情緒，學會與自己相處"),
    "emotion_tip": MessageLookupByLibrary.simpleMessage(
      "接納當下的自己，情緒如同星辰流轉，終將歸於平靜",
    ),
    "emotion_tired": MessageLookupByLibrary.simpleMessage("😴 疲憊"),
    "emotionalCompatibility": MessageLookupByLibrary.simpleMessage("情感"),
    "emptyChatRoomMessage": MessageLookupByLibrary.simpleMessage(
      "你的專屬聊天室還是空的\n但星星知道，對的人正在向你走來",
    ),
    "energy": MessageLookupByLibrary.simpleMessage("能量"),
    "energy_category": MessageLookupByLibrary.simpleMessage("能量"),
    "energy_index": MessageLookupByLibrary.simpleMessage("能量指數"),
    "energy_level": MessageLookupByLibrary.simpleMessage("能量水平"),
    "enterBirthPlace": MessageLookupByLibrary.simpleMessage("출생지를 입력하세요"),
    "every_emotion_matters": MessageLookupByLibrary.simpleMessage(
      "每一種情緒都值得被看見和記錄",
    ),
    "exceptionAstroLearnContentFilterTips":
        MessageLookupByLibrary.simpleMessage("未寄出。Zena不會翻譯違禁詞。"),
    "exceptionAstroLearnOverloadedTips": MessageLookupByLibrary.simpleMessage(
      "Zena過載，請稍後再試。",
    ),
    "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
      "傳送失敗，請稍後再試。",
    ),
    "fateOnTheWay": MessageLookupByLibrary.simpleMessage("緣分正在路上"),
    "feedback": MessageLookupByLibrary.simpleMessage("反饋"),
    "filter": MessageLookupByLibrary.simpleMessage("過濾器"),
    "findingFolksWhoShareYourInterests": MessageLookupByLibrary.simpleMessage(
      "找到與你有共同興趣的人",
    ),
    "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
      "Zena正在尋找一些潜在的朋友...",
    ),
    "first_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "上弦月，是行動和決策的好時機",
    ),
    "friendsIntention": MessageLookupByLibrary.simpleMessage(
      "嘿，我覺得你很棒。我們成為朋友怎麼樣？",
    ),
    "full_moon_insight": MessageLookupByLibrary.simpleMessage("滿月能量最強，適合釋放情緒"),
    "futureCompatibility": MessageLookupByLibrary.simpleMessage("未来"),
    "geminiSign": MessageLookupByLibrary.simpleMessage("双子座"),
    "getAstroLearnPlus": MessageLookupByLibrary.simpleMessage("取得Zena Plus"),
    "gifNotAllowed": MessageLookupByLibrary.simpleMessage("GIF檔案不允許"),
    "goDiscover": MessageLookupByLibrary.simpleMessage("去發現"),
    "gotIt": MessageLookupByLibrary.simpleMessage("明白了"),
    "great_keep_going": MessageLookupByLibrary.simpleMessage("你真棒！繼續保持 ✨"),
    "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
      "嘿，猜猜誰會先打破沉默？",
    ),
    "haveAstroLearnSayHi": MessageLookupByLibrary.simpleMessage("讓Zena打招呼"),
    "healing_calendar_title": MessageLookupByLibrary.simpleMessage("星盤療癒日曆"),
    "healing_category": MessageLookupByLibrary.simpleMessage("療癒"),
    "healing_count": MessageLookupByLibrary.simpleMessage("療癒次數"),
    "healing_data": MessageLookupByLibrary.simpleMessage("療癒數據"),
    "healing_music_title": MessageLookupByLibrary.simpleMessage("療癒音樂"),
    "healing_sessions": MessageLookupByLibrary.simpleMessage("療癒次數"),
    "hereAstroLearnCookedUpForU": MessageLookupByLibrary.simpleMessage(
      "這是Zena為你特製的",
    ),
    "horoscopeAnalysisError": m2,
    "horoscopeFetchFailed": MessageLookupByLibrary.simpleMessage("獲取運勢失敗"),
    "horoscopeRemark": MessageLookupByLibrary.simpleMessage("每日運勢解讀"),
    "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage("你覺得AI傳譯怎麼樣?"),
    "iDigYourEnergy": MessageLookupByLibrary.simpleMessage("你的活力很有吸引力！"),
    "iLikeYourStyle": MessageLookupByLibrary.simpleMessage("我中意你的風格！"),
    "imInterestedSomething": m3,
    "imVeryInterestedInSomething": m4,
    "incompleteBirthdayInfo": MessageLookupByLibrary.simpleMessage("用戶生日資訊不完整"),
    "infoIncompleteTitle": MessageLookupByLibrary.simpleMessage("資訊不完整"),
    "intellectualCompatibility": MessageLookupByLibrary.simpleMessage("智力"),
    "interests": MessageLookupByLibrary.simpleMessage("興趣"),
    "interpretationOff": MessageLookupByLibrary.simpleMessage("AI傳譯：關"),
    "interpretationOn": MessageLookupByLibrary.simpleMessage("AI傳譯：開"),
    "issues": MessageLookupByLibrary.simpleMessage("問題"),
    "justNow": MessageLookupByLibrary.simpleMessage("剛剛"),
    "justSendALike": MessageLookupByLibrary.simpleMessage("就分享你的欣賞"),
    "justTypeInYourLanguage": m5,
    "keep_it_up": MessageLookupByLibrary.simpleMessage("堅持就是勝利，繼續加油 ✨"),
    "last_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "下弦月，放下過去，準備新開始",
    ),
    "leoSign": MessageLookupByLibrary.simpleMessage("獅子座"),
    "letAstroLearnSayHiForYou": MessageLookupByLibrary.simpleMessage(
      "讓Zena代你打招呼",
    ),
    "libraSign": MessageLookupByLibrary.simpleMessage("天秤座"),
    "lifestyleCompatibility": MessageLookupByLibrary.simpleMessage("生活"),
    "lightAnalysisTitle": MessageLookupByLibrary.simpleMessage("가벼운 AI 분석"),
    "lightSynastryRemark": MessageLookupByLibrary.simpleMessage("合盤分析"),
    "likeBack": MessageLookupByLibrary.simpleMessage("回讚"),
    "likedBack": MessageLookupByLibrary.simpleMessage("已回讚"),
    "likedPageMonetizeButton": MessageLookupByLibrary.simpleMessage("了解他們的分享"),
    "likedPageNoData": MessageLookupByLibrary.simpleMessage(
      "狀態：姑且沒欣賞哦\n\n該做什麼：開始分享\n\n建議：\n真實的自拍照\n真誠的故事\n共同興趣連接\n\n就是說...\n上傳一些真實照片\n分享你的真實故事\n選擇你的興趣",
    ),
    "likedYou": MessageLookupByLibrary.simpleMessage("欣賞你的分享"),
    "loading": MessageLookupByLibrary.simpleMessage("載入中..."),
    "locationAuthorizeContent": MessageLookupByLibrary.simpleMessage(
      "我們需要您的位置來顯示附近的人",
    ),
    "locationLocatedFailed": MessageLookupByLibrary.simpleMessage("獲取位置失敗"),
    "locationLocatedSuccess": MessageLookupByLibrary.simpleMessage("已定位到當前位置"),
    "locationPermissionRequestSubtitle": MessageLookupByLibrary.simpleMessage(
      "我們需要您的位置信息來改善您的社交體驗",
    ),
    "locationPermissionRequestTitle": MessageLookupByLibrary.simpleMessage(
      "位置授權",
    ),
    "mapSelectedLocation": MessageLookupByLibrary.simpleMessage("地圖選擇地點"),
    "matchPageSelectIdeas": m6,
    "me": MessageLookupByLibrary.simpleMessage("我的"),
    "meditation_category": MessageLookupByLibrary.simpleMessage("冥想"),
    "meditation_count": MessageLookupByLibrary.simpleMessage("冥想次數"),
    "meditation_practice": MessageLookupByLibrary.simpleMessage("冥想練習"),
    "meditation_practice_title": MessageLookupByLibrary.simpleMessage("冥想練習"),
    "meditation_saved": MessageLookupByLibrary.simpleMessage("✅ 冥想記錄已保存"),
    "meditation_subtitle": MessageLookupByLibrary.simpleMessage(
      "通過星座冥想，找到內心的平靜",
    ),
    "memberCenter": MessageLookupByLibrary.simpleMessage("會員中心"),
    "membersPerks": MessageLookupByLibrary.simpleMessage("會員享受專屬特權"),
    "minutes_duration": m7,
    "month": MessageLookupByLibrary.simpleMessage("月"),
    "month_day_format": m8,
    "mood": MessageLookupByLibrary.simpleMessage("心情"),
    "mood_index": MessageLookupByLibrary.simpleMessage("心情指數"),
    "mood_score": m9,
    "moonPhaseAnalysis": MessageLookupByLibrary.simpleMessage("月相分析"),
    "moonPhaseAnalysisError": m10,
    "moonPhaseAnalysisRemark": MessageLookupByLibrary.simpleMessage("月相能量解讀"),
    "moonPhaseAnalysisTitle": MessageLookupByLibrary.simpleMessage("月相能量解讀"),
    "moonPhaseEnergy": MessageLookupByLibrary.simpleMessage("月相能量"),
    "moonPhaseFetchFailed": MessageLookupByLibrary.simpleMessage("獲取月相解讀失敗"),
    "moonPhaseRemark": MessageLookupByLibrary.simpleMessage("月相能量解讀"),
    "morePhotosBenefit": MessageLookupByLibrary.simpleMessage("照片越多，推薦值越高"),
    "morePhotosMoreCharm": MessageLookupByLibrary.simpleMessage("照片多多魅力增！"),
    "music_subtitle": MessageLookupByLibrary.simpleMessage("放鬆身心的星座音頻"),
    "myPhotos": MessageLookupByLibrary.simpleMessage("我的照片"),
    "myProfileTitle": MessageLookupByLibrary.simpleMessage("我的"),
    "my_statistics": MessageLookupByLibrary.simpleMessage("我的統計"),
    "navigateToAstroProfile": MessageLookupByLibrary.simpleMessage(
      "跳轉到星盤資料完善頁面",
    ),
    "nearby": MessageLookupByLibrary.simpleMessage("附近"),
    "newGameplay": MessageLookupByLibrary.simpleMessage("新玩法"),
    "newMatch": MessageLookupByLibrary.simpleMessage("新連接！"),
    "new_moon_insight": MessageLookupByLibrary.simpleMessage("新月時刻，適合開啟新的療癒計劃"),
    "nextBilingDate": MessageLookupByLibrary.simpleMessage("下次付費日"),
    "noMessageTips": MessageLookupByLibrary.simpleMessage(
      "狀態：暫無消息\n\n該做什麼：尋找傾聽者\n\n建議：分享真實的自己",
    ),
    "noOneFoundYourCharm": MessageLookupByLibrary.simpleMessage("還沒有人發現你的魅力"),
    "noThanks": MessageLookupByLibrary.simpleMessage("不了，謝謝"),
    "no_audio": MessageLookupByLibrary.simpleMessage("暫無音頻"),
    "no_quotes": MessageLookupByLibrary.simpleMessage("暫無心語記錄"),
    "no_records_today": MessageLookupByLibrary.simpleMessage("這天還沒有記錄哦"),
    "notes": MessageLookupByLibrary.simpleMessage("記錄"),
    "notifications": MessageLookupByLibrary.simpleMessage("通知"),
    "onboarding0": MessageLookupByLibrary.simpleMessage("Zena是世界公民的家園"),
    "onboarding1": MessageLookupByLibrary.simpleMessage(
      "無論在家或是在旅途，都可以結識世界各地的朋友。 並且...",
    ),
    "onboarding2": MessageLookupByLibrary.simpleMessage(
      "你將獲得超能力：\n通曉語言\n無需再擔心交流障礙",
    ),
    "onboarding3": MessageLookupByLibrary.simpleMessage(
      "閒話少說，開始吧！\n傳奇的浪漫邂逅在等著你",
    ),
    "onboardingWish": MessageLookupByLibrary.simpleMessage("請完成心願單\n獲得更理想的配對"),
    "oneLineToWin": MessageLookupByLibrary.simpleMessage("一句話打動對方"),
    "oopsNoDataRightNow": MessageLookupByLibrary.simpleMessage("哎呀，現在沒有數據"),
    "peopleFromYourWishlistGetMoreRecommendations":
        MessageLookupByLibrary.simpleMessage("更多推薦來自你心願單的人"),
    "permissionRequiredContent": MessageLookupByLibrary.simpleMessage(
      "我們需要這個權限來為您提供最佳體驗",
    ),
    "permissionRequiredTitle": MessageLookupByLibrary.simpleMessage("需要權限"),
    "personaCompleteProfile": MessageLookupByLibrary.simpleMessage("完善基礎資料"),
    "personaCompleteProfileDesc": MessageLookupByLibrary.simpleMessage(
      "完善姓名、生日、性別，解鎖更多推薦",
    ),
    "personaEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "開啟消息通知",
    ),
    "personaEnableNotificationsDesc": MessageLookupByLibrary.simpleMessage(
      "不錯過匹配和消息，及時互動",
    ),
    "personaForYou": MessageLookupByLibrary.simpleMessage("為你推薦"),
    "personaShowCity": MessageLookupByLibrary.simpleMessage("展示所在城市"),
    "personaShowCityDesc": MessageLookupByLibrary.simpleMessage("更容易被同城用戶發現"),
    "personaUploadPhotos": MessageLookupByLibrary.simpleMessage("上傳你的照片"),
    "personaUploadPhotosDesc": MessageLookupByLibrary.simpleMessage(
      "至少添加 2 張清晰照片，提升曝光",
    ),
    "photoFromCamera": MessageLookupByLibrary.simpleMessage("拍照"),
    "photoFromGallery": MessageLookupByLibrary.simpleMessage("從圖庫選擇"),
    "photoMightNotBeReal": MessageLookupByLibrary.simpleMessage("這張照片可能不是真實的"),
    "photos": MessageLookupByLibrary.simpleMessage("照片"),
    "piscesSign": MessageLookupByLibrary.simpleMessage("雙魚座"),
    "played_audio": MessageLookupByLibrary.simpleMessage("播放了音頻"),
    "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
        MessageLookupByLibrary.simpleMessage("請檢查網路或點擊刷新重試"),
    "please_write_feelings": MessageLookupByLibrary.simpleMessage("請寫下你的感受"),
    "plusBenefitActivityReminder": MessageLookupByLibrary.simpleMessage(
      "對方活躍/回流提醒",
    ),
    "plusBenefitActivitySort": MessageLookupByLibrary.simpleMessage(
      "最近活躍/回覆率排序",
    ),
    "plusBenefitAdvancedFilter": MessageLookupByLibrary.simpleMessage(
      "高級篩選：國家/語言/時區/城市",
    ),
    "plusBenefitAntiHarassment": MessageLookupByLibrary.simpleMessage(
      "反騷擾優先攔截與權重保護",
    ),
    "plusBenefitConflictAdvice": MessageLookupByLibrary.simpleMessage(
      "衝突與建議：矛盾點提示+相處建議",
    ),
    "plusBenefitDestinyPriority": MessageLookupByLibrary.simpleMessage(
      "命定優先曝光：在推薦、喜歡我的排序靠前",
    ),
    "plusBenefitDestinyPush": MessageLookupByLibrary.simpleMessage("新命定到達推送"),
    "plusBenefitDimensionBreakdown": MessageLookupByLibrary.simpleMessage(
      "維度拆解：性格/溝通/親密/邊界4大維度",
    ),
    "plusBenefitHighMatchDisplay": MessageLookupByLibrary.simpleMessage(
      "高匹配標識與百分比展示",
    ),
    "plusBenefitHistoryTranslation": MessageLookupByLibrary.simpleMessage(
      "歷史消息一鍵翻譯",
    ),
    "plusBenefitInterestFilter": MessageLookupByLibrary.simpleMessage(
      "興趣與出行計劃篩選",
    ),
    "plusBenefitLikeReminder": MessageLookupByLibrary.simpleMessage(
      "被回讚/已讀未回/回覆窗口提醒",
    ),
    "plusBenefitMatchScore": MessageLookupByLibrary.simpleMessage(
      "速配分數：整體匹配分可視化",
    ),
    "plusBenefitMessageTemplates": MessageLookupByLibrary.simpleMessage(
      "快捷消息模板（讚美/邀約/換平台）",
    ),
    "plusBenefitOCRTranslation": MessageLookupByLibrary.simpleMessage(
      "圖片即時翻譯/文本識別（OCR+翻譯）",
    ),
    "plusBenefitRealTimeTranslation": MessageLookupByLibrary.simpleMessage(
      "實時翻譯與潤色：多語言自動糾錯與本地化語氣",
    ),
    "plusBenefitSmartOpener": MessageLookupByLibrary.simpleMessage(
      "智能開場白：每人3條高轉化開場建議",
    ),
    "plusBenefitStarGreeting": MessageLookupByLibrary.simpleMessage(
      "星語問候包：每日10次一鍵問候",
    ),
    "plusBenefitSupportChannel": MessageLookupByLibrary.simpleMessage(
      "訂閱問題處理加速通道",
    ),
    "plusBenefitTopicPool": MessageLookupByLibrary.simpleMessage(
      "續聊話題池：基於對方畫像動態生成",
    ),
    "plusBenefitUnlockLikedMe": MessageLookupByLibrary.simpleMessage(
      "解鎖喜歡我的清晰頭像與標籤",
    ),
    "plusDescTitle": MessageLookupByLibrary.simpleMessage("Plus描述"),
    "plusFuncAIInterpretation": MessageLookupByLibrary.simpleMessage(
      "每天1000條AI傳譯",
    ),
    "plusFuncAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "Zena Tips - 你的聊天參謀",
    ),
    "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage("每週5次DM"),
    "plusFuncFilterMatchingCountries": MessageLookupByLibrary.simpleMessage(
      "篩選連接的國家",
    ),
    "plusFuncUnlimitedLikes": MessageLookupByLibrary.simpleMessage("無限點讚"),
    "plusFuncUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "解鎖查看誰欣賞你的分享",
    ),
    "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3個心願"),
    "plusMember": MessageLookupByLibrary.simpleMessage("Plus 會員"),
    "plusMembershipBenefits": MessageLookupByLibrary.simpleMessage("Plus會員權益"),
    "plusPerkDuoSnap": MessageLookupByLibrary.simpleMessage("Plus雙人快照"),
    "practice_count": MessageLookupByLibrary.simpleMessage("練習次數"),
    "preference": MessageLookupByLibrary.simpleMessage("偏好"),
    "privacy": MessageLookupByLibrary.simpleMessage("隱私"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("隱私政策"),
    "productNotFound": MessageLookupByLibrary.simpleMessage("상품을 찾을 수 없음"),
    "profileInfoTab": MessageLookupByLibrary.simpleMessage("資料"),
    "profileNotShown": MessageLookupByLibrary.simpleMessage("TA還沒有展示真容"),
    "profileTip": MessageLookupByLibrary.simpleMessage("✨ 完善資料讓星星更了解你，匹配更精準"),
    "psychological_healing": MessageLookupByLibrary.simpleMessage("心理療癒"),
    "purchaseFailed": MessageLookupByLibrary.simpleMessage("購買失敗"),
    "purchasePending": MessageLookupByLibrary.simpleMessage("購買處理中..."),
    "pushNotifications": MessageLookupByLibrary.simpleMessage("推送通知"),
    "quickActions": MessageLookupByLibrary.simpleMessage("快捷操作"),
    "quote_1": MessageLookupByLibrary.simpleMessage("今天的你，閃耀如星"),
    "quote_10": MessageLookupByLibrary.simpleMessage("在寧靜中尋找內心的答案"),
    "quote_2": MessageLookupByLibrary.simpleMessage("相信自己，如同相信星座的指引"),
    "quote_3": MessageLookupByLibrary.simpleMessage("每個人都是獨一無二的星座組合"),
    "quote_4": MessageLookupByLibrary.simpleMessage("宇宙的能量與你同在"),
    "quote_5": MessageLookupByLibrary.simpleMessage("接納當下的自己，你已經很好了"),
    "quote_6": MessageLookupByLibrary.simpleMessage("每一種情緒都值得被看見"),
    "quote_7": MessageLookupByLibrary.simpleMessage("深呼吸，讓星辰的力量流經你的身體"),
    "quote_8": MessageLookupByLibrary.simpleMessage("今天是嶄新的一天，充滿無限可能"),
    "quote_9": MessageLookupByLibrary.simpleMessage("你的存在本身就是一種奇蹟"),
    "quotes_subtitle": MessageLookupByLibrary.simpleMessage("來自星座的治癒能量"),
    "record_daily_status": MessageLookupByLibrary.simpleMessage("記錄今日狀態"),
    "record_today_hint": MessageLookupByLibrary.simpleMessage("今天有什麼想記錄的嗎？"),
    "record_your_feelings": MessageLookupByLibrary.simpleMessage("記錄你的感受"),
    "recorded_days": MessageLookupByLibrary.simpleMessage("記錄天數"),
    "recorded_emotion": MessageLookupByLibrary.simpleMessage("記錄了情緒"),
    "relaxation_category": MessageLookupByLibrary.simpleMessage("放鬆"),
    "remindUploadPhoto": MessageLookupByLibrary.simpleMessage(
      "📸 提醒TA上傳照片，讓彼此更了解",
    ),
    "report": MessageLookupByLibrary.simpleMessage("舉報"),
    "reportOptionGore": MessageLookupByLibrary.simpleMessage("血腥"),
    "reportOptionOther": MessageLookupByLibrary.simpleMessage("其他"),
    "reportOptionPerAstroLearnlAttack": MessageLookupByLibrary.simpleMessage(
      "人身攻擊",
    ),
    "reportOptionPersonalAttack": MessageLookupByLibrary.simpleMessage("人身攻擊"),
    "reportOptionPornography": MessageLookupByLibrary.simpleMessage("色情"),
    "reportOptionScam": MessageLookupByLibrary.simpleMessage("詐騙"),
    "requireYourRealPhoto": MessageLookupByLibrary.simpleMessage("我們需要你的真實照片"),
    "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
      "優先展示附近的外國人",
    ),
    "sagittariusSign": MessageLookupByLibrary.simpleMessage("射手座"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "save_failed": m11,
    "scorpioSign": MessageLookupByLibrary.simpleMessage("天蠍座"),
    "screenshotEvidence": MessageLookupByLibrary.simpleMessage("截圖證據"),
    "seeProfile": MessageLookupByLibrary.simpleMessage("查看個人資料"),
    "seeWhoLikeU": MessageLookupByLibrary.simpleMessage("看看誰欣賞你"),
    "selectBirthPlace": MessageLookupByLibrary.simpleMessage("출생지 선택"),
    "selectBirthdayHint": MessageLookupByLibrary.simpleMessage("請選擇出生日期查看您的星盤"),
    "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage("選擇國家"),
    "selectLocationTitle": MessageLookupByLibrary.simpleMessage("選擇地點"),
    "select_duration_start": MessageLookupByLibrary.simpleMessage("選擇時長，開始冥想"),
    "select_meditation_duration": MessageLookupByLibrary.simpleMessage(
      "選擇冥想時長",
    ),
    "sendDm": MessageLookupByLibrary.simpleMessage("發送私訊"),
    "sendDmRemark": MessageLookupByLibrary.simpleMessage("發送DM消息"),
    "sendStarGreetingToUnlockAlbum": MessageLookupByLibrary.simpleMessage(
      "💫 發送星語問候解鎖相冊 繼續",
    ),
    "setDefault": MessageLookupByLibrary.simpleMessage("設定預設"),
    "setInterestTags": MessageLookupByLibrary.simpleMessage("設置清晰的興趣標籤"),
    "settings": MessageLookupByLibrary.simpleMessage("設定"),
    "showYourPerAstroLearnlity": MessageLookupByLibrary.simpleMessage("展現你的個性"),
    "showYourPersonality": MessageLookupByLibrary.simpleMessage("展現你的個性"),
    "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage("即將完成"),
    "sixMonths": MessageLookupByLibrary.simpleMessage("6個月"),
    "sleep_category": MessageLookupByLibrary.simpleMessage("睡眠"),
    "speakSameLanguage": MessageLookupByLibrary.simpleMessage("🤝 同語無需譯,靈犀一點通"),
    "spiritual_growth": MessageLookupByLibrary.simpleMessage("心靈成長"),
    "standard": MessageLookupByLibrary.simpleMessage("標準"),
    "startChat": MessageLookupByLibrary.simpleMessage("開聊"),
    "start_meditation": MessageLookupByLibrary.simpleMessage("開始冥想"),
    "startedChat": MessageLookupByLibrary.simpleMessage("開始與聊天"),
    "status_saved": MessageLookupByLibrary.simpleMessage("✅ 狀態已保存"),
    "stop_meditation": MessageLookupByLibrary.simpleMessage("停止冥想"),
    "streak_days": MessageLookupByLibrary.simpleMessage("連續打卡"),
    "streak_x_days": m12,
    "stress": MessageLookupByLibrary.simpleMessage("壓力"),
    "stress_index": MessageLookupByLibrary.simpleMessage("壓力指數"),
    "stress_level": MessageLookupByLibrary.simpleMessage("壓力水平"),
    "subPageSubtitleAIInterpretationDaily":
        MessageLookupByLibrary.simpleMessage("每天1000條\nAI傳譯"),
    "subPageSubtitleAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "Zena Tips - \n你的聊天參謀",
    ),
    "subPageSubtitleDMWeekly": MessageLookupByLibrary.simpleMessage("每週5次DM"),
    "subPageSubtitleFilterMatchingCountries":
        MessageLookupByLibrary.simpleMessage("篩選連接的\n國家"),
    "subPageSubtitleUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "無限點讚",
    ),
    "subPageSubtitleUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "解鎖查看\n誰欣賞你",
    ),
    "subPageTitle": MessageLookupByLibrary.simpleMessage("取得Zena Plus"),
    "subscriptionAgreement": MessageLookupByLibrary.simpleMessage("條款"),
    "subscriptionAgreementPrefix": m13,
    "subscriptionAgreementSuffix": MessageLookupByLibrary.simpleMessage("。"),
    "sunSignLabel": MessageLookupByLibrary.simpleMessage("태양 별자리"),
    "synastryAnalysis": MessageLookupByLibrary.simpleMessage("合盤分析"),
    "takeIt": MessageLookupByLibrary.simpleMessage("使用"),
    "taurusSign": MessageLookupByLibrary.simpleMessage("金牛座"),
    "termsOfService": MessageLookupByLibrary.simpleMessage("服務條款"),
    "theKeyIsBalance": MessageLookupByLibrary.simpleMessage("關鍵是平衡"),
    "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
      "👆 在等你的回答喲",
    ),
    "threeMonths": MessageLookupByLibrary.simpleMessage("3個月"),
    "toastHitDailyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👀已達到今日限額",
    ),
    "toastHitWeeklyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👅你已達到本週限額",
    ),
    "toggle_background_music": MessageLookupByLibrary.simpleMessage(
      "開啟/關閉背景音樂",
    ),
    "total_duration": MessageLookupByLibrary.simpleMessage("總時長"),
    "unknownLocation": MessageLookupByLibrary.simpleMessage("未知"),
    "unlockDailyHoroscope": MessageLookupByLibrary.simpleMessage("獲取詳細星座運勢解讀"),
    "unlockHighMatchUsers": m14,
    "unlockMoonPhaseInsight": MessageLookupByLibrary.simpleMessage(
      "解鎖今日月相能量解讀",
    ),
    "unlockUsersWithDestiny": m15,
    "unmissableSpecialOfferPrices": MessageLookupByLibrary.simpleMessage(
      "不容錯過的特價",
    ),
    "unsupportedPlatform": MessageLookupByLibrary.simpleMessage("지원되지 않는 플랫폼"),
    "upgradeForMoreRecommendations": MessageLookupByLibrary.simpleMessage(
      "開通會員獲得更多推薦",
    ),
    "uploadQualityPhotos": MessageLookupByLibrary.simpleMessage("上傳高品質的真實照片"),
    "uploadYourPhoto": MessageLookupByLibrary.simpleMessage("上傳你的照片"),
    "uploadYourPhotoHint": MessageLookupByLibrary.simpleMessage("上傳你最好的照片"),
    "uploading": MessageLookupByLibrary.simpleMessage("上傳中..."),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage("使用當前位置"),
    "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage("拍照"),
    "userAvatarOptionGallery": MessageLookupByLibrary.simpleMessage("從圖庫選擇"),
    "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
      "一張好的肖像可以幫助你與更多傾聽者建立連接。请使用真實照片。",
    ),
    "userAvatarPageTitle": MessageLookupByLibrary.simpleMessage("展現你的自信"),
    "userAvatarUploadedLabel": MessageLookupByLibrary.simpleMessage("上傳搞定！"),
    "userBirthdayInputLabel": MessageLookupByLibrary.simpleMessage("出生日期"),
    "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "一旦確認，國籍無法更改",
    ),
    "userCitizenshipPickerTitle": MessageLookupByLibrary.simpleMessage("國籍"),
    "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("性別"),
    "userGenderOptionFemale": MessageLookupByLibrary.simpleMessage("女性"),
    "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("男性"),
    "userGenderOptionNonBinary": MessageLookupByLibrary.simpleMessage("非二元性別"),
    "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "您的性別不會公開顯示，僅用於幫助建立連接",
    ),
    "userInfoPageNamePlaceholder": MessageLookupByLibrary.simpleMessage("輸入"),
    "userInfoPageTitle": MessageLookupByLibrary.simpleMessage("基本資訊"),
    "userNameInputLabel": MessageLookupByLibrary.simpleMessage("名稱"),
    "userPhoneNumberPagePlaceholder": MessageLookupByLibrary.simpleMessage(
      "電話號碼",
    ),
    "userPhoneNumberPagePrivacySuffix": MessageLookupByLibrary.simpleMessage(
      " ",
    ),
    "userPhoneNumberPagePrivacyText": MessageLookupByLibrary.simpleMessage(
      "隱私政策",
    ),
    "userPhoneNumberPageTermsAnd": MessageLookupByLibrary.simpleMessage("和"),
    "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
      "點擊“下一步”，即表示您同意我們的",
    ),
    "userPhoneNumberPageTermsText": MessageLookupByLibrary.simpleMessage(
      "服務條款",
    ),
    "userPhoneNumberPageTitle": MessageLookupByLibrary.simpleMessage("請輸入電話號碼"),
    "valuesCompatibility": MessageLookupByLibrary.simpleMessage("價值觀"),
    "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage("輸入驗證碼"),
    "viewAstroReport": MessageLookupByLibrary.simpleMessage("查看與的星盤合盤"),
    "view_details": MessageLookupByLibrary.simpleMessage("查看詳情"),
    "virgoSign": MessageLookupByLibrary.simpleMessage("處女座"),
    "waning_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "殘月時刻，休息和恢復很重要",
    ),
    "waning_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "月亮漸虧，適合反思和整理",
    ),
    "wannaHollaAt": MessageLookupByLibrary.simpleMessage("你願意分享嗎…"),
    "warningCancelDisplayCity": MessageLookupByLibrary.simpleMessage(
      "關閉後，你的城市不會在匹配時顯示",
    ),
    "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
      "您的帳戶將在14天後自動刪除。請記得去商店取消您目前的訂閱，以避免額外的費用。",
    ),
    "warningDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "如果您刪除帳戶，將無法再用它登入。您確定要刪除嗎？",
    ),
    "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
      "外部連結。點擊前請確認來源可靠，因為不明連結可能是詐騙或竊取數據。謹慎行事。",
    ),
    "warningTitleCaution": MessageLookupByLibrary.simpleMessage("注意"),
    "warningUnmatching": MessageLookupByLibrary.simpleMessage(
      "結束分享後，你們之間的對話內容都將被清除。",
    ),
    "waxing_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "月亮漸盈，能量逐漸積累",
    ),
    "waxing_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "滿月將至，情緒可能更加敏感",
    ),
    "whatsYourEmail": MessageLookupByLibrary.simpleMessage("你的郵箱是什麼？"),
    "whoLIkesYou": MessageLookupByLibrary.simpleMessage("誰欣賞你的分享"),
    "whoLikesU": MessageLookupByLibrary.simpleMessage("誰欣賞你"),
    "wishActivityAddTitle": MessageLookupByLibrary.simpleMessage("加入你的想法"),
    "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "幫你找到小夥伴",
    ),
    "wishActivityPickerTitle": MessageLookupByLibrary.simpleMessage(
      "有什麼特別想做的事嗎？",
    ),
    "wishCityPickerSkipButton": m16,
    "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "如果你去那裡，你想去哪些城市？",
    ),
    "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage(
      "你 對哪個國家更感興趣？",
    ),
    "wishCreationComplete": MessageLookupByLibrary.simpleMessage("已收到你的心願!"),
    "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("已經在這了"),
    "wishDateOptionNotSure": MessageLookupByLibrary.simpleMessage("還不確定喲"),
    "wishDateOptionRecent": MessageLookupByLibrary.simpleMessage("近期吧，大概"),
    "wishDateOptionYear": MessageLookupByLibrary.simpleMessage("一年內"),
    "wishDatePickerSubtitle": m17,
    "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("何時"),
    "wishList": MessageLookupByLibrary.simpleMessage("心願單"),
    "wishes": MessageLookupByLibrary.simpleMessage("心願"),
    "writeInterestingBio": MessageLookupByLibrary.simpleMessage("寫一個有趣的個人簡介"),
    "write_feelings_hint": MessageLookupByLibrary.simpleMessage("寫下此刻的感受..."),
    "x_days": m18,
    "x_hours": m19,
    "x_times": m20,
    "youAreAClubMemberNow": MessageLookupByLibrary.simpleMessage("你現在是俱樂部會員了"),
    "youCanEditItAnytime": MessageLookupByLibrary.simpleMessage("你可以隨時編輯"),
    "youSeemCool": MessageLookupByLibrary.simpleMessage("你看起來很酷。"),
  };
}
