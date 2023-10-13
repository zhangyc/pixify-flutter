import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:intl/intl.dart';
import 'package:sona/common/permission/permission.dart';
import 'package:sona/generated/assets.dart';
import 'package:sona/utils/global/global.dart';
import 'package:uuid/uuid.dart';

import '../../account/providers/profile.dart';
import '../../common/widgets/webview.dart';
import '../../test_pay/_MyApp.dart';
import '../../utils/dialog/input.dart';
import '../match/util/event.dart';
import '../match/util/iap_helper.dart';
import 'widgets/powers_widget.dart';
import 'package:url_launcher/url_launcher.dart';

Uuid uuid=const Uuid();
class SubscribePage extends ConsumerStatefulWidget {
  const SubscribePage( {super.key,required this.fromTag,});
  final FromTag fromTag;
  @override
  ConsumerState createState() => _SubscribePageState();
}

const String annually = '1_annually';
const String month = '1_month';
const String quarter = '1_quarter';
const String biannually = '1_biannually';
const List<String> _kProductIds = <String>[
  month,
  quarter,
  biannually,
  annually,
];
class _SubscribePageState extends ConsumerState<SubscribePage> {
  //final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;
  ProductDetails? _productDetails;
  ScrollController _scrollController=ScrollController();
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
      Future.delayed(Duration(milliseconds: 200),(){
        _scrollController.animateTo(_scrollController.initialScrollOffset+211/1.5, duration: Duration(milliseconds: 200),curve: Curves.bounceIn);
        setState(() {

        });

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffeaeaea),
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(onPressed: (){
            initUserPermission();
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back_ios)),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(Assets.iconsSuper,width: 48,height: 19,),
              Text('Super SONA',style: TextStyle(
                  color: Colors.black
              ),),
            ],
          ),
          actions: [
            !ref.read(myProfileProvider)!.isMember?
            TextButton(onPressed: () async {
              var result=await showRadioFieldDialog(
                  context: context,
                  title: 'Manage Payments',
                  options: {'Report': 'Next Billing Date: ${ref.read(myProfileProvider)?.vipEndDate}', 'Unsubscribe': 'Unsubscribe'});
                  if(result=='Unsubscribe'){
                    if(Platform.isAndroid){
                      launchUrl(Uri.parse('https://play.google.com/store/account/subscriptions?sku=${month}&package=com.planetwalk.sona'), mode: LaunchMode.externalApplication);

                    }else if(Platform.isIOS){
                      launchUrl(Uri.parse("https://apps.apple.com/account/subscriptions"), mode: LaunchMode.externalApplication);

                    }
                  }


             }, child: Text('Manage',style: TextStyle(
                color: Color(0xff555555)
            ),)):
            Container()
          ],
        ),
        body: Stack(
          children: [
            Stack(
              children: [
                _queryProductError==null?ListView(
                  children: <Widget>[
                    _buildConnectionCheckTile(),
                    _buildProductList(),
                    // _buildConsumableBox(),
                    // _buildRestoreButton(),
                  ],
                ):Center(
                  child: Text(_queryProductError!),
                ),
              ],
            ),
            Positioned(bottom: 0,
              width: MediaQuery.of(context).size.width,child: Column(
                children: [
                  ElevatedButton(onPressed: () async{
                    late PurchaseParam purchaseParam;
                    if(_productDetails==null){
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
                          productDetails: _productDetails!,
                          changeSubscriptionParam: (oldSubscription != null)
                              ? ChangeSubscriptionParam(
                            oldPurchaseDetails: oldSubscription,
                            prorationMode: ProrationMode.immediateAndChargeFullPrice,
                          ) : null);
                    } else {
                      //InAppPurchase.instance.restorePurchases();
                      purchaseParam = AppStorePurchaseParam(
                        applicationUserName: ref.read(myProfileProvider)!.id.toString(),
                        productDetails: _productDetails!,
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
                        fixedSize: Size(346, 50),
                        padding: EdgeInsets.zero
                    ),
                    child: Container(decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xffFF0099),
                          Color(0xffF5326D),
                        ])
                    ),
                      alignment: Alignment.center,child: const Text('Continue'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),

                    child: RichText(text:TextSpan(text: _terms,
                        style: const TextStyle(
                            color: Color(0xffa9a9a9)
                        ),
                        children: [
                          TextSpan(text: ' Terms',recognizer: TapGestureRecognizer()..onTap=(){
                            Navigator.push(context, MaterialPageRoute(builder: (c){
                              return const WebView(url: 'https://h5.sona.pinpon.fun/terms-and-conditions.html', title: 'Terms and conditions');
                            }));
                          },
                              style: const TextStyle(
                                  color: Color(0xffEA01FF)
                              )
                          ),
                          TextSpan(text: '.')
                        ]
                    ),

                    ),
                  )
                ],
              ),
            ),
            _purchasePending?const Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.7,
                  child: ModalBarrier(dismissible: false, color: Colors.black),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Color(0xffE33E79)),
                      SizedBox(
                        height: 16,
                      ),
                      Text("Payment processing. Don't exit to prevent errors.",style: TextStyle(color: Colors.white),)
                    ],
                  ),
                ),


              ],
            ):Container(),
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
          final PurchaseDetails? previousPurchase = purchases[productDetails.id];
          return GestureDetector(
            onTap: () async {

              if(_productDetails!=productDetails){
                _productDetails=productDetails;

                setState(() {

                });
              }

            },
            child: SizedBox(
              width: 211,
              height: 126,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: 211,
                    height: 111,
                    margin: EdgeInsets.only(right: 11,top: 14),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        // gradient: _productDetails==productDetails?const LinearGradient(colors: [
                        //   Color(0xffFFC36A),
                        //   Color(0xffFFDF8E),
                        // ]):null,
                        border: Border.all(
                          color: _productDetails==productDetails?Color(0xffFF37A3):Color(0xffFFB3DC),
                          width: 4
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildSubTitle(productDetails,monthBill),
                          _buildPerMonth(productDetails)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 96,
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: _productDetails==productDetails?Color(0xffFF37A3):Color(0xffFFB3DC),
                    ),
                    child: Text('${productDetails.price}',style: TextStyle(
                      color: Colors.white
                    ),),
                  )
                ],
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
          Container(
            height: 365,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only( 
                topLeft: Radius.zero,
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
            ),
            child: PowersWidget()
          ),

        ]);
  }

  // Card _buildConsumableBox() {
  //   if (_loading) {
  //     return const Card(
  //         child: ListTile(
  //             leading: CircularProgressIndicator(),
  //             title: Text('Fetching consumables...')));
  //   }
  //   if (!_isAvailable || _notFoundIds.contains(_kConsumableId)) {
  //     return const Card();
  //   }
  //   const ListTile consumableHeader =
  //   ListTile(title: Text('Purchased consumables'));
  //   final List<Widget> tokens = _consumables.map((String id) {
  //     return GridTile(
  //       child: IconButton(
  //         icon: const Icon(
  //           Icons.stars,
  //           size: 42.0,
  //           color: Colors.orange,
  //         ),
  //         splashColor: Colors.yellowAccent,
  //         onPressed: () => consume(id),
  //       ),
  //     );
  //   }).toList();
  //   return Card(
  //       child: Column(children: <Widget>[
  //         consumableHeader,
  //         const Divider(),
  //         GridView.count(
  //           crossAxisCount: 5,
  //           shrinkWrap: true,
  //           padding: const EdgeInsets.all(16.0),
  //           children: tokens,
  //         )
  //       ]));
  // }

  // Widget _buildRestoreButton() {
  //   if (_loading) {
  //     return Container();
  //   }
  //
  //   return Padding(
  //     padding: const EdgeInsets.all(4.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: <Widget>[
  //         TextButton(
  //           style: TextButton.styleFrom(
  //             backgroundColor: Theme.of(context).primaryColor,
  //             foregroundColor: Colors.white,
  //           ),
  //           onPressed: () => _inAppPurchase.restorePurchases(),
  //           child: const Text('Restore purchases'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  ///初始化店铺信息
  Future<void> initStoreInfo() async {
    ///可用
    final bool isAvailable = await inAppPurchase.isAvailable();
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
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }
    ///产品详情响应
    final ProductDetailsResponse productDetailResponse = await inAppPurchase.queryProductDetails(_kProductIds.toSet());
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
        _products = productDetailResponse.productDetails;
        _productDetails=_products.last;
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
  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async{
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

    final response=await dio.post('/callback/google-pay',data: map);
    if(response.data!=null){
      if(response.data){
        return Future<bool>.value(true);
      }else {
        return Future<bool>.value(false);
      }
    }
    return Future<bool>.value(false);

  }
  ///传递
  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
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
    if(mounted){
      ref.read(myProfileProvider.notifier).refresh();
    }
    setState(() {
      _purchases.add(purchaseDetails);
      _purchasePending = false;
    });
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
  ///监听到的服务端配置的产品
  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    ///遍历购买列表
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {

      if (purchaseDetails.status == PurchaseStatus.pending) {
        //purchaseDetails.status=PurchaseStatus.canceled;

        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
          ///已购买
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            ///恢复购买
            purchaseDetails.status == PurchaseStatus.restored) {
          try{
            final bool valid = await _verifyPurchase(purchaseDetails);
            if (valid) {
              unawaited(deliverProduct(purchaseDetails));
            } else {
              ///处理无效的购买
              _handleInvalidPurchase(purchaseDetails);
              return;
            }
          } catch(e){
            Fluttertoast.showToast(msg: 'Handle err');
            setState(() {
              _purchasePending = false;
            });
          }

        }
        if (purchaseDetails.pendingCompletePurchase) {
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
      p='1 Month';
      // return Container();
    }else if(id==quarter){
      per='Save ${NumberFormat.percentPattern().format(double.tryParse((1-(details.rawPrice/3)/monthBill).toStringAsFixed(2)))}';
      p='3 Month';
    }
    else if(id==biannually){
      p='6 Month';
      per='Save ${NumberFormat.percentPattern().format(double.tryParse((1-(details.rawPrice/6)/monthBill).toStringAsFixed(2)))}';

     // per='${detail s.currencySymbol}${(details.rawPrice/6).toStringAsFixed(2)}';
    }
    else if(id==annually){
      p='12 Month';
      per='Save ${NumberFormat.percentPattern().format(double.tryParse((1-(details.rawPrice/12)/monthBill).toStringAsFixed(2)))}';

      //(details.rawPrice/12)/monthBill;
     //per='${details.currencySymbol}${(details.rawPrice/12).toStringAsFixed(2)}';
      // return Text();
    }
    return Column(
      children: [
        Text(p,style: TextStyle(
            color: Colors.black,
            fontSize: 20
        ),),
        Text('${(per)}',style: TextStyle(
            color: Color(0xffFF5C8D),
            fontSize: 12
        ),),
      ],
    );
  }
  _buildPerMonth(ProductDetails details) {
    String id=details.id;
    String p='';
    if(id==month){
      p='${details.currencySymbol}${(details.rawPrice).toStringAsFixed(2)}/mo';
      //return Container();
    }else if(id==quarter){
      // return Text('${details.currencySymbol}${(details.rawPrice/3).toStringAsFixed(1)}');
      p='${details.currencySymbol}${(details.rawPrice/3).toStringAsFixed(2)}/mo';
    }
    else if(id==biannually){
      // return Text('${details.currencySymbol}${(details.rawPrice/6).toStringAsFixed(1)}');
      p='${details.currencySymbol}${(details.rawPrice/6).toStringAsFixed(2)}/mo';
    }
    else if(id==annually){
      p='${details.currencySymbol}${(details.rawPrice/12).toStringAsFixed(2)}/mo';
      // return Text();
    }
    return Text(p,style: TextStyle(
      color: Color(0xffFF185D),
      fontSize: 14
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
  profile_myplan
}

List<String> unlockFeatures=[
  '查看谁喜欢了我',
  'Arrow',
  '无限点赞',
  '趣味建议',
  'sona回复',
  'sona建议',
  'hook'
];
String _terms='''By tapping Continue, you will be charged, your subscription will auto-renew for the same price and package length until you cancel via Play Store settings, and you agree to our ''';