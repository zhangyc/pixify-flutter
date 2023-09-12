import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:sona/account/models/user_info.dart';
import 'package:sona/generated/assets.dart';

import '../../account/providers/profile.dart';
import '../../test_pay/_MyApp.dart';
import '../../utils/providers/dio.dart';
class SubscribePage extends ConsumerStatefulWidget {
  const SubscribePage({super.key});

  @override
  ConsumerState createState() => _SubscribePageState();
}
final bool _kAutoConsume = Platform.isIOS || true;

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
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  // List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;
  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          _subscription.cancel();
        }, onError: (Object error) {
          print(error);
        });
    initStoreInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> stack = <Widget>[];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: <Widget>[
            _buildConnectionCheckTile(),
            _buildProductList(),
            // _buildConsumableBox(),
            // _buildRestoreButton(),
          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError!),
      ));
    }
    if (_purchasePending) {
      stack.add(
        const Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.3,
              child: ModalBarrier(dismissible: false, color: Colors.red),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffeaeaea),
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(onPressed: ()=>Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios)),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.iconsSuper,width: 85,height: 40,),
              Text('SONA',style: TextStyle(
                color: Colors.black
              ),),
            ],
          ),
        ),
        body: Stack(
          children: stack,
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
      productList.add(ListTile(
          title: Text('[${_notFoundIds.join(", ")}] not found',
              style: TextStyle(color: ThemeData.light().colorScheme.error)),
          subtitle: const Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    ///标记购买的内容已交付给用户。转换一下数据类型
    final Map<String, PurchaseDetails> purchases = Map<String, PurchaseDetails>.fromEntries(
        _purchases.map((PurchaseDetails purchase) {
          if (purchase.pendingCompletePurchase) {
            _inAppPurchase.completePurchase(purchase);
          }
          return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
        }));
    ///产品列表，继续转换一下数据类型
    productList.addAll(_products.map(
          (ProductDetails productDetails) {
        ///购买前购买详情，赋值给商品。
        final PurchaseDetails? previousPurchase = purchases[productDetails.id];
        return GestureDetector(
          onTap: () async {
            late PurchaseParam purchaseParam;

            if (Platform.isAndroid) {
              // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
              // verify the latest status of you your subscription by using server side receipt validation
              // and update the UI accordingly. The subscription purchase status shown
              // inside the app may not be accurate.
              final GooglePlayPurchaseDetails? oldSubscription = await  _getOldSubscription();
              purchaseParam = GooglePlayPurchaseParam(
                  applicationUserName: ref.read(asyncMyProfileProvider).value!.id.toString(),
                  productDetails: productDetails,
                  changeSubscriptionParam: (oldSubscription != null)
                      ? ChangeSubscriptionParam(
                    oldPurchaseDetails: oldSubscription,
                    prorationMode: ProrationMode.immediateAndChargeFullPrice,
                  ) : null);
            } else {
              purchaseParam = PurchaseParam(
                productDetails: productDetails,
              );
            }
            _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);

          },
          child: Container(
            width: 135,
            height: 151,
            margin: EdgeInsets.only(right: 11),
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                Text(
                  productDetails.title,
                ),
                Text(
                  productDetails.description,
                ),
                Text(productDetails.price),
              ],
            ),
          ),
        );
      },
    ));

    return Column(
        children: <Widget>[
          SizedBox(
            child: ListView(
              padding: EdgeInsets.symmetric(
                  horizontal: 20
              ),
              scrollDirection: Axis.horizontal,
              children: productList,
            ),
            height: 151,
            width: MediaQuery.maybeOf(context)?.size.width,
          ),
          Container(
            child: Text(' When i become a supersona,i can do:'),
          ),
          Container(
            height: 318,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
            ),
            child: ListView.separated(itemBuilder: (_,i){
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 12
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(unlockFeatures[i]),
                ),
              );

            }, separatorBuilder: (_,i){
              return Container(
                color: Colors.grey,
                height: 2,
              );
            }, itemCount: unlockFeatures.length

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('到期自动续费，可随时取消到期自动续费，可随时取消到期自动续费，可随时取消'),
          )
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
    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
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
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      ///设置代理
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }
    ///产品详情响应
    final ProductDetailsResponse productDetailResponse =
    await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    ///如果没有错误
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        // _consumables = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }
    ///产品详情为空
    if (productDetailResponse.productDetails.isEmpty) {
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
      return;
    }
    ///载入本地保存的消耗品的id
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      // _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }
  ///
  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }
  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async{

    final response=await ref.read(dioProvider).post('/callback/google-pay',data: {
      "packageName":"com.planetwalk.sona",
      "productId":purchaseDetails.productID,
      "purchaseToken":purchaseDetails.verificationData.serverVerificationData,
      "serviceType":"SUBSCRIPTION"
    });
    if(response!=null&&response.data!=null){
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
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
          ///已购买
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            ///恢复购买
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            unawaited(deliverProduct(purchaseDetails));
          } else {
            ///处理无效的购买
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
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
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }
//获取老订单
  Future<GooglePlayPurchaseDetails?> _getOldSubscription() async {
    GooglePlayPurchaseDetails? oldSubscription;
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition = _inAppPurchase.getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
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
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }
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