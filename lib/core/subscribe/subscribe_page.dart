import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:intl/intl.dart';
import 'package:sona/common/env.dart';
import 'package:sona/common/permission/permission.dart';
import 'package:sona/common/widgets/image/icon.dart';
import 'package:sona/core/subscribe/providers/subscriptions.dart';
import 'package:sona/generated/assets.dart';
import 'package:sona/utils/global/global.dart';
import 'package:uuid/uuid.dart';

import '../../account/providers/profile.dart';
import '../../common/widgets/webview.dart';
import '../../generated/l10n.dart';
import '../../utils/dialog/input.dart';
import '../match/util/event.dart';
import '../match/util/iap_helper.dart';
import 'model/member.dart';
import 'package:url_launcher/url_launcher.dart';

const uuid = Uuid();

class SubscribePage extends ConsumerStatefulWidget {
  const SubscribePage({
    super.key,
    required this.fromTag
  });
  final FromTag fromTag;

  @override
  ConsumerState createState() => _SubscribePageState();
}

class _SubscribePageState extends ConsumerState<SubscribePage> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  bool _purchasePending = false;
  ScrollController _scrollController=ScrollController();
  late var _showing = [
    FromTag.pay_chatlist_likedme,
    FromTag.pay_match_arrow,
    FromTag.club_duo_snap
  ].contains(widget.fromTag) ? 'plus' : 'club';

  @override
  void initState() {
    super.initState();
    SonaAnalytics.log(ChatEvent.pay_page_open.name,{
      "fromTag":widget.fromTag.name
    });
    _subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      if (kDebugMode) print(error);
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if(_scrollController.hasClients){
          _scrollController.animateTo(_scrollController.initialScrollOffset+211/1.5, duration: Duration(milliseconds: 200),curve: Curves.bounceIn);
          setState(() {});
        }
      });
    });
  }

  Future _subscribeClub() async {
    final clubDetails = ref.read(asyncSubscriptionsProvider).value!.firstWhere((sub) => sub.id == clubMonthlyId);
    _subscribe(clubDetails);
  }

  Future _subscribePlus() async {
    final plusDetails = ref.read(asyncSubscriptionsProvider).value!.firstWhere((sub) => sub.id == ref.read(selectedPlusSubIdProvider));
    _subscribe(plusDetails);
  }

  Future _subscribe(ProductDetails pd) async {
    late PurchaseParam purchaseParam;
    if (Platform.isAndroid) {
      // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
      // verify the latest status of you your subscription by using server side receipt validation
      // and update the UI accordingly. The subscription purchase status shown
      // inside the app may not be accurate.
      final GooglePlayPurchaseDetails? oldSubscription = await  _getOldSubscription();
      purchaseParam = GooglePlayPurchaseParam(
          applicationUserName: ref.read(myProfileProvider)!.id.toString(),
          productDetails: pd,
          changeSubscriptionParam: (oldSubscription != null)
              ? ChangeSubscriptionParam(
            oldPurchaseDetails: oldSubscription,
            prorationMode: ProrationMode.immediateAndChargeFullPrice,
          ) : null);
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
      inAppPurchase.restorePurchases(applicationUserName: ref.read(myProfileProvider)!.id.toString());
    }
    //inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    SonaAnalytics.log(PayEvent.pay_continue.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _showing == 'club' ? Colors.white : const Color(0xFFBEFF06),
      appBar: AppBar(
        backgroundColor: _showing == 'club' ? const Color(0xFFBEFF06) : Colors.white,
        title: Text('Subscribe'),
        actions: [
          if (ref.read(myProfileProvider)!.isMember) UnconstrainedBox(
            child: TextButton(
              onPressed: () async {
                var result = await showActionButtons(
                  context: context,
                  title: S.of(context).buttonManage,
                  options: {
                    S.of(context).buttonUnsubscribe: 'manage'
                  }
                );
                if (result == 'manage') {
                  if (Platform.isAndroid) {
                    launchUrl(Uri.parse('https://play.google.com/store/account/subscriptions?package=com.planetwalk.sona'), mode: LaunchMode.externalApplication);
                  } else if (Platform.isIOS) {
                    launchUrl(Uri.parse("https://apps.apple.com/account/subscriptions"), mode: LaunchMode.externalApplication);
                  }
                }
              },
              child: Text(S.of(context).buttonManage),
            ),
          )
        ],
      ),
      floatingActionButton: ref.watch(myProfileProvider)!.memberType == MemberType.none || (ref.watch(myProfileProvider)!.memberType == MemberType.club && _showing == 'plus') ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: OutlinedButton(
          onPressed: _purchasePending || !ref.watch(asyncSubscriptionsProvider).hasValue ? null : (_showing == 'club' ? _subscribeClub : _subscribePlus),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: _showing == 'club' ? Color(0xFFBEFF06) : Colors.white
          ),
          child: _purchasePending ? CircularProgressIndicator() : Text(_showing == 'club' ? S.current.buttonJoinNow : '🌟 ${S.of(context).buttonContinue} 🌟'),
        ),
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _showing == 'club' ? _buildClub() : _buildPlus()
    );
  }

  void _showTab(String name) {
    if (_showing != name) {
      setState(() {
        _showing = name;
      });
    }
  }

  Widget _buildTabBar() => Container(
    margin: EdgeInsets.symmetric(vertical: 12),
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Flexible(
          child: OutlinedButton(
              onPressed: () => _showTab('club'),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(_showing == 'club' ? Colors.black : Colors.transparent),
                foregroundColor: MaterialStatePropertyAll(_showing == 'club' ? Colors.white : Colors.black),
              ),
              child: Text('Club')
          ),
        ),
        SizedBox(width: 12),
        Flexible(
          child: OutlinedButton(
              onPressed: () => _showTab('plus'),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(_showing == 'plus' ? Colors.black : Colors.transparent),
                foregroundColor: MaterialStatePropertyAll(_showing == 'plus' ? Colors.white : Colors.black),
              ),
              child: Text('Plus')
          ),
        ),
      ],
    ),
  );

  Widget _buildPlusTerms() => Container(
    margin: EdgeInsets.only(top: 24),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: RichText(
      text: TextSpan(
        text: S.current.subscriptionAgreementPrefix(Platform.isAndroid ? 'Play Store' : 'Apple ID'),
        style: const TextStyle(
          color: Color(0xffa9a9a9),
          fontSize: 12,
        ),
        children: [
          TextSpan(
              text: S.current.subscriptionAgreement,
              recognizer: TapGestureRecognizer()..onTap = () {
                Navigator.push(context, MaterialPageRoute(builder: (c){
                  return WebView(url: env.termsOfService, title: S.of(context).termsOfService);
                }));
              },
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w800
              )
          ),
          TextSpan(text: S.current.subscriptionAgreementSuffix),
        ]
      ),
    ),
  );

  Widget _buildClubTerms() => Container(
    margin: EdgeInsets.only(top: 24),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: RichText(
      text: TextSpan(
          text: S.current.clubTerms(Platform.isAndroid ? 'Play Store' : 'Apple ID'),
          style: const TextStyle(
            color: Color(0xffa9a9a9),
            fontSize: 12,
          ),
          children: [
            TextSpan(
                text: S.current.subscriptionAgreement,
                recognizer: TapGestureRecognizer()..onTap = () {
                  Navigator.push(context, MaterialPageRoute(builder: (c){
                    return WebView(url: env.termsOfService, title: S.of(context).termsOfService);
                  }));
                },
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w800
                )
            ),
            TextSpan(text: S.current.subscriptionAgreementSuffix),
          ]
      ),
    ),
  );

  Widget _buildClubFee() {
    return Container(
        height: 200,
        alignment: Alignment.center,
        child: ref.watch(asyncSubscriptionsProvider).when(
            data: (subscriptions) {
              final club = subscriptions.firstWhere((sub) => sub.id == clubMonthlyId);
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      clipBehavior: Clip.antiAlias,
                      alignment: Alignment.center,
                      child: Text(S.current.clubPromotionTitle, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    alignment: Alignment.center,
                    child: Text(S.current.clubFeePrefix,
                        style: Theme.of(context).textTheme.titleLarge
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    alignment: Alignment.center,
                    child: Text('${club.price}/${S.of(context).month}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 32
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    alignment: Alignment.center,
                    child: Text('😉 ${S.current.clubFeeJoking}',
                        style: Theme.of(context).textTheme.bodySmall
                    ),
                  ),
                ],
              );
            },
            error: (_, __) => Container(),
            loading: () => const SizedBox(width: 32, height: 32, child: CircularProgressIndicator())
        )
    );
  }

  final _clubPerks = [
    S.current.clubPerkDuoSnap,
    S.current.clubPerkLike,
    S.current.clubPerkSonaMessage,
    S.current.clubPerkSonaTip,
    S.current.clubPerkBadge
  ];

  Widget _buildClubDesc() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/white_star_bg.png'),
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.current.membersPerks,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900
              )
          ),
          const SizedBox(height: 8),
          ..._clubPerks.map((perk) => Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Image.asset(Assets.iconsCorrect, width: 14, height: 14, color: Colors.black),
                const SizedBox(width: 8),
                Text(perk,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800
                  )
                ),
              ],
            ),
          )),
          const SizedBox(height: 8),
          Text(S.current.clubPromotionContent,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Color(0xFFFFE41F),
                fontWeight: FontWeight.w900
              )
          )
        ],
      ),
    );
  }

  Widget _buildRestoreButton() {
    return Visibility(
      visible: Platform.isIOS,
      child: TextButton(
        onPressed: (){
          bool isMember=ref.read(myProfileProvider)?.isMember??false;
          if(isMember){
            Fluttertoast.showToast(
                msg: switch(ref.read(myProfileProvider)?.memberType) {
                  MemberType.club => S.current.youAreAClubMemberNow,
                  MemberType.plus => S.current.buttonAlreadyPlus,
                  _ => ''
                }
            );
          } else {
            if (hasPurchased == true) {
              inAppPurchase.restorePurchases(applicationUserName: ref.read(myProfileProvider)!.id.toString());
            } else {
              Fluttertoast.showToast(msg: 'Failed to restore, can\'t find records.');
            }
          }
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          maximumSize: Size(MediaQuery.of(context).size.width, 56),
          fixedSize: Size(MediaQuery.of(context).size.width, 56)
        ),
        child: Text(S.of(context).buttonRestore)
      ),
    );
  }

  Widget _buildClub() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: 90),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/green_bg.png'),
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _buildTabBar(),
            _buildClubFee(),
            _buildClubDesc(),
            _buildClubTerms(),
            _buildRestoreButton()
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Image.asset('assets/images/cloud_green_narrow.png', fit: BoxFit.fitWidth);
  }

  Widget _buildPlusTitle() {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(widget.fromTag == FromTag.club_duo_snap ? S.current.plusPerkDuoSnap : S.current.plusDescTitle,
              style: Theme.of(context).textTheme.titleLarge
            )
          ),
          SonaIcon(icon: SonaIcons.plus_mark, size: 100)
        ],
      ),
    );
  }

  final _plusPerks = [
    S.current.plusPerkDuoSnap,
    S.current.plusFuncUnlockWhoLikesU,
    S.current.plusFuncAIInterpretation,
    S.current.plusFuncUnlimitedLikes,
    S.current.plusFuncDMPerWeek,
    S.current.plusFuncSonaTips
  ];

  Widget _buildPlusDesc() {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._plusPerks.map((perk) => Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Image.asset(Assets.iconsCorrect, width: 14, height: 14, color: Colors.black),
                const SizedBox(width: 8),
                Text(perk,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800
                  )
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPlus() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: 90),
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.3],
            colors: [
              Colors.white,
              Color(0xFFBEFF06)
            ]
          )
        ),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildTabBar(),
                  _buildPlusTitle(),
                  _buildPlusDesc(),
                  _buildDivider(),
                ],
              ),
            ),
            _buildPlusSubscriptionsTitle(),
            _buildPlusSubscriptions(),
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
      child: Text('Sona Plus',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 24
          )
      )
    );
  }

  Widget _buildPlusSubscriptions() {
    return Container(
      height: 152,
      width: MediaQuery.maybeOf(context)?.size.width,
      child: ref.watch(asyncSubscriptionsProvider).when(
        data: (subscriptions) {
          final monthlyPrice = subscriptions.firstWhere((sub) => sub.id == plusMonthlyId).rawPrice;
          return ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              ...(subscriptions.where((sub) => plusSubscriptionIds.contains(sub.id)).toList()..sort((a, b) => (a.rawPrice - b.rawPrice).ceil())).map<Widget>((sub) => GestureDetector(
                onTap: () async {
                  ref.read(selectedPlusSubIdProvider.notifier).update((state) => sub.id);
                },
                child: Container(
                  width: 160,
                  height: 134,
                  margin: EdgeInsets.only(right: 11,top: 14),
                  decoration: BoxDecoration(
                      color: ref.watch(selectedPlusSubIdProvider) == sub.id ? Color(0xff2c2c2c) : Color(0xffF6F3F3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xff2c2c2c), width: 2)
                  ),
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
        )
      ),
    );
  }

  ///
  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<Response> _verifyPurchase(PurchaseDetails purchaseDetails) async{

    Map<String,dynamic> map={};
    if(Platform.isAndroid){
      map={
        "packageName":"com.planetwalk.sona",
        "productId":purchaseDetails.productID,
        "purchaseToken":purchaseDetails.verificationData.serverVerificationData,
        "serviceType":"SUBSCRIPTION"
      };
    }else if(Platform.isIOS){
      map={
        "packageName":"com.planetwalk.sona",
        "productId":purchaseDetails.productID,
        "purchaseToken":purchaseDetails.verificationData.serverVerificationData,
        "serviceType":"SUBSCRIPTION_APPLE"
      };
    }

    return dio.post('/callback/google-pay',data: map);
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
          msg: switch(ref.read(myProfileProvider)?.memberType) {
            MemberType.club => S.current.youAreAClubMemberNow,
            MemberType.plus => S.current.buttonAlreadyPlus,
            _ => ''
          }
      );
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
  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    final hp = purchaseDetailsList.any((p) => p.status == PurchaseStatus.purchased);
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
          } catch(e){
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
      final InAppPurchaseAndroidPlatformAddition androidAddition = inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      QueryPurchaseDetailsResponse oldPurchaseDetailsQuery = await androidAddition.queryPastPurchases();

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
    final (monthCount, name) = switch(details.id) {
      plusMonthlyId => (1, S.current.aMonth),
      plusQuarterlyId => (3, S.current.threeMonths),
      plusBiannuallyId => (6, S.current.sixMonths),
      plusAnnuallyId => (12, S.current.aYear),
      _ => throw()
    };

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name,
          style: TextStyle(
            color: selected ? Colors.white : Color(0xff2c2c2c),
            fontSize: 20,
            fontWeight: FontWeight.w800
        ),),
        SizedBox(
          height: 4,
        ),
        Text('${details.currencySymbol}${(details.rawPrice/monthCount).toStringAsFixed(2)}/${S.current.month}',
          style: TextStyle(
            color: selected ? Colors.white : Color(0xff2c2c2c),
            fontSize: 14,
            fontWeight: FontWeight.w400
          )
        ),
        SizedBox(height: 4),
        details.id==plusMonthlyId?Container():Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: selected ? Color(0xffFFE806) : Color(0xff2c2c2c),
          ),
          width: 85,
          height: 32,
          child: Text(monthCount == 1 ? '' : 'Save ${NumberFormat.percentPattern().format(double.tryParse((1-(details.rawPrice/monthCount)/priceMonthly).toStringAsFixed(2)))}',
            style: TextStyle(
              color: selected ? Color(0xff2c2c2c) : Color(0xffffffff),
              fontSize: 12,
              fontWeight: FontWeight.w900
            )
          ),
        ),
      ],
    );
  }
}

enum FromTag{
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

final selectedPlusSubIdProvider = StateProvider<String>((ref) => plusBiannuallyId);