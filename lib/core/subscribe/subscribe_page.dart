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
import 'package:sona/core/subscribe/utils/pay_util.dart';
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
import 'widgets/powers_widget.dart';
import 'package:url_launcher/url_launcher.dart';

const uuid = Uuid();
const String annually = '1_annually';
const String month = '1_month';
const String quarter = '1_quarter';
const String biannually = '1_biannually';
const clubMonthly = 'club_monthly';
const List<String> _kProductIds = <String>[
  month,
  quarter,
  biannually,
  annually,
];

class SubscribePage extends ConsumerStatefulWidget {
  const SubscribePage(this.showType,  {super.key,required this.fromTag,});
  final FromTag fromTag;
  final SubscribeShowType showType;
  @override
  ConsumerState createState() => _SubscribePageState();
}

class _SubscribePageState extends ConsumerState<SubscribePage> {
  //final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  ProductDetails? _clubProduct;
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;
  ProductDetails? _productDetails;
  ScrollController _scrollController=ScrollController();
  var _showing = 'club';

  @override
  void initState() {
    SonaAnalytics.log(ChatEvent.pay_page_open.name,{
      "fromTag":widget.fromTag.name
    });
    // final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          _subscription.cancel();
        }, onError: (Object error) {
          if (kDebugMode) print(error);
        });
    initStoreInfo();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(milliseconds: 500),(){
        if(_scrollController.hasClients){
          _scrollController.animateTo(_scrollController.initialScrollOffset+211/1.5, duration: Duration(milliseconds: 200),curve: Curves.bounceIn);
          setState(() {});
        }
      });
    });
    super.initState();
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
                var result=await showActionButtons(
                    context: context,
                    title: S.of(context).buttonManage,
                    options: {
                      // 'Next Billing Date': '${ref.read(myProfileProvider)?.vipEndDate}',
                      S.of(context).buttonUnsubscribe: 'Unsubscribe'});
                if(result=='Unsubscribe'){
                  if(Platform.isAndroid){
                    launchUrl(Uri.parse('https://play.google.com/store/account/subscriptions?package=com.planetwalk.sona'), mode: LaunchMode.externalApplication);

                  }else if(Platform.isIOS){
                    launchUrl(Uri.parse("https://apps.apple.com/account/subscriptions"), mode: LaunchMode.externalApplication);

                  }
                }
              },
              child: Text(S.of(context).buttonManage),
            ),
          )
        ],
      ),
      floatingActionButton: ref.watch(myProfileProvider)!.memberType == MemberType.none
        || (ref.watch(myProfileProvider)!.memberType == MemberType.club && _showing == 'plus') ? Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: OutlinedButton(onPressed: _purchasePending?null:() async{
          late PurchaseParam purchaseParam;
          if (_productDetails == null || _clubProduct == null) {
            return;
          }
          if (Platform.isAndroid) {
            // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
            // verify the latest status of you your subscription by using server side receipt validation
            // and update the UI accordingly. The subscription purchase status shown
            // inside the app may not be accurate.
            final GooglePlayPurchaseDetails? oldSubscription = await  _getOldSubscription();
            purchaseParam = GooglePlayPurchaseParam(
                applicationUserName: ref.read(myProfileProvider)!.id.toString(),
                productDetails: _showing == 'club' ? _clubProduct! : _productDetails!,
                changeSubscriptionParam: (oldSubscription != null)
                    ? ChangeSubscriptionParam(
                  oldPurchaseDetails: oldSubscription,
                  prorationMode: ProrationMode.immediateAndChargeFullPrice,
                ) : null);
          } else {
            //InAppPurchase.instance.restorePurchases();
            purchaseParam = AppStorePurchaseParam(
              applicationUserName: ref.read(myProfileProvider)!.id.toString(),
              productDetails: _showing == 'club' ? _clubProduct! : _productDetails!,
            );
          }
          try {
            await inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
          } catch (e) {
            inAppPurchase.restorePurchases(applicationUserName: ref.read(myProfileProvider)!.id.toString());
          }
          //inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
          SonaAnalytics.log(PayEvent.pay_continue.name);
        },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: _showing == 'club' ? Color(0xFFBEFF06) : Colors.white
          ),
          child: _purchasePending ? CircularProgressIndicator() : Text(_showing == 'club' ? S.current.buttonJoinNow : '🌟 ${S.of(context).buttonContinue} 🌟'),
        ),
      ) : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _showing == 'club' ? _buildClub() : SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTabBar(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(widget.showType.label,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.w900
                            )
                        ),
                      ),
                      PowersWidget(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 80),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.imagesSubBg),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter
                    ),
                    color: Colors.white
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('SONA Plus',style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff2c2c2c)
                        ),),
                      ),
                      Container(
                        color: Color(0xFFBEFF06),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProductList(),
                            SizedBox(
                              height: 8,
                            ),
                            _buildPlusTerms(),
                            _buildRestoreButton()
                          ],
                        ),
                      ),
                      SizedBox(height: 100)
                    ],
                  ),
                ),
              ],
            ),
            Positioned(child: Image.asset(widget.showType.path,width: 150,height: 150,),right: 0, top: 70),
          ],
        ),
      ),
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

  Widget _buildPlusTerms() => Padding(
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

  Widget _buildClubTerms() => Padding(
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
    return _clubProduct != null ? Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
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
            child: Text('${_clubProduct!.price}/mo',
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
      ),
    ) : Container(
      height: 200,
      alignment: Alignment.center,
      child: const SizedBox(width: 32, height: 32, child: CircularProgressIndicator())
    );
  }

  static final _clubPerks = [
    S.current.clubPerkDuoSnap,
    S.current.clubPerkLike,
    S.current.clubPerkSonaMessage,
    S.current.clubPerkSonaTip,
    S.current.clubPerkBadge
  ];
  Widget _buildClubDesc() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 16),
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

  ///连接检查
  Card _buildConnectionCheckTile() {
    if (_loading) {
      return const Card(child: ListTile(title: Text('Trying to connect...')));
    }
    final Widget storeHeader = _isAvailable?Container():ListTile(
      leading: Icon(_isAvailable ? Icons.check : Icons.block,
          color: _isAvailable
              ? Colors.green
              : ThemeData.light().colorScheme.error),
      title:
      Text('The store is ${_isAvailable ? 'available' : 'unavailable'}.'),
    );
    final List<Widget> children = <Widget>[storeHeader];

    if (!_isAvailable) {
      children.addAll(<Widget>[
        const Divider(),
        ListTile(
          title: Text('Not connected',
              style: TextStyle(color: ThemeData.light().colorScheme.error)),
          subtitle: const Text(
              'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.'),
        ),
      ]);
    }
    return Card(child: Column(children: children));
  }
  ///产品列表
  Widget _buildProductList() {
    if (_loading) {
      return const Card(
          child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching products...')));
    }
    if (!_isAvailable) {
      return const Card();
    }
    final List<Widget> productList = <Widget>[];
    if (_notFoundIds.isNotEmpty) {
      ///产品未找到
      productList.add(Text('[${_notFoundIds.join(", ")}] not found',
          style: TextStyle(color: ThemeData.light().colorScheme.error)),);
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    ///标记购买的内容已交付给用户。转换一下数据类型
    final Map<String, PurchaseDetails> purchases = Map<String, PurchaseDetails>.fromEntries(
        _purchases.map((PurchaseDetails purchase) {
          if (purchase.pendingCompletePurchase) {
            inAppPurchase.completePurchase(purchase);
          }
          return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
        }));
    ///产品列表，继续转换一下数据类型
    _products.sort((l,r)=>l.rawPrice.compareTo(r.rawPrice));
    double monthBill;
    try{
      monthBill =_products.firstWhere((element) => element.id==month).rawPrice;
    }catch(e){
      return const Text('Error');
    }
    if(_products.isNotEmpty){

      productList.addAll(_products.map(
            (ProductDetails productDetails) {
          ///购买前购买详情，赋值给商品。
          return GestureDetector(
            onTap: () async {

              if(_productDetails!=productDetails){
                _productDetails=productDetails;

                setState(() {

                });
              }

            },
            child: Container(
              width: 160,
              height: 134,
              margin: EdgeInsets.only(right: 11,top: 14),
              decoration: BoxDecoration(
                  color: _productDetails==productDetails?Color(0xff2c2c2c):Color(0xffF6F3F3),
                  borderRadius: BorderRadius.circular(20),
                  // gradient: _productDetails==productDetails?const LinearGradient(colors: [
                  //   Color(0xffFFC36A),
                  //   Color(0xffFFDF8E),
                  // ]):null,
                  border: Border.all(
                      color: Color(0xff2c2c2c),
                      width: 2
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubTitle(productDetails,monthBill),
                  ],
                ),
              ),
            ),
          );
        },
      ));
    }
    return Column(
        children: <Widget>[

          SizedBox(
            height: 151,
            width: MediaQuery.maybeOf(context)?.size.width,
            child: ListView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                  horizontal: 20
              ),
              scrollDirection: Axis.horizontal,
              children: productList,
            ),
          ),

        ]);
  }

  ///初始化店铺信息
  Future<void> initStoreInfo() async {
    ///可用
    final bool isAvailable = await inAppPurchase.isAvailable();
    if(!isAvailable){
      SonaAnalytics.log('inAppPurchase_unAvailable');
    }

    if (!isAvailable&&mounted ) {
      setState(() {
        _isAvailable = isAvailable;
        ///产品详情
        _products = <ProductDetails>[];
        ///购买详情
        _purchases = <PurchaseDetails>[];
        ///没找到
        _notFoundIds = <String>[];
        ///消耗品的id集合
        // _consumables = <String>[];
        ///购买待定
        _purchasePending = false;
        ///正在载入
        _loading = false;
      });
      return;
    }
    ///如果是苹果
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      ///设置代理
      await iosPlatformAddition.setDelegate(IOSPaymentQueueDelegate());
    }
    ///产品详情响应
    final ProductDetailsResponse productDetailResponse = await inAppPurchase.queryProductDetails(_kProductIds.toSet()..add(clubMonthly));
    ///如果没有错误
    if (productDetailResponse.error != null) {
      if(mounted){
        setState(() {
          _queryProductError = productDetailResponse.error!.message;
          _isAvailable = isAvailable;
          _products = productDetailResponse.productDetails;

          // for (var element in _products) {
          //   if(element.id==month){
          //     monthBill=element.rawPrice;
          //   }
          // }
          _purchases = <PurchaseDetails>[];
          _notFoundIds = productDetailResponse.notFoundIDs;
          // _consumables = <String>[];
          _purchasePending = false;
          _loading = false;
        });
      }
      return;
    }
    ///产品详情为空
    if (productDetailResponse.productDetails.isEmpty) {
      if(mounted){
        setState(() {
          _queryProductError = null;
          _isAvailable = isAvailable;
          _products = productDetailResponse.productDetails;
          _purchases = <PurchaseDetails>[];
          _notFoundIds = productDetailResponse.notFoundIDs;
          // _consumables = <String>[];
          _purchasePending = false;
          _loading = false;
        });
      }
      return;
    }
    if(mounted){
      ///载入本地保存的消耗品的id
      setState(() {
        _isAvailable = isAvailable;
        var clubIndex = productDetailResponse.productDetails.indexWhere((pd) => pd.id == clubMonthly);
        _clubProduct = productDetailResponse.productDetails.removeAt(clubIndex);
        _products = List.from(productDetailResponse.productDetails);
        _productDetails=_products.firstWhere((element) => element.id==biannually);
        //_productDetails=_products.last;
        _notFoundIds = productDetailResponse.notFoundIDs;
        // _consumables = consumables;
        _purchasePending = false;
        _loading = false;
      });
    }

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
  ///传递
  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    SonaAnalytics.log('iap_deliver');

    // IMPORTANT!! Always verify purchase details before delivering the product.
    // if (purchaseDetails.productID == _kConsumableId) {
    //   await ConsumableStore.save(purchaseDetails.purchaseID!);
    //   final List<String> consumables = await ConsumableStore.load();
    //   setState(() {
    //     _purchasePending = false;
    //     _consumables = consumables;
    //   });
    // } else {
    //
    // }
    initUserPermission();
    ref.read(myProfileProvider.notifier).refresh();
    if (mounted) {
      setState(() {
        _purchases.add(purchaseDetails);
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

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
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
//获取老订单
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
  _buildSubTitle(ProductDetails details, double monthBill) {
    String id=details.id;
    String p='';
    String per='';

    if(id==month){
      p=S.current.aMonth;
      // return Container();
    }else if(id==quarter){
      per='Save ${NumberFormat.percentPattern().format(double.tryParse((1-(details.rawPrice/3)/monthBill).toStringAsFixed(2)))}';
      p=S.current.threeMonths;
    }
    else if(id==biannually){
      p=S.current.sixMonths;
      per='Save ${NumberFormat.percentPattern().format(double.tryParse((1-(details.rawPrice/6)/monthBill).toStringAsFixed(2)))}';

     // per='${detail s.currencySymbol}${(details.rawPrice/6).toStringAsFixed(2)}';
    }
    else if(id==annually){
      p=S.current.aYear;
      per='Save ${NumberFormat.percentPattern().format(double.tryParse((1-(details.rawPrice/12)/monthBill).toStringAsFixed(2)))}';

      //(details.rawPrice/12)/monthBill;
     //per='${details.currencySymbol}${(details.rawPrice/12).toStringAsFixed(2)}';
      // return Text();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(p,style: TextStyle(
            color: _productDetails==details?Color(0xffffffff):Color(0xff2c2c2c),
            fontSize: 20,
            fontWeight: FontWeight.w800

        ),),
        SizedBox(
          height: 4,
        ),
        _buildPerMonth(details),
        SizedBox(
          height: 4,
        ),
        details.id==month?Container():Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _productDetails==details?Color(0xffFFE806):Color(0xff2c2c2c),
          ),
          width: 85,
          height: 32,
          child: Text('${(per)}',style: TextStyle(
              color: _productDetails==details?Color(0xff2c2c2c):Color(0xffffffff),
              fontSize: 12,
            fontWeight: FontWeight.w900
          ),),
        ),
      ],
    );
  }
  _buildPerMonth(ProductDetails details) {
    String id=details.id;
    String p='';
    if(id==month){
      p='${details.currencySymbol}${(details.rawPrice).toStringAsFixed(2)}/${S.current.month}';
      //return Container();
    }else if(id==quarter){
      // return Text('${details.currencySymbol}${(details.rawPrice/3).toStringAsFixed(1)}');
      p='${details.currencySymbol}${(details.rawPrice/3).toStringAsFixed(2)}/${S.current.month}';
    }
    else if(id==biannually){
      // return Text('${details.currencySymbol}${(details.rawPrice/6).toStringAsFixed(1)}');
      p='${details.currencySymbol}${(details.rawPrice/6).toStringAsFixed(2)}/${S.current.month}';
    }
    else if(id==annually){
      p='${details.currencySymbol}${(details.rawPrice/12).toStringAsFixed(2)}/${S.current.month}';
      // return Text();
    }
    return Text(p,style: TextStyle(
      color: _productDetails==details?Color(0xffffffff):Color(0xff2c2c2c),
      fontSize: 14,
      fontWeight: FontWeight.w400
    ),);
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
  travel_wish
}
class SubscribeShowType{
  String path;
  String label;
  SubscribeShowType(this.label,this.path);
  ///解锁who lik eme
  factory SubscribeShowType.unlockWhoLikeMe(){
    return SubscribeShowType(S.current.subPageSubtitleUnlockWhoLikesU,Assets.imagesM1);
  }
  ///解锁无限like
  factory SubscribeShowType.unlockUnlimitedLikes(){
    return SubscribeShowType(S.current.subPageSubtitleUnlimitedLikes,Assets.imagesM2);
  }
  ///解锁DM
  factory SubscribeShowType.unlockDM(){
    return SubscribeShowType(S.current.subPageSubtitleDMWeekly,Assets.imagesM3);
  }
  ///解锁sona建议
  factory SubscribeShowType.unlockSonaTips(){
    return SubscribeShowType(S.current.subPageSubtitleSonaTips,Assets.imagesM4);
  }
  ///解锁三个愿望单
  factory SubscribeShowType.unlockThreeWishes(){
    return SubscribeShowType(S.current.subPageSubtitleFilterMatchingCountries,Assets.imagesM5);
  }
  ///解锁无限次的sona翻译
  factory SubscribeShowType.unlockMoreAIInterpretation(){
    return SubscribeShowType(S.current.subPageSubtitleAIInterpretationDaily,Assets.imagesM6);
  }
}