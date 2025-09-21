import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sona/common/env.dart';
import 'package:sona/common/permission/permission.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/subscribe/providers/subscriptions.dart';
import 'package:sona/utils/global/global.dart';

import '../../account/providers/profile.dart';
import '../../common/widgets/webview.dart';
import '../../generated/l10n.dart';
import '../../utils/dialog/input.dart';
import '../../utils/toast/flutter_toast.dart';
import '../match/util/event.dart';
import '../match/util/iap_helper.dart';
import 'model/member.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscribePage extends ConsumerStatefulWidget {
  const SubscribePage({super.key, required this.fromTag});
  final FromTag fromTag;

  @override
  ConsumerState createState() => _SubscribePageState();
}

class _SubscribePageState extends ConsumerState<SubscribePage> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  bool _purchasePending = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    SonaAnalytics.log(
        ChatEvent.pay_page_open.name, {"fromTag": widget.fromTag.name});
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      if (kDebugMode) print(error);
    });
  }

  Future _subscribePlus() async {
    final plusDetails = ref
        .read(asyncSubscriptionsProvider)
        .value!
        .firstWhere((sub) => sub.id == ref.read(selectedPlusSubIdProvider));
    _subscribe(plusDetails);
  }

  Future _subscribe(ProductDetails pd) async {
    late PurchaseParam purchaseParam;
    if (Platform.isAndroid) {
      // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
      // verify the latest status of you your subscription by using server side receipt validation
      // and update the UI accordingly. The subscription purchase status shown
      // inside the app may not be accurate.
      final GooglePlayPurchaseDetails? oldSubscription =
          await _getOldSubscription();
      purchaseParam = GooglePlayPurchaseParam(
          // applicationUserName: ref.read(myProfileProvider)!.id.toString(),
          productDetails: pd,
          changeSubscriptionParam: (oldSubscription != null)
              ? ChangeSubscriptionParam(
                  oldPurchaseDetails: oldSubscription,
                  replacementMode: ReplacementMode.chargeFullPrice,
                )
              : null);
    } else {
      //InAppPurchase.instance.restorePurchases();
      purchaseParam = AppStorePurchaseParam(
        applicationUserName: ref.read(myProfileProvider)!.id.toString(),
        productDetails: pd,
      );
    }
    try {
      await inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      inAppPurchase.restorePurchases(
          applicationUserName: ref.read(myProfileProvider)!.id.toString());
    }
    //inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    SonaAnalytics.log(PayEvent.pay_continue.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).subPageTitle),
          actions: [
            if (ref.read(myProfileProvider)!.isMember)
              UnconstrainedBox(
                child: TextButton(
                  onPressed: () async {
                    var result = await showActionButtons(
                        context: context,
                        title: S.of(context).buttonManage,
                        options: {S.of(context).buttonUnsubscribe: 'manage'});
                    if (result == 'manage') {
                      if (Platform.isAndroid) {
                        launchUrl(
                            Uri.parse(
                                'https://play.google.com/store/account/subscriptions?package=com.solararrow.pixify'),
                            mode: LaunchMode.externalApplication);
                      } else if (Platform.isIOS) {
                        launchUrl(
                            Uri.parse(
                                "https://apps.apple.com/account/subscriptions"),
                            mode: LaunchMode.externalApplication);
                      }
                    }
                  },
                  child: Text(S.of(context).buttonManage),
                ),
              )
          ],
        ),
        floatingActionButton:
            (ref.watch(myProfileProvider)!.memberType == MemberType.none ||
                    ref.watch(myProfileProvider)!.memberType == MemberType.club)
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: _purchasePending ||
                              !ref.watch(asyncSubscriptionsProvider).hasValue
                          ? null
                          : _subscribePlus,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00EED1),
                        foregroundColor: Colors.black,
                        elevation: 8,
                        shadowColor: const Color(0xFF00EED1).withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 56),
                      ),
                      child: _purchasePending
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.auto_awesome,
                                    size: 20, color: Colors.black),
                                const SizedBox(width: 8),
                                Text(
                                  S.of(context).buttonContinue,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.auto_awesome,
                                    size: 20, color: Colors.black),
                              ],
                            ),
                    ),
                  )
                : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _buildPlus());
  }

  Widget _buildPlusTerms() => Container(
        margin: EdgeInsets.only(top: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RichText(
          text: TextSpan(
              text: S.current.subscriptionAgreementPrefix(
                  Platform.isAndroid ? 'Play Store' : 'Apple ID'),
              style: const TextStyle(
                color: Color(0xffa9a9a9),
                fontSize: 12,
              ),
              children: [
                TextSpan(
                    text: S.current.subscriptionAgreement,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context,
                            MaterialPageRoute<void>(builder: (c) {
                          return WebView(
                              url: env.termsOfService,
                              title: S.of(context).termsOfService);
                        }));
                      },
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontSize: 12, fontWeight: FontWeight.w800)),
                TextSpan(text: S.current.subscriptionAgreementSuffix),
              ]),
        ),
      );

  Widget _buildRestoreButton() {
    return Visibility(
      visible: Platform.isIOS,
      child: TextButton(
          onPressed: () {
            bool isMember = ref.read(myProfileProvider)?.isMember ?? false;
            if (isMember) {
              Fluttertoast.showToast(
                  msg: switch (ref.read(myProfileProvider)?.memberType) {
                MemberType.club => S.current.youAreAClubMemberNow,
                MemberType.plus => S.current.buttonAlreadyPlus,
                _ => ''
              });
            } else {
              if (hasPurchased == true) {
                inAppPurchase.restorePurchases(
                    applicationUserName:
                        ref.read(myProfileProvider)!.id.toString());
              } else {
                Fluttertoast.showToast(
                    msg: 'Failed to restore, can\'t find records.');
              }
            }
          },
          style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              maximumSize: Size(MediaQuery.of(context).size.width, 56),
              fixedSize: Size(MediaQuery.of(context).size.width, 56)),
          child: Text(S.of(context).buttonRestore)),
    );
  }

  Widget _buildPlusTitle() {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF00EED1).withOpacity(0.1),
            const Color(0xFF00EED1).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00EED1).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Astro Pair Plus",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: const Color(0xFF00EED1),
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Destiny Through Stars",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF00EED1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: SonaIcon(
              icon: SonaIcons.plus_mark,
              size: 48,
              color: const Color(0xFF00EED1),
            ),
          ),
        ],
      ),
    );
  }

  // Plus 权益清单（使用新的 i18n 文案）
  List<String> _plusPerksList(BuildContext context) {
    return <String>[
      // 曝光/可见
      S.of(context).plusBenefitDestinyPriority,
      S.of(context).plusBenefitUnlockLikedMe,
      S.of(context).plusBenefitHighMatchDisplay,

      // 开聊/转化
      S.of(context).plusBenefitStarGreeting,
      S.of(context).plusBenefitSmartOpener,
      S.of(context).plusBenefitTopicPool,
      S.of(context).plusBenefitRealTimeTranslation,

      // 合盘/洞察
      S.of(context).plusBenefitMatchScore,
      S.of(context).plusBenefitDimensionBreakdown,
      S.of(context).plusBenefitConflictAdvice,

      // 筛选/控制
      S.of(context).plusBenefitAdvancedFilter,
      S.of(context).plusBenefitInterestFilter,
      S.of(context).plusBenefitActivitySort,

      // 提醒/回访
      S.of(context).plusBenefitLikeReminder,
      S.of(context).plusBenefitActivityReminder,
      S.of(context).plusBenefitDestinyPush,

      // 效率/体验
      S.of(context).plusBenefitOCRTranslation,
      S.of(context).plusBenefitMessageTemplates,
      S.of(context).plusBenefitHistoryTranslation,

      // 保障
      S.of(context).plusBenefitAntiHarassment,
      S.of(context).plusBenefitSupportChannel,
    ];
  }

  Widget _buildPlusDesc() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Plus 会员权益",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 16),
          ..._plusPerksList(context).asMap().entries.map((entry) {
            final index = entry.key;
            final perk = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: index < _plusPerksList(context).length - 1
                    ? Border(
                        bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.1),
                          width: 1,
                        ),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00EED1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 14,
                      color: const Color(0xFF00EED1),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      perk,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPlus() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(bottom: 90),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFF8F9FA),
              const Color(0xFF00EED1).withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildPlusSubscriptions(),
            _buildPlusTitle(),
            _buildPlusDesc(),
            const SizedBox(height: 20),
            _buildPlusSubscriptionsTitle(),
            _buildPlusTerms(),
            _buildRestoreButton()
          ],
        ),
      ),
    );
  }

  Widget _buildPlusSubscriptionsTitle() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Text('Astro Pair Plus',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 24)));
  }

  Widget _buildPlusSubscriptions() {
    return Container(
      height: 152,
      width: MediaQuery.maybeOf(context)?.size.width,
      child: ref.watch(asyncSubscriptionsProvider).when(
          data: (subscriptions) {
            final monthlyPrice = subscriptions
                .firstWhere((sub) => sub.id == plusMonthlyId)
                .rawPrice;
            return ListView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                ...(subscriptions
                        .where((sub) => plusSubscriptionIds.contains(sub.id))
                        .toList()
                      ..sort((a, b) => (a.rawPrice - b.rawPrice).ceil()))
                    .map<Widget>((sub) => GestureDetector(
                          onTap: () async {
                            ref
                                .read(selectedPlusSubIdProvider.notifier)
                                .update((state) => sub.id);
                          },
                          child: Container(
                            width: 160,
                            height: 134,
                            margin: EdgeInsets.only(right: 11, top: 14),
                            decoration: BoxDecoration(
                                color: ref.watch(selectedPlusSubIdProvider) ==
                                        sub.id
                                    ? Color(0xff2c2c2c)
                                    : Color(0xffF6F3F3),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Color(0xff2c2c2c), width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: _buildSubTitle(sub, monthlyPrice),
                            ),
                          ),
                        ))
              ],
            );
          },
          error: (_, __) => Container(),
          loading: () => Center(
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(),
                ),
              )),
    );
  }

  ///
  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<Response> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    /// 获取包名通过PackageInfo
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;

    ///
    Map<String, dynamic> map = {};
    if (Platform.isAndroid) {
      map = {
        "packageName": packageName,
        "productId": purchaseDetails.productID,
        "purchaseToken":
            purchaseDetails.verificationData.serverVerificationData,
        "serviceType": "SUBSCRIPTION"
      };
    } else if (Platform.isIOS) {
      map = {
        "packageName": packageName,
        "productId": purchaseDetails.productID,
        "purchaseToken":
            purchaseDetails.verificationData.serverVerificationData,
        "serviceType": "SUBSCRIPTION_APPLE"
      };
    }

    return dio.post('/callback/google-pay', data: map);
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    SonaAnalytics.log('iap_deliver');
    initUserPermission();
    await ref.read(myProfileProvider.notifier).refresh();
    if (mounted) {
      setState(() {
        _purchasePending = false;
      });
      Fluttertoast.showToast(
          msg: switch (ref.read(myProfileProvider)?.memberType) {
        MemberType.club => S.current.youAreAClubMemberNow,
        MemberType.plus => S.current.buttonAlreadyPlus,
        _ => ''
      });
    }
  }

  ///设置挂起状态的UI
  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  bool? hasPurchased = false;

  /// 监听到的服务端配置的产品
  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    final hp =
        purchaseDetailsList.any((p) => p.status == PurchaseStatus.purchased);
    if (hp && hasPurchased != true) {
      hasPurchased = true;
    }
    // 遍历购买列表
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        SonaAnalytics.log('iap_error_pending');

        // purchaseDetails.status=PurchaseStatus.canceled;
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          SonaAnalytics.log('iap_error_${purchaseDetails.error!.code}');

          handleError(purchaseDetails.error!);
          // 已购买
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            // 恢复购买
            purchaseDetails.status == PurchaseStatus.restored) {
          try {
            final resp = await _verifyPurchase(purchaseDetails);
            if (resp.statusCode == 0) {
              SonaAnalytics.log('iap_verified');
              SonaAnalytics.logFacebookEvent(
                  'iap_verified', {'product_id': purchaseDetails.productID});
              unawaited(deliverProduct(purchaseDetails));
            } else {
              SonaAnalytics.log('iap_verify_failed');
              Fluttertoast.showToast(msg: 'Failed to verify the purchase.');
              // if (resp.statusCode == 40030) {
              //   // 已绑定在其他账号
              //   Fluttertoast.showToast(msg: 'This purchase is already linked to another App account. Please use the original account to login the App.');
              // } else if (resp.statusCode == 40040) {
              //   // 已绑定
              //   Fluttertoast.showToast(msg: 'This purchase is already linked to your account.');
              // } else {
              //   Fluttertoast.showToast(msg: 'Failed to verify the purchase.');
              //   // return;
              // }
            }
          } catch (e) {
            SonaAnalytics.log('iap_error');
            Fluttertoast.showToast(msg: 'Failed to verify the purchase.');
          } finally {
            setState(() {
              _purchasePending = false;
            });
          }
        }

        if (purchaseDetails.pendingCompletePurchase) {
          SonaAnalytics.log('iap_Completed');
          await inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  ///确认价格改变
  Future<void> confirmPriceChange(BuildContext context) async {
    // Price changes for Android are not handled by the application, but are
    // instead handled by the Play Store. See
    // https://developer.android.com/google/play/billing/price-changes for more
    // information on price changes on Android.
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
          inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }

  // 获取老订单
  Future<GooglePlayPurchaseDetails?> _getOldSubscription() async {
    GooglePlayPurchaseDetails? oldSubscription;
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition = inAppPurchase
          .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      QueryPurchaseDetailsResponse oldPurchaseDetailsQuery =
          await androidAddition.queryPastPurchases();

      for (var element in oldPurchaseDetailsQuery.pastPurchases) {
        if (element.status == PurchaseStatus.purchased) {
          oldSubscription = element;
        }
      }
    }

    return oldSubscription;
  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildSubTitle(ProductDetails details, double priceMonthly) {
    final selected = ref.watch(selectedPlusSubIdProvider) == details.id;
    int monthCount;
    String name;
    if (details.id == plusMonthlyId) {
      monthCount = 1;
      name = S.current.aMonth;
    } else if (details.id == plusQuarterlyId) {
      monthCount = 3;
      name = S.current.threeMonths;
    } else if (details.id == plusBiannuallyId) {
      monthCount = 6;
      name = S.current.sixMonths;
    } else if (details.id == plusAnnuallyId) {
      monthCount = 12;
      name = S.current.aYear;
    } else {
      throw ();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
              color: selected ? Colors.white : Color(0xff2c2c2c),
              fontSize: 20,
              fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
            '${details.currencySymbol}${(details.rawPrice / monthCount).toStringAsFixed(2)}/${S.current.month}',
            style: TextStyle(
                color: selected ? Colors.white : Color(0xff2c2c2c),
                fontSize: 14,
                fontWeight: FontWeight.w400)),
        SizedBox(height: 4),
        details.id == plusMonthlyId
            ? Container()
            : Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: selected ? Color(0xffFFE806) : Color(0xff2c2c2c),
                ),
                width: 85,
                height: 32,
                child: Text(
                    monthCount == 1
                        ? ''
                        : 'Save ${NumberFormat.percentPattern().format(double.tryParse((1 - (details.rawPrice / monthCount) / priceMonthly).toStringAsFixed(2)))}',
                    style: TextStyle(
                        color: selected ? Color(0xff2c2c2c) : Color(0xffffffff),
                        fontSize: 12,
                        fontWeight: FontWeight.w900)),
              ),
      ],
    );
  }
}

enum FromTag {
  pay_profile,
  pay_chatlist_likedme,
  pay_chatlist_blur,
  pay_chat_sonamsg,
  pay_chat_suggest,
  pay_chat_style,
  pay_chat_hook,
  pay_match_arrow,
  pay_match_likelimit,
  chat_starter,
  profile_myplan,
  travel_wish,
  club_duo_snap, // club会员的duo snap次数用完时
  duo_snap
}

final selectedPlusSubIdProvider =
    StateProvider<String>((ref) => plusQuarterlyId);
