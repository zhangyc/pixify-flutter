// Facebook App Events 枚举定义
enum FacebookEvent {
  // 注册流程
  signUpStart('sign_up_start'),
  signUpComplete('sign_up_complete'),
  completeRegistration('fb_mobile_complete_registration'),
  phoneVerify('phone_verify'),
  phoneVerifySuccess('phone_verify_success'),
  phoneVerifyFail('phone_verify_fail'),
  photoUpload('photo_upload'),
  photoUploadSuccess('photo_upload_success'),
  photoUploadFail('photo_upload_fail'),
  profileComplete('profile_complete'),
  locationPermissionRequest('location_permission_request'),
  locationPermissionGranted('location_permission_granted'),
  notificationPermissionRequest('notification_permission_request'),
  notificationPermissionGranted('notification_permission_granted'),

  // 用户行为
  appOpen('app_open'),
  appBackground('app_background'),
  appForeground('app_foreground'),
  sessionStart('session_start'),
  sessionEnd('session_end'),
  firstMatch('first_match'),
  firstMessage('first_message'),
  viewContent('fb_mobile_content_view'),
  viewProfile('view_profile'),
  viewAstroChart('view_astro_chart'),
  searchStart('search_start'),
  searchComplete('search_complete'),
  filterApply('filter_apply'),

  // 互动行为
  sendLike('send_like'),
  sendSuperLike('send_super_like'),
  receiveLike('receive_like'),
  receiveSuperLike('receive_super_like'),
  matchSuccess('match_success'),
  messageCompose('message_compose'),
  messageSend('message_send'),
  messageRead('message_read'),
  messageReply('message_reply'),
  blockUser('block_user'),
  reportUser('report_user'),
  unmatch('unmatch'),

  // 付费相关
  viewPaywall('view_paywall'),
  paywallImpression('paywall_impression'),
  initiateCheckout('fb_mobile_initiated_checkout'),
  addPaymentInfo('add_payment_info'),
  purchase('fb_mobile_purchase'),
  purchaseSuccess('purchase_success'),
  purchaseFail('purchase_fail'),
  subscribe('Subscribe'),
  subscriptionStart('subscription_start'),
  subscriptionRenew('subscription_renew'),
  subscriptionCancel('subscription_cancel'),
  restorePurchase('restore_purchase'),

  // 功能使用
  astroAnalysisStart('astro_analysis_start'),
  astroAnalysisComplete('astro_analysis_complete'),
  aiInterpretationRequest('ai_interpretation_request'),
  aiInterpretationReceive('ai_interpretation_receive'),
  synastryCheckStart('synastry_check_start'),
  synastryCheckComplete('synastry_check_complete'),

  // 广告相关
  adClick('ad_click'),
  adImpression('ad_impression'),
  adConversion('ad_conversion'),

  // 用户参与
  inviteFriend('invite_friend'),
  shareProfile('share_profile'),
  shareApp('share_app'),
  rateApp('rate_app'),
  provideFeedback('provide_feedback'),

  // 关键节点
  activateUser('activate_user'),
  retentionD1('retention_d1'),
  retentionD7('retention_d7'),
  retentionD30('retention_d30'),
  churnRisk('churn_risk'),
  reactivate('reactivate');

  final String value;
  const FacebookEvent(this.value);
}

// 事件参数枚举
enum FacebookEventParam {
  // 用户信息
  userId('user_id'),
  userGender('user_gender'),
  userAge('user_age'),
  userCountry('user_country'),
  userCity('user_city'),
  userZodiacSign('user_zodiac_sign'),
  userAscendant('user_ascendant'),
  userRegistrationDate('user_registration_date'),
  userStatus('user_status'),

  // 来源/场景
  source('source'),
  scene('scene'),
  trigger('trigger'),
  entryPoint('entry_point'),
  previousScreen('previous_screen'),

  // 内容相关
  contentType('content_type'),
  contentId('content_id'),
  duration('duration'),
  position('position'),

  // 交互数据
  action('action'),
  result('result'),
  success('success'),
  errorCode('error_code'),
  errorMessage('error_message'),

  // 支付相关
  currency('currency'),
  paymentType('payment_type'),
  productId('product_id'),
  subscriptionType('subscription_type'),
  discountApplied('discount_applied'),
  trialPeriod('trial_period'),

  // 功能使用
  featureType('feature_type'),
  featureId('feature_id'),
  featureVersion('feature_version'),

  // 匹配相关
  matchType('match_type'),
  matchScore('match_score'),
  compatibilityScore('compatibility_score'),
  messageType('message_type'),

  // 性能指标
  loadTime('load_time'),
  responseTime('response_time'),
  networkType('network_type'),

  // 设备/系统
  deviceType('device_type'),
  deviceId('device_id'),
  osVersion('os_version'),
  appVersion('app_version'),

  // 广告相关
  campaignId('campaign_id'),
  adSetId('ad_set_id'),
  adId('ad_id'),
  placementId('placement_id'),

  // 其他
  timestamp('timestamp'),
  sessionId('session_id'),
  eventSequence('event_sequence');

  final String value;
  const FacebookEventParam(this.value);
}

// 使用示例：
// SonaAnalytics.logFacebookEvent(
//   FacebookEvent.matchSuccess.value,
//   {
//     FacebookEventParam.userId.value: userId,
//     FacebookEventParam.matchType.value: 'zodiac_match',
//     FacebookEventParam.matchScore.value: 85,
//     FacebookEventParam.compatibilityScore.value: 90,
//     FacebookEventParam.source.value: 'swipe',
//     FacebookEventParam.timestamp.value: DateTime.now().toIso8601String()
//   }
// );
