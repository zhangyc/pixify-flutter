// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
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
  String get localeName => 'zh_CN';

  static String m0(month, day) => "${month}月${day}日";

  static String m1(x) => "距离30天目标还有 ${x} 次";

  static String m2(error) => "获取运势失败: ${error}";

  static String m3(something) => "\"我对${something}感兴趣~\"";

  static String m4(something) => "我对「${something}」非常感兴趣！";

  static String m5(lang) => "只需输入${lang}";

  static String m6(gender) =>
      "${Intl.gender(gender, female: '她', male: '他', other: '他们')}的哪些分享经历让你有共鸣？";

  static String m7(minutes) => "${minutes} 分钟";

  static String m8(month, day) => "${month}月${day}日";

  static String m9(score) => "心情 ${score}/10";

  static String m10(error) => "获取月相解读失败: ${error}";

  static String m11(error) => "❌ 保存失败：${error}";

  static String m12(x) => "🔥 连续记录 ${x} 天！";

  static String m13(storeName) =>
      "点击“继续”后你会被收取费用，您的订阅将按对应套餐价格自动续订，您可以通过${storeName}取消，继续代表您同意我们的";

  static String m14(count) => "解锁查看${count}个高匹配用户 ✨";

  static String m15(count, destinyCount) =>
      "解锁${count}个用户，包含${destinyCount}个命定匹配 ⭐";

  static String m16(country) => "跳过,就${country}";

  static String m17(country) => "有计划去${country}吗";

  static String m18(x) => "${x}天";

  static String m19(x) => "${x}小时";

  static String m20(x) => "${x}次";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aMonth": MessageLookupByLibrary.simpleMessage("1个月"),
    "aYear": MessageLookupByLibrary.simpleMessage("1年"),
    "about": MessageLookupByLibrary.simpleMessage("关于"),
    "account": MessageLookupByLibrary.simpleMessage("账户"),
    "active_days": MessageLookupByLibrary.simpleMessage("活跃天数"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("添加照片"),
    "age": MessageLookupByLibrary.simpleMessage("年龄"),
    "aiCreatingFunGroupPics": MessageLookupByLibrary.simpleMessage(
      "AI正在创建有趣的群组照片",
    ),
    "allPeople": MessageLookupByLibrary.simpleMessage("所有人"),
    "analyzingDailyHoroscope": MessageLookupByLibrary.simpleMessage(
      "正在解读今日运势...",
    ),
    "analyzingMoonPhase": MessageLookupByLibrary.simpleMessage("正在解读月相能量..."),
    "analyzingText": MessageLookupByLibrary.simpleMessage("분석 중..."),
    "aquariusSign": MessageLookupByLibrary.simpleMessage("水瓶座"),
    "ariesSign": MessageLookupByLibrary.simpleMessage("白羊座"),
    "ascendantSignLabel": MessageLookupByLibrary.simpleMessage("上升星座"),
    "astroChartTab": MessageLookupByLibrary.simpleMessage("星盘"),
    "astroInfoIncompleteMessage": MessageLookupByLibrary.simpleMessage(
      "对方尚未完善出生地信息，暂时无法生成星盘分析。请期待对方完善信息后查看。",
    ),
    "astroLearnInterpretationOff": MessageLookupByLibrary.simpleMessage(
      "⭕ Zena传译已关闭",
    ),
    "astroLearnRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
      "Zena推荐：冷却中\n怎么办：等等\n建议：看看小破站？",
    ),
    "astroLearnWillGenerateABioBasedOnInterests":
        MessageLookupByLibrary.simpleMessage("Zena会根据你的兴趣生成一份简介"),
    "astroReport": MessageLookupByLibrary.simpleMessage("合盘"),
    "astro_calendar_title": MessageLookupByLibrary.simpleMessage("星盘疗愈日历"),
    "audio_1_desc": MessageLookupByLibrary.simpleMessage("在宁静的星空下，找到内心的平静"),
    "audio_1_title": MessageLookupByLibrary.simpleMessage("星空冥想曲"),
    "audio_2_desc": MessageLookupByLibrary.simpleMessage("激发你内在的勇气与活力"),
    "audio_2_title": MessageLookupByLibrary.simpleMessage("白羊座能量音频"),
    "audio_3_desc": MessageLookupByLibrary.simpleMessage("释放压力，让身心完全放松"),
    "audio_3_title": MessageLookupByLibrary.simpleMessage("深度放松引导"),
    "audio_4_desc": MessageLookupByLibrary.simpleMessage("平衡情绪，找回内心的和谐"),
    "audio_4_title": MessageLookupByLibrary.simpleMessage("情绪平衡音乐"),
    "avatarUpdateFailed": MessageLookupByLibrary.simpleMessage("头像更新失败"),
    "average_mood": MessageLookupByLibrary.simpleMessage("平均心情"),
    "bio": MessageLookupByLibrary.simpleMessage("简介"),
    "birthInfo": MessageLookupByLibrary.simpleMessage("出生資訊"),
    "birthPlace": MessageLookupByLibrary.simpleMessage("出生地"),
    "birthPlaceLabel": MessageLookupByLibrary.simpleMessage("出生地點"),
    "birthTimeLabel": MessageLookupByLibrary.simpleMessage("出生時間"),
    "birthday": MessageLookupByLibrary.simpleMessage("生日"),
    "block": MessageLookupByLibrary.simpleMessage("屏蔽"),
    "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
        MessageLookupByLibrary.simpleMessage("屏蔽此人以免收到他们的任何消息"),
    "boostYourAppeal": MessageLookupByLibrary.simpleMessage("魅力UP!"),
    "breakIce": MessageLookupByLibrary.simpleMessage(
      "🔨🔨🔨 别在意我🔨🔨🔨 我在破冰🔨🔨🔨",
    ),
    "breathe_relax": MessageLookupByLibrary.simpleMessage("深呼吸，放松身心..."),
    "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage("你是Plus会员"),
    "buttonAuthorize": MessageLookupByLibrary.simpleMessage("授权"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("取消"),
    "buttonChange": MessageLookupByLibrary.simpleMessage("更改"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("確定"),
    "buttonContinue": MessageLookupByLibrary.simpleMessage("继续"),
    "buttonCopy": MessageLookupByLibrary.simpleMessage("复制"),
    "buttonDelete": MessageLookupByLibrary.simpleMessage("删除"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("删除账户"),
    "buttonDone": MessageLookupByLibrary.simpleMessage("完成"),
    "buttonEdit": MessageLookupByLibrary.simpleMessage("编辑"),
    "buttonEditProfile": MessageLookupByLibrary.simpleMessage("编辑资料"),
    "buttonGenerate": MessageLookupByLibrary.simpleMessage("生成"),
    "buttonGo": MessageLookupByLibrary.simpleMessage("开始"),
    "buttonGotIt": MessageLookupByLibrary.simpleMessage("明白了"),
    "buttonHitAIInterpretationMaximumLimit":
        MessageLookupByLibrary.simpleMessage("😪Zena累了，👇点击给她加油！"),
    "buttonJoinNow": MessageLookupByLibrary.simpleMessage("立即加入"),
    "buttonKeepAccount": MessageLookupByLibrary.simpleMessage("保留账户"),
    "buttonManage": MessageLookupByLibrary.simpleMessage("管理"),
    "buttonNext": MessageLookupByLibrary.simpleMessage("下一步"),
    "buttonOpenLink": MessageLookupByLibrary.simpleMessage("打开链接"),
    "buttonPreview": MessageLookupByLibrary.simpleMessage("预览"),
    "buttonPurchase": MessageLookupByLibrary.simpleMessage("购买"),
    "buttonRefresh": MessageLookupByLibrary.simpleMessage("刷新"),
    "buttonResend": MessageLookupByLibrary.simpleMessage("重发"),
    "buttonRestore": MessageLookupByLibrary.simpleMessage("恢复"),
    "buttonSave": MessageLookupByLibrary.simpleMessage("保存"),
    "buttonSignOut": MessageLookupByLibrary.simpleMessage("退出"),
    "buttonSubmit": MessageLookupByLibrary.simpleMessage("提交"),
    "buttonUnlockVipPerks": MessageLookupByLibrary.simpleMessage("解锁VIP特权"),
    "buttonUnmatch": MessageLookupByLibrary.simpleMessage("结束分享"),
    "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("取消订阅"),
    "cancerSign": MessageLookupByLibrary.simpleMessage("巨蟹座"),
    "capricornSign": MessageLookupByLibrary.simpleMessage("摩羯座"),
    "catchMore": MessageLookupByLibrary.simpleMessage("抓住更多"),
    "charmTips": MessageLookupByLibrary.simpleMessage("提升魅力小贴士"),
    "chartPreview": MessageLookupByLibrary.simpleMessage("星盘预览"),
    "chat": MessageLookupByLibrary.simpleMessage("聊天"),
    "chatWithMatches": MessageLookupByLibrary.simpleMessage("主动与匹配的用户聊天"),
    "checkItOut": MessageLookupByLibrary.simpleMessage("来看看"),
    "checkOutTheirProfiles": MessageLookupByLibrary.simpleMessage("看看都是谁"),
    "choosePlaceholder": MessageLookupByLibrary.simpleMessage("选择"),
    "clickToSetBirthPlace": MessageLookupByLibrary.simpleMessage("點擊設置出生地"),
    "clickToSetBirthday": MessageLookupByLibrary.simpleMessage("點擊設置生日"),
    "click_for_encouragement": MessageLookupByLibrary.simpleMessage("点击我获得鼓励"),
    "click_to_record_status": MessageLookupByLibrary.simpleMessage("点击记录今日状态"),
    "closeButtonText": MessageLookupByLibrary.simpleMessage("關閉"),
    "clubFeeJoking": MessageLookupByLibrary.simpleMessage("开玩笑！免费的"),
    "clubFeePrefix": MessageLookupByLibrary.simpleMessage("俱乐部费用：\$99/月"),
    "clubPromotionContent": MessageLookupByLibrary.simpleMessage(
      "加入我们的专属俱乐部享受精彩福利",
    ),
    "clubPromotionTitle": MessageLookupByLibrary.simpleMessage("加入俱乐部"),
    "commonLanguage": MessageLookupByLibrary.simpleMessage("主要语言"),
    "commonLanguageTitle": MessageLookupByLibrary.simpleMessage("常用语言"),
    "communicationCompatibility": MessageLookupByLibrary.simpleMessage("沟通"),
    "compatibilityScore": MessageLookupByLibrary.simpleMessage("契合度"),
    "completeAstroInfo": MessageLookupByLibrary.simpleMessage("完善详细的星盘信息"),
    "completeAstroProfile": MessageLookupByLibrary.simpleMessage("完善你的星盘资料"),
    "completeAstroProfileButton": MessageLookupByLibrary.simpleMessage(
      "完善星盘资料",
    ),
    "completeBirthLocationInfo": MessageLookupByLibrary.simpleMessage(
      "請完善出生地資訊",
    ),
    "completeProfile": MessageLookupByLibrary.simpleMessage("完善资料"),
    "confirmSelectLocation": MessageLookupByLibrary.simpleMessage("确认选择此地点"),
    "continueWithPhone": MessageLookupByLibrary.simpleMessage("使用手机继续"),
    "currentSelectedCoordinates": MessageLookupByLibrary.simpleMessage(
      "当前选择的坐标",
    ),
    "current_emotion": MessageLookupByLibrary.simpleMessage("此刻的情绪"),
    "dailyHoroscope": MessageLookupByLibrary.simpleMessage("每日运势"),
    "dailyHoroscopeAnalysis": MessageLookupByLibrary.simpleMessage("每日运势分析"),
    "dailyHoroscopeAnalysisRemark": MessageLookupByLibrary.simpleMessage(
      "每日运势解读",
    ),
    "dailyHoroscopeTitle": MessageLookupByLibrary.simpleMessage("每日运势"),
    "daily_quote": MessageLookupByLibrary.simpleMessage("今日心语"),
    "daily_quotes_title": MessageLookupByLibrary.simpleMessage("每日心语"),
    "daily_status": MessageLookupByLibrary.simpleMessage("每日状态"),
    "date_format_md": m0,
    "days_to_30_goal": m1,
    "deepAnalysisReportTitle": MessageLookupByLibrary.simpleMessage("深度AI分析報告"),
    "deepSynastryAnalysis": MessageLookupByLibrary.simpleMessage("深度分析"),
    "deepSynastryRemark": MessageLookupByLibrary.simpleMessage("深度合盘分析"),
    "defaultBirthTime": MessageLookupByLibrary.simpleMessage("12:00 (預設)"),
    "deletePhoto": MessageLookupByLibrary.simpleMessage("删除照片"),
    "deletePhotoContent": MessageLookupByLibrary.simpleMessage(
      "确定要删除这张照片吗？此操作无法撤销。",
    ),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage("描述（可选）"),
    "destinyMatch": MessageLookupByLibrary.simpleMessage("命定"),
    "diamondConsumeFailed": MessageLookupByLibrary.simpleMessage("钻石消费失败"),
    "diamondInsufficient": MessageLookupByLibrary.simpleMessage("钻石不足"),
    "diamondPack1": MessageLookupByLibrary.simpleMessage("钻石礼包"),
    "diamondPack2": MessageLookupByLibrary.simpleMessage("钻石宝箱"),
    "diamondPack3": MessageLookupByLibrary.simpleMessage("钻石豪礼"),
    "diamondPack4": MessageLookupByLibrary.simpleMessage("钻石大礼包"),
    "diamondPack5": MessageLookupByLibrary.simpleMessage("钻石至尊礼包"),
    "diamondStore": MessageLookupByLibrary.simpleMessage("钻石商店"),
    "diamondStoreSubtitle": MessageLookupByLibrary.simpleMessage("解锁钻石商店特权功能"),
    "diamondStoreTitle": MessageLookupByLibrary.simpleMessage("钻石商店"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("免责声明"),
    "displayMyCity": MessageLookupByLibrary.simpleMessage("显示我的城市"),
    "dm": MessageLookupByLibrary.simpleMessage("超级私信"),
    "duoSnap": MessageLookupByLibrary.simpleMessage("双人快照"),
    "duosnapAnyway": MessageLookupByLibrary.simpleMessage("无论如何都要双人快照"),
    "editProfile": MessageLookupByLibrary.simpleMessage("编辑资料"),
    "emotion_analysis": MessageLookupByLibrary.simpleMessage("情绪分析"),
    "emotion_angry": MessageLookupByLibrary.simpleMessage("😠 愤怒"),
    "emotion_anxious": MessageLookupByLibrary.simpleMessage("😰 焦虑"),
    "emotion_calm": MessageLookupByLibrary.simpleMessage("😌 平静"),
    "emotion_category": MessageLookupByLibrary.simpleMessage("情绪"),
    "emotion_diary": MessageLookupByLibrary.simpleMessage("情绪日记"),
    "emotion_diary_saved": MessageLookupByLibrary.simpleMessage("✅ 情绪日记已保存"),
    "emotion_diary_title": MessageLookupByLibrary.simpleMessage("情绪日记"),
    "emotion_distribution": MessageLookupByLibrary.simpleMessage("情绪分布"),
    "emotion_happy": MessageLookupByLibrary.simpleMessage("😊 开心"),
    "emotion_management": MessageLookupByLibrary.simpleMessage("情绪管理"),
    "emotion_management_title": MessageLookupByLibrary.simpleMessage("情绪管理"),
    "emotion_records": MessageLookupByLibrary.simpleMessage("情绪记录"),
    "emotion_sad": MessageLookupByLibrary.simpleMessage("😢 难过"),
    "emotion_subtitle": MessageLookupByLibrary.simpleMessage("了解你的情绪，学会与自己相处"),
    "emotion_tip": MessageLookupByLibrary.simpleMessage(
      "接纳当下的自己，情绪如同星辰流转，终将归于平静",
    ),
    "emotion_tired": MessageLookupByLibrary.simpleMessage("😴 疲惫"),
    "emotionalCompatibility": MessageLookupByLibrary.simpleMessage("情感"),
    "emptyChatRoomMessage": MessageLookupByLibrary.simpleMessage(
      "你的专属聊天室还是空的\n但星星知道，对的人正在向你走来",
    ),
    "energy": MessageLookupByLibrary.simpleMessage("能量"),
    "energy_category": MessageLookupByLibrary.simpleMessage("能量"),
    "energy_index": MessageLookupByLibrary.simpleMessage("能量指数"),
    "energy_level": MessageLookupByLibrary.simpleMessage("能量水平"),
    "enterBirthPlace": MessageLookupByLibrary.simpleMessage("請輸入出生地"),
    "every_emotion_matters": MessageLookupByLibrary.simpleMessage(
      "每一种情绪都值得被看见和记录",
    ),
    "exceptionAstroLearnContentFilterTips":
        MessageLookupByLibrary.simpleMessage("未发送。Zena不会翻译违禁词。"),
    "exceptionAstroLearnOverloadedTips": MessageLookupByLibrary.simpleMessage(
      "Zena过载，请稍后再试。",
    ),
    "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
      "发送失败，请稍后再试。",
    ),
    "fateOnTheWay": MessageLookupByLibrary.simpleMessage("缘分正在路上"),
    "feedback": MessageLookupByLibrary.simpleMessage("反馈"),
    "filter": MessageLookupByLibrary.simpleMessage("筛选"),
    "findingFolksWhoShareYourInterests": MessageLookupByLibrary.simpleMessage(
      "找到与你有共同兴趣的人",
    ),
    "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
      "Zena正在寻找一些潜在的朋友...",
    ),
    "first_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "上弦月，是行动和决策的好时机",
    ),
    "friendsIntention": MessageLookupByLibrary.simpleMessage(
      "嘿，我觉得你很棒。我们聊聊怎么样？",
    ),
    "full_moon_insight": MessageLookupByLibrary.simpleMessage("满月能量最强，适合释放情绪"),
    "futureCompatibility": MessageLookupByLibrary.simpleMessage("未来"),
    "geminiSign": MessageLookupByLibrary.simpleMessage("双子座"),
    "getAstroLearnPlus": MessageLookupByLibrary.simpleMessage("获取Zena Plus"),
    "gifNotAllowed": MessageLookupByLibrary.simpleMessage("GIF文件不允许"),
    "goDiscover": MessageLookupByLibrary.simpleMessage("去发现"),
    "gotIt": MessageLookupByLibrary.simpleMessage("明白了"),
    "great_keep_going": MessageLookupByLibrary.simpleMessage("你真棒！继续保持 ✨"),
    "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
      "嘿，猜猜谁会先打破沉默？",
    ),
    "haveAstroLearnSayHi": MessageLookupByLibrary.simpleMessage("让Zena打招呼"),
    "healing_calendar_title": MessageLookupByLibrary.simpleMessage("星盘疗愈日历"),
    "healing_category": MessageLookupByLibrary.simpleMessage("疗愈"),
    "healing_count": MessageLookupByLibrary.simpleMessage("疗愈次数"),
    "healing_data": MessageLookupByLibrary.simpleMessage("疗愈数据"),
    "healing_music_title": MessageLookupByLibrary.simpleMessage("疗愈音乐"),
    "healing_sessions": MessageLookupByLibrary.simpleMessage("疗愈次数"),
    "hereAstroLearnCookedUpForU": MessageLookupByLibrary.simpleMessage(
      "这是Zena为你特制的",
    ),
    "horoscopeAnalysisError": m2,
    "horoscopeFetchFailed": MessageLookupByLibrary.simpleMessage("获取运势失败"),
    "horoscopeRemark": MessageLookupByLibrary.simpleMessage("每日运势解读"),
    "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage("你觉得AI传译怎么样?"),
    "iDigYourEnergy": MessageLookupByLibrary.simpleMessage("我喜欢你的活力！"),
    "iLikeYourStyle": MessageLookupByLibrary.simpleMessage("我喜欢你的风格！"),
    "imInterestedSomething": m3,
    "imVeryInterestedInSomething": m4,
    "incompleteBirthdayInfo": MessageLookupByLibrary.simpleMessage("用户生日信息不完整"),
    "infoIncompleteTitle": MessageLookupByLibrary.simpleMessage("信息不完整"),
    "intellectualCompatibility": MessageLookupByLibrary.simpleMessage("智力"),
    "interests": MessageLookupByLibrary.simpleMessage("兴趣"),
    "interpretationOff": MessageLookupByLibrary.simpleMessage("AI传译：关"),
    "interpretationOn": MessageLookupByLibrary.simpleMessage("AI传译：开"),
    "issues": MessageLookupByLibrary.simpleMessage("问题"),
    "justNow": MessageLookupByLibrary.simpleMessage("刚刚"),
    "justSendALike": MessageLookupByLibrary.simpleMessage("就分享你的欣赏"),
    "justTypeInYourLanguage": m5,
    "keep_it_up": MessageLookupByLibrary.simpleMessage("坚持就是胜利，继续加油 ✨"),
    "last_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "下弦月，放下过去，准备新开始",
    ),
    "leoSign": MessageLookupByLibrary.simpleMessage("狮子座"),
    "letAstroLearnSayHiForYou": MessageLookupByLibrary.simpleMessage(
      "让Zena帮你打招呼",
    ),
    "libraSign": MessageLookupByLibrary.simpleMessage("天秤座"),
    "lifestyleCompatibility": MessageLookupByLibrary.simpleMessage("生活"),
    "lightAnalysisTitle": MessageLookupByLibrary.simpleMessage("輕度AI分析"),
    "lightSynastryRemark": MessageLookupByLibrary.simpleMessage("合盘分析"),
    "likeBack": MessageLookupByLibrary.simpleMessage("回赞"),
    "likedBack": MessageLookupByLibrary.simpleMessage("已回赞"),
    "likedPageMonetizeButton": MessageLookupByLibrary.simpleMessage("了解他们的分享"),
    "likedPageNoData": MessageLookupByLibrary.simpleMessage(
      "状态：暂时没有欣赏哦\n\n该做什么：开始分享\n\n建议：\n真实的自拍照\n真诚的故事\n共同兴趣连接\n\n就是说...\n上传一些真实照片\n分享你的真实故事\n选择你的兴趣",
    ),
    "likedYou": MessageLookupByLibrary.simpleMessage("欣赏你的分享"),
    "loading": MessageLookupByLibrary.simpleMessage("加载中..."),
    "locationAuthorizeContent": MessageLookupByLibrary.simpleMessage(
      "我们需要您的位置来显示附近的人",
    ),
    "locationLocatedFailed": MessageLookupByLibrary.simpleMessage("获取位置失败"),
    "locationLocatedSuccess": MessageLookupByLibrary.simpleMessage("已定位到当前位置"),
    "locationPermissionRequestSubtitle": MessageLookupByLibrary.simpleMessage(
      "我们需要您的位置信息来改善您的社交体验",
    ),
    "locationPermissionRequestTitle": MessageLookupByLibrary.simpleMessage(
      "位置授权",
    ),
    "mapSelectedLocation": MessageLookupByLibrary.simpleMessage("地图选择地点"),
    "matchPageSelectIdeas": m6,
    "me": MessageLookupByLibrary.simpleMessage("我的"),
    "meditation_category": MessageLookupByLibrary.simpleMessage("冥想"),
    "meditation_count": MessageLookupByLibrary.simpleMessage("冥想次数"),
    "meditation_practice": MessageLookupByLibrary.simpleMessage("冥想练习"),
    "meditation_practice_title": MessageLookupByLibrary.simpleMessage("冥想练习"),
    "meditation_saved": MessageLookupByLibrary.simpleMessage("✅ 冥想记录已保存"),
    "meditation_subtitle": MessageLookupByLibrary.simpleMessage(
      "通过星座冥想，找到内心的平静",
    ),
    "memberCenter": MessageLookupByLibrary.simpleMessage("会员中心"),
    "membersPerks": MessageLookupByLibrary.simpleMessage("会员享受专属特权"),
    "minutes_duration": m7,
    "month": MessageLookupByLibrary.simpleMessage("月"),
    "month_day_format": m8,
    "mood": MessageLookupByLibrary.simpleMessage("心情"),
    "mood_index": MessageLookupByLibrary.simpleMessage("心情指数"),
    "mood_score": m9,
    "moonPhaseAnalysis": MessageLookupByLibrary.simpleMessage("月相分析"),
    "moonPhaseAnalysisError": m10,
    "moonPhaseAnalysisRemark": MessageLookupByLibrary.simpleMessage("月相能量解读"),
    "moonPhaseAnalysisTitle": MessageLookupByLibrary.simpleMessage("月相能量解读"),
    "moonPhaseEnergy": MessageLookupByLibrary.simpleMessage("月相能量"),
    "moonPhaseFetchFailed": MessageLookupByLibrary.simpleMessage("获取月相解读失败"),
    "moonPhaseRemark": MessageLookupByLibrary.simpleMessage("月相能量解读"),
    "morePhotosBenefit": MessageLookupByLibrary.simpleMessage("照片越多，推荐值越高"),
    "morePhotosMoreCharm": MessageLookupByLibrary.simpleMessage("照片多多魅力增！"),
    "music_subtitle": MessageLookupByLibrary.simpleMessage("放松身心的星座音频"),
    "myPhotos": MessageLookupByLibrary.simpleMessage("我的照片"),
    "myProfileTitle": MessageLookupByLibrary.simpleMessage("我的"),
    "my_statistics": MessageLookupByLibrary.simpleMessage("我的统计"),
    "navigateToAstroProfile": MessageLookupByLibrary.simpleMessage(
      "跳转到星盘资料完善页面",
    ),
    "nearby": MessageLookupByLibrary.simpleMessage("附近"),
    "newGameplay": MessageLookupByLibrary.simpleMessage("新玩法"),
    "newMatch": MessageLookupByLibrary.simpleMessage("新连接！"),
    "new_moon_insight": MessageLookupByLibrary.simpleMessage("新月时刻，适合开启新的疗愈计划"),
    "nextBilingDate": MessageLookupByLibrary.simpleMessage("下次付费日"),
    "noMessageTips": MessageLookupByLibrary.simpleMessage(
      "状态：暂无消息\n\n该做什么：寻找倾听者\n\n建议：分享真实的自己",
    ),
    "noOneFoundYourCharm": MessageLookupByLibrary.simpleMessage("还没有人发现你的魅力"),
    "noThanks": MessageLookupByLibrary.simpleMessage("不了，谢谢"),
    "no_audio": MessageLookupByLibrary.simpleMessage("暂无音频"),
    "no_quotes": MessageLookupByLibrary.simpleMessage("暂无心语记录"),
    "no_records_today": MessageLookupByLibrary.simpleMessage("这天还没有记录哦"),
    "notes": MessageLookupByLibrary.simpleMessage("记录"),
    "notifications": MessageLookupByLibrary.simpleMessage("通知"),
    "onboarding0": MessageLookupByLibrary.simpleMessage("Zena是世界公民的家园"),
    "onboarding1": MessageLookupByLibrary.simpleMessage(
      "无论在家或是在旅途，都可以结识世界各地的朋友。并且...",
    ),
    "onboarding2": MessageLookupByLibrary.simpleMessage(
      "你将获得超能力：\n通晓语言\n无需再担心交流障碍",
    ),
    "onboarding3": MessageLookupByLibrary.simpleMessage(
      "闲话少说，开始吧！\n传奇的浪漫邂逅在等着你",
    ),
    "onboardingWish": MessageLookupByLibrary.simpleMessage("请完成心愿单\n获得更理想的配对"),
    "oneLineToWin": MessageLookupByLibrary.simpleMessage("一句话打动对方"),
    "oopsNoDataRightNow": MessageLookupByLibrary.simpleMessage("哎呀，现在没有数据"),
    "peopleFromYourWishlistGetMoreRecommendations":
        MessageLookupByLibrary.simpleMessage("更多推荐来自你心愿单的人"),
    "permissionRequiredContent": MessageLookupByLibrary.simpleMessage(
      "我们需要这个权限来为您提供最佳体验",
    ),
    "permissionRequiredTitle": MessageLookupByLibrary.simpleMessage("需要权限"),
    "personaCompleteProfile": MessageLookupByLibrary.simpleMessage("完善基础资料"),
    "personaCompleteProfileDesc": MessageLookupByLibrary.simpleMessage(
      "完善姓名、生日、性别，解锁更多推荐",
    ),
    "personaEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "开启消息通知",
    ),
    "personaEnableNotificationsDesc": MessageLookupByLibrary.simpleMessage(
      "不错过匹配和消息，及时互动",
    ),
    "personaForYou": MessageLookupByLibrary.simpleMessage("为你推荐"),
    "personaShowCity": MessageLookupByLibrary.simpleMessage("展示所在城市"),
    "personaShowCityDesc": MessageLookupByLibrary.simpleMessage("更容易被同城用户发现"),
    "personaUploadPhotos": MessageLookupByLibrary.simpleMessage("上传你的照片"),
    "personaUploadPhotosDesc": MessageLookupByLibrary.simpleMessage(
      "至少添加 2 张清晰照片，提升曝光",
    ),
    "photoFromCamera": MessageLookupByLibrary.simpleMessage("拍照"),
    "photoFromGallery": MessageLookupByLibrary.simpleMessage("从图库选择"),
    "photoMightNotBeReal": MessageLookupByLibrary.simpleMessage("这张照片可能不是真实的"),
    "photos": MessageLookupByLibrary.simpleMessage("照片"),
    "piscesSign": MessageLookupByLibrary.simpleMessage("双鱼座"),
    "played_audio": MessageLookupByLibrary.simpleMessage("播放了音频"),
    "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
        MessageLookupByLibrary.simpleMessage("请检查网络或点击刷新重试"),
    "please_write_feelings": MessageLookupByLibrary.simpleMessage("请写下你的感受"),
    "plusBenefitActivityReminder": MessageLookupByLibrary.simpleMessage(
      "对方活跃/回流提醒",
    ),
    "plusBenefitActivitySort": MessageLookupByLibrary.simpleMessage(
      "最近活跃/回复率排序",
    ),
    "plusBenefitAdvancedFilter": MessageLookupByLibrary.simpleMessage(
      "高级筛选：国家/语言/时区/城市",
    ),
    "plusBenefitAntiHarassment": MessageLookupByLibrary.simpleMessage(
      "反骚扰优先拦截与权重保护",
    ),
    "plusBenefitConflictAdvice": MessageLookupByLibrary.simpleMessage(
      "冲突与建议：矛盾点提示+相处建议",
    ),
    "plusBenefitDestinyPriority": MessageLookupByLibrary.simpleMessage(
      "命定优先曝光：在推荐、喜欢我的排序靠前",
    ),
    "plusBenefitDestinyPush": MessageLookupByLibrary.simpleMessage("新命定到达推送"),
    "plusBenefitDimensionBreakdown": MessageLookupByLibrary.simpleMessage(
      "维度拆解：性格/沟通/亲密/边界4大维度",
    ),
    "plusBenefitHighMatchDisplay": MessageLookupByLibrary.simpleMessage(
      "高匹配标识与百分比展示",
    ),
    "plusBenefitHistoryTranslation": MessageLookupByLibrary.simpleMessage(
      "历史消息一键翻译",
    ),
    "plusBenefitInterestFilter": MessageLookupByLibrary.simpleMessage(
      "兴趣与出行计划筛选",
    ),
    "plusBenefitLikeReminder": MessageLookupByLibrary.simpleMessage(
      "被回赞/已读未回/回复窗口提醒",
    ),
    "plusBenefitMatchScore": MessageLookupByLibrary.simpleMessage(
      "速配分数：整体匹配分可视化",
    ),
    "plusBenefitMessageTemplates": MessageLookupByLibrary.simpleMessage(
      "快捷消息模板（赞美/邀约/换平台）",
    ),
    "plusBenefitOCRTranslation": MessageLookupByLibrary.simpleMessage(
      "图片即时翻译/文本识别（OCR+翻译）",
    ),
    "plusBenefitRealTimeTranslation": MessageLookupByLibrary.simpleMessage(
      "实时翻译与润色：多语言自动纠错与本地化语气",
    ),
    "plusBenefitSmartOpener": MessageLookupByLibrary.simpleMessage(
      "智能开场白：每人3条高转化开场建议",
    ),
    "plusBenefitStarGreeting": MessageLookupByLibrary.simpleMessage(
      "星语问候包：每日10次一键问候",
    ),
    "plusBenefitSupportChannel": MessageLookupByLibrary.simpleMessage(
      "订阅问题处理加速通道",
    ),
    "plusBenefitTopicPool": MessageLookupByLibrary.simpleMessage(
      "续聊话题池：基于对方画像动态生成",
    ),
    "plusBenefitUnlockLikedMe": MessageLookupByLibrary.simpleMessage(
      "解锁喜欢我的清晰头像与标签",
    ),
    "plusDescTitle": MessageLookupByLibrary.simpleMessage("Plus描述"),
    "plusFuncAIInterpretation": MessageLookupByLibrary.simpleMessage(
      "每天1000条AI传译",
    ),
    "plusFuncAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "Zena Tips - 你的聊天参谋",
    ),
    "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage("每周5条DM"),
    "plusFuncFilterMatchingCountries": MessageLookupByLibrary.simpleMessage(
      "筛选连接的国家",
    ),
    "plusFuncUnlimitedLikes": MessageLookupByLibrary.simpleMessage("无限点赞"),
    "plusFuncUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "解锁查看谁欣赏你的分享",
    ),
    "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3个心愿"),
    "plusMember": MessageLookupByLibrary.simpleMessage("Plus 会员"),
    "plusMembershipBenefits": MessageLookupByLibrary.simpleMessage("Plus会员权益"),
    "plusPerkDuoSnap": MessageLookupByLibrary.simpleMessage("Plus双人快照"),
    "practice_count": MessageLookupByLibrary.simpleMessage("练习次数"),
    "preference": MessageLookupByLibrary.simpleMessage("偏好"),
    "privacy": MessageLookupByLibrary.simpleMessage("隐私"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("隐私政策"),
    "productNotFound": MessageLookupByLibrary.simpleMessage("商品不存在"),
    "profileInfoTab": MessageLookupByLibrary.simpleMessage("资料"),
    "profileNotShown": MessageLookupByLibrary.simpleMessage("TA还没有展示真容"),
    "profileTip": MessageLookupByLibrary.simpleMessage("✨ 完善资料让星星更了解你，匹配更精准"),
    "psychological_healing": MessageLookupByLibrary.simpleMessage("心理疗愈"),
    "purchaseFailed": MessageLookupByLibrary.simpleMessage("购买失败"),
    "purchasePending": MessageLookupByLibrary.simpleMessage("购买处理中..."),
    "pushNotifications": MessageLookupByLibrary.simpleMessage("推送通知"),
    "quickActions": MessageLookupByLibrary.simpleMessage("快捷操作"),
    "quote_1": MessageLookupByLibrary.simpleMessage("今天的你，闪耀如星"),
    "quote_10": MessageLookupByLibrary.simpleMessage("在宁静中寻找内心的答案"),
    "quote_2": MessageLookupByLibrary.simpleMessage("相信自己，如同相信星座的指引"),
    "quote_3": MessageLookupByLibrary.simpleMessage("每个人都是独一无二的星座组合"),
    "quote_4": MessageLookupByLibrary.simpleMessage("宇宙的能量与你同在"),
    "quote_5": MessageLookupByLibrary.simpleMessage("接纳当下的自己，你已经很好了"),
    "quote_6": MessageLookupByLibrary.simpleMessage("每一种情绪都值得被看见"),
    "quote_7": MessageLookupByLibrary.simpleMessage("深呼吸，让星辰的力量流经你的身体"),
    "quote_8": MessageLookupByLibrary.simpleMessage("今天是崭新的一天，充满无限可能"),
    "quote_9": MessageLookupByLibrary.simpleMessage("你的存在本身就是一种奇迹"),
    "quotes_subtitle": MessageLookupByLibrary.simpleMessage("来自星座的治愈能量"),
    "record_daily_status": MessageLookupByLibrary.simpleMessage("记录今日状态"),
    "record_today_hint": MessageLookupByLibrary.simpleMessage("今天有什么想记录的吗？"),
    "record_your_feelings": MessageLookupByLibrary.simpleMessage("记录你的感受"),
    "recorded_days": MessageLookupByLibrary.simpleMessage("记录天数"),
    "recorded_emotion": MessageLookupByLibrary.simpleMessage("记录了情绪"),
    "relaxation_category": MessageLookupByLibrary.simpleMessage("放松"),
    "remindUploadPhoto": MessageLookupByLibrary.simpleMessage(
      "📸 提醒TA上传照片，让彼此更了解",
    ),
    "report": MessageLookupByLibrary.simpleMessage("举报"),
    "reportOptionGore": MessageLookupByLibrary.simpleMessage("血腥"),
    "reportOptionOther": MessageLookupByLibrary.simpleMessage("其他"),
    "reportOptionPerAstroLearnlAttack": MessageLookupByLibrary.simpleMessage(
      "人身攻击",
    ),
    "reportOptionPersonalAttack": MessageLookupByLibrary.simpleMessage("人身攻击"),
    "reportOptionPornography": MessageLookupByLibrary.simpleMessage("色情"),
    "reportOptionScam": MessageLookupByLibrary.simpleMessage("骗局"),
    "requireYourRealPhoto": MessageLookupByLibrary.simpleMessage("我们需要你的真实照片"),
    "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
      "优先展示附近的老外",
    ),
    "sagittariusSign": MessageLookupByLibrary.simpleMessage("射手座"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "save_failed": m11,
    "scorpioSign": MessageLookupByLibrary.simpleMessage("天蝎座"),
    "screenshotEvidence": MessageLookupByLibrary.simpleMessage("截图证据"),
    "seeProfile": MessageLookupByLibrary.simpleMessage("查看资料"),
    "seeWhoLikeU": MessageLookupByLibrary.simpleMessage("看看谁欣赏你"),
    "selectBirthPlace": MessageLookupByLibrary.simpleMessage("選擇出生地"),
    "selectBirthdayHint": MessageLookupByLibrary.simpleMessage("请选择出生日期查看您的星盘"),
    "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage("选择国家"),
    "selectLocationTitle": MessageLookupByLibrary.simpleMessage("选择地点"),
    "select_duration_start": MessageLookupByLibrary.simpleMessage("选择时长，开始冥想"),
    "select_meditation_duration": MessageLookupByLibrary.simpleMessage(
      "选择冥想时长",
    ),
    "sendDm": MessageLookupByLibrary.simpleMessage("发送私信"),
    "sendDmRemark": MessageLookupByLibrary.simpleMessage("发送DM消息"),
    "sendStarGreetingToUnlockAlbum": MessageLookupByLibrary.simpleMessage(
      "💫 发送星语问候解锁相册 继续",
    ),
    "setDefault": MessageLookupByLibrary.simpleMessage("设置默认"),
    "setInterestTags": MessageLookupByLibrary.simpleMessage("设置清晰的兴趣标签"),
    "settings": MessageLookupByLibrary.simpleMessage("设置"),
    "showYourPerAstroLearnlity": MessageLookupByLibrary.simpleMessage(
      "大声说出你的故事！",
    ),
    "showYourPersonality": MessageLookupByLibrary.simpleMessage("展现你的个性"),
    "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage("即将完成"),
    "sixMonths": MessageLookupByLibrary.simpleMessage("6个月"),
    "sleep_category": MessageLookupByLibrary.simpleMessage("睡眠"),
    "speakSameLanguage": MessageLookupByLibrary.simpleMessage("🤝 同语无需译,灵犀一点通"),
    "spiritual_growth": MessageLookupByLibrary.simpleMessage("心灵成长"),
    "standard": MessageLookupByLibrary.simpleMessage("标准"),
    "startChat": MessageLookupByLibrary.simpleMessage("开聊"),
    "start_meditation": MessageLookupByLibrary.simpleMessage("开始冥想"),
    "startedChat": MessageLookupByLibrary.simpleMessage("开始与聊天"),
    "status_saved": MessageLookupByLibrary.simpleMessage("✅ 状态已保存"),
    "stop_meditation": MessageLookupByLibrary.simpleMessage("停止冥想"),
    "streak_days": MessageLookupByLibrary.simpleMessage("连续打卡"),
    "streak_x_days": m12,
    "stress": MessageLookupByLibrary.simpleMessage("压力"),
    "stress_index": MessageLookupByLibrary.simpleMessage("压力指数"),
    "stress_level": MessageLookupByLibrary.simpleMessage("压力水平"),
    "subPageSubtitleAIInterpretationDaily":
        MessageLookupByLibrary.simpleMessage("每天1000条\nAI传译"),
    "subPageSubtitleAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "Zena Tips - \n你的聊天参谋",
    ),
    "subPageSubtitleDMWeekly": MessageLookupByLibrary.simpleMessage("每周5条DM"),
    "subPageSubtitleFilterMatchingCountries":
        MessageLookupByLibrary.simpleMessage("筛选连接的\n国家"),
    "subPageSubtitleUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "无限点赞",
    ),
    "subPageSubtitleUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "解锁查看\n谁欣赏你",
    ),
    "subPageTitle": MessageLookupByLibrary.simpleMessage("获取Zena Plus"),
    "subscriptionAgreement": MessageLookupByLibrary.simpleMessage("条款"),
    "subscriptionAgreementPrefix": m13,
    "subscriptionAgreementSuffix": MessageLookupByLibrary.simpleMessage("。"),
    "sunSignLabel": MessageLookupByLibrary.simpleMessage("太陽星座"),
    "synastryAnalysis": MessageLookupByLibrary.simpleMessage("合盘分析"),
    "takeIt": MessageLookupByLibrary.simpleMessage("使用"),
    "taurusSign": MessageLookupByLibrary.simpleMessage("金牛座"),
    "termsOfService": MessageLookupByLibrary.simpleMessage("服务条款"),
    "theKeyIsBalance": MessageLookupByLibrary.simpleMessage("关键是平衡"),
    "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
      "👆在等你的回复哦",
    ),
    "threeMonths": MessageLookupByLibrary.simpleMessage("3个月"),
    "toastHitDailyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👀已达到今日限额",
    ),
    "toastHitWeeklyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👅你已达到本周限额",
    ),
    "toggle_background_music": MessageLookupByLibrary.simpleMessage(
      "开启/关闭背景音乐",
    ),
    "total_duration": MessageLookupByLibrary.simpleMessage("总时长"),
    "unknownLocation": MessageLookupByLibrary.simpleMessage("不知"),
    "unlockDailyHoroscope": MessageLookupByLibrary.simpleMessage("获取详细星座运势解读"),
    "unlockHighMatchUsers": m14,
    "unlockMoonPhaseInsight": MessageLookupByLibrary.simpleMessage(
      "解锁今日月相能量解读",
    ),
    "unlockUsersWithDestiny": m15,
    "unmissableSpecialOfferPrices": MessageLookupByLibrary.simpleMessage(
      "不容错过的特价",
    ),
    "unsupportedPlatform": MessageLookupByLibrary.simpleMessage("不支援的平台"),
    "upgradeForMoreRecommendations": MessageLookupByLibrary.simpleMessage(
      "开通会员获得更多推荐",
    ),
    "uploadQualityPhotos": MessageLookupByLibrary.simpleMessage("上传高质量的真实照片"),
    "uploadYourPhoto": MessageLookupByLibrary.simpleMessage("上传你的照片"),
    "uploadYourPhotoHint": MessageLookupByLibrary.simpleMessage("上传你最好的照片"),
    "uploading": MessageLookupByLibrary.simpleMessage("上传中..."),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage("使用当前位置"),
    "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage("拍照"),
    "userAvatarOptionGallery": MessageLookupByLibrary.simpleMessage("从图库选择"),
    "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
      "一张好的肖像可以帮助你与更多倾听者建立连接。保持真实的自我。",
    ),
    "userAvatarPageTitle": MessageLookupByLibrary.simpleMessage("展示你的自信"),
    "userAvatarUploadedLabel": MessageLookupByLibrary.simpleMessage("上传搞定！"),
    "userBirthdayInputLabel": MessageLookupByLibrary.simpleMessage("出生日期"),
    "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "一旦确认，国籍无法更改",
    ),
    "userCitizenshipPickerTitle": MessageLookupByLibrary.simpleMessage("国籍"),
    "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("性别"),
    "userGenderOptionFemale": MessageLookupByLibrary.simpleMessage("女性"),
    "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("男性"),
    "userGenderOptionNonBinary": MessageLookupByLibrary.simpleMessage("非二元性别"),
    "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "您的性别不会公开显示，仅用于帮助建立连接",
    ),
    "userInfoPageNamePlaceholder": MessageLookupByLibrary.simpleMessage("输入"),
    "userInfoPageTitle": MessageLookupByLibrary.simpleMessage("基础资料"),
    "userNameInputLabel": MessageLookupByLibrary.simpleMessage("名字"),
    "userPhoneNumberPagePlaceholder": MessageLookupByLibrary.simpleMessage(
      "电话号码",
    ),
    "userPhoneNumberPagePrivacySuffix": MessageLookupByLibrary.simpleMessage(
      " ",
    ),
    "userPhoneNumberPagePrivacyText": MessageLookupByLibrary.simpleMessage(
      "隐私政策",
    ),
    "userPhoneNumberPageTermsAnd": MessageLookupByLibrary.simpleMessage("和"),
    "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
      "点击“下一步”，即表示您同意我们的",
    ),
    "userPhoneNumberPageTermsText": MessageLookupByLibrary.simpleMessage(
      "服务条款",
    ),
    "userPhoneNumberPageTitle": MessageLookupByLibrary.simpleMessage("请输入电话号码"),
    "valuesCompatibility": MessageLookupByLibrary.simpleMessage("价值观"),
    "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage("输入验证码"),
    "viewAstroReport": MessageLookupByLibrary.simpleMessage("查看与的星盘合盘"),
    "view_details": MessageLookupByLibrary.simpleMessage("查看详情"),
    "virgoSign": MessageLookupByLibrary.simpleMessage("处女座"),
    "waning_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "残月时刻，休息和恢复很重要",
    ),
    "waning_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "月亮渐亏，适合反思和整理",
    ),
    "wannaHollaAt": MessageLookupByLibrary.simpleMessage("你愿意分享吗…"),
    "warningCancelDisplayCity": MessageLookupByLibrary.simpleMessage(
      "关闭后，你的城市不会在匹配时显示",
    ),
    "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
      "您的账户将在14天后自动删除。请记得去商店取消您当前的订阅，以避免额外的费用。",
    ),
    "warningDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "如果您删除账户，将无法再用它登录。您确定要删除吗？",
    ),
    "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
      "外部链接。在点击前请确认来源可靠，因为不明链接可能是诈骗或窃取数据。谨慎行事。",
    ),
    "warningTitleCaution": MessageLookupByLibrary.simpleMessage("注意"),
    "warningUnmatching": MessageLookupByLibrary.simpleMessage(
      "结束分享后，你们之间的对话内容都将被清除。",
    ),
    "waxing_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "月亮渐盈，能量逐渐积累",
    ),
    "waxing_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "满月将至，情绪可能更加敏感",
    ),
    "whatsYourEmail": MessageLookupByLibrary.simpleMessage("你的邮箱是什么？"),
    "whoLIkesYou": MessageLookupByLibrary.simpleMessage("谁欣赏你的分享"),
    "whoLikesU": MessageLookupByLibrary.simpleMessage("谁欣赏你"),
    "wishActivityAddTitle": MessageLookupByLibrary.simpleMessage("添加你的想法"),
    "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "帮你找到搭子",
    ),
    "wishActivityPickerTitle": MessageLookupByLibrary.simpleMessage(
      "有啥特想做的事吗？",
    ),
    "wishCityPickerSkipButton": m16,
    "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "如果你去那里，你想去哪些城市？",
    ),
    "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage(
      "你 对哪个国家更感兴趣？",
    ),
    "wishCreationComplete": MessageLookupByLibrary.simpleMessage("你的心愿已收到!"),
    "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("已经在这了"),
    "wishDateOptionNotSure": MessageLookupByLibrary.simpleMessage("还不确定哦"),
    "wishDateOptionRecent": MessageLookupByLibrary.simpleMessage("近期吧，大概"),
    "wishDateOptionYear": MessageLookupByLibrary.simpleMessage("一年内"),
    "wishDatePickerSubtitle": m17,
    "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("何时"),
    "wishList": MessageLookupByLibrary.simpleMessage("心愿单"),
    "wishes": MessageLookupByLibrary.simpleMessage("心愿"),
    "writeInterestingBio": MessageLookupByLibrary.simpleMessage("写一个有趣的个人简介"),
    "write_feelings_hint": MessageLookupByLibrary.simpleMessage("写下此刻的感受..."),
    "x_days": m18,
    "x_hours": m19,
    "x_times": m20,
    "youAreAClubMemberNow": MessageLookupByLibrary.simpleMessage("你现在是俱乐部会员了"),
    "youCanEditItAnytime": MessageLookupByLibrary.simpleMessage("你可以随时编辑"),
    "youSeemCool": MessageLookupByLibrary.simpleMessage("你看起来很酷。"),
  };
}
