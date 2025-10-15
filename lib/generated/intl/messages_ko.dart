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

  static String m0(month, day) => "${month}월 ${day}일";

  static String m1(x) => "30일 목표까지 ${x}일 남음";

  static String m2(something) => "\"${something}에 관심이 있어요!\"";

  static String m3(something) => "\'${something}\'에 매우 관심이 있어요！";

  static String m4(lang) => "${lang}로만 입력하세요";

  static String m5(gender) =>
      "${Intl.gender(gender, female: '그녀의', male: '그의', other: '그들의')} 어떤 공유 경험이 당신의 마음에 와 닿나요?";

  static String m6(minutes) => "${minutes} 분";

  static String m7(month, day) => "${month}월${day}일";

  static String m8(score) => "기분 ${score}/10";

  static String m9(error) => "❌ 저장 실패: ${error}";

  static String m10(x) => "🔥 ${x}일 연속!";

  static String m11(storeName) =>
      "계속을 클릭하면 요금이 부과되며, 해당 패키지 가격에 따라 구독이 자동 갱신됩니다. ${storeName}를 통해 취소할 수 있습니다. 계속 진행하면 우리의 ";

  static String m12(count) => "고매치 사용자 ${count}명 잠금 해제하여 보기 ✨";

  static String m13(count, destinyCount) =>
      "사용자 ${count}명 잠금 해제 운명의 매치 ${destinyCount}명 포함 ⭐";

  static String m14(country) => "건너뛰기, 그냥country}";

  static String m15(country) => "${country}에 가려고 하세요?";

  static String m16(x) => "${x}일";

  static String m17(x) => "${x}시간";

  static String m18(x) => "${x}회";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aMonth": MessageLookupByLibrary.simpleMessage("1개월"),
    "aYear": MessageLookupByLibrary.simpleMessage("1년"),
    "about": MessageLookupByLibrary.simpleMessage("정보"),
    "account": MessageLookupByLibrary.simpleMessage("계정"),
    "active_days": MessageLookupByLibrary.simpleMessage("활성 일수"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("사진 추가"),
    "age": MessageLookupByLibrary.simpleMessage("나이"),
    "aiCreatingFunGroupPics": MessageLookupByLibrary.simpleMessage(
      "AI가 재미있는 그룹 사진을 만들고 있습니다",
    ),
    "allPeople": MessageLookupByLibrary.simpleMessage("전부"),
    "analyzingText": MessageLookupByLibrary.simpleMessage("Analisando..."),
    "aquariusSign": MessageLookupByLibrary.simpleMessage("물병자리"),
    "ariesSign": MessageLookupByLibrary.simpleMessage("양자리"),
    "ascendantSignLabel": MessageLookupByLibrary.simpleMessage("ราศีอัศจรรย์"),
    "astroChartTab": MessageLookupByLibrary.simpleMessage("별자리 차트"),
    "astroInfoIncompleteMessage": MessageLookupByLibrary.simpleMessage(
      "상대방이 아직 출생지 정보를 완료하지 않았으므로 점성술 차트를 생성할 수 없습니다. 상대방이 정보를 완료할 때까지 기다려주세요.",
    ),
    "astroLearnInterpretationOff": MessageLookupByLibrary.simpleMessage(
      "⭕ Zena 동시 통역이 꺼졌습니다",
    ),
    "astroLearnRecommendationCooldown": MessageLookupByLibrary.simpleMessage(
      "Zena 추천: 쿨다운. \n해야 할 일: 기다리기. \n제안: 영화 보기?",
    ),
    "astroLearnWillGenerateABioBasedOnInterests":
        MessageLookupByLibrary.simpleMessage(
          "Zena는 당신의 관심사에 기반하여 바이오를 생성할 것입니다",
        ),
    "astroReport": MessageLookupByLibrary.simpleMessage("별자리 리포트"),
    "astro_calendar_title": MessageLookupByLibrary.simpleMessage("별자리 치유 캘린더"),
    "audio_1_desc": MessageLookupByLibrary.simpleMessage(
      "조용한 별하늘 아래서 내면의 평화를 찾으세요",
    ),
    "audio_1_title": MessageLookupByLibrary.simpleMessage("별하늘 명상"),
    "audio_2_desc": MessageLookupByLibrary.simpleMessage("내면의 용기와 활력을 일깨우세요"),
    "audio_2_title": MessageLookupByLibrary.simpleMessage("양자리 에너지 오디오"),
    "audio_3_desc": MessageLookupByLibrary.simpleMessage(
      "스트레스를 해소하고 완전한 이완을 찾으세요",
    ),
    "audio_3_title": MessageLookupByLibrary.simpleMessage("깊은 이완 가이드"),
    "audio_4_desc": MessageLookupByLibrary.simpleMessage(
      "감정의 균형을 잡고 내면의 조화를 찾으세요",
    ),
    "audio_4_title": MessageLookupByLibrary.simpleMessage("감정 균형 음악"),
    "avatarUpdateFailed": MessageLookupByLibrary.simpleMessage("아바타 업데이트 실패"),
    "average_mood": MessageLookupByLibrary.simpleMessage("평균 기분"),
    "bio": MessageLookupByLibrary.simpleMessage("소개"),
    "birthInfo": MessageLookupByLibrary.simpleMessage("ข้อมูลการเกิด"),
    "birthPlace": MessageLookupByLibrary.simpleMessage("สถานที่เกิด"),
    "birthPlaceLabel": MessageLookupByLibrary.simpleMessage("สถานที่เกิด"),
    "birthTimeLabel": MessageLookupByLibrary.simpleMessage("เวลาเกิด"),
    "birthday": MessageLookupByLibrary.simpleMessage("วันเกิด"),
    "block": MessageLookupByLibrary.simpleMessage("차단"),
    "blockThisPersonSoYouWontReceiveAnyMessagesFromThem":
        MessageLookupByLibrary.simpleMessage("이 사람을 차단해서 그들로부터 메시지를 받지 않게 하세요"),
    "boostYourAppeal": MessageLookupByLibrary.simpleMessage("매력 업"),
    "breakIce": MessageLookupByLibrary.simpleMessage(
      "🔨🔨🔨 나를 신경 쓰지 마🔨🔨🔨 분위기를 풀러 왔어🔨🔨🔨",
    ),
    "breathe_relax": MessageLookupByLibrary.simpleMessage("깊은 숨을 쉬고 휴식..."),
    "buttonAlreadyPlus": MessageLookupByLibrary.simpleMessage("Plus 회원이에요"),
    "buttonAuthorize": MessageLookupByLibrary.simpleMessage("승인"),
    "buttonCancel": MessageLookupByLibrary.simpleMessage("취소"),
    "buttonChange": MessageLookupByLibrary.simpleMessage("변경"),
    "buttonConfirm": MessageLookupByLibrary.simpleMessage("ยืนยัน"),
    "buttonContinue": MessageLookupByLibrary.simpleMessage("계속"),
    "buttonCopy": MessageLookupByLibrary.simpleMessage("복사"),
    "buttonDelete": MessageLookupByLibrary.simpleMessage("삭제"),
    "buttonDeleteAccount": MessageLookupByLibrary.simpleMessage("계정 삭제"),
    "buttonDone": MessageLookupByLibrary.simpleMessage("완료"),
    "buttonEdit": MessageLookupByLibrary.simpleMessage("편집"),
    "buttonEditProfile": MessageLookupByLibrary.simpleMessage("프로필 편집"),
    "buttonGenerate": MessageLookupByLibrary.simpleMessage("생성하다"),
    "buttonGo": MessageLookupByLibrary.simpleMessage("가다"),
    "buttonGotIt": MessageLookupByLibrary.simpleMessage("알겠어요"),
    "buttonHitAIInterpretationMaximumLimit":
        MessageLookupByLibrary.simpleMessage("😪Zena 피곤해, 👇탭하고 에너지 충전해!"),
    "buttonJoinNow": MessageLookupByLibrary.simpleMessage("지금 가입"),
    "buttonKeepAccount": MessageLookupByLibrary.simpleMessage("계정 유지"),
    "buttonManage": MessageLookupByLibrary.simpleMessage("관리하다"),
    "buttonNext": MessageLookupByLibrary.simpleMessage("다음 단계"),
    "buttonOpenLink": MessageLookupByLibrary.simpleMessage("링크 열기"),
    "buttonPreview": MessageLookupByLibrary.simpleMessage("미리보기"),
    "buttonPurchase": MessageLookupByLibrary.simpleMessage("구매"),
    "buttonRefresh": MessageLookupByLibrary.simpleMessage("새로 고침"),
    "buttonResend": MessageLookupByLibrary.simpleMessage("다시 보내다"),
    "buttonRestore": MessageLookupByLibrary.simpleMessage("복원하다"),
    "buttonSave": MessageLookupByLibrary.simpleMessage("저장"),
    "buttonSignOut": MessageLookupByLibrary.simpleMessage("로그아웃"),
    "buttonSubmit": MessageLookupByLibrary.simpleMessage("제출하다"),
    "buttonUnlockVipPerks": MessageLookupByLibrary.simpleMessage(
      "VIP 혜택 잠금 해제",
    ),
    "buttonUnmatch": MessageLookupByLibrary.simpleMessage("공유 종료"),
    "buttonUnsubscribe": MessageLookupByLibrary.simpleMessage("구독 취소"),
    "cancerSign": MessageLookupByLibrary.simpleMessage("게자리"),
    "capricornSign": MessageLookupByLibrary.simpleMessage("염소자리"),
    "catchMore": MessageLookupByLibrary.simpleMessage("더 많이 잡아"),
    "charmTips": MessageLookupByLibrary.simpleMessage("매력 향상 팁"),
    "chartPreview": MessageLookupByLibrary.simpleMessage("차트 미리보기"),
    "chat": MessageLookupByLibrary.simpleMessage("채팅"),
    "chatWithMatches": MessageLookupByLibrary.simpleMessage(
      "매칭된 사용자와 적극적으로 채팅하세요",
    ),
    "checkItOut": MessageLookupByLibrary.simpleMessage("확인해보세요"),
    "checkOutTheirProfiles": MessageLookupByLibrary.simpleMessage(
      "그들의 프로필을 확인하세요",
    ),
    "choosePlaceholder": MessageLookupByLibrary.simpleMessage("선택"),
    "clickToSetBirthPlace": MessageLookupByLibrary.simpleMessage(
      "คลิกเพื่อตั้งสถานที่เกิด",
    ),
    "clickToSetBirthday": MessageLookupByLibrary.simpleMessage(
      "คลิกเพื่อตั้งวันเกิด",
    ),
    "click_for_encouragement": MessageLookupByLibrary.simpleMessage(
      "격려를 받으려면 클릭",
    ),
    "click_to_record_status": MessageLookupByLibrary.simpleMessage("상태 기록하기"),
    "closeButtonText": MessageLookupByLibrary.simpleMessage("ปิด"),
    "clubFeeJoking": MessageLookupByLibrary.simpleMessage("농담이에요! 무료입니다"),
    "clubFeePrefix": MessageLookupByLibrary.simpleMessage("클럽 요금: 월 \$99"),
    "clubPromotionContent": MessageLookupByLibrary.simpleMessage(
      "놀라운 혜택을 위해 독점 클럽에 가입하세요",
    ),
    "clubPromotionTitle": MessageLookupByLibrary.simpleMessage("클럽에 가입"),
    "commonLanguage": MessageLookupByLibrary.simpleMessage("주요 언어"),
    "commonLanguageTitle": MessageLookupByLibrary.simpleMessage("자주 사용되는 언어"),
    "communicationCompatibility": MessageLookupByLibrary.simpleMessage(
      "커뮤니케이션",
    ),
    "compatibilityScore": MessageLookupByLibrary.simpleMessage("호환성"),
    "completeAstroInfo": MessageLookupByLibrary.simpleMessage(
      "상세한 별자리 정보를 완성하세요",
    ),
    "completeAstroProfile": MessageLookupByLibrary.simpleMessage(
      "별자리 프로필을 완성하세요",
    ),
    "completeAstroProfileButton": MessageLookupByLibrary.simpleMessage(
      "별자리 프로필 완성",
    ),
    "completeBirthLocationInfo": MessageLookupByLibrary.simpleMessage(
      "กรุณากรอกข้อมูลตำแหน่งที่เกิดให้ครบถ้วน",
    ),
    "completeProfile": MessageLookupByLibrary.simpleMessage("프로필 완성"),
    "confirmSelectLocation": MessageLookupByLibrary.simpleMessage("이 위치 선택 확인"),
    "continueWithPhone": MessageLookupByLibrary.simpleMessage("전화로 계속하기"),
    "currentSelectedCoordinates": MessageLookupByLibrary.simpleMessage(
      "현재 선택된 좌표",
    ),
    "current_emotion": MessageLookupByLibrary.simpleMessage("현재 감정"),
    "daily_quote": MessageLookupByLibrary.simpleMessage("오늘의 명언"),
    "daily_quotes_title": MessageLookupByLibrary.simpleMessage("일일 명언"),
    "daily_status": MessageLookupByLibrary.simpleMessage("일일 상태"),
    "date_format_md": m0,
    "days_to_30_goal": m1,
    "deepAnalysisReportTitle": MessageLookupByLibrary.simpleMessage(
      "รายงานการวิเคราะห์ AI อย่างลึกซึ้ง",
    ),
    "deepSynastryAnalysis": MessageLookupByLibrary.simpleMessage(
      "การวิเคราะห์เชิงลึก",
    ),
    "deepSynastryRemark": MessageLookupByLibrary.simpleMessage("심층 시너스트리 분석"),
    "defaultBirthTime": MessageLookupByLibrary.simpleMessage(
      "12:00 (ค่าเริ่มต้น)",
    ),
    "deletePhoto": MessageLookupByLibrary.simpleMessage("사진 삭제"),
    "deletePhotoContent": MessageLookupByLibrary.simpleMessage(
      "이 사진을 삭제하시겠습니까? 이 작업은 취소할 수 없습니다.",
    ),
    "descriptionOptional": MessageLookupByLibrary.simpleMessage("설명 (선택 사항)"),
    "destinyMatch": MessageLookupByLibrary.simpleMessage("운명의 매치"),
    "diamondConsumeFailed": MessageLookupByLibrary.simpleMessage("다이아몬드 소비 실패"),
    "diamondInsufficient": MessageLookupByLibrary.simpleMessage("다이아몬드가 부족합니다"),
    "diamondPack1": MessageLookupByLibrary.simpleMessage("다이아몬드 팩"),
    "diamondPack2": MessageLookupByLibrary.simpleMessage("다이아몬드 상자"),
    "diamondPack3": MessageLookupByLibrary.simpleMessage("다이아몬드 선물"),
    "diamondPack4": MessageLookupByLibrary.simpleMessage("다이아몬드 번들"),
    "diamondPack5": MessageLookupByLibrary.simpleMessage("다이아몬드 슈프림 팩"),
    "diamondStore": MessageLookupByLibrary.simpleMessage("다이아몬드 상점"),
    "diamondStoreSubtitle": MessageLookupByLibrary.simpleMessage(
      "다이아몬드로 프리미엄 기능 잠금 해제",
    ),
    "diamondStoreTitle": MessageLookupByLibrary.simpleMessage("다이아몬드 상점"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("면책 조항"),
    "displayMyCity": MessageLookupByLibrary.simpleMessage("나의 도시 표시"),
    "dm": MessageLookupByLibrary.simpleMessage("DM"),
    "duoSnap": MessageLookupByLibrary.simpleMessage("듀오 스냅"),
    "duosnapAnyway": MessageLookupByLibrary.simpleMessage("어쨌든 듀오 스냅"),
    "editProfile": MessageLookupByLibrary.simpleMessage("프로필 편집"),
    "emotion_analysis": MessageLookupByLibrary.simpleMessage("감정 분석"),
    "emotion_angry": MessageLookupByLibrary.simpleMessage("😠 화남"),
    "emotion_anxious": MessageLookupByLibrary.simpleMessage("😰 불안"),
    "emotion_calm": MessageLookupByLibrary.simpleMessage("😌 평온"),
    "emotion_category": MessageLookupByLibrary.simpleMessage("감정"),
    "emotion_diary": MessageLookupByLibrary.simpleMessage("감정 일기"),
    "emotion_diary_saved": MessageLookupByLibrary.simpleMessage("✅ 감정 일기 저장됨"),
    "emotion_diary_title": MessageLookupByLibrary.simpleMessage("감정 일기"),
    "emotion_distribution": MessageLookupByLibrary.simpleMessage("감정 분포"),
    "emotion_happy": MessageLookupByLibrary.simpleMessage("😊 행복"),
    "emotion_management": MessageLookupByLibrary.simpleMessage("감정 관리"),
    "emotion_management_title": MessageLookupByLibrary.simpleMessage("감정 관리"),
    "emotion_records": MessageLookupByLibrary.simpleMessage("감정 기록"),
    "emotion_sad": MessageLookupByLibrary.simpleMessage("😢 슬픔"),
    "emotion_subtitle": MessageLookupByLibrary.simpleMessage(
      "감정을 이해하고 자기 관리를 배우세요",
    ),
    "emotion_tip": MessageLookupByLibrary.simpleMessage(
      "현재의 자신을 받아들이고, 감정은 별처럼 흘러 결국 평화로 돌아간다",
    ),
    "emotion_tired": MessageLookupByLibrary.simpleMessage("😴 피곤"),
    "emotionalCompatibility": MessageLookupByLibrary.simpleMessage("감정"),
    "emptyChatRoomMessage": MessageLookupByLibrary.simpleMessage(
      "당신의 전용 채팅방은 아직 비어있습니다\n하지만 별들은 알고 있습니다, 운명의 사람이 당신에게 오고 있습니다",
    ),
    "energy": MessageLookupByLibrary.simpleMessage("에너지"),
    "energy_category": MessageLookupByLibrary.simpleMessage("에너지"),
    "energy_index": MessageLookupByLibrary.simpleMessage("에너지 지수"),
    "energy_level": MessageLookupByLibrary.simpleMessage("에너지 레벨"),
    "enterBirthPlace": MessageLookupByLibrary.simpleMessage(
      "กรุณากรอกสถานที่เกิด",
    ),
    "every_emotion_matters": MessageLookupByLibrary.simpleMessage(
      "모든 감정은 기록될 가치가 있습니다",
    ),
    "exceptionAstroLearnContentFilterTips":
        MessageLookupByLibrary.simpleMessage(
          "발송되지 않음. Zena는 금지된 단어를 번역하지 않습니다.",
        ),
    "exceptionAstroLearnOverloadedTips": MessageLookupByLibrary.simpleMessage(
      "Zena가 과부하 상태입니다, 나중에 다시 시도해주세요.",
    ),
    "exceptionFailedToSendTips": MessageLookupByLibrary.simpleMessage(
      "전송 실패, 나중에 다시 시도해주세요.",
    ),
    "fateOnTheWay": MessageLookupByLibrary.simpleMessage("운명이 오고 있어"),
    "feedback": MessageLookupByLibrary.simpleMessage("피드백"),
    "filter": MessageLookupByLibrary.simpleMessage("필터"),
    "findingFolksWhoShareYourInterests": MessageLookupByLibrary.simpleMessage(
      "같은 관심사를 가진 사람들 찾기",
    ),
    "firstLandingLoadingTitle": MessageLookupByLibrary.simpleMessage(
      "Zena가 잠재적인 친구를 찾고 있습니다...",
    ),
    "first_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "상현달, 행동과 결정을 내리기에 좋은 시기",
    ),
    "friendsIntention": MessageLookupByLibrary.simpleMessage(
      "헤이, 너 정말 멋진 것 같아. 친구가 되어볼래?",
    ),
    "full_moon_insight": MessageLookupByLibrary.simpleMessage(
      "보름달 에너지가 가장 강함, 감정을 해방하기에 완벽",
    ),
    "futureCompatibility": MessageLookupByLibrary.simpleMessage("미래"),
    "geminiSign": MessageLookupByLibrary.simpleMessage("쌍둥이자리"),
    "getAstroLearnPlus": MessageLookupByLibrary.simpleMessage("Zena Plus받기"),
    "gifNotAllowed": MessageLookupByLibrary.simpleMessage("GIF는 허용되지 않습니다"),
    "goDiscover": MessageLookupByLibrary.simpleMessage("발견하러 가기"),
    "gotIt": MessageLookupByLibrary.simpleMessage("알겠어요"),
    "great_keep_going": MessageLookupByLibrary.simpleMessage("잘했어요! 계속 가요 ✨"),
    "guessWhoBreakSilence": MessageLookupByLibrary.simpleMessage(
      "헤이, 누가 먼저 침묵을 깰까?",
    ),
    "haveAstroLearnSayHi": MessageLookupByLibrary.simpleMessage(
      "Zena에게 인사하게 하세요",
    ),
    "healing_calendar_title": MessageLookupByLibrary.simpleMessage("별자리 치유 달력"),
    "healing_category": MessageLookupByLibrary.simpleMessage("치유"),
    "healing_count": MessageLookupByLibrary.simpleMessage("치유 세션"),
    "healing_data": MessageLookupByLibrary.simpleMessage("치유 데이터"),
    "healing_music_title": MessageLookupByLibrary.simpleMessage("치유 음악"),
    "healing_sessions": MessageLookupByLibrary.simpleMessage("치유 세션"),
    "hereAstroLearnCookedUpForU": MessageLookupByLibrary.simpleMessage(
      "이것은 Zena가 당신을 위해 특별히 만든 것입니다",
    ),
    "howDoUFeelAboutAI": MessageLookupByLibrary.simpleMessage(
      "AI 동시통역에 대해 어떻게 생각하세요?",
    ),
    "iDigYourEnergy": MessageLookupByLibrary.simpleMessage("너의 에너지가 대단해!"),
    "iLikeYourStyle": MessageLookupByLibrary.simpleMessage("스타일이 마음에 들어요!"),
    "imInterestedSomething": m2,
    "imVeryInterestedInSomething": m3,
    "incompleteBirthdayInfo": MessageLookupByLibrary.simpleMessage(
      "사용자 생년월일 정보가 불완전합니다",
    ),
    "infoIncompleteTitle": MessageLookupByLibrary.simpleMessage("정보 불완전"),
    "intellectualCompatibility": MessageLookupByLibrary.simpleMessage("지적"),
    "interests": MessageLookupByLibrary.simpleMessage("관심사"),
    "interpretationOff": MessageLookupByLibrary.simpleMessage("AI 동시 통역: 꺼짐"),
    "interpretationOn": MessageLookupByLibrary.simpleMessage("AI 동시 통역: 켜짐"),
    "issues": MessageLookupByLibrary.simpleMessage("문제"),
    "justNow": MessageLookupByLibrary.simpleMessage("방금 전"),
    "justSendALike": MessageLookupByLibrary.simpleMessage("그냥 감사를 표현하세요"),
    "justTypeInYourLanguage": m4,
    "keep_it_up": MessageLookupByLibrary.simpleMessage("계속 해요! 잘하고 있어요 ✨"),
    "last_quarter_insight": MessageLookupByLibrary.simpleMessage(
      "하현달, 과거를 놓고 새로운 시작을 준비",
    ),
    "leoSign": MessageLookupByLibrary.simpleMessage("사자자리"),
    "letAstroLearnSayHiForYou": MessageLookupByLibrary.simpleMessage(
      "Zena가 당신을 대신해 인사해요",
    ),
    "libraSign": MessageLookupByLibrary.simpleMessage("천칭자리"),
    "lifestyleCompatibility": MessageLookupByLibrary.simpleMessage("라이프스타일"),
    "lightAnalysisTitle": MessageLookupByLibrary.simpleMessage(
      "การวิเคราะห์ AI แบบอ่อน",
    ),
    "lightSynastryRemark": MessageLookupByLibrary.simpleMessage("시너스트리 분석"),
    "likeBack": MessageLookupByLibrary.simpleMessage("좋아요 반사"),
    "likedBack": MessageLookupByLibrary.simpleMessage("이미 좋아요 반사함"),
    "likedPageMonetizeButton": MessageLookupByLibrary.simpleMessage(
      "그들의 공유에 대해 알아보세요",
    ),
    "likedPageNoData": MessageLookupByLibrary.simpleMessage(
      "상태: 아직 평가 없음\n\n할 일: 공유 시작\n\n제안: \n진정한 초상화\n진실된 이야기\n공유된 관심사 연결\n\n즉...\n만족스러운 사진을 업로드하세요\n진정한 바이오를 작성하세요\n관심사를 고르세요",
    ),
    "likedYou": MessageLookupByLibrary.simpleMessage("너의 공유를 높이 평가해요"),
    "loading": MessageLookupByLibrary.simpleMessage("로딩 중..."),
    "locationAuthorizeContent": MessageLookupByLibrary.simpleMessage(
      "근처 사람들을 보여주기 위해 위치가 필요합니다",
    ),
    "locationLocatedFailed": MessageLookupByLibrary.simpleMessage("위치 가져오기 실패"),
    "locationLocatedSuccess": MessageLookupByLibrary.simpleMessage(
      "현재 위치로 이동됨",
    ),
    "locationPermissionRequestSubtitle": MessageLookupByLibrary.simpleMessage(
      "소셜 경험을 향상시키기 위해 위치 정보가 필요합니다",
    ),
    "locationPermissionRequestTitle": MessageLookupByLibrary.simpleMessage(
      "위치 승인",
    ),
    "mapSelectedLocation": MessageLookupByLibrary.simpleMessage("지도에서 선택한 위치"),
    "matchPageSelectIdeas": m5,
    "me": MessageLookupByLibrary.simpleMessage("나"),
    "meditation_category": MessageLookupByLibrary.simpleMessage("명상"),
    "meditation_count": MessageLookupByLibrary.simpleMessage("명상 횟수"),
    "meditation_practice": MessageLookupByLibrary.simpleMessage("명상 연습"),
    "meditation_practice_title": MessageLookupByLibrary.simpleMessage("명상 연습"),
    "meditation_saved": MessageLookupByLibrary.simpleMessage("✅ 명상 기록 저장됨"),
    "meditation_subtitle": MessageLookupByLibrary.simpleMessage(
      "별자리 명상으로 내면의 평화를 찾으세요",
    ),
    "memberCenter": MessageLookupByLibrary.simpleMessage("회원 센터"),
    "membersPerks": MessageLookupByLibrary.simpleMessage("멤버는 독점 혜택을 받습니다"),
    "minutes_duration": m6,
    "month": MessageLookupByLibrary.simpleMessage("월"),
    "month_day_format": m7,
    "mood": MessageLookupByLibrary.simpleMessage("기분"),
    "mood_index": MessageLookupByLibrary.simpleMessage("기분 지수"),
    "mood_score": m8,
    "morePhotosBenefit": MessageLookupByLibrary.simpleMessage(
      "사진이 많을수록 추천도가 높아집니다",
    ),
    "morePhotosMoreCharm": MessageLookupByLibrary.simpleMessage(
      "사진이 더 많으면 매력도 더해요",
    ),
    "music_subtitle": MessageLookupByLibrary.simpleMessage("마음과 몸을 위한 별자리 오디오"),
    "myPhotos": MessageLookupByLibrary.simpleMessage("내 사진"),
    "myProfileTitle": MessageLookupByLibrary.simpleMessage("내 프로필"),
    "my_statistics": MessageLookupByLibrary.simpleMessage("내 통계"),
    "navigateToAstroProfile": MessageLookupByLibrary.simpleMessage(
      "별자리 프로필 페이지로 이동",
    ),
    "nearby": MessageLookupByLibrary.simpleMessage("근처에"),
    "newGameplay": MessageLookupByLibrary.simpleMessage("새로운 게임플레이"),
    "newMatch": MessageLookupByLibrary.simpleMessage("새로운 연결!"),
    "new_moon_insight": MessageLookupByLibrary.simpleMessage(
      "새달의 순간, 새로운 치유 계획을 시작하기에 완벽",
    ),
    "nextBilingDate": MessageLookupByLibrary.simpleMessage("다음 지불 날짜"),
    "noMessageTips": MessageLookupByLibrary.simpleMessage(
      "상태: 메시지 없음\n\n할 일: 청취자를 찾아라\n\n제안: 진정한 자신을 공유하세요",
    ),
    "noOneFoundYourCharm": MessageLookupByLibrary.simpleMessage(
      "아직 아무도 당신의 매력을 발견하지 못했어요",
    ),
    "noThanks": MessageLookupByLibrary.simpleMessage("아니요, 감사합니다"),
    "no_audio": MessageLookupByLibrary.simpleMessage("오디오 없음"),
    "no_quotes": MessageLookupByLibrary.simpleMessage("명언 없음"),
    "no_records_today": MessageLookupByLibrary.simpleMessage("이 날의 기록이 없습니다"),
    "notes": MessageLookupByLibrary.simpleMessage("메모"),
    "notifications": MessageLookupByLibrary.simpleMessage("알림"),
    "onboarding0": MessageLookupByLibrary.simpleMessage(
      "Zena는 세계 시민들의 근거지와 같습니다",
    ),
    "onboarding1": MessageLookupByLibrary.simpleMessage(
      "집에 있든 길 위에 있든, 전 세계 사람들을 만나세요. 그리고...",
    ),
    "onboarding2": MessageLookupByLibrary.simpleMessage(
      "언어를 마스터하는 초능력을 얻게 됩니다. 더 이상 의사소통 장벽은 없습니다",
    ),
    "onboarding3": MessageLookupByLibrary.simpleMessage(
      "말은 줄이고, 사랑은 늘려요. 전설적인 로맨스가 당신을 기다리고 있습니다",
    ),
    "onboardingWish": MessageLookupByLibrary.simpleMessage(
      "소원 목록을 완성하여\n 더 이상적인 매칭을 얻으세요",
    ),
    "oneLineToWin": MessageLookupByLibrary.simpleMessage("한 줄로 상대를 사로잡아"),
    "oopsNoDataRightNow": MessageLookupByLibrary.simpleMessage(
      "오잉, 지금 데이터가 없어요",
    ),
    "peopleFromYourWishlistGetMoreRecommendations":
        MessageLookupByLibrary.simpleMessage("당신의 위시리스트 설정이 더 큰 역할을 할 것입니다"),
    "permissionRequiredContent": MessageLookupByLibrary.simpleMessage(
      "최고의 경험을 제공하기 위해 이 권한이 필요합니다",
    ),
    "permissionRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "권한이 필요합니다",
    ),
    "personaCompleteProfile": MessageLookupByLibrary.simpleMessage("기본 프로필 완성"),
    "personaCompleteProfileDesc": MessageLookupByLibrary.simpleMessage(
      "이름, 생일, 성별을 완성하여 더 많은 추천 잠금 해제",
    ),
    "personaEnableNotifications": MessageLookupByLibrary.simpleMessage(
      "메시지 알림 활성화",
    ),
    "personaEnableNotificationsDesc": MessageLookupByLibrary.simpleMessage(
      "매치와 메시지를 놓치지 말고 적시에 상호작용",
    ),
    "personaForYou": MessageLookupByLibrary.simpleMessage("당신을 위한"),
    "personaShowCity": MessageLookupByLibrary.simpleMessage("도시 표시"),
    "personaShowCityDesc": MessageLookupByLibrary.simpleMessage(
      "지역 사용자에게 더 쉽게 발견됨",
    ),
    "personaUploadPhotos": MessageLookupByLibrary.simpleMessage("사진 업로드"),
    "personaUploadPhotosDesc": MessageLookupByLibrary.simpleMessage(
      "최소 2장의 선명한 사진을 추가하여 노출도 증가",
    ),
    "photoFromCamera": MessageLookupByLibrary.simpleMessage("사진 찍기"),
    "photoFromGallery": MessageLookupByLibrary.simpleMessage("갤러리에서 선택"),
    "photoMightNotBeReal": MessageLookupByLibrary.simpleMessage(
      "이 사진은 실제가 아닐 수 있습니다",
    ),
    "photos": MessageLookupByLibrary.simpleMessage("사진"),
    "piscesSign": MessageLookupByLibrary.simpleMessage("물고기자리"),
    "played_audio": MessageLookupByLibrary.simpleMessage("오디오 재생"),
    "pleaseCheckYourInternetOrTapToRefreshAndTryAgain":
        MessageLookupByLibrary.simpleMessage("인터넷을 확인하거나 새로 고침을 탭하여 다시 시도하세요"),
    "please_write_feelings": MessageLookupByLibrary.simpleMessage("감정을 적어주세요"),
    "plusBenefitActivityReminder": MessageLookupByLibrary.simpleMessage(
      "활동 및 복귀 알림",
    ),
    "plusBenefitActivitySort": MessageLookupByLibrary.simpleMessage(
      "최근 활동과 답장률로 정렬",
    ),
    "plusBenefitAdvancedFilter": MessageLookupByLibrary.simpleMessage(
      "고급 필터: 국가/언어/시간대/도시",
    ),
    "plusBenefitAntiHarassment": MessageLookupByLibrary.simpleMessage(
      "우선순위 반괴롭힘 보호 및 가중치 보호",
    ),
    "plusBenefitConflictAdvice": MessageLookupByLibrary.simpleMessage(
      "갈등점과 관계 조언",
    ),
    "plusBenefitDestinyPriority": MessageLookupByLibrary.simpleMessage(
      "추천과 좋아요에서 운명 우선 노출",
    ),
    "plusBenefitDestinyPush": MessageLookupByLibrary.simpleMessage(
      "새로운 운명의 매치 도착 알림",
    ),
    "plusBenefitDimensionBreakdown": MessageLookupByLibrary.simpleMessage(
      "4차원 분석: 성격/소통/친밀감/경계",
    ),
    "plusBenefitHighMatchDisplay": MessageLookupByLibrary.simpleMessage(
      "높은 매치 점수와 백분율 표시",
    ),
    "plusBenefitHistoryTranslation": MessageLookupByLibrary.simpleMessage(
      "메시지 기록 원클릭 번역",
    ),
    "plusBenefitInterestFilter": MessageLookupByLibrary.simpleMessage(
      "관심사와 여행 계획 필터",
    ),
    "plusBenefitLikeReminder": MessageLookupByLibrary.simpleMessage(
      "좋아요 반사 및 읽음 확인 알림",
    ),
    "plusBenefitMatchScore": MessageLookupByLibrary.simpleMessage(
      "전체 호환성 점수 시각화",
    ),
    "plusBenefitMessageTemplates": MessageLookupByLibrary.simpleMessage(
      "빠른 메시지 템플릿 (칭찬/초대/플랫폼 전환)",
    ),
    "plusBenefitOCRTranslation": MessageLookupByLibrary.simpleMessage(
      "이미지 즉시 번역 및 텍스트 인식",
    ),
    "plusBenefitRealTimeTranslation": MessageLookupByLibrary.simpleMessage(
      "실시간 번역 및 다듬기: 다국어 자동 수정",
    ),
    "plusBenefitSmartOpener": MessageLookupByLibrary.simpleMessage(
      "스마트 오프닝: 1인당 3개의 고전환 제안",
    ),
    "plusBenefitStarGreeting": MessageLookupByLibrary.simpleMessage(
      "별자리 인사 패키지: 하루 10회",
    ),
    "plusBenefitSupportChannel": MessageLookupByLibrary.simpleMessage(
      "구독 문제 해결 빠른 처리",
    ),
    "plusBenefitTopicPool": MessageLookupByLibrary.simpleMessage(
      "프로필 분석 기반 대화 주제 풀",
    ),
    "plusBenefitUnlockLikedMe": MessageLookupByLibrary.simpleMessage(
      "좋아요 받은에서 선명한 아바타와 태그 잠금 해제",
    ),
    "plusDescTitle": MessageLookupByLibrary.simpleMessage("Plus 설명"),
    "plusFuncAIInterpretation": MessageLookupByLibrary.simpleMessage(
      "하루에 1000번 AI 동시통역",
    ),
    "plusFuncAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "Zena Tips - 당신의 채팅 상담원",
    ),
    "plusFuncDMPerWeek": MessageLookupByLibrary.simpleMessage("주당 5회 DM"),
    "plusFuncFilterMatchingCountries": MessageLookupByLibrary.simpleMessage(
      "연결되는 국가 필터링",
    ),
    "plusFuncUnlimitedLikes": MessageLookupByLibrary.simpleMessage("무제한 좋아요"),
    "plusFuncUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "너의 공유를 높이 평가하는 사람이 누구인지 보려면 잠금 해제",
    ),
    "plusFuncWishes": MessageLookupByLibrary.simpleMessage("3개의 소원"),
    "plusMember": MessageLookupByLibrary.simpleMessage("Plus 회원"),
    "plusMembershipBenefits": MessageLookupByLibrary.simpleMessage(
      "Plus 멤버십 혜택",
    ),
    "plusPerkDuoSnap": MessageLookupByLibrary.simpleMessage("Plus 듀오 스냅"),
    "practice_count": MessageLookupByLibrary.simpleMessage("연습 횟수"),
    "preference": MessageLookupByLibrary.simpleMessage("취향"),
    "privacy": MessageLookupByLibrary.simpleMessage("프라이버시"),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("개인정보처리방침"),
    "productNotFound": MessageLookupByLibrary.simpleMessage("ไม่พบสินค้า"),
    "profileInfoTab": MessageLookupByLibrary.simpleMessage("프로필"),
    "profileNotShown": MessageLookupByLibrary.simpleMessage(
      "아직 진짜 모습을 보여주지 않았어요",
    ),
    "profileTip": MessageLookupByLibrary.simpleMessage(
      "✨ 프로필을 완성하여 별들이 당신을 더 잘 알 수 있도록, 더 정확한 매칭을",
    ),
    "psychological_healing": MessageLookupByLibrary.simpleMessage("심리 치유"),
    "purchaseFailed": MessageLookupByLibrary.simpleMessage("구매 실패"),
    "purchasePending": MessageLookupByLibrary.simpleMessage("구매 진행 중..."),
    "pushNotifications": MessageLookupByLibrary.simpleMessage("푸시 알림"),
    "quickActions": MessageLookupByLibrary.simpleMessage("빠른 작업"),
    "quote_1": MessageLookupByLibrary.simpleMessage("오늘의 당신은 별처럼 빛나요"),
    "quote_10": MessageLookupByLibrary.simpleMessage("조용한 순간에 답을 찾으세요"),
    "quote_2": MessageLookupByLibrary.simpleMessage("별을 믿듯이 자신을 믿으세요"),
    "quote_3": MessageLookupByLibrary.simpleMessage("모든 사람은 독특한 별자리예요"),
    "quote_4": MessageLookupByLibrary.simpleMessage("우주의 에너지가 당신과 함께해요"),
    "quote_5": MessageLookupByLibrary.simpleMessage("지금의 자신을 받아들이세요"),
    "quote_6": MessageLookupByLibrary.simpleMessage("모든 감정은 인정받을 가치가 있어요"),
    "quote_7": MessageLookupByLibrary.simpleMessage("별의 에너지가 당신을 통해 흐르게 하세요"),
    "quote_8": MessageLookupByLibrary.simpleMessage("오늘은 무한한 가능성이 있는 새로운 날이에요"),
    "quote_9": MessageLookupByLibrary.simpleMessage("당신의 존재 자체가 기적이에요"),
    "quotes_subtitle": MessageLookupByLibrary.simpleMessage("별들로부터의 치유 에너지"),
    "record_daily_status": MessageLookupByLibrary.simpleMessage("일일 상태 기록"),
    "record_today_hint": MessageLookupByLibrary.simpleMessage(
      "오늘 무엇을 기록하고 싶으신가요?",
    ),
    "record_your_feelings": MessageLookupByLibrary.simpleMessage("감정을 기록하세요"),
    "recorded_days": MessageLookupByLibrary.simpleMessage("기록 일수"),
    "recorded_emotion": MessageLookupByLibrary.simpleMessage("기록된 감정"),
    "relaxation_category": MessageLookupByLibrary.simpleMessage("이완"),
    "remindUploadPhoto": MessageLookupByLibrary.simpleMessage(
      "📸 사진 업로드를 권하고 서로를 더 잘 알아가세요",
    ),
    "report": MessageLookupByLibrary.simpleMessage("신고"),
    "reportOptionGore": MessageLookupByLibrary.simpleMessage("잔인함"),
    "reportOptionOther": MessageLookupByLibrary.simpleMessage("기타"),
    "reportOptionPerAstroLearnlAttack": MessageLookupByLibrary.simpleMessage(
      "인신공격",
    ),
    "reportOptionPersonalAttack": MessageLookupByLibrary.simpleMessage("인신공격"),
    "reportOptionPornography": MessageLookupByLibrary.simpleMessage("포르노"),
    "reportOptionScam": MessageLookupByLibrary.simpleMessage("사기"),
    "requireYourRealPhoto": MessageLookupByLibrary.simpleMessage(
      "당신의 실제 사진이 필요합니다",
    ),
    "runningIntoForeignersNearYou": MessageLookupByLibrary.simpleMessage(
      "당신 근처에서 외국인을 만나다",
    ),
    "sagittariusSign": MessageLookupByLibrary.simpleMessage("사수자리"),
    "save": MessageLookupByLibrary.simpleMessage("저장"),
    "save_failed": m9,
    "scorpioSign": MessageLookupByLibrary.simpleMessage("전갈자리"),
    "screenshotEvidence": MessageLookupByLibrary.simpleMessage("스크린샷 증거"),
    "seeProfile": MessageLookupByLibrary.simpleMessage("프로필 보기"),
    "seeWhoLikeU": MessageLookupByLibrary.simpleMessage(
      "너의 공유를 높이 평가하는 사람들 보기",
    ),
    "selectBirthPlace": MessageLookupByLibrary.simpleMessage(
      "เลือกสถานที่เกิด",
    ),
    "selectBirthdayHint": MessageLookupByLibrary.simpleMessage(
      "생년월일을 선택하여 별자리 차트를 확인하세요",
    ),
    "selectCountryPageTitle": MessageLookupByLibrary.simpleMessage("국가 선택"),
    "selectLocationTitle": MessageLookupByLibrary.simpleMessage("위치 선택"),
    "select_duration_start": MessageLookupByLibrary.simpleMessage(
      "시간을 선택하고 명상 시작",
    ),
    "select_meditation_duration": MessageLookupByLibrary.simpleMessage(
      "명상 시간 선택",
    ),
    "sendDm": MessageLookupByLibrary.simpleMessage("DM 보내기"),
    "sendDmRemark": MessageLookupByLibrary.simpleMessage("DM 메시지 보내기"),
    "sendStarGreetingToUnlockAlbum": MessageLookupByLibrary.simpleMessage(
      "💫 별 인사말을 보내서 앨범 잠금 해제 계속",
    ),
    "setDefault": MessageLookupByLibrary.simpleMessage("기본으로 설정"),
    "setInterestTags": MessageLookupByLibrary.simpleMessage(
      "명확한 관심사 태그를 설정하세요",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("설정"),
    "showYourPerAstroLearnlity": MessageLookupByLibrary.simpleMessage(
      "당신의 개성을 보여주세요",
    ),
    "showYourPersonality": MessageLookupByLibrary.simpleMessage(
      "당신의 개성을 보여주세요",
    ),
    "signUpLastStepPageTitle": MessageLookupByLibrary.simpleMessage("곧 완성됩니다"),
    "sixMonths": MessageLookupByLibrary.simpleMessage("6개월"),
    "sleep_category": MessageLookupByLibrary.simpleMessage("수면"),
    "speakSameLanguage": MessageLookupByLibrary.simpleMessage(
      "여러분은 같은 언어를 사용합니다",
    ),
    "spiritual_growth": MessageLookupByLibrary.simpleMessage("영적 성장"),
    "standard": MessageLookupByLibrary.simpleMessage("표준"),
    "startChat": MessageLookupByLibrary.simpleMessage("채팅 시작"),
    "start_meditation": MessageLookupByLibrary.simpleMessage("명상 시작"),
    "startedChat": MessageLookupByLibrary.simpleMessage("채팅 시작"),
    "status_saved": MessageLookupByLibrary.simpleMessage("✅ 상태 저장됨"),
    "stop_meditation": MessageLookupByLibrary.simpleMessage("명상 중지"),
    "streak_days": MessageLookupByLibrary.simpleMessage("연속 일수"),
    "streak_x_days": m10,
    "stress": MessageLookupByLibrary.simpleMessage("스트레스"),
    "stress_index": MessageLookupByLibrary.simpleMessage("스트레스 지수"),
    "stress_level": MessageLookupByLibrary.simpleMessage("스트레스 레벨"),
    "subPageSubtitleAIInterpretationDaily":
        MessageLookupByLibrary.simpleMessage("하루에 1000번 \nAI 동시통역"),
    "subPageSubtitleAstroLearnTips": MessageLookupByLibrary.simpleMessage(
      "Zena Tips - \n당신의 채팅 상담원",
    ),
    "subPageSubtitleDMWeekly": MessageLookupByLibrary.simpleMessage("주당 5회 DM"),
    "subPageSubtitleFilterMatchingCountries":
        MessageLookupByLibrary.simpleMessage("연결되는 국가 \n필터링"),
    "subPageSubtitleUnlimitedLikes": MessageLookupByLibrary.simpleMessage(
      "무제한 좋아요",
    ),
    "subPageSubtitleUnlockWhoLikesU": MessageLookupByLibrary.simpleMessage(
      "너의 공유를 높이 평가하는 사람이 \n누구인지 보려면 잠금 해제",
    ),
    "subPageTitle": MessageLookupByLibrary.simpleMessage("Zena Plus받기"),
    "subscriptionAgreement": MessageLookupByLibrary.simpleMessage("약관"),
    "subscriptionAgreementPrefix": m11,
    "subscriptionAgreementSuffix": MessageLookupByLibrary.simpleMessage(
      "에 동의하는 것입니다.",
    ),
    "sunSignLabel": MessageLookupByLibrary.simpleMessage("ราศีดวงอาทิตย์"),
    "synastryAnalysis": MessageLookupByLibrary.simpleMessage("합판 분석"),
    "takeIt": MessageLookupByLibrary.simpleMessage("사용하다"),
    "taurusSign": MessageLookupByLibrary.simpleMessage("황소자리"),
    "termsOfService": MessageLookupByLibrary.simpleMessage("이용 약관"),
    "theKeyIsBalance": MessageLookupByLibrary.simpleMessage("균형이 관건이다"),
    "theyAreWaitingForYourReply": MessageLookupByLibrary.simpleMessage(
      "👆 답장을 기다리고 있어요",
    ),
    "threeMonths": MessageLookupByLibrary.simpleMessage("3개월"),
    "toastHitDailyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👀당신은 오늘의 한도에 도달했습니다",
    ),
    "toastHitWeeklyMaximumLimit": MessageLookupByLibrary.simpleMessage(
      "👅당신은 이번 주의 한도에 도달했습니다",
    ),
    "toggle_background_music": MessageLookupByLibrary.simpleMessage("배경음악 전환"),
    "total_duration": MessageLookupByLibrary.simpleMessage("총 시간"),
    "unknownLocation": MessageLookupByLibrary.simpleMessage("알 수 없음"),
    "unlockHighMatchUsers": m12,
    "unlockUsersWithDestiny": m13,
    "unmissableSpecialOfferPrices": MessageLookupByLibrary.simpleMessage(
      "놓치면 안 되는 특가",
    ),
    "unsupportedPlatform": MessageLookupByLibrary.simpleMessage(
      "แพลตฟอร์มที่ไม่รองรับ",
    ),
    "upgradeForMoreRecommendations": MessageLookupByLibrary.simpleMessage(
      "프리미엄으로 업그레이드하여 더 많은 추천 받기",
    ),
    "uploadQualityPhotos": MessageLookupByLibrary.simpleMessage(
      "고품질의 실제 사진을 업로드하세요",
    ),
    "uploadYourPhoto": MessageLookupByLibrary.simpleMessage("사진을 업로드하세요"),
    "uploadYourPhotoHint": MessageLookupByLibrary.simpleMessage(
      "최고의 사진을 업로드하세요",
    ),
    "uploading": MessageLookupByLibrary.simpleMessage("업로드 중..."),
    "useCurrentLocation": MessageLookupByLibrary.simpleMessage("현재 위치 사용"),
    "userAvatarOptionCamera": MessageLookupByLibrary.simpleMessage("사진 찍기"),
    "userAvatarOptionGallery": MessageLookupByLibrary.simpleMessage("갤러리에서 선택"),
    "userAvatarPageSubtitle": MessageLookupByLibrary.simpleMessage(
      "좋은 초상화는 더 많은 청취자와 연결하는 데 도움이 됩니다. 실제 사진을 사용하세요.",
    ),
    "userAvatarPageTitle": MessageLookupByLibrary.simpleMessage("너 자신을 드러내"),
    "userAvatarUploadedLabel": MessageLookupByLibrary.simpleMessage("업로드 완료!"),
    "userBirthdayInputLabel": MessageLookupByLibrary.simpleMessage("생년월일"),
    "userCitizenshipPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "확인되면, 국적은 변경할 수 없습니다",
    ),
    "userCitizenshipPickerTitle": MessageLookupByLibrary.simpleMessage("국적"),
    "userGenderInputLabel": MessageLookupByLibrary.simpleMessage("성별"),
    "userGenderOptionFemale": MessageLookupByLibrary.simpleMessage("여성"),
    "userGenderOptionMale": MessageLookupByLibrary.simpleMessage("남성"),
    "userGenderOptionNonBinary": MessageLookupByLibrary.simpleMessage("비이성애자"),
    "userGenderPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "공개되지 않으며, 연결을 위해서만 사용됩니다",
    ),
    "userInfoPageNamePlaceholder": MessageLookupByLibrary.simpleMessage("입력"),
    "userInfoPageTitle": MessageLookupByLibrary.simpleMessage("기본 정보"),
    "userNameInputLabel": MessageLookupByLibrary.simpleMessage("이름"),
    "userPhoneNumberPagePlaceholder": MessageLookupByLibrary.simpleMessage(
      "전화번호",
    ),
    "userPhoneNumberPagePrivacySuffix": MessageLookupByLibrary.simpleMessage(
      "에 동의하는 것입니다",
    ),
    "userPhoneNumberPagePrivacyText": MessageLookupByLibrary.simpleMessage(
      "개인정보 보호정책",
    ),
    "userPhoneNumberPageTermsAnd": MessageLookupByLibrary.simpleMessage("및"),
    "userPhoneNumberPageTermsPrefix": MessageLookupByLibrary.simpleMessage(
      "“다음 단계”를 탭하면, 우리의 ",
    ),
    "userPhoneNumberPageTermsText": MessageLookupByLibrary.simpleMessage(
      "서비스 약관",
    ),
    "userPhoneNumberPageTitle": MessageLookupByLibrary.simpleMessage(
      "전화번호를 입력하세요",
    ),
    "valuesCompatibility": MessageLookupByLibrary.simpleMessage("가치관"),
    "verifyCodePageTitle": MessageLookupByLibrary.simpleMessage("인증 코드를 입력하세요"),
    "viewAstroReport": MessageLookupByLibrary.simpleMessage("별자리 리포트 보기"),
    "view_details": MessageLookupByLibrary.simpleMessage("상세 보기"),
    "virgoSign": MessageLookupByLibrary.simpleMessage("처녀자리"),
    "waning_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "그믐달의 순간, 휴식과 회복이 중요",
    ),
    "waning_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "달이 기울어지고, 성찰과 정리에 좋은 시기",
    ),
    "wannaHollaAt": MessageLookupByLibrary.simpleMessage("공유하고 싶으세요!"),
    "warningCancelDisplayCity": MessageLookupByLibrary.simpleMessage(
      "닫은 후에는 페어링할 때 도시가 표시되지 않습니다",
    ),
    "warningCancelSubscription": MessageLookupByLibrary.simpleMessage(
      "귀하의 계정은 14일 후에 자동으로 삭제될 예정입니다. 추가 요금을 피하기 위해 현재 구독을 취소하기 위해 매장에 가야 함을 기억해 주세요.",
    ),
    "warningDeleteAccount": MessageLookupByLibrary.simpleMessage(
      "계정을 삭제하면 더 이상 로그인할 수 없습니다. 정말 삭제하시겠습니까?",
    ),
    "warningOpenExternalLink": MessageLookupByLibrary.simpleMessage(
      "외부 링크입니다. 탭하기 전에 출처가 신뢰할 수 있는지 확인하세요. 알려지지 않은 링크는 사기 또는 데이터 도용일 수 있습니다. 주의해서 진행하세요.",
    ),
    "warningTitleCaution": MessageLookupByLibrary.simpleMessage("주의"),
    "warningUnmatching": MessageLookupByLibrary.simpleMessage(
      "공유 종료 후, 서로의 대화 기록이 모두 삭제됩니다.",
    ),
    "waxing_crescent_insight": MessageLookupByLibrary.simpleMessage(
      "달이 차오르고, 에너지가 점진적으로 축적됨",
    ),
    "waxing_gibbous_insight": MessageLookupByLibrary.simpleMessage(
      "보름달이 다가오고, 감정이 더 민감해질 수 있음",
    ),
    "whatsYourEmail": MessageLookupByLibrary.simpleMessage("이메일 주소가 무엇인가요?"),
    "whoLIkesYou": MessageLookupByLibrary.simpleMessage("너의 공유를 높이 평가하는 사람"),
    "whoLikesU": MessageLookupByLibrary.simpleMessage("너를 높이 평가하는 사람"),
    "wishActivityAddTitle": MessageLookupByLibrary.simpleMessage("생각을 추가하세요"),
    "wishActivityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "동반자 찾기를 도와드립니다",
    ),
    "wishActivityPickerTitle": MessageLookupByLibrary.simpleMessage(
      "뭔가 하고 싶어?",
    ),
    "wishCityPickerSkipButton": m14,
    "wishCityPickerSubtitle": MessageLookupByLibrary.simpleMessage(
      "거기에 간다면, 어떤 도시를 방문하고 싶습니까?",
    ),
    "wishCountryPickerTitle": MessageLookupByLibrary.simpleMessage(
      "어느 나라에 더 관심이 있나요?",
    ),
    "wishCreationComplete": MessageLookupByLibrary.simpleMessage(
      "당신의 소원을 받았습니다",
    ),
    "wishDateOptionHere": MessageLookupByLibrary.simpleMessage("이미 여기 있어요"),
    "wishDateOptionNotSure": MessageLookupByLibrary.simpleMessage("아직 확실하지 않아"),
    "wishDateOptionRecent": MessageLookupByLibrary.simpleMessage("최근이라고 생각해요"),
    "wishDateOptionYear": MessageLookupByLibrary.simpleMessage("1년 이내"),
    "wishDatePickerSubtitle": m15,
    "wishDatePickerTitle": MessageLookupByLibrary.simpleMessage("언제"),
    "wishList": MessageLookupByLibrary.simpleMessage("소망 목록"),
    "wishes": MessageLookupByLibrary.simpleMessage("소원"),
    "writeInterestingBio": MessageLookupByLibrary.simpleMessage(
      "흥미로운 개인 소개를 작성하세요",
    ),
    "write_feelings_hint": MessageLookupByLibrary.simpleMessage(
      "지금 느끼는 것을 적어보세요...",
    ),
    "x_days": m16,
    "x_hours": m17,
    "x_times": m18,
    "youAreAClubMemberNow": MessageLookupByLibrary.simpleMessage("이제 클럽 멤버입니다"),
    "youCanEditItAnytime": MessageLookupByLibrary.simpleMessage(
      "언제든지 편집할 수 있습니다",
    ),
    "youSeemCool": MessageLookupByLibrary.simpleMessage("멋져 보여요."),
  };
}
