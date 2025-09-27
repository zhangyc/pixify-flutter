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

  static String m0(something) => "\"我对${something}感兴趣~\"";

  static String m1(something) => "我对「${something}」非常感兴趣！";

  static String m2(lang) => "只需输入${lang}";

  static String m3(gender) =>
      "你喜欢${Intl.gender(gender, female: '她', male: '他', other: '他们')}的哪个想法？";

  static String m4(storeName) =>
      "点击“继续”后你会被收取费用，您的订阅将按对应套餐价格自动续订，您可以通过${storeName}取消，继续代表您同意我们的";

  static String m5(count) => "解锁查看${count}个高匹配用户 ✨";

  static String m6(count, destinyCount) =>
      "解锁${count}个用户，包含${destinyCount}个命定匹配 ⭐";

  static String m7(country) => "跳过,就${country}";

  static String m8(country) => "有计划去${country}吗";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aMonth": MessageLookupByLibrary.simpleMessage("1个月"),
    "aYear": MessageLookupByLibrary.simpleMessage("1年"),
    "about": MessageLookupByLibrary.simpleMessage("关于"),
    "account": MessageLookupByLibrary.simpleMessage("账户"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("添加照片"),
    "age": MessageLookupByLibrary.simpleMessage("年龄"),
    "aiCreatingFunGroupPics": MessageLookupByLibrary.simpleMessage(
      "AI正在创建有趣的群组照片",
    ),
    "allPeople": MessageLookupByLibrary.simpleMessage("所有人"),
    "astroChartTab": MessageLookupByLibrary.simpleMessage("星盘"),
    "astroInfoIncompleteMessage": MessageLookupByLibrary.simpleMessage(
      "对方尚未完善出生地信息，暂时无法生成星盘分析。请期待对方完善信息后查看。",
    ),
    "astroPairInterpretationOff": MessageLookupByLibrary.simpleMessage(
      "⭕ AstroPair传译已关闭",
    ),
    "astroPairRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
      "AstroPair推荐：冷却中\n怎么办：等等\n建议：看看小破站？",
    ),
    "astroPairWillGenerateABioBasedOnInterests":
        MessageLookupByLibrary.simpleMessage("AstroPair会根据你的兴趣生成一份简介"),
    "astroReport": MessageLookupByLibrary.simpleMessage("合盘"),
    "avatarUpdateFailed": MessageLookupByLibrary.simpleMessage("头像更新失败"),
    "bio": MessageLookupByLibrary.simpleMessage("简介"),
    "block": MessageLookupByLibrary.simpleMessage("屏蔽"),
    "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
        MessageLookupByLibrary.simpleMessage("屏蔽此人以免收到他们的任何消息"),
    "boostYourAppeal": MessageLookupByLibrary.simpleMessage("魅力UP!"),
    "breakIce": MessageLookupByLibrary.simpleMessage(
      "🔨🔨🔨 别在意我🔨🔨🔨 我在破冰🔨🔨🔨",
    ),
    "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage("你是Plus会员"),
    "buttonAuthorize": MessageLookupByLibrary.simpleMessage("授权"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("取消"),
    "buttonChange": MessageLookupByLibrary.simpleMessage("更改"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("确认"),
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
        MessageLookupByLibrary.simpleMessage("😪AstroPair累了，👇点击给她加油！"),
    "buttonJoinNow": MessageLookupByLibrary.simpleMessage("立即加入"),
    "buttonKeepAccount": MessageLookupByLibrary.simpleMessage("保留账户"),
    "buttonManage": MessageLookupByLibrary.simpleMessage("管理"),
    "buttonNext": MessageLookupByLibrary.simpleMessage("下一步"),
    "buttonOpenLink": MessageLookupByLibrary.simpleMessage("打开链接"),
    "buttonPreview": MessageLookupByLibrary.simpleMessage("预览"),
    "buttonRefresh": MessageLookupByLibrary.simpleMessage("刷新"),
    "buttonResend": MessageLookupByLibrary.simpleMessage("重发"),
    "buttonRestore": MessageLookupByLibrary.simpleMessage("恢复"),
    "buttonSave": MessageLookupByLibrary.simpleMessage("保存"),
    "buttonSignOut": MessageLookupByLibrary.simpleMessage("退出"),
    "buttonSubmit": MessageLookupByLibrary.simpleMessage("提交"),
    "buttonUnlockVipPerks": MessageLookupByLibrary.simpleMessage("解锁VIP特权"),
    "buttonUnmatch": MessageLookupByLibrary.simpleMessage("取消匹配"),
    "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("取消订阅"),
    "catchMore": MessageLookupByLibrary.simpleMessage("抓住更多"),
    "charmTips": MessageLookupByLibrary.simpleMessage("提升魅力小贴士"),
    "chat": MessageLookupByLibrary.simpleMessage("聊天"),
    "chatWithMatches": MessageLookupByLibrary.simpleMessage("主动与匹配的用户聊天"),
    "checkItOut": MessageLookupByLibrary.simpleMessage("来看看"),
    "checkOutTheirProfiles": MessageLookupByLibrary.simpleMessage("看看都是谁"),
    "choosePlaceholder": MessageLookupByLibrary.simpleMessage("选择"),
    "clubFeeJoking": MessageLookupByLibrary.simpleMessage("开玩笑！免费的"),
    "clubFeePrefix": MessageLookupByLibrary.simpleMessage("俱乐部费用：\$99/月"),
    "clubPromotionContent": MessageLookupByLibrary.simpleMessage(
      "加入我们的专属俱乐部享受精彩福利",
    ),
    "clubPromotionTitle": MessageLookupByLibrary.simpleMessage("加入俱乐部"),
    "commonLanguage": MessageLookupByLibrary.simpleMessage("主要语言"),
    "commonLanguageTitle": MessageLookupByLibrary.simpleMessage("常用语言"),
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
    "deletePhoto": MessageLookupByLibrary.simpleMessage("删除照片"),
    "deletePhotoContent": MessageLookupByLibrary.simpleMessage(
      "确定要删除这张照片吗？此操作无法撤销。",
    ),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage("描述（可选）"),
    "destinyMatch": MessageLookupByLibrary.simpleMessage("命定"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("免责声明"),
    "displayMyCity": MessageLookupByLibrary.simpleMessage("显示我的城市"),
    "dm": MessageLookupByLibrary.simpleMessage("超级私信"),
    "duoSnap": MessageLookupByLibrary.simpleMessage("双人快照"),
    "duosnapAnyway": MessageLookupByLibrary.simpleMessage("无论如何都要双人快照"),
    "editProfile": MessageLookupByLibrary.simpleMessage("编辑资料"),
    "emptyChatRoomMessage": MessageLookupByLibrary.simpleMessage(
      "你的专属聊天室还是空的\n但星星知道，对的人正在向你走来",
    ),
    "exceptionAstroPairContentFilterTips": MessageLookupByLibrary.simpleMessage(
      "未发送。AstroPair不会翻译违禁词。",
    ),
    "exceptionAstroPairOverloadedTips": MessageLookupByLibrary.simpleMessage(
      "AstroPair过载，请稍后再试。",
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
      "AstroPair正在寻找一些潜在的朋友...",
    ),
    "friendsIntention": MessageLookupByLibrary.simpleMessage(
      "嘿，我觉得你很棒。我们聊聊怎么样？",
    ),
    "getAstroPairPlus": MessageLookupByLibrary.simpleMessage(
      "获取AstroPair Plus",
    ),
    "gifNotAllowed": MessageLookupByLibrary.simpleMessage("GIF文件不允许"),
    "goDiscover": MessageLookupByLibrary.simpleMessage("去发现"),
    "gotIt": MessageLookupByLibrary.simpleMessage("明白了"),
    "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
      "嘿，猜猜谁会先打破沉默？",
    ),
    "haveAstroPairSayHi": MessageLookupByLibrary.simpleMessage("让AstroPair打招呼"),
    "hereAstroPairCookedUpForU": MessageLookupByLibrary.simpleMessage(
      "这是AstroPair为你特制的",
    ),
    "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage("你觉得AI传译怎么样?"),
    "iDigYourEnergy": MessageLookupByLibrary.simpleMessage("我喜欢你的活力！"),
    "iLikeYourStyle": MessageLookupByLibrary.simpleMessage("我喜欢你的风格！"),
    "imInterestedSomething": m0,
    "imVeryInterestedInSomething": m1,
    "infoIncompleteTitle": MessageLookupByLibrary.simpleMessage("信息不完整"),
    "interests": MessageLookupByLibrary.simpleMessage("兴趣"),
    "interpretationOff": MessageLookupByLibrary.simpleMessage("AI传译：关"),
    "interpretationOn": MessageLookupByLibrary.simpleMessage("AI传译：开"),
    "issues": MessageLookupByLibrary.simpleMessage("问题"),
    "justNow": MessageLookupByLibrary.simpleMessage("刚刚"),
    "justSendALike": MessageLookupByLibrary.simpleMessage("就点个赞"),
    "justTypeInYourLanguage": m2,
    "letAstroPairSayHiForYou": MessageLookupByLibrary.simpleMessage(
      "让AstroPair帮你打招呼",
    ),
    "likeBack": MessageLookupByLibrary.simpleMessage("回赞"),
    "likedBack": MessageLookupByLibrary.simpleMessage("已回赞"),
    "likedPageMonetizeButton": MessageLookupByLibrary.simpleMessage("看看都是谁"),
    "likedPageNoData": MessageLookupByLibrary.simpleMessage(
      "状态：暂时没有赞哦\n\n该做什么：采取主动\n\n建议：\n多传照片多加分\n写下简介显真诚\n选择兴趣有\n同道中人",
    ),
    "likedYou": MessageLookupByLibrary.simpleMessage("喜欢了你"),
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
    "matchPageSelectIdeas": m3,
    "me": MessageLookupByLibrary.simpleMessage("我的"),
    "memberCenter": MessageLookupByLibrary.simpleMessage("会员中心"),
    "membersPerks": MessageLookupByLibrary.simpleMessage("会员享受专属特权"),
    "month": MessageLookupByLibrary.simpleMessage("月"),
    "morePhotosBenefit": MessageLookupByLibrary.simpleMessage("照片越多，推荐值越高"),
    "morePhotosMoreCharm": MessageLookupByLibrary.simpleMessage("照片多多魅力增！"),
    "myPhotos": MessageLookupByLibrary.simpleMessage("我的照片"),
    "myProfileTitle": MessageLookupByLibrary.simpleMessage("我的"),
    "navigateToAstroProfile": MessageLookupByLibrary.simpleMessage(
      "跳转到星盘资料完善页面",
    ),
    "nearby": MessageLookupByLibrary.simpleMessage("附近"),
    "newGameplay": MessageLookupByLibrary.simpleMessage("新玩法"),
    "newMatch": MessageLookupByLibrary.simpleMessage("新匹配！"),
    "nextBilingDate": MessageLookupByLibrary.simpleMessage("下次付费日"),
    "noMessageTips": MessageLookupByLibrary.simpleMessage(
      "状态：暂无消息\n\n该做什么：前往匹配\n\n建议：制作棒棒的个人资料",
    ),
    "noOneFoundYourCharm": MessageLookupByLibrary.simpleMessage("还没有人发现你的魅力"),
    "noThanks": MessageLookupByLibrary.simpleMessage("不了，谢谢"),
    "notifications": MessageLookupByLibrary.simpleMessage("通知"),
    "onboarding0": MessageLookupByLibrary.simpleMessage("AstroPair是世界公民的家园"),
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
    "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
        MessageLookupByLibrary.simpleMessage("请检查网络或点击刷新重试"),
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
    "plusFuncAstroPairTips": MessageLookupByLibrary.simpleMessage(
      "AstroPair Tips - 你的聊天参谋",
    ),
    "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage("每周5条DM"),
    "plusFuncFilterMatchingCountries": MessageLookupByLibrary.simpleMessage(
      "筛选配对的国家",
    ),
    "plusFuncUnlimitedLikes": MessageLookupByLibrary.simpleMessage("无限点赞"),
    "plusFuncUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "解锁查看谁喜欢了你",
    ),
    "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3个心愿"),
    "plusMember": MessageLookupByLibrary.simpleMessage("Plus 会员"),
    "plusMembershipBenefits": MessageLookupByLibrary.simpleMessage("Plus会员权益"),
    "plusPerkDuoSnap": MessageLookupByLibrary.simpleMessage("Plus双人快照"),
    "preference": MessageLookupByLibrary.simpleMessage("偏好"),
    "privacy": MessageLookupByLibrary.simpleMessage("隐私"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("隐私政策"),
    "profileInfoTab": MessageLookupByLibrary.simpleMessage("资料"),
    "profileNotShown": MessageLookupByLibrary.simpleMessage("TA还没有展示真容"),
    "profileTip": MessageLookupByLibrary.simpleMessage("✨ 完善资料让星星更了解你，匹配更精准"),
    "pushNotifications": MessageLookupByLibrary.simpleMessage("推送通知"),
    "quickActions": MessageLookupByLibrary.simpleMessage("快捷操作"),
    "remindUploadPhoto": MessageLookupByLibrary.simpleMessage(
      "📸 提醒TA上传照片，让彼此更了解",
    ),
    "report": MessageLookupByLibrary.simpleMessage("举报"),
    "reportOptionGore": MessageLookupByLibrary.simpleMessage("血腥"),
    "reportOptionOther": MessageLookupByLibrary.simpleMessage("其他"),
    "reportOptionPerAstroPairlAttack": MessageLookupByLibrary.simpleMessage(
      "人身攻击",
    ),
    "reportOptionPersonalAttack": MessageLookupByLibrary.simpleMessage("人身攻击"),
    "reportOptionPornography": MessageLookupByLibrary.simpleMessage("色情"),
    "reportOptionScam": MessageLookupByLibrary.simpleMessage("骗局"),
    "requireYourRealPhoto": MessageLookupByLibrary.simpleMessage("我们需要你的真实照片"),
    "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
      "优先展示附近的老外",
    ),
    "screenshotEvidence": MessageLookupByLibrary.simpleMessage("截图证据"),
    "seeProfile": MessageLookupByLibrary.simpleMessage("查看资料"),
    "seeWhoLikeU": MessageLookupByLibrary.simpleMessage("看看谁喜欢你"),
    "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage("选择国家"),
    "selectLocationTitle": MessageLookupByLibrary.simpleMessage("选择地点"),
    "sendDm": MessageLookupByLibrary.simpleMessage("发送私信"),
    "sendStarGreetingToUnlockAlbum": MessageLookupByLibrary.simpleMessage(
      "💫 发送星语问候解锁相册 继续",
    ),
    "setDefault": MessageLookupByLibrary.simpleMessage("设置默认"),
    "setInterestTags": MessageLookupByLibrary.simpleMessage("设置清晰的兴趣标签"),
    "settings": MessageLookupByLibrary.simpleMessage("设置"),
    "showYourPerAstroPairlity": MessageLookupByLibrary.simpleMessage(
      "大声说出你的故事！",
    ),
    "showYourPersonality": MessageLookupByLibrary.simpleMessage("展现你的个性"),
    "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage("即将完成"),
    "sixMonths": MessageLookupByLibrary.simpleMessage("6个月"),
    "speakSameLanguage": MessageLookupByLibrary.simpleMessage("🤝 同语无需译,灵犀一点通"),
    "standard": MessageLookupByLibrary.simpleMessage("标准"),
    "startChat": MessageLookupByLibrary.simpleMessage("开聊"),
    "startedChat": MessageLookupByLibrary.simpleMessage("开始与聊天"),
    "subPageSubtitleAIInterpretationDaily":
        MessageLookupByLibrary.simpleMessage("每天1000条\nAI传译"),
    "subPageSubtitleAstroPairTips": MessageLookupByLibrary.simpleMessage(
      "AstroPair Tips - \n你的聊天参谋",
    ),
    "subPageSubtitleDMWeekly": MessageLookupByLibrary.simpleMessage("每周5条DM"),
    "subPageSubtitleFilterMatchingCountries":
        MessageLookupByLibrary.simpleMessage("筛选配对的\n国家"),
    "subPageSubtitleUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "无限点赞",
    ),
    "subPageSubtitleUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "解锁查看\n谁喜欢了你",
    ),
    "subPageTitle": MessageLookupByLibrary.simpleMessage("获取AstroPair Plus"),
    "subscriptionAgreement": MessageLookupByLibrary.simpleMessage("条款"),
    "subscriptionAgreementPrefix": m4,
    "subscriptionAgreementSuffix": MessageLookupByLibrary.simpleMessage("。"),
    "takeIt": MessageLookupByLibrary.simpleMessage("使用"),
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
    "unlockHighMatchUsers": m5,
    "unlockUsersWithDestiny": m6,
    "unmissableSpecialOfferPrices": MessageLookupByLibrary.simpleMessage(
      "不容错过的特价",
    ),
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
      "一张好的肖像可以让你获得更多的匹配。保持真实的自我。",
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
      "您的性别不会公开显示，仅用于帮助匹配",
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
    "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage("输入验证码"),
    "viewAstroReport": MessageLookupByLibrary.simpleMessage("查看与的星盘合盘"),
    "wannaHollaAt": MessageLookupByLibrary.simpleMessage("打个招呼吧！"),
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
      "取消匹配后，你们之间的聊天内容都将被清除。",
    ),
    "whatsYourEmail": MessageLookupByLibrary.simpleMessage("你的邮箱是什么？"),
    "whoLIkesYou": MessageLookupByLibrary.simpleMessage("谁喜欢了你"),
    "whoLikesU": MessageLookupByLibrary.simpleMessage("谁喜欢了你"),
    "wishActivityAddTitle": MessageLookupByLibrary.simpleMessage("添加你的想法"),
    "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "帮你找到搭子",
    ),
    "wishActivityPickerTitle": MessageLookupByLibrary.simpleMessage(
      "有啥特想做的事吗？",
    ),
    "wishCityPickerSkipButton": m7,
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
    "wishDatePickerSubtitle": m8,
    "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("何时"),
    "wishList": MessageLookupByLibrary.simpleMessage("心愿单"),
    "wishes": MessageLookupByLibrary.simpleMessage("心愿"),
    "writeInterestingBio": MessageLookupByLibrary.simpleMessage("写一个有趣的个人简介"),
    "youAreAClubMemberNow": MessageLookupByLibrary.simpleMessage("你现在是俱乐部会员了"),
    "youCanEditItAnytime": MessageLookupByLibrary.simpleMessage("你可以随时编辑"),
    "youSeemCool": MessageLookupByLibrary.simpleMessage("你看起来很酷。"),
  };
}
