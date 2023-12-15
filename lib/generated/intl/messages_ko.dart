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

  static String m4(country) => "건너뛰기, 그냥country}";

  static String m5(country) => "${country}에 가려고 하세요?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "age": MessageLookupByLibrary.simpleMessage("나이"),
        "block": MessageLookupByLibrary.simpleMessage("차단"),
        "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
            MessageLookupByLibrary.simpleMessage(
                "이 사람을 차단해서 그들로부터 메시지를 받지 않게 하세요"),
        "breakIce": MessageLookupByLibrary.simpleMessage(
            "🔨🔨🔨 나를 신경 쓰지 마🔨🔨🔨 분위기를 풀러 왔어🔨🔨🔨"),
        "buttonCopy": MessageLookupByLibrary.simpleMessage("복사"),
        "buttonDelete": MessageLookupByLibrary.simpleMessage("삭제"),
        "buttonOpenLink": MessageLookupByLibrary.simpleMessage("링크 열기"),
        "buttonResend": MessageLookupByLibrary.simpleMessage("다시 보내다"),
        "buttonUnmatch": MessageLookupByLibrary.simpleMessage("매치 해제"),
        "cancelButton": MessageLookupByLibrary.simpleMessage("취소"),
        "chat": MessageLookupByLibrary.simpleMessage("채팅"),
        "checkOutTheirProfiles":
            MessageLookupByLibrary.simpleMessage("그들의 프로필을 확인하세요"),
        "choosePlaceholder": MessageLookupByLibrary.simpleMessage("선택"),
        "commonLanguageTitle":
            MessageLookupByLibrary.simpleMessage("자주 사용되는 언어"),
        "descriptionOptional":
            MessageLookupByLibrary.simpleMessage("설명 (선택 사항)"),
        "dm": MessageLookupByLibrary.simpleMessage("DM"),
        "doneButton": MessageLookupByLibrary.simpleMessage("완료"),
        "exceptionFailedToSendTips":
            MessageLookupByLibrary.simpleMessage("전송 실패, 나중에 다시 시도해주세요."),
        "exceptionSonaContentFilterTips": MessageLookupByLibrary.simpleMessage(
            "발송되지 않음. SONA는 금지된 단어를 번역하지 않습니다."),
        "exceptionSonaOverloadedTips": MessageLookupByLibrary.simpleMessage(
            "SONA가 과부하 상태입니다, 나중에 다시 시도해주세요."),
        "filter": MessageLookupByLibrary.simpleMessage("필터"),
        "firstLandingLoadingTitle":
            MessageLookupByLibrary.simpleMessage("SONA가 잠재적인 친구를 찾고 있습니다..."),
        "friendsIntention":
            MessageLookupByLibrary.simpleMessage("헤이, 너 정말 멋진 것 같아. 친구가 되어볼래?"),
        "gore": MessageLookupByLibrary.simpleMessage("잔인함"),
        "guessWhoBreakSilence":
            MessageLookupByLibrary.simpleMessage("헤이, 누가 먼저 침묵을 깰까?"),
        "haveSonaSayHi":
            MessageLookupByLibrary.simpleMessage("SONA에게 인사하게 하세요"),
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
            MessageLookupByLibrary.simpleMessage("같은 도시의 외국인 찾기"),
        "locationPermissionRequestTitle":
            MessageLookupByLibrary.simpleMessage("위치 승인"),
        "matchPageSelectIdeas": m3,
        "nearby": MessageLookupByLibrary.simpleMessage("근처에"),
        "newMatch": MessageLookupByLibrary.simpleMessage("새로운 매치!"),
        "nextButton": MessageLookupByLibrary.simpleMessage("다음 단계"),
        "noMessageTips": MessageLookupByLibrary.simpleMessage(
            "상태: 메시지 없음\n\n할 일: 매칭 페이지로 가자\n\n제안: 멋진 프로필을 만드세요"),
        "oopsNoDataRightNow":
            MessageLookupByLibrary.simpleMessage("오잉, 지금 데이터가 없어요"),
        "other": MessageLookupByLibrary.simpleMessage("기타"),
        "peopleFromYourWishlistGetMoreRecommendations":
            MessageLookupByLibrary.simpleMessage(
                "당신의 위시리스트 설정이 더 큰 역할을 할 것입니다"),
        "personalAttack": MessageLookupByLibrary.simpleMessage("인신공격"),
        "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "인터넷을 확인하거나 새로 고침을 탭하여 다시 시도하세요"),
        "pornography": MessageLookupByLibrary.simpleMessage("포르노"),
        "preference": MessageLookupByLibrary.simpleMessage("취향"),
        "refresh": MessageLookupByLibrary.simpleMessage("새로 고침"),
        "report": MessageLookupByLibrary.simpleMessage("신고"),
        "resendButton": MessageLookupByLibrary.simpleMessage("다시 보내다"),
        "runningIntoForeignersNearYou":
            MessageLookupByLibrary.simpleMessage("당신 근처에서 외국인을 만나다"),
        "scam": MessageLookupByLibrary.simpleMessage("사기"),
        "screenshotEvidence": MessageLookupByLibrary.simpleMessage("스크린샷 증거"),
        "seeProfile": MessageLookupByLibrary.simpleMessage("프로필 보기"),
        "seeWhoLikeU": MessageLookupByLibrary.simpleMessage("당신을 좋아하는 사람들 보기"),
        "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage("국가 선택"),
        "signUpLastStepPageTitle":
            MessageLookupByLibrary.simpleMessage("마지막 단계"),
        "sonaInterpretationOff":
            MessageLookupByLibrary.simpleMessage("⭕ SONA 동시 통역이 꺼졌습니다"),
        "sonaRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
            "Sona 추천: 쿨다운. \n해야 할 일: 기다리기. \n제안: 영화 보기?"),
        "speakSameLanguage":
            MessageLookupByLibrary.simpleMessage("여러분은 같은 언어를 사용합니다"),
        "submitButton": MessageLookupByLibrary.simpleMessage("제출하다"),
        "theyAreWaitingForYourReply":
            MessageLookupByLibrary.simpleMessage("👆 답장을 기다리고 있어요"),
        "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage("사진 찍기"),
        "userAvatarOptionGallery":
            MessageLookupByLibrary.simpleMessage("갤러리에서 선택"),
        "userAvatarPageChangeButton":
            MessageLookupByLibrary.simpleMessage("변경"),
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
        "wishCityPickerSkipButton": m4,
        "wishCityPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("거기에 간다면, 어떤 도시를 방문하고 싶습니까?"),
        "wishCountryPickerSubtitle":
            MessageLookupByLibrary.simpleMessage("나라 사람들과 잘 맞습니까?"),
        "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage("어느"),
        "wishCreationComplete":
            MessageLookupByLibrary.simpleMessage("당신의 소원을 받았습니다"),
        "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("이미 여기 있어요"),
        "wishDateOptionNotSure":
            MessageLookupByLibrary.simpleMessage("아직 확실하지 않아"),
        "wishDateOptionRecent":
            MessageLookupByLibrary.simpleMessage("최근이라고 생각해요"),
        "wishDateOptionYear": MessageLookupByLibrary.simpleMessage("1년 이내"),
        "wishDatePickerSubtitle": m5,
        "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("언제"),
        "wishList": MessageLookupByLibrary.simpleMessage("소망 목록"),
        "wishes": MessageLookupByLibrary.simpleMessage("소원"),
        "youSeemCool": MessageLookupByLibrary.simpleMessage("멋져 보여요.")
      };
}
