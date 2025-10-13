// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja locale. All the
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
  String get localeName => 'ja';

  static String m0(something) => "\"${something}に興味があります\"";

  static String m1(something) => "「${something}」にとても興味があります！";

  static String m2(lang) => "${lang}でチャットできるよー";

  static String m3(gender) =>
      "${Intl.gender(gender, female: '彼女', male: '彼', other: '彼ら')}のどの共有体験が心に響きますか？";

  static String m4(storeName) =>
      "「続行」をクリックすると料金が発生し、対応するパッケージの価格で自動更新されます。${storeName}でキャンセルが可能です。続行することで、私たちの";

  static String m5(count) => "高マッチユーザー${count}人をアンロックして表示 ✨";

  static String m6(count, destinyCount) =>
      "ユーザー${count}人をアンロック 命定マッチ${destinyCount}人含む ⭐";

  static String m7(country) => "スキップ、ただ${country}";

  static String m8(country) => "${country}に行く予定ですか";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aMonth": MessageLookupByLibrary.simpleMessage("1ヶ月"),
    "aYear": MessageLookupByLibrary.simpleMessage("1年"),
    "about": MessageLookupByLibrary.simpleMessage("約"),
    "account": MessageLookupByLibrary.simpleMessage("アカウント"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("写真を追加"),
    "age": MessageLookupByLibrary.simpleMessage("年齢"),
    "aiCreatingFunGroupPics": MessageLookupByLibrary.simpleMessage(
      "AIが楽しいグループ写真を作成中",
    ),
    "allPeople": MessageLookupByLibrary.simpleMessage("全部"),
    "analyzingText": MessageLookupByLibrary.simpleMessage("分析中..."),
    "aquariusSign": MessageLookupByLibrary.simpleMessage("水瓶座"),
    "ariesSign": MessageLookupByLibrary.simpleMessage("牡羊座"),
    "ascendantSignLabel": MessageLookupByLibrary.simpleMessage("上升星座"),
    "astroChartTab": MessageLookupByLibrary.simpleMessage("星占いチャート"),
    "astroInfoIncompleteMessage": MessageLookupByLibrary.simpleMessage(
      "相手ユーザーが出生地の情報をまだ完了していないため、占星術チャートを生成できません。相手が情報を完了するまでお待ちください。",
    ),
    "astroLearnInterpretationOff": MessageLookupByLibrary.simpleMessage(
      "⭕ AstroLearn同期通訳はオフになりました",
    ),
    "astroLearnRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
      "ソナおすすめ:クールダウン中\nやること:待ってる\nアドバイス:漫画でも読んどいたら?",
    ),
    "astroLearnWillGenerateABioBasedOnInterests":
        MessageLookupByLibrary.simpleMessage("あなたの興味に基づいてAstroLearnがバイオを生成します"),
    "astroReport": MessageLookupByLibrary.simpleMessage("星盤レポート"),
    "avatarUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "アバターの更新に失敗しました",
    ),
    "bio": MessageLookupByLibrary.simpleMessage("アバウトミー"),
    "birthInfo": MessageLookupByLibrary.simpleMessage("出生信息"),
    "birthPlace": MessageLookupByLibrary.simpleMessage("出生地"),
    "birthPlaceLabel": MessageLookupByLibrary.simpleMessage("出生地点"),
    "birthTimeLabel": MessageLookupByLibrary.simpleMessage("出生时间"),
    "birthday": MessageLookupByLibrary.simpleMessage("生日"),
    "block": MessageLookupByLibrary.simpleMessage("ブロック"),
    "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
        MessageLookupByLibrary.simpleMessage(
          "この人をブロックして、彼らからのメッセージを受け取らないようにする",
        ),
    "boostYourAppeal": MessageLookupByLibrary.simpleMessage("魅力をアップさせる"),
    "breakIce": MessageLookupByLibrary.simpleMessage(
      "🔨🔨🔨 気にしないで🔨🔨🔨 氷を砕くだけ🔨🔨🔨",
    ),
    "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage("あなたはPlus会員です"),
    "buttonAuthorize": MessageLookupByLibrary.simpleMessage("認証"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("キャンセル"),
    "buttonChange": MessageLookupByLibrary.simpleMessage("変更"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("确定"),
    "buttonContinue": MessageLookupByLibrary.simpleMessage("続行"),
    "buttonCopy": MessageLookupByLibrary.simpleMessage("コピー"),
    "buttonDelete": MessageLookupByLibrary.simpleMessage("削除"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("アカウント削除"),
    "buttonDone": MessageLookupByLibrary.simpleMessage("済みました"),
    "buttonEdit": MessageLookupByLibrary.simpleMessage("編集"),
    "buttonEditProfile": MessageLookupByLibrary.simpleMessage("プロフィール編集"),
    "buttonGenerate": MessageLookupByLibrary.simpleMessage("生成する"),
    "buttonGo": MessageLookupByLibrary.simpleMessage("進む"),
    "buttonGotIt": MessageLookupByLibrary.simpleMessage("分かった"),
    "buttonHitAIInterpretationMaximumLimit":
        MessageLookupByLibrary.simpleMessage(
          "AstroLearn疲れた😪、👇クリックでエネルギーチャージ！",
        ),
    "buttonJoinNow": MessageLookupByLibrary.simpleMessage("今すぐ参加"),
    "buttonKeepAccount": MessageLookupByLibrary.simpleMessage("アカウントを保持"),
    "buttonManage": MessageLookupByLibrary.simpleMessage("管理する"),
    "buttonNext": MessageLookupByLibrary.simpleMessage("次のステップ"),
    "buttonOpenLink": MessageLookupByLibrary.simpleMessage("リンクを開く"),
    "buttonPreview": MessageLookupByLibrary.simpleMessage("プレビュー"),
    "buttonPurchase": MessageLookupByLibrary.simpleMessage("購入"),
    "buttonRefresh": MessageLookupByLibrary.simpleMessage("更新"),
    "buttonResend": MessageLookupByLibrary.simpleMessage("再送信"),
    "buttonRestore": MessageLookupByLibrary.simpleMessage("リストアする"),
    "buttonSave": MessageLookupByLibrary.simpleMessage("保存"),
    "buttonSignOut": MessageLookupByLibrary.simpleMessage("ログアウト"),
    "buttonSubmit": MessageLookupByLibrary.simpleMessage("提出する"),
    "buttonUnlockVipPerks": MessageLookupByLibrary.simpleMessage("VIP特典をアンロック"),
    "buttonUnmatch": MessageLookupByLibrary.simpleMessage("共有を終了"),
    "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("購読を解除する"),
    "cancerSign": MessageLookupByLibrary.simpleMessage("蟹座"),
    "capricornSign": MessageLookupByLibrary.simpleMessage("山羊座"),
    "catchMore": MessageLookupByLibrary.simpleMessage("もっとキャッチ"),
    "charmTips": MessageLookupByLibrary.simpleMessage("魅力アップのコツ"),
    "chartPreview": MessageLookupByLibrary.simpleMessage("チャートプレビュー"),
    "chat": MessageLookupByLibrary.simpleMessage("チャット"),
    "chatWithMatches": MessageLookupByLibrary.simpleMessage(
      "マッチしたユーザーと積極的にチャットする",
    ),
    "checkItOut": MessageLookupByLibrary.simpleMessage("チェックしてみて"),
    "checkOutTheirProfiles": MessageLookupByLibrary.simpleMessage(
      "あいつらのプロフチェックしよう!",
    ),
    "choosePlaceholder": MessageLookupByLibrary.simpleMessage("選択"),
    "clickToSetBirthPlace": MessageLookupByLibrary.simpleMessage("点击设置出生地"),
    "clickToSetBirthday": MessageLookupByLibrary.simpleMessage("点击设置生日"),
    "closeButtonText": MessageLookupByLibrary.simpleMessage("关闭"),
    "clubFeeJoking": MessageLookupByLibrary.simpleMessage("冗談です！無料です"),
    "clubFeePrefix": MessageLookupByLibrary.simpleMessage("クラブ料金：月額99ドル"),
    "clubPromotionContent": MessageLookupByLibrary.simpleMessage(
      "素晴らしい特典のために限定クラブに参加",
    ),
    "clubPromotionTitle": MessageLookupByLibrary.simpleMessage("クラブに参加"),
    "commonLanguage": MessageLookupByLibrary.simpleMessage("主要言語"),
    "commonLanguageTitle": MessageLookupByLibrary.simpleMessage("一般的に使用される言語"),
    "communicationCompatibility": MessageLookupByLibrary.simpleMessage(
      "コミュニケーション",
    ),
    "compatibilityScore": MessageLookupByLibrary.simpleMessage("相性"),
    "completeAstroInfo": MessageLookupByLibrary.simpleMessage("詳細な星盤情報を完成させる"),
    "completeAstroProfile": MessageLookupByLibrary.simpleMessage(
      "星盤プロフィールを完成させて",
    ),
    "completeAstroProfileButton": MessageLookupByLibrary.simpleMessage(
      "星盤プロフィール完成",
    ),
    "completeBirthLocationInfo": MessageLookupByLibrary.simpleMessage(
      "请完善出生地信息",
    ),
    "completeProfile": MessageLookupByLibrary.simpleMessage("プロフィールを完成"),
    "confirmSelectLocation": MessageLookupByLibrary.simpleMessage(
      "この場所を選択することを確認",
    ),
    "continueWithPhone": MessageLookupByLibrary.simpleMessage("電話で続行"),
    "currentSelectedCoordinates": MessageLookupByLibrary.simpleMessage(
      "現在選択されている座標",
    ),
    "deepAnalysisReportTitle": MessageLookupByLibrary.simpleMessage("深度AI分析报告"),
    "deepSynastryAnalysis": MessageLookupByLibrary.simpleMessage("深度分析"),
    "deepSynastryRemark": MessageLookupByLibrary.simpleMessage("深い相性分析"),
    "defaultBirthTime": MessageLookupByLibrary.simpleMessage("12:00 (默认)"),
    "deletePhoto": MessageLookupByLibrary.simpleMessage("写真を削除"),
    "deletePhotoContent": MessageLookupByLibrary.simpleMessage(
      "この写真を削除してもよろしいですか？この操作は取り消すことができません。",
    ),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage("説明（任意）"),
    "destinyMatch": MessageLookupByLibrary.simpleMessage("命定"),
    "diamondConsumeFailed": MessageLookupByLibrary.simpleMessage(
      "ダイヤモンド消費に失敗しました",
    ),
    "diamondInsufficient": MessageLookupByLibrary.simpleMessage("钻石不足"),
    "diamondPack1": MessageLookupByLibrary.simpleMessage("ダイヤモンドパック"),
    "diamondPack2": MessageLookupByLibrary.simpleMessage("ダイヤモンドチェスト"),
    "diamondPack3": MessageLookupByLibrary.simpleMessage("ダイヤモンドギフト"),
    "diamondPack4": MessageLookupByLibrary.simpleMessage("ダイヤモンドバンドル"),
    "diamondPack5": MessageLookupByLibrary.simpleMessage("ダイヤモンド至尊パック"),
    "diamondStore": MessageLookupByLibrary.simpleMessage("ダイヤモンドストア"),
    "diamondStoreSubtitle": MessageLookupByLibrary.simpleMessage(
      "ダイヤモンドでプレミアム機能を解除",
    ),
    "diamondStoreTitle": MessageLookupByLibrary.simpleMessage("ダイヤモンドストア"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("免責事項"),
    "displayMyCity": MessageLookupByLibrary.simpleMessage("私の都市を表示"),
    "dm": MessageLookupByLibrary.simpleMessage("ディーエム"),
    "duoSnap": MessageLookupByLibrary.simpleMessage("デュオスナップ"),
    "duosnapAnyway": MessageLookupByLibrary.simpleMessage("とにかくデュオスナップ"),
    "editProfile": MessageLookupByLibrary.simpleMessage("プロフィールを編集"),
    "emotionalCompatibility": MessageLookupByLibrary.simpleMessage("感情"),
    "emptyChatRoomMessage": MessageLookupByLibrary.simpleMessage(
      "あなたの専用チャットルームはまだ空です\nでも星は知っています、運命の人はあなたに向かって来ています",
    ),
    "enterBirthPlace": MessageLookupByLibrary.simpleMessage("请输入出生地"),
    "exceptionAstroLearnContentFilterTips":
        MessageLookupByLibrary.simpleMessage(
          "送信されていない。AstroLearnは禁止された言葉を翻訳しません。",
        ),
    "exceptionAstroLearnOverloadedTips": MessageLookupByLibrary.simpleMessage(
      "AstroLearnは過負荷です、後で再試行してください。",
    ),
    "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
      "送信に失敗しました、後で再試行してください。",
    ),
    "fateOnTheWay": MessageLookupByLibrary.simpleMessage("運命は道の途中に"),
    "feedback": MessageLookupByLibrary.simpleMessage("フィードバック"),
    "filter": MessageLookupByLibrary.simpleMessage("フィルター"),
    "findingFolksWhoShareYourInterests": MessageLookupByLibrary.simpleMessage(
      "同じ趣味を持つ人を見つける",
    ),
    "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
      "AstroLearnは潜在的な友人を探しています...",
    ),
    "friendsIntention": MessageLookupByLibrary.simpleMessage(
      "こんにちは!面白そうな人だね。ちょっと話してみませんか？",
    ),
    "futureCompatibility": MessageLookupByLibrary.simpleMessage("未来"),
    "geminiSign": MessageLookupByLibrary.simpleMessage("双子座"),
    "getAstroLearnPlus": MessageLookupByLibrary.simpleMessage(
      "AstroLearn Plusを入手",
    ),
    "gifNotAllowed": MessageLookupByLibrary.simpleMessage("GIFは許可されていません"),
    "goDiscover": MessageLookupByLibrary.simpleMessage("発見に行く"),
    "gotIt": MessageLookupByLibrary.simpleMessage("分かった"),
    "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
      "ねえ、誰が最初に沈黙を破ると思う？",
    ),
    "haveAstroLearnSayHi": MessageLookupByLibrary.simpleMessage(
      "AstroLearnに挨拶させて",
    ),
    "hereAstroLearnCookedUpForU": MessageLookupByLibrary.simpleMessage(
      "これはAstroLearn特製です",
    ),
    "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
      "AIのAI同期通訳についてどう思いますか?",
    ),
    "iDigYourEnergy": MessageLookupByLibrary.simpleMessage("あなたのオーラがすごくいい感じ！"),
    "iLikeYourStyle": MessageLookupByLibrary.simpleMessage("スタイルがすごくかわいいわね!"),
    "imInterestedSomething": m0,
    "imVeryInterestedInSomething": m1,
    "incompleteBirthdayInfo": MessageLookupByLibrary.simpleMessage(
      "ユーザーの生年月日情報が不完全です",
    ),
    "infoIncompleteTitle": MessageLookupByLibrary.simpleMessage("情報が不完全です"),
    "intellectualCompatibility": MessageLookupByLibrary.simpleMessage("知性"),
    "interests": MessageLookupByLibrary.simpleMessage("興味"),
    "interpretationOff": MessageLookupByLibrary.simpleMessage("AI同期通訳：オフ"),
    "interpretationOn": MessageLookupByLibrary.simpleMessage("AI同期通訳：オン"),
    "issues": MessageLookupByLibrary.simpleMessage("問題"),
    "justNow": MessageLookupByLibrary.simpleMessage("たった今"),
    "justSendALike": MessageLookupByLibrary.simpleMessage("感謝の気持ちを伝えるだけ"),
    "justTypeInYourLanguage": m2,
    "leoSign": MessageLookupByLibrary.simpleMessage("獅子座"),
    "letAstroLearnSayHiForYou": MessageLookupByLibrary.simpleMessage(
      "AstroLearnに挨拶させて",
    ),
    "libraSign": MessageLookupByLibrary.simpleMessage("天秤座"),
    "lifestyleCompatibility": MessageLookupByLibrary.simpleMessage("ライフスタイル"),
    "lightAnalysisTitle": MessageLookupByLibrary.simpleMessage("轻度AI分析"),
    "lightSynastryRemark": MessageLookupByLibrary.simpleMessage("相性分析"),
    "likeBack": MessageLookupByLibrary.simpleMessage("いいね返し"),
    "likedBack": MessageLookupByLibrary.simpleMessage("いいね返し済み"),
    "likedPageMonetizeButton": MessageLookupByLibrary.simpleMessage(
      "彼らの共有について知ろう",
    ),
    "likedPageNoData": MessageLookupByLibrary.simpleMessage(
      "ステータス：まだ評価がないね\n\nすること：共有を始める\n\n提案：\n本物の写真を\n本当のストーリーを\n興味を共有しよう\n\nつまり...\n素敵な写真をアップロード\n本物の自己紹介を書く\n興味を選ぶ",
    ),
    "likedYou": MessageLookupByLibrary.simpleMessage("あなたの共有を評価してくれる"),
    "loading": MessageLookupByLibrary.simpleMessage("読み込み中..."),
    "locationAuthorizeContent": MessageLookupByLibrary.simpleMessage(
      "近くの人を見せるために位置情報が必要です",
    ),
    "locationLocatedFailed": MessageLookupByLibrary.simpleMessage(
      "場所の取得に失敗しました",
    ),
    "locationLocatedSuccess": MessageLookupByLibrary.simpleMessage(
      "現在位置に移動しました",
    ),
    "locationPermissionRequestSubtitle": MessageLookupByLibrary.simpleMessage(
      "より良いサービスのために, 位置情報提供をお願いします",
    ),
    "locationPermissionRequestTitle": MessageLookupByLibrary.simpleMessage(
      "位置を許可する",
    ),
    "mapSelectedLocation": MessageLookupByLibrary.simpleMessage("マップで選択された場所"),
    "matchPageSelectIdeas": m3,
    "me": MessageLookupByLibrary.simpleMessage("マイページ"),
    "memberCenter": MessageLookupByLibrary.simpleMessage("会員センター"),
    "membersPerks": MessageLookupByLibrary.simpleMessage("メンバーは限定特典を獲得"),
    "month": MessageLookupByLibrary.simpleMessage("月"),
    "morePhotosBenefit": MessageLookupByLibrary.simpleMessage(
      "写真多いほどおすすめ度高くなる",
    ),
    "morePhotosMoreCharm": MessageLookupByLibrary.simpleMessage("写真増えて、魅力もね♪"),
    "myPhotos": MessageLookupByLibrary.simpleMessage("私の写真"),
    "myProfileTitle": MessageLookupByLibrary.simpleMessage("マイプロフィール"),
    "navigateToAstroProfile": MessageLookupByLibrary.simpleMessage(
      "星盤プロフィールページにジャンプ",
    ),
    "nearby": MessageLookupByLibrary.simpleMessage("近くに"),
    "newGameplay": MessageLookupByLibrary.simpleMessage("新しいゲームプレイ"),
    "newMatch": MessageLookupByLibrary.simpleMessage("新しいつながり！"),
    "nextBilingDate": MessageLookupByLibrary.simpleMessage("次の請求日"),
    "noMessageTips": MessageLookupByLibrary.simpleMessage(
      "ステータス：メッセージなし\n\nすること：さあ、聞き手を探そう！\n\n提案：本当の自分を共有しよう",
    ),
    "noOneFoundYourCharm": MessageLookupByLibrary.simpleMessage(
      "まだ誰もあなたの魅力を見つけていません",
    ),
    "noThanks": MessageLookupByLibrary.simpleMessage("いいえ、ありがとう"),
    "notifications": MessageLookupByLibrary.simpleMessage("通知"),
    "onboarding0": MessageLookupByLibrary.simpleMessage(
      "AstroLearnは世界中の人々の共通の我が家です",
    ),
    "onboarding1": MessageLookupByLibrary.simpleMessage(
      "自宅にいても、旅行中でも、世界中の人々と出会おう。そして…",
    ),
    "onboarding2": MessageLookupByLibrary.simpleMessage(
      "ほら、魔法を授けるよ:\n全知言語\nもう外国語が分からないなんて心配いらないだろ",
    ),
    "onboarding3": MessageLookupByLibrary.simpleMessage(
      "余計な話は省いて、始めよう！\n伝説のロマンチックな出会いがあなたを待っているよ",
    ),
    "onboardingWish": MessageLookupByLibrary.simpleMessage(
      "願いリストを完成させて、\nより理想的なマッチを得ましょう",
    ),
    "oneLineToWin": MessageLookupByLibrary.simpleMessage("一言で相手を魅了"),
    "oopsNoDataRightNow": MessageLookupByLibrary.simpleMessage(
      "おっと、今はデータがありません",
    ),
    "peopleFromYourWishlistGetMoreRecommendations":
        MessageLookupByLibrary.simpleMessage(
          "あなたのウィッシュリストの設定はもっと大きな役割を果たすようになるよ",
        ),
    "permissionRequiredContent": MessageLookupByLibrary.simpleMessage(
      "最高の体験を提供するためにこの権限が必要です",
    ),
    "permissionRequiredTitle": MessageLookupByLibrary.simpleMessage("権限が必要です"),
    "personaCompleteProfile": MessageLookupByLibrary.simpleMessage(
      "基本プロフィールを完成",
    ),
    "personaCompleteProfileDesc": MessageLookupByLibrary.simpleMessage(
      "名前、誕生日、性別を完成してより多くのおすすめをアンロック",
    ),
    "personaEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "メッセージ通知を有効にする",
    ),
    "personaEnableNotificationsDesc": MessageLookupByLibrary.simpleMessage(
      "マッチとメッセージを見逃さず、タイムリーにやり取り",
    ),
    "personaForYou": MessageLookupByLibrary.simpleMessage("おすすめ"),
    "personaShowCity": MessageLookupByLibrary.simpleMessage("あなたの都市を表示"),
    "personaShowCityDesc": MessageLookupByLibrary.simpleMessage(
      "地元ユーザーに見つけられやすくなる",
    ),
    "personaUploadPhotos": MessageLookupByLibrary.simpleMessage("写真をアップロード"),
    "personaUploadPhotosDesc": MessageLookupByLibrary.simpleMessage(
      "少なくとも2枚の鮮明な写真を追加して露出を増やす",
    ),
    "photoFromCamera": MessageLookupByLibrary.simpleMessage("写真を撮る"),
    "photoFromGallery": MessageLookupByLibrary.simpleMessage("ギャラリーから選択"),
    "photoMightNotBeReal": MessageLookupByLibrary.simpleMessage(
      "この写真は本物ではない可能性があります",
    ),
    "photos": MessageLookupByLibrary.simpleMessage("写真"),
    "piscesSign": MessageLookupByLibrary.simpleMessage("魚座"),
    "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
        MessageLookupByLibrary.simpleMessage(
          "ネットワークを確認するか、更新ボタンを押してリトライしてくださいね~",
        ),
    "plusBenefitActivityReminder": MessageLookupByLibrary.simpleMessage(
      "活動と復帰リマインダー",
    ),
    "plusBenefitActivitySort": MessageLookupByLibrary.simpleMessage(
      "最近の活動と返信率で並び替え",
    ),
    "plusBenefitAdvancedFilter": MessageLookupByLibrary.simpleMessage(
      "高度なフィルター：国/言語/タイムゾーン/都市",
    ),
    "plusBenefitAntiHarassment": MessageLookupByLibrary.simpleMessage(
      "優先的な反ハラスメント保護と重み保護",
    ),
    "plusBenefitConflictAdvice": MessageLookupByLibrary.simpleMessage(
      "対立点と関係アドバイス",
    ),
    "plusBenefitDestinyPriority": MessageLookupByLibrary.simpleMessage(
      "推薦とライクで命定優先表示",
    ),
    "plusBenefitDestinyPush": MessageLookupByLibrary.simpleMessage(
      "新しい命定マッチ到着通知",
    ),
    "plusBenefitDimensionBreakdown": MessageLookupByLibrary.simpleMessage(
      "4次元分解：性格/コミュニケーション/親密さ/境界",
    ),
    "plusBenefitHighMatchDisplay": MessageLookupByLibrary.simpleMessage(
      "高マッチスコアとパーセンテージ表示",
    ),
    "plusBenefitHistoryTranslation": MessageLookupByLibrary.simpleMessage(
      "メッセージ履歴のワンクリック翻訳",
    ),
    "plusBenefitInterestFilter": MessageLookupByLibrary.simpleMessage(
      "興味と旅行計画フィルター",
    ),
    "plusBenefitLikeReminder": MessageLookupByLibrary.simpleMessage(
      "いいね返しと既読リマインダー",
    ),
    "plusBenefitMatchScore": MessageLookupByLibrary.simpleMessage(
      "全体的な相性スコアの可視化",
    ),
    "plusBenefitMessageTemplates": MessageLookupByLibrary.simpleMessage(
      "クイックメッセージテンプレート（褒め/招待/プラットフォーム切り替え）",
    ),
    "plusBenefitOCRTranslation": MessageLookupByLibrary.simpleMessage(
      "画像の即座翻訳とテキスト認識",
    ),
    "plusBenefitRealTimeTranslation": MessageLookupByLibrary.simpleMessage(
      "リアルタイム翻訳と磨き：多言語自動修正",
    ),
    "plusBenefitSmartOpener": MessageLookupByLibrary.simpleMessage(
      "スマートオープニング：1人3つの高コンバージョン提案",
    ),
    "plusBenefitStarGreeting": MessageLookupByLibrary.simpleMessage(
      "星語あいさつパック：1日10回",
    ),
    "plusBenefitSupportChannel": MessageLookupByLibrary.simpleMessage(
      "サブスクリプション問題の迅速解決",
    ),
    "plusBenefitTopicPool": MessageLookupByLibrary.simpleMessage(
      "プロフィール分析に基づく会話トピックプール",
    ),
    "plusBenefitUnlockLikedMe": MessageLookupByLibrary.simpleMessage(
      "いいねされたでクリアなアバターとタグをアンロック",
    ),
    "plusDescTitle": MessageLookupByLibrary.simpleMessage("Plus説明"),
    "plusFuncAIInterpretation": MessageLookupByLibrary.simpleMessage(
      "1日に1000回のAI同期通訳",
    ),
    "plusFuncAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "AstroLearn Tips - あなたのチャット参謀",
    ),
    "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage("週に5回のDM"),
    "plusFuncFilterMatchingCountries": MessageLookupByLibrary.simpleMessage(
      "つながりの国を絞り込む",
    ),
    "plusFuncUnlimitedLikes": MessageLookupByLibrary.simpleMessage("いいね無制限"),
    "plusFuncUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "あなたの共有を評価してくれる人が誰か見るために解除",
    ),
    "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3つの願い"),
    "plusMember": MessageLookupByLibrary.simpleMessage("Plus会員"),
    "plusMembershipBenefits": MessageLookupByLibrary.simpleMessage("Plus会員特典"),
    "plusPerkDuoSnap": MessageLookupByLibrary.simpleMessage("Plusでデュオスナップ"),
    "preference": MessageLookupByLibrary.simpleMessage("好み"),
    "privacy": MessageLookupByLibrary.simpleMessage("プライバシー"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("プライバシーポリシー"),
    "productNotFound": MessageLookupByLibrary.simpleMessage("商品不存在"),
    "profileInfoTab": MessageLookupByLibrary.simpleMessage("プロフィール"),
    "profileNotShown": MessageLookupByLibrary.simpleMessage("まだ本音を出していない"),
    "profileTip": MessageLookupByLibrary.simpleMessage(
      "✨ プロフィールを完成させて、星があなたをもっとよく知れるように、より正確なマッチングを",
    ),
    "purchaseFailed": MessageLookupByLibrary.simpleMessage("購入に失敗しました"),
    "purchasePending": MessageLookupByLibrary.simpleMessage("購入処理中..."),
    "pushNotifications": MessageLookupByLibrary.simpleMessage("プッシュ通知"),
    "quickActions": MessageLookupByLibrary.simpleMessage("クイックアクション"),
    "remindUploadPhoto": MessageLookupByLibrary.simpleMessage(
      "📸 写真のアップロードを促し、お互いをもっと知り合いましょう",
    ),
    "report": MessageLookupByLibrary.simpleMessage("報告する"),
    "reportOptionGore": MessageLookupByLibrary.simpleMessage("グロテスク"),
    "reportOptionOther": MessageLookupByLibrary.simpleMessage("その他"),
    "reportOptionPerAstroLearnlAttack": MessageLookupByLibrary.simpleMessage(
      "人身攻撃",
    ),
    "reportOptionPersonalAttack": MessageLookupByLibrary.simpleMessage("人身攻撃"),
    "reportOptionPornography": MessageLookupByLibrary.simpleMessage("ポルノ"),
    "reportOptionScam": MessageLookupByLibrary.simpleMessage("詐欺"),
    "requireYourRealPhoto": MessageLookupByLibrary.simpleMessage(
      "あなたの本物の写真が必要です",
    ),
    "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
      "あなたの近くの外国人に出会う",
    ),
    "sagittariusSign": MessageLookupByLibrary.simpleMessage("射手座"),
    "scorpioSign": MessageLookupByLibrary.simpleMessage("蠍座"),
    "screenshotEvidence": MessageLookupByLibrary.simpleMessage("スクリーンショットの証拠"),
    "seeProfile": MessageLookupByLibrary.simpleMessage("プロフィールを見る"),
    "seeWhoLikeU": MessageLookupByLibrary.simpleMessage(
      "誰があなたの共有を評価してくれるか見てみて",
    ),
    "selectBirthPlace": MessageLookupByLibrary.simpleMessage("选择出生地"),
    "selectBirthdayHint": MessageLookupByLibrary.simpleMessage(
      "生年月日を選択して星座チャートを表示してください",
    ),
    "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage("国を選択"),
    "selectLocationTitle": MessageLookupByLibrary.simpleMessage("場所を選択"),
    "sendDm": MessageLookupByLibrary.simpleMessage("DMを送る"),
    "sendDmRemark": MessageLookupByLibrary.simpleMessage("DMメッセージ送信"),
    "sendStarGreetingToUnlockAlbum": MessageLookupByLibrary.simpleMessage(
      "💫 星の挨拶を送ってアルバムをアンロック 続行",
    ),
    "setDefault": MessageLookupByLibrary.simpleMessage("デフォルトに設定"),
    "setInterestTags": MessageLookupByLibrary.simpleMessage("明確な興味タグを設定する"),
    "settings": MessageLookupByLibrary.simpleMessage("設定"),
    "showYourPerAstroLearnlity": MessageLookupByLibrary.simpleMessage(
      "あなたの世界観や個性を表現してみてね ♪",
    ),
    "showYourPersonality": MessageLookupByLibrary.simpleMessage("あなたの個性を見せて"),
    "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage("もうすぐ完成です"),
    "sixMonths": MessageLookupByLibrary.simpleMessage("6ヶ月"),
    "speakSameLanguage": MessageLookupByLibrary.simpleMessage(
      "🤝 同語なら翻訳しなくてもいいよ",
    ),
    "standard": MessageLookupByLibrary.simpleMessage("標準"),
    "startChat": MessageLookupByLibrary.simpleMessage("チャット開始"),
    "startedChat": MessageLookupByLibrary.simpleMessage("チャット開始"),
    "subPageSubtitleAIInterpretationDaily":
        MessageLookupByLibrary.simpleMessage("1日に1000回\nのAI同期通訳"),
    "subPageSubtitleAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "AstroLearn Tips - \nあなたのチャット参謀",
    ),
    "subPageSubtitleDMWeekly": MessageLookupByLibrary.simpleMessage("週に5回のDM"),
    "subPageSubtitleFilterMatchingCountries":
        MessageLookupByLibrary.simpleMessage("つながりの\n国を絞り込む"),
    "subPageSubtitleUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "いいね無制限",
    ),
    "subPageSubtitleUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "あなたの共有を評価してくれる人が\n誰か見るために解除",
    ),
    "subPageTitle": MessageLookupByLibrary.simpleMessage("AstroLearn Plusを入手"),
    "subscriptionAgreement": MessageLookupByLibrary.simpleMessage("利用規約"),
    "subscriptionAgreementPrefix": m4,
    "subscriptionAgreementSuffix": MessageLookupByLibrary.simpleMessage(
      "に同意したことになります。",
    ),
    "sunSignLabel": MessageLookupByLibrary.simpleMessage("太阳星座"),
    "synastryAnalysis": MessageLookupByLibrary.simpleMessage("合盘分析"),
    "takeIt": MessageLookupByLibrary.simpleMessage("使用する"),
    "taurusSign": MessageLookupByLibrary.simpleMessage("牡牛座"),
    "termsOfService": MessageLookupByLibrary.simpleMessage("利用規約"),
    "theKeyIsBalance": MessageLookupByLibrary.simpleMessage("バランスが鍵です"),
    "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
      "👆 彼らはあなたの返事を待ってるよ",
    ),
    "threeMonths": MessageLookupByLibrary.simpleMessage("3ヶ月"),
    "toastHitDailyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👀1日の制限に達しました",
    ),
    "toastHitWeeklyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👅週の制限に達しました",
    ),
    "unknownLocation": MessageLookupByLibrary.simpleMessage("不明"),
    "unlockHighMatchUsers": m5,
    "unlockUsersWithDestiny": m6,
    "unmissableSpecialOfferPrices": MessageLookupByLibrary.simpleMessage(
      "見逃せない特別価格",
    ),
    "unsupportedPlatform": MessageLookupByLibrary.simpleMessage("不支持的平台"),
    "upgradeForMoreRecommendations": MessageLookupByLibrary.simpleMessage(
      "プレミアムにアップグレードしてより多くのおすすめを",
    ),
    "uploadQualityPhotos": MessageLookupByLibrary.simpleMessage(
      "高品質な本物の写真をアップロード",
    ),
    "uploadYourPhoto": MessageLookupByLibrary.simpleMessage("写真をアップロード"),
    "uploadYourPhotoHint": MessageLookupByLibrary.simpleMessage("最高の写真をアップロード"),
    "uploading": MessageLookupByLibrary.simpleMessage("アップロード中..."),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage("現在位置を使用"),
    "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage("写真を撮る"),
    "userAvatarOptionGallery": MessageLookupByLibrary.simpleMessage(
      "ギャラリーから選択",
    ),
    "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
      "良いポートレートはもっと多くの聞き手とつながるのに役立ちます。本物の写真を使ってください。",
    ),
    "userAvatarPageTitle": MessageLookupByLibrary.simpleMessage("写真を追加する"),
    "userAvatarUploadedLabel": MessageLookupByLibrary.simpleMessage(
      "アップロード完了！",
    ),
    "userBirthdayInputLabel": MessageLookupByLibrary.simpleMessage("生年月日"),
    "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "確認されたら、国籍は変更できません",
    ),
    "userCitizenshipPickerTitle": MessageLookupByLibrary.simpleMessage("国籍"),
    "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("性別"),
    "userGenderOptionFemale": MessageLookupByLibrary.simpleMessage("女性"),
    "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("男性"),
    "userGenderOptionNonBinary": MessageLookupByLibrary.simpleMessage(
      "ノンバイナリー",
    ),
    "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "公開されることなく、つながりのためだけに使用されます",
    ),
    "userInfoPageNamePlaceholder": MessageLookupByLibrary.simpleMessage("入力"),
    "userInfoPageTitle": MessageLookupByLibrary.simpleMessage("個人情報"),
    "userNameInputLabel": MessageLookupByLibrary.simpleMessage("お名前"),
    "userPhoneNumberPagePlaceholder": MessageLookupByLibrary.simpleMessage(
      "電話番号",
    ),
    "userPhoneNumberPagePrivacySuffix": MessageLookupByLibrary.simpleMessage(
      "に同意したことになります",
    ),
    "userPhoneNumberPagePrivacyText": MessageLookupByLibrary.simpleMessage(
      "プライバシーポリシー",
    ),
    "userPhoneNumberPageTermsAnd": MessageLookupByLibrary.simpleMessage("および"),
    "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
      "「次のステップ」をタップすることで、",
    ),
    "userPhoneNumberPageTermsText": MessageLookupByLibrary.simpleMessage(
      "利用規約",
    ),
    "userPhoneNumberPageTitle": MessageLookupByLibrary.simpleMessage(
      "携帯電話番号を入力",
    ),
    "valuesCompatibility": MessageLookupByLibrary.simpleMessage("価値観"),
    "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage(
      "認証コードを入力してください",
    ),
    "viewAstroReport": MessageLookupByLibrary.simpleMessage("星盤レポートを表示"),
    "virgoSign": MessageLookupByLibrary.simpleMessage("乙女座"),
    "wannaHollaAt": MessageLookupByLibrary.simpleMessage("共有したいですか…"),
    "warningCancelDisplayCity": MessageLookupByLibrary.simpleMessage(
      "閉じた後、ペアリング時にあなたの街は表示されません",
    ),
    "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
      "あなたのアカウントは14日後に自動的に削除されます。追加料金を避けるために、現在のサブスクリプションをキャンセルするために店に行くことを忘れないでください。",
    ),
    "warningDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "アカウントを削除すると、もうログインできなくなります。本当に削除しますか？",
    ),
    "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
      "外部リンクです。信頼できるソースか確認してください。未知のリンクは詐欺やデータ盗難の可能性があります。慎重に進んでください。",
    ),
    "warningTitleCaution": MessageLookupByLibrary.simpleMessage("注意"),
    "warningUnmatching": MessageLookupByLibrary.simpleMessage(
      "共有終了後、お互いの会話履歴が全てクリアされます。",
    ),
    "whatsYourEmail": MessageLookupByLibrary.simpleMessage("メールアドレスは何ですか？"),
    "whoLIkesYou": MessageLookupByLibrary.simpleMessage("あなたの共有を評価してくれる人"),
    "whoLikesU": MessageLookupByLibrary.simpleMessage("あなたを評価してくれる人"),
    "wishActivityAddTitle": MessageLookupByLibrary.simpleMessage(
      "あなたの考えを加えてみてね",
    ),
    "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "パートナーを見つけてあげるよ",
    ),
    "wishActivityPickerTitle": MessageLookupByLibrary.simpleMessage(
      "特別にしたいことあるかな?",
    ),
    "wishCityPickerSkipButton": m7,
    "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "そこに行くなら、どの都市を訪れたいですか？",
    ),
    "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage(
      "ど の国にもっと興味がありますか？",
    ),
    "wishCreationComplete": MessageLookupByLibrary.simpleMessage(
      "あなたの願い、受け取ったよ!",
    ),
    "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("既にここにいます"),
    "wishDateOptionNotSure": MessageLookupByLibrary.simpleMessage("まだ確かじゃないよ"),
    "wishDateOptionRecent": MessageLookupByLibrary.simpleMessage("最近ね、たぶん"),
    "wishDateOptionYear": MessageLookupByLibrary.simpleMessage("1年以内"),
    "wishDatePickerSubtitle": m8,
    "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("いつ"),
    "wishList": MessageLookupByLibrary.simpleMessage("願いリスト"),
    "wishes": MessageLookupByLibrary.simpleMessage("願い"),
    "writeInterestingBio": MessageLookupByLibrary.simpleMessage("興味深い自己紹介を書く"),
    "youAreAClubMemberNow": MessageLookupByLibrary.simpleMessage(
      "あなたは今クラブメンバーです",
    ),
    "youCanEditItAnytime": MessageLookupByLibrary.simpleMessage("いつでも編集できます"),
    "youSeemCool": MessageLookupByLibrary.simpleMessage("かっこよさそう。"),
  };
}
