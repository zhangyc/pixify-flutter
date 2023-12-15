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

  static String m4(country) => "跳过,就${country}";

  static String m5(country) => "有计划去${country}吗";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "age": MessageLookupByLibrary.simpleMessage("年龄"),
        "block": MessageLookupByLibrary.simpleMessage("屏蔽"),
        "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
            MessageLookupByLibrary.simpleMessage("屏蔽此人以免收到他们的任何消息"),
        "breakIce": MessageLookupByLibrary.simpleMessage(
            "🔨🔨🔨 别在意我🔨🔨🔨 我在破冰🔨🔨🔨"),
        "buttonCopy": MessageLookupByLibrary.simpleMessage("复制"),
        "buttonDelete": MessageLookupByLibrary.simpleMessage("删除"),
        "buttonOpenLink": MessageLookupByLibrary.simpleMessage("打开链接"),
        "buttonResend": MessageLookupByLibrary.simpleMessage("重发"),
        "buttonUnmatch": MessageLookupByLibrary.simpleMessage("取消匹配"),
        "cancelButton": MessageLookupByLibrary.simpleMessage("取消"),
        "chat": MessageLookupByLibrary.simpleMessage("聊天"),
        "checkOutTheirProfiles": MessageLookupByLibrary.simpleMessage("看看都是谁"),
        "choosePlaceholder": MessageLookupByLibrary.simpleMessage("选择"),
        "commonLanguageTitle": MessageLookupByLibrary.simpleMessage("常用语言"),
        "descriptionOptional": MessageLookupByLibrary.simpleMessage("描述（可选）"),
        "dm": MessageLookupByLibrary.simpleMessage("超级私信"),
        "doneButton": MessageLookupByLibrary.simpleMessage("完成"),
        "exceptionFailedToSendTips":
            MessageLookupByLibrary.simpleMessage("发送失败，请稍后再试。"),
        "exceptionSonaContentFilterTips":
            MessageLookupByLibrary.simpleMessage("未发送。SONA不会翻译违禁词。"),
        "exceptionSonaOverloadedTips":
            MessageLookupByLibrary.simpleMessage("SONA过载，请稍后再试。"),
        "filter": MessageLookupByLibrary.simpleMessage("筛选"),
        "firstLandingLoadingTitle":
            MessageLookupByLibrary.simpleMessage("SONA正在寻找一些潜在的朋友..."),
        "friendsIntention":
            MessageLookupByLibrary.simpleMessage("嘿，我觉得你很棒。我们聊聊怎么样？"),
        "gore": MessageLookupByLibrary.simpleMessage("血腥"),
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
        "nearby": MessageLookupByLibrary.simpleMessage("附近"),
        "newMatch": MessageLookupByLibrary.simpleMessage("新匹配！"),
        "nextButton": MessageLookupByLibrary.simpleMessage("下一步"),
        "noMessageTips": MessageLookupByLibrary.simpleMessage(
            "状态：暂无消息\n\n该做什么：前往匹配\n\n建议：制作棒棒的个人资料"),
        "oopsNoDataRightNow": MessageLookupByLibrary.simpleMessage("哎呀，现在没有数据"),
        "other": MessageLookupByLibrary.simpleMessage("其他"),
        "peopleFromYourWishlistGetMoreRecommendations":
            MessageLookupByLibrary.simpleMessage("更多推荐来自你心愿单的人"),
        "personalAttack": MessageLookupByLibrary.simpleMessage("人身攻击"),
        "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
            MessageLookupByLibrary.simpleMessage("请检查网络或点击刷新重试"),
        "pornography": MessageLookupByLibrary.simpleMessage("色情"),
        "preference": MessageLookupByLibrary.simpleMessage("偏好"),
        "refresh": MessageLookupByLibrary.simpleMessage("刷新"),
        "report": MessageLookupByLibrary.simpleMessage("举报"),
        "resendButton": MessageLookupByLibrary.simpleMessage("重发"),
        "runningIntoForeignersNearYou":
            MessageLookupByLibrary.simpleMessage("优先展示附近的老外"),
        "scam": MessageLookupByLibrary.simpleMessage("骗局"),
        "screenshotEvidence": MessageLookupByLibrary.simpleMessage("截图证据"),
        "seeProfile": MessageLookupByLibrary.simpleMessage("查看资料"),
        "seeWhoLikeU": MessageLookupByLibrary.simpleMessage("看看谁喜欢你"),
        "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage("选择国家"),
        "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage("最后一步"),
        "sonaInterpretationOff":
            MessageLookupByLibrary.simpleMessage("⭕ SONA传译已关闭"),
        "sonaRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
            "Sona推荐：冷却中\n怎么办：等等\n建议：看看小破站？"),
        "speakSameLanguage":
            MessageLookupByLibrary.simpleMessage("🤝 同语无需译,灵犀一点通"),
        "submitButton": MessageLookupByLibrary.simpleMessage("提交"),
        "theyAreWaitingForYourReply":
            MessageLookupByLibrary.simpleMessage("👆在等你的回复哦"),
        "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage("拍照"),
        "userAvatarOptionGallery":
            MessageLookupByLibrary.simpleMessage("从图库选择"),
        "userAvatarPageChangeButton":
            MessageLookupByLibrary.simpleMessage("更改"),
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
            MessageLookupByLibrary.simpleMessage(""),
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
        "wishCityPickerSkipButton": m4,
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
        "wishDatePickerSubtitle": m5,
        "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("何时"),
        "wishList": MessageLookupByLibrary.simpleMessage("心愿单"),
        "wishes": MessageLookupByLibrary.simpleMessage("心愿"),
        "youSeemCool": MessageLookupByLibrary.simpleMessage("你看起来很酷。")
      };
}
