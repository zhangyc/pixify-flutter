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

  static String m5(country) => "跳过,就${country}";

  static String m6(country) => "有计划去${country}吗";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aMonth": MessageLookupByLibrary.simpleMessage("1个月"),
        "aYear": MessageLookupByLibrary.simpleMessage("1年"),
        "about": MessageLookupByLibrary.simpleMessage("关于"),
        "account": MessageLookupByLibrary.simpleMessage("账户"),
        "age": MessageLookupByLibrary.simpleMessage("年龄"),
        "allPeople": MessageLookupByLibrary.simpleMessage("所有人"),
        "bio": MessageLookupByLibrary.simpleMessage("简介"),
        "block": MessageLookupByLibrary.simpleMessage("屏蔽"),
        "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
            MessageLookupByLibrary.simpleMessage("屏蔽此人以免收到他们的任何消息"),
        "breakIce": MessageLookupByLibrary.simpleMessage(
            "🔨🔨🔨 别在意我🔨🔨🔨 我在破冰🔨🔨🔨"),
        "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage("你是Plus会员"),
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
        "buttonGotIt": MessageLookupByLibrary.simpleMessage("明白了"),
        "buttonHitAIInterpretationMaximumLimit":
            MessageLookupByLibrary.simpleMessage("😪SONA累了，👇点击给她加油！"),
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
        "buttonUnmatch": MessageLookupByLibrary.simpleMessage("取消匹配"),
        "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("取消订阅"),
        "chat": MessageLookupByLibrary.simpleMessage("聊天"),
        "checkOutTheirProfiles": MessageLookupByLibrary.simpleMessage("看看都是谁"),
        "choosePlaceholder": MessageLookupByLibrary.simpleMessage("选择"),
        "commonLanguage": MessageLookupByLibrary.simpleMessage("主要语言"),
        "commonLanguageTitle": MessageLookupByLibrary.simpleMessage("常用语言"),
        "descriptionOptional": MessageLookupByLibrary.simpleMessage("描述（可选）"),
        "disclaimer": MessageLookupByLibrary.simpleMessage("免责声明"),
        "displayMyCity": MessageLookupByLibrary.simpleMessage("显示我的城市"),
        "dm": MessageLookupByLibrary.simpleMessage("超级私信"),
        "exceptionFailedToSendTips":
            MessageLookupByLibrary.simpleMessage("发送失败，请稍后再试。"),
        "exceptionSonaContentFilterTips":
            MessageLookupByLibrary.simpleMessage("未发送。SONA不会翻译违禁词。"),
        "exceptionSonaOverloadedTips":
            MessageLookupByLibrary.simpleMessage("SONA过载，请稍后再试。"),
        "feedback": MessageLookupByLibrary.simpleMessage("反馈"),
        "filter": MessageLookupByLibrary.simpleMessage("筛选"),
        "findingFolksWhoShareYourInterests":
            MessageLookupByLibrary.simpleMessage("找到与你有共同兴趣的人"),
        "firstLandingLoadingTitle":
            MessageLookupByLibrary.simpleMessage("SONA正在寻找一些潜在的朋友..."),
        "friendsIntention":
            MessageLookupByLibrary.simpleMessage("嘿，我觉得你很棒。我们聊聊怎么样？"),
        "getSonaPlus": MessageLookupByLibrary.simpleMessage("获取SONA Plus"),
        "guessWhoBreakSilence":
            MessageLookupByLibrary.simpleMessage("嘿，猜猜谁会先打破沉默？"),
        "haveSonaSayHi": MessageLookupByLibrary.simpleMessage("让SONA打招呼"),
        "howDoUFeelAboutAI":
            MessageLookupByLibrary.simpleMessage("你觉得AI传译怎么样?"),
        "iDigYourEnergy": MessageLookupByLibrary.simpleMessage("我喜欢你的活力！"),
        "iLikeYourStyle": MessageLookupByLibrary.simpleMessage("我喜欢你的风格！"),
        "imInterestedSomething": m0,
        "imVeryInterestedInSomething": m1,
        "interests": MessageLookupByLibrary.simpleMessage("兴趣"),
        "interpretationOff": MessageLookupByLibrary.simpleMessage("AI传译：关"),
        "interpretationOn": MessageLookupByLibrary.simpleMessage("AI传译：开"),
        "justSendALike": MessageLookupByLibrary.simpleMessage("就点个赞"),
        "justTypeInYourLanguage": m2,
        "letSONASayHiForYou":
            MessageLookupByLibrary.simpleMessage("让SONA帮你打招呼"),
        "likedPageMonetizeButton":
            MessageLookupByLibrary.simpleMessage("看看都是谁"),
        "likedPageNoData": MessageLookupByLibrary.simpleMessage(
            "状态：暂时没有赞哦\n\n该做什么：采取主动\n\n建议：\n多传照片多加分\n写下简介显真诚\n选择兴趣有\n同道中人"),
        "likedYou": MessageLookupByLibrary.simpleMessage("喜欢了你"),
        "locationPermissionRequestSubtitle":
            MessageLookupByLibrary.simpleMessage("同城外国人寻找"),
        "locationPermissionRequestTitle":
            MessageLookupByLibrary.simpleMessage("位置授权"),
        "matchPageSelectIdeas": m3,
        "me": MessageLookupByLibrary.simpleMessage("我的"),
        "month": MessageLookupByLibrary.simpleMessage("月"),
        "morePhotosBenefit": MessageLookupByLibrary.simpleMessage("照片越多，推荐值越高"),
        "nearby": MessageLookupByLibrary.simpleMessage("附近"),
        "newMatch": MessageLookupByLibrary.simpleMessage("新匹配！"),
        "nextBilingDate": MessageLookupByLibrary.simpleMessage("下次付费日"),
        "noMessageTips": MessageLookupByLibrary.simpleMessage(
            "状态：暂无消息\n\n该做什么：前往匹配\n\n建议：制作棒棒的个人资料"),
        "notifications": MessageLookupByLibrary.simpleMessage("通知"),
        "oopsNoDataRightNow": MessageLookupByLibrary.simpleMessage("哎呀，现在没有数据"),
        "peopleFromYourWishlistGetMoreRecommendations":
            MessageLookupByLibrary.simpleMessage("更多推荐来自你心愿单的人"),
        "photos": MessageLookupByLibrary.simpleMessage("照片"),
        "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
            MessageLookupByLibrary.simpleMessage("请检查网络或点击刷新重试"),
        "plusFuncAIInterpretation":
            MessageLookupByLibrary.simpleMessage("每天1000条AI传译"),
        "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage("每周5条DM"),
        "plusFuncFilterMatchingCountries":
            MessageLookupByLibrary.simpleMessage("筛选配对的国家"),
        "plusFuncSonaTips":
            MessageLookupByLibrary.simpleMessage("SONA Tips - 你的聊天参谋"),
        "plusFuncUnlimitedLikes": MessageLookupByLibrary.simpleMessage("无限点赞"),
        "plusFuncUnlockWhoLikesU":
            MessageLookupByLibrary.simpleMessage("解锁查看谁喜欢了你"),
        "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3个心愿"),
        "preference": MessageLookupByLibrary.simpleMessage("偏好"),
        "privacy": MessageLookupByLibrary.simpleMessage("隐私"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("隐私政策"),
        "pushNotifications": MessageLookupByLibrary.simpleMessage("推送通知"),
        "report": MessageLookupByLibrary.simpleMessage("举报"),
        "reportOptionGore": MessageLookupByLibrary.simpleMessage("血腥"),
        "reportOptionOther": MessageLookupByLibrary.simpleMessage("其他"),
        "reportOptionPersonalAttack":
            MessageLookupByLibrary.simpleMessage("人身攻击"),
        "reportOptionPornography": MessageLookupByLibrary.simpleMessage("色情"),
        "reportOptionScam": MessageLookupByLibrary.simpleMessage("骗局"),
        "runningIntoForeignersNearYou":
            MessageLookupByLibrary.simpleMessage("优先展示附近的老外"),
        "screenshotEvidence": MessageLookupByLibrary.simpleMessage("截图证据"),
        "seeProfile": MessageLookupByLibrary.simpleMessage("查看资料"),
        "seeWhoLikeU": MessageLookupByLibrary.simpleMessage("看看谁喜欢你"),
        "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage("选择国家"),
        "settings": MessageLookupByLibrary.simpleMessage("设置"),
        "showYourPersonality":
            MessageLookupByLibrary.simpleMessage("大声说出你的故事！"),
        "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage("最后一步"),
        "sixMonths": MessageLookupByLibrary.simpleMessage("6个月"),
        "sonaInterpretationOff":
            MessageLookupByLibrary.simpleMessage("⭕ SONA传译已关闭"),
        "sonaRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
            "Sona推荐：冷却中\n怎么办：等等\n建议：看看小破站？"),
        "speakSameLanguage":
            MessageLookupByLibrary.simpleMessage("🤝 同语无需译,灵犀一点通"),
        "standard": MessageLookupByLibrary.simpleMessage("标准"),
        "subPageSubtitleAIInterpretationDaily":
            MessageLookupByLibrary.simpleMessage("每天1000条\nAI传译"),
        "subPageSubtitleDMWeekly":
            MessageLookupByLibrary.simpleMessage("每周5条DM"),
        "subPageSubtitleFilterMatchingCountries":
            MessageLookupByLibrary.simpleMessage("筛选配对的\n国家"),
        "subPageSubtitleSonaTips":
            MessageLookupByLibrary.simpleMessage("SONA Tips - \n你的聊天参谋"),
        "subPageSubtitleUnlimitedLikes":
            MessageLookupByLibrary.simpleMessage("无限点赞"),
        "subPageSubtitleUnlockWhoLikesU":
            MessageLookupByLibrary.simpleMessage("解锁查看\n谁喜欢了你"),
        "subPageTitle": MessageLookupByLibrary.simpleMessage("获取SONA Plus"),
        "subscriptionAgreement": MessageLookupByLibrary.simpleMessage("条款"),
        "subscriptionAgreementPrefix": m4,
        "subscriptionAgreementSuffix":
            MessageLookupByLibrary.simpleMessage("。"),
        "termsOfService": MessageLookupByLibrary.simpleMessage("服务条款"),
        "theKeyIsBalance": MessageLookupByLibrary.simpleMessage("关键是平衡"),
        "theyAreWaitingForYourReply":
            MessageLookupByLibrary.simpleMessage("👆在等你的回复哦"),
        "threeMonths": MessageLookupByLibrary.simpleMessage("3个月"),
        "toastHitDailyMaximumLimit":
            MessageLookupByLibrary.simpleMessage("👀已达到今日限额"),
        "toastHitWeeklyMaximumLimit":
            MessageLookupByLibrary.simpleMessage("👅你已达到本周限额"),
        "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage("拍照"),
        "userAvatarOptionGallery":
            MessageLookupByLibrary.simpleMessage("从图库选择"),
        "userAvatarPageSubtitle":
            MessageLookupByLibrary.simpleMessage("一张好的肖像可以让你获得更多的匹配。保持真实的自我。"),
        "userAvatarPageTitle": MessageLookupByLibrary.simpleMessage("展示你的自信"),
        "userAvatarUploadedLabel":
            MessageLookupByLibrary.simpleMessage("上传搞定！"),
        "userBirthdayInputLabel": MessageLookupByLibrary.simpleMessage("出生日期"),
        "userCitizenshipPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("一旦确认，国籍无法更改"),
        "userCitizenshipPickerTitle":
            MessageLookupByLibrary.simpleMessage("国籍"),
        "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("性别"),
        "userGenderOptionFemale": MessageLookupByLibrary.simpleMessage("女性"),
        "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("男性"),
        "userGenderOptionNonBinary":
            MessageLookupByLibrary.simpleMessage("非二元性别"),
        "userGenderPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("您的性别不会公开显示，仅用于帮助匹配"),
        "userInfoPageNamePlaceholder":
            MessageLookupByLibrary.simpleMessage("输入"),
        "userInfoPageTitle": MessageLookupByLibrary.simpleMessage("基础资料"),
        "userNameInputLabel": MessageLookupByLibrary.simpleMessage("名字"),
        "userPhoneNumberPagePlaceholder":
            MessageLookupByLibrary.simpleMessage("电话号码"),
        "userPhoneNumberPagePrivacySuffix":
            MessageLookupByLibrary.simpleMessage(" "),
        "userPhoneNumberPagePrivacyText":
            MessageLookupByLibrary.simpleMessage("隐私政策"),
        "userPhoneNumberPageTermsAnd":
            MessageLookupByLibrary.simpleMessage("和"),
        "userPhoneNumberPageTermsPrefix":
            MessageLookupByLibrary.simpleMessage("点击“下一步”，即表示您同意我们的"),
        "userPhoneNumberPageTermsText":
            MessageLookupByLibrary.simpleMessage("服务条款"),
        "userPhoneNumberPageTitle":
            MessageLookupByLibrary.simpleMessage("请输入电话号码"),
        "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage("输入验证码"),
        "wannaHollaAt": MessageLookupByLibrary.simpleMessage("打个招呼吧！"),
        "warningCancelDisplayCity":
            MessageLookupByLibrary.simpleMessage("关闭后，你的城市不会在匹配时显示"),
        "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
            "您的账户将在14天后自动删除。请记得去商店取消您当前的订阅，以避免额外的费用。"),
        "warningDeleteAccount":
            MessageLookupByLibrary.simpleMessage("如果您删除账户，将无法再用它登录。您确定要删除吗？"),
        "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
            "外部链接。在点击前请确认来源可靠，因为不明链接可能是诈骗或窃取数据。谨慎行事。"),
        "warningTitleCaution": MessageLookupByLibrary.simpleMessage("注意"),
        "warningUnmatching":
            MessageLookupByLibrary.simpleMessage("取消匹配后，你们之间的聊天内容都将被清除。"),
        "whoLIkesYou": MessageLookupByLibrary.simpleMessage("谁喜欢了你"),
        "whoLikesU": MessageLookupByLibrary.simpleMessage("谁喜欢了你"),
        "wishActivityAddTitle": MessageLookupByLibrary.simpleMessage("添加你的想法"),
        "wishActivityPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("帮你找到搭子"),
        "wishActivityPickerTitle":
            MessageLookupByLibrary.simpleMessage("有啥特想做的事吗？"),
        "wishCityPickerSkipButton": m5,
        "wishCityPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("如果你去那里，你想去哪些城市？"),
        "wishCountryPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("国家的人更有共鸣?"),
        "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage("哪个"),
        "wishCreationComplete":
            MessageLookupByLibrary.simpleMessage("你的心愿已收到!"),
        "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("已经在这了"),
        "wishDateOptionNotSure": MessageLookupByLibrary.simpleMessage("还不确定哦"),
        "wishDateOptionRecent": MessageLookupByLibrary.simpleMessage("近期吧，大概"),
        "wishDateOptionYear": MessageLookupByLibrary.simpleMessage("一年内"),
        "wishDatePickerSubtitle": m6,
        "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("何时"),
        "wishList": MessageLookupByLibrary.simpleMessage("心愿单"),
        "wishes": MessageLookupByLibrary.simpleMessage("心愿"),
        "youSeemCool": MessageLookupByLibrary.simpleMessage("你看起来很酷。")
      };
}
