// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
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
  String get localeName => 'ko';

  static String m0(something) => "\"${something}에 관심이 있어요!\"";

  static String m1(something) => "\'${something}\'에 매우 관심이 있어요！";

  static String m2(lang) => "${lang}로만 입력하세요";

  static String m3(gender) =>
      "${Intl.gender(gender, female: '그녀의', male: '그의', other: '그들의')} 어떤 아이디어가 마음에 드세요?";

  static String m4(storeName) =>
      "계속을 클릭하면 요금이 부과되며, 해당 패키지 가격에 따라 구독이 자동 갱신됩니다. ${storeName}를 통해 취소할 수 있습니다. 계속 진행하면 우리의 ";

  static String m5(country) => "건너뛰기, 그냥country}";

  static String m6(country) => "${country}에 가려고 하세요?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aMonth": MessageLookupByLibrary.simpleMessage("1개월"),
        "aYear": MessageLookupByLibrary.simpleMessage("1년"),
        "about": MessageLookupByLibrary.simpleMessage("정보"),
        "account": MessageLookupByLibrary.simpleMessage("계정"),
        "age": MessageLookupByLibrary.simpleMessage("나이"),
        "allPeople": MessageLookupByLibrary.simpleMessage("전부"),
        "bio": MessageLookupByLibrary.simpleMessage("소개"),
        "block": MessageLookupByLibrary.simpleMessage("차단"),
        "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
            MessageLookupByLibrary.simpleMessage(
                "이 사람을 차단해서 그들로부터 메시지를 받지 않게 하세요"),
        "boostYourAppeal": MessageLookupByLibrary.simpleMessage("매력 업"),
        "breakIce": MessageLookupByLibrary.simpleMessage(
            "🔨🔨🔨 나를 신경 쓰지 마🔨🔨🔨 분위기를 풀러 왔어🔨🔨🔨"),
        "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage("Plus 회원이에요"),
        "buttonCancel": MessageLookupByLibrary.simpleMessage("취소"),
        "buttonChange": MessageLookupByLibrary.simpleMessage("변경"),
        "buttonConfirm": MessageLookupByLibrary.simpleMessage("확인"),
        "buttonContinue": MessageLookupByLibrary.simpleMessage("계속"),
        "buttonCopy": MessageLookupByLibrary.simpleMessage("복사"),
        "buttonDelete": MessageLookupByLibrary.simpleMessage("삭제"),
        "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("계정 삭제"),
        "buttonDone": MessageLookupByLibrary.simpleMessage("완료"),
        "buttonEdit": MessageLookupByLibrary.simpleMessage("편집"),
        "buttonEditProfile": MessageLookupByLibrary.simpleMessage("프로필 편집"),
        "buttonGenerate": MessageLookupByLibrary.simpleMessage("생성하다"),
        "buttonGotIt": MessageLookupByLibrary.simpleMessage("알겠어요"),
        "buttonHitAIInterpretationMaximumLimit":
            MessageLookupByLibrary.simpleMessage("😪SONA 피곤해, 👇탭하고 에너지 충전해!"),
        "buttonKeepAccount": MessageLookupByLibrary.simpleMessage("계정 유지"),
        "buttonManage": MessageLookupByLibrary.simpleMessage("관리하다"),
        "buttonNext": MessageLookupByLibrary.simpleMessage("다음 단계"),
        "buttonOpenLink": MessageLookupByLibrary.simpleMessage("링크 열기"),
        "buttonPreview": MessageLookupByLibrary.simpleMessage("미리보기"),
        "buttonRefresh": MessageLookupByLibrary.simpleMessage("새로 고침"),
        "buttonResend": MessageLookupByLibrary.simpleMessage("다시 보내다"),
        "buttonRestore": MessageLookupByLibrary.simpleMessage("복원하다"),
        "buttonSave": MessageLookupByLibrary.simpleMessage("저장"),
        "buttonSignOut": MessageLookupByLibrary.simpleMessage("로그아웃"),
        "buttonSubmit": MessageLookupByLibrary.simpleMessage("제출하다"),
        "buttonUnmatch": MessageLookupByLibrary.simpleMessage("매치 해제"),
        "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("구독 취소"),
        "chat": MessageLookupByLibrary.simpleMessage("채팅"),
        "checkOutTheirProfiles":
            MessageLookupByLibrary.simpleMessage("그들의 프로필을 확인하세요"),
        "choosePlaceholder": MessageLookupByLibrary.simpleMessage("선택"),
        "commonLanguage": MessageLookupByLibrary.simpleMessage("주요 언어"),
        "commonLanguageTitle":
            MessageLookupByLibrary.simpleMessage("자주 사용되는 언어"),
        "descriptionOptional":
            MessageLookupByLibrary.simpleMessage("설명 (선택 사항)"),
        "disclaimer": MessageLookupByLibrary.simpleMessage("면책 조항"),
        "displayMyCity": MessageLookupByLibrary.simpleMessage("나의 도시 표시"),
        "dm": MessageLookupByLibrary.simpleMessage("DM"),
        "exceptionFailedToSendTips":
            MessageLookupByLibrary.simpleMessage("전송 실패, 나중에 다시 시도해주세요."),
        "exceptionSonaContentFilterTips": MessageLookupByLibrary.simpleMessage(
            "발송되지 않음. SONA는 금지된 단어를 번역하지 않습니다."),
        "exceptionSonaOverloadedTips": MessageLookupByLibrary.simpleMessage(
            "SONA가 과부하 상태입니다, 나중에 다시 시도해주세요."),
        "feedback": MessageLookupByLibrary.simpleMessage("피드백"),
        "filter": MessageLookupByLibrary.simpleMessage("필터"),
        "findingFolksWhoShareYourInterests":
            MessageLookupByLibrary.simpleMessage("같은 관심사를 가진 사람들 찾기"),
        "firstLandingLoadingTitle":
            MessageLookupByLibrary.simpleMessage("SONA가 잠재적인 친구를 찾고 있습니다..."),
        "friendsIntention":
            MessageLookupByLibrary.simpleMessage("헤이, 너 정말 멋진 것 같아. 친구가 되어볼래?"),
        "getSonaPlus": MessageLookupByLibrary.simpleMessage("SONA Plus받기"),
        "guessWhoBreakSilence":
            MessageLookupByLibrary.simpleMessage("헤이, 누가 먼저 침묵을 깰까?"),
        "haveSonaSayHi":
            MessageLookupByLibrary.simpleMessage("SONA에게 인사하게 하세요"),
        "hereSonaCookedUpForU": MessageLookupByLibrary.simpleMessage(
            "이것은 SONA가 당신을 위해 특별히 만든 것입니다"),
        "howDoUFeelAboutAI":
            MessageLookupByLibrary.simpleMessage("AI 동시통역에 대해 어떻게 생각하세요?"),
        "iDigYourEnergy": MessageLookupByLibrary.simpleMessage("너의 에너지가 대단해!"),
        "iLikeYourStyle": MessageLookupByLibrary.simpleMessage("스타일이 마음에 들어요!"),
        "imInterestedSomething": m0,
        "imVeryInterestedInSomething": m1,
        "interests": MessageLookupByLibrary.simpleMessage("관심사"),
        "interpretationOff":
            MessageLookupByLibrary.simpleMessage("AI 동시 통역: 꺼짐"),
        "interpretationOn":
            MessageLookupByLibrary.simpleMessage("AI 동시 통역: 켜짐"),
        "justSendALike": MessageLookupByLibrary.simpleMessage("그냥 좋아요를 보내세요"),
        "justTypeInYourLanguage": m2,
        "letSONASayHiForYou":
            MessageLookupByLibrary.simpleMessage("SONA가 당신을 대신해 인사해요"),
        "likedPageMonetizeButton":
            MessageLookupByLibrary.simpleMessage("그들의 프로필을 확인하세요"),
        "likedPageNoData": MessageLookupByLibrary.simpleMessage(
            "상태: 아직 좋아요 없음\n\n할 일: 주도권을 잡다\n\n제안: \n만족스러운 사진을 업로드하세요\n진실된 바이오를 작성하세요\n관심사를 고르세요"),
        "likedYou": MessageLookupByLibrary.simpleMessage("당신을 좋아했어요"),
        "locationPermissionRequestSubtitle":
            MessageLookupByLibrary.simpleMessage(
                "소셜 경험을 향상시키기 위해 위치 정보가 필요합니다"),
        "locationPermissionRequestTitle":
            MessageLookupByLibrary.simpleMessage("위치 승인"),
        "matchPageSelectIdeas": m3,
        "me": MessageLookupByLibrary.simpleMessage("나"),
        "month": MessageLookupByLibrary.simpleMessage("월"),
        "morePhotosBenefit":
            MessageLookupByLibrary.simpleMessage("사진이 많을수록 추천도가 높아집니다"),
        "morePhotosMoreCharm":
            MessageLookupByLibrary.simpleMessage("사진이 더 많으면 매력도 더해요"),
        "nearby": MessageLookupByLibrary.simpleMessage("근처에"),
        "newMatch": MessageLookupByLibrary.simpleMessage("새로운 매치!"),
        "nextBilingDate": MessageLookupByLibrary.simpleMessage("다음 지불 날짜"),
        "noMessageTips": MessageLookupByLibrary.simpleMessage(
            "상태: 메시지 없음\n\n할 일: 매칭 페이지로 가자\n\n제안: 멋진 프로필을 만드세요"),
        "noThanks": MessageLookupByLibrary.simpleMessage("아니요, 감사합니다"),
        "notifications": MessageLookupByLibrary.simpleMessage("알림"),
        "onboarding0":
            MessageLookupByLibrary.simpleMessage("SONA는 세계 시민들의 근거지와 같습니다"),
        "onboarding1": MessageLookupByLibrary.simpleMessage(
            "집에 있든 길 위에 있든, 전 세계 사람들을 만나세요. 그리고..."),
        "onboarding2": MessageLookupByLibrary.simpleMessage(
            "언어를 마스터하는 초능력을 얻게 됩니다. 더 이상 의사소통 장벽은 없습니다"),
        "onboarding3": MessageLookupByLibrary.simpleMessage(
            "말은 줄이고, 사랑은 늘려요. 전설적인 로맨스가 당신을 기다리고 있습니다"),
        "onboardingWish":
            MessageLookupByLibrary.simpleMessage("소원 목록을 완성하여 더 이상적인 매칭을 얻으세요"),
        "oopsNoDataRightNow":
            MessageLookupByLibrary.simpleMessage("오잉, 지금 데이터가 없어요"),
        "peopleFromYourWishlistGetMoreRecommendations":
            MessageLookupByLibrary.simpleMessage(
                "당신의 위시리스트 설정이 더 큰 역할을 할 것입니다"),
        "photoFromCamera": MessageLookupByLibrary.simpleMessage("사진 찍기"),
        "photoFromGallery": MessageLookupByLibrary.simpleMessage("갤러리에서 선택"),
        "photos": MessageLookupByLibrary.simpleMessage("사진"),
        "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "인터넷을 확인하거나 새로 고침을 탭하여 다시 시도하세요"),
        "plusFuncAIInterpretation":
            MessageLookupByLibrary.simpleMessage("하루에 1000번 AI 동시통역"),
        "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage("주당 5회 DM"),
        "plusFuncFilterMatchingCountries":
            MessageLookupByLibrary.simpleMessage("매칭되는 국가 필터링"),
        "plusFuncSonaTips":
            MessageLookupByLibrary.simpleMessage("SONA Tips - 당신의 채팅 상담원"),
        "plusFuncUnlimitedLikes":
            MessageLookupByLibrary.simpleMessage("무제한 좋아요"),
        "plusFuncUnlockWhoLikesU":
            MessageLookupByLibrary.simpleMessage("좋아하는 사람이 누구인지 보려면 잠금 해제"),
        "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3개의 소원"),
        "preference": MessageLookupByLibrary.simpleMessage("취향"),
        "privacy": MessageLookupByLibrary.simpleMessage("프라이버시"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("개인정보처리방침"),
        "pushNotifications": MessageLookupByLibrary.simpleMessage("푸시 알림"),
        "report": MessageLookupByLibrary.simpleMessage("신고"),
        "reportOptionGore": MessageLookupByLibrary.simpleMessage("잔인함"),
        "reportOptionOther": MessageLookupByLibrary.simpleMessage("기타"),
        "reportOptionPersonalAttack":
            MessageLookupByLibrary.simpleMessage("인신공격"),
        "reportOptionPornography": MessageLookupByLibrary.simpleMessage("포르노"),
        "reportOptionScam": MessageLookupByLibrary.simpleMessage("사기"),
        "runningIntoForeignersNearYou":
            MessageLookupByLibrary.simpleMessage("당신 근처에서 외국인을 만나다"),
        "screenshotEvidence": MessageLookupByLibrary.simpleMessage("스크린샷 증거"),
        "seeProfile": MessageLookupByLibrary.simpleMessage("프로필 보기"),
        "seeWhoLikeU": MessageLookupByLibrary.simpleMessage("당신을 좋아하는 사람들 보기"),
        "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage("국가 선택"),
        "setDefault": MessageLookupByLibrary.simpleMessage("기본으로 설정"),
        "settings": MessageLookupByLibrary.simpleMessage("설정"),
        "showYourPersonality":
            MessageLookupByLibrary.simpleMessage("당신의 개성을 보여주세요"),
        "signUpLastStepPageTitle":
            MessageLookupByLibrary.simpleMessage("곧 완성됩니다"),
        "sixMonths": MessageLookupByLibrary.simpleMessage("6개월"),
        "sonaInterpretationOff":
            MessageLookupByLibrary.simpleMessage("⭕ SONA 동시 통역이 꺼졌습니다"),
        "sonaRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
            "Sona 추천: 쿨다운. \n해야 할 일: 기다리기. \n제안: 영화 보기?"),
        "sonaWillGenerateABioBasedOnInterests":
            MessageLookupByLibrary.simpleMessage(
                "SONA는 당신의 관심사에 기반하여 바이오를 생성할 것입니다"),
        "speakSameLanguage":
            MessageLookupByLibrary.simpleMessage("여러분은 같은 언어를 사용합니다"),
        "standard": MessageLookupByLibrary.simpleMessage("표준"),
        "subPageSubtitleAIInterpretationDaily":
            MessageLookupByLibrary.simpleMessage("하루에 1000번 \nAI 동시통역"),
        "subPageSubtitleDMWeekly":
            MessageLookupByLibrary.simpleMessage("주당 5회 DM"),
        "subPageSubtitleFilterMatchingCountries":
            MessageLookupByLibrary.simpleMessage("매칭되는 국가 \n필터링"),
        "subPageSubtitleSonaTips":
            MessageLookupByLibrary.simpleMessage("SONA Tips - \n당신의 채팅 상담원"),
        "subPageSubtitleUnlimitedLikes":
            MessageLookupByLibrary.simpleMessage("무제한 좋아요"),
        "subPageSubtitleUnlockWhoLikesU":
            MessageLookupByLibrary.simpleMessage("좋아하는 사람이 누구인지 \n보려면 잠금 해제"),
        "subPageTitle": MessageLookupByLibrary.simpleMessage("SONA Plus받기"),
        "subscriptionAgreement": MessageLookupByLibrary.simpleMessage("약관"),
        "subscriptionAgreementPrefix": m4,
        "subscriptionAgreementSuffix":
            MessageLookupByLibrary.simpleMessage("에 동의하는 것입니다."),
        "takeIt": MessageLookupByLibrary.simpleMessage("사용하다"),
        "termsOfService": MessageLookupByLibrary.simpleMessage("이용 약관"),
        "theKeyIsBalance": MessageLookupByLibrary.simpleMessage("균형이 관건이다"),
        "theyAreWaitingForYourReply":
            MessageLookupByLibrary.simpleMessage("👆 답장을 기다리고 있어요"),
        "threeMonths": MessageLookupByLibrary.simpleMessage("3개월"),
        "toastHitDailyMaximumLimit":
            MessageLookupByLibrary.simpleMessage("👀당신은 오늘의 한도에 도달했습니다"),
        "toastHitWeeklyMaximumLimit":
            MessageLookupByLibrary.simpleMessage("👅당신은 이번 주의 한도에 도달했습니다"),
        "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage("사진 찍기"),
        "userAvatarOptionGallery":
            MessageLookupByLibrary.simpleMessage("갤러리에서 선택"),
        "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
            "좋은 초상화는 더 많은 매치를 가져다 줍니다. 실제 사진을 사용하세요."),
        "userAvatarPageTitle":
            MessageLookupByLibrary.simpleMessage("너 자신을 드러내"),
        "userAvatarUploadedLabel":
            MessageLookupByLibrary.simpleMessage("업로드 완료!"),
        "userBirthdayInputLabel": MessageLookupByLibrary.simpleMessage("생년월일"),
        "userCitizenshipPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("확인되면, 국적은 변경할 수 없습니다"),
        "userCitizenshipPickerTitle":
            MessageLookupByLibrary.simpleMessage("국적"),
        "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("성별"),
        "userGenderOptionFemale": MessageLookupByLibrary.simpleMessage("여성"),
        "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("남성"),
        "userGenderOptionNonBinary":
            MessageLookupByLibrary.simpleMessage("비이성애자"),
        "userGenderPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("공개되지 않으며, 매칭을 위해서만 사용됩니다"),
        "userInfoPageNamePlaceholder":
            MessageLookupByLibrary.simpleMessage("입력"),
        "userInfoPageTitle": MessageLookupByLibrary.simpleMessage("기본 정보"),
        "userNameInputLabel": MessageLookupByLibrary.simpleMessage("이름"),
        "userPhoneNumberPagePlaceholder":
            MessageLookupByLibrary.simpleMessage("전화번호"),
        "userPhoneNumberPagePrivacySuffix":
            MessageLookupByLibrary.simpleMessage("에 동의하는 것입니다"),
        "userPhoneNumberPagePrivacyText":
            MessageLookupByLibrary.simpleMessage("개인정보 보호정책"),
        "userPhoneNumberPageTermsAnd":
            MessageLookupByLibrary.simpleMessage("및"),
        "userPhoneNumberPageTermsPrefix":
            MessageLookupByLibrary.simpleMessage("“다음 단계”를 탭하면, 우리의 "),
        "userPhoneNumberPageTermsText":
            MessageLookupByLibrary.simpleMessage("서비스 약관"),
        "userPhoneNumberPageTitle":
            MessageLookupByLibrary.simpleMessage("전화번호를 입력하세요"),
        "verifyCodePageTitle":
            MessageLookupByLibrary.simpleMessage("인증 코드를 입력하세요"),
        "wannaHollaAt": MessageLookupByLibrary.simpleMessage("인사해봐!"),
        "warningCancelDisplayCity":
            MessageLookupByLibrary.simpleMessage("닫은 후에는 페어링할 때 도시가 표시되지 않습니다"),
        "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
            "귀하의 계정은 14일 후에 자동으로 삭제될 예정입니다. 추가 요금을 피하기 위해 현재 구독을 취소하기 위해 매장에 가야 함을 기억해 주세요."),
        "warningDeleteAccount": MessageLookupByLibrary.simpleMessage(
            "계정을 삭제하면 더 이상 로그인할 수 없습니다. 정말 삭제하시겠습니까?"),
        "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
            "외부 링크입니다. 탭하기 전에 출처가 신뢰할 수 있는지 확인하세요. 알려지지 않은 링크는 사기 또는 데이터 도용일 수 있습니다. 주의해서 진행하세요."),
        "warningTitleCaution": MessageLookupByLibrary.simpleMessage("주의"),
        "warningUnmatching": MessageLookupByLibrary.simpleMessage(
            "페어링 해제 후, 서로의 채팅 내용이 모두 삭제됩니다."),
        "whoLIkesYou": MessageLookupByLibrary.simpleMessage("너를 좋아하는 사람"),
        "whoLikesU": MessageLookupByLibrary.simpleMessage("너를 좋아하는 사람"),
        "wishActivityAddTitle":
            MessageLookupByLibrary.simpleMessage("생각을 추가하세요"),
        "wishActivityPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("동반자 찾기를 도와드립니다"),
        "wishActivityPickerTitle":
            MessageLookupByLibrary.simpleMessage("뭔가 하고 싶어?"),
        "wishCityPickerSkipButton": m5,
        "wishCityPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("거기에 간다면, 어떤 도시를 방문하고 싶습니까?"),
        "wishCountryPickerTitle":
            MessageLookupByLibrary.simpleMessage("어느 나라에 더 관심이 있나요?"),
        "wishCreationComplete":
            MessageLookupByLibrary.simpleMessage("당신의 소원을 받았습니다"),
        "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("이미 여기 있어요"),
        "wishDateOptionNotSure":
            MessageLookupByLibrary.simpleMessage("아직 확실하지 않아"),
        "wishDateOptionRecent":
            MessageLookupByLibrary.simpleMessage("최근이라고 생각해요"),
        "wishDateOptionYear": MessageLookupByLibrary.simpleMessage("1년 이내"),
        "wishDatePickerSubtitle": m6,
        "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("언제"),
        "wishList": MessageLookupByLibrary.simpleMessage("소망 목록"),
        "wishes": MessageLookupByLibrary.simpleMessage("소원"),
        "youCanEditItAnytime":
            MessageLookupByLibrary.simpleMessage("언제든지 편집할 수 있습니다"),
        "youSeemCool": MessageLookupByLibrary.simpleMessage("멋져 보여요.")
      };
}
