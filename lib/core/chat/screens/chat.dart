import 'dart:async';
import 'dart:io';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sona/account/providers/info.dart';
import 'package:sona/core/chat/models/message.dart';
import 'package:sona/core/chat/providers/chat.dart';
import 'package:sona/core/chat/providers/chat_action.dart';
import 'package:sona/core/chat/providers/chat_style.dart';
import 'package:sona/core/chat/screens/info.dart';
import 'package:sona/core/chat/services/chat.dart';
import 'package:sona/core/chat/widgets/chat_actions.dart';
import 'package:sona/core/chat/widgets/chat_input.dart';
import 'package:sona/core/chat/widgets/chat_instruction_input.dart';
import 'package:sona/core/persona/widgets/sona_message.dart';
import 'package:sona/common/widgets/button/colored.dart';
import 'package:sona/common/widgets/text/gradient_colored_text.dart';

import '../../../common/models/user.dart';
import '../../../test_pay/_MyApp.dart';
import '../../../utils/providers/dio.dart';

class ChatFunctionScreen extends StatefulHookConsumerWidget {
  const ChatFunctionScreen({super.key, required this.otherSide});
  final UserInfo otherSide;
  static const routeName="lib/core/chat/screens/chat";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatFunctionScreenState();
}

class _ChatFunctionScreenState extends ConsumerState<ChatFunctionScreen> with RouteAware {

  ChatActionMode _mode = ChatActionMode.docker;

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didPushNext() {
    super.didPushNext();
  }

  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherSide.name!),
        actions: [
          IconButton(onPressed: _deleteAllMessages, icon: Icon(Icons.cleaning_services_outlined)),
          IconButton(onPressed: _showInfo, icon: Icon(Icons.info_outline))
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
            _mode = ChatActionMode.docker;
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 100,
              child: ref.watch(messageStreamProvider(widget.otherSide.id)).when(
                data: (messages) => messages.isNotEmpty ? Container(
                  alignment: Alignment.topCenter,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      final msg = messages[index];
                      return _itemBuilder(msg);
                    },
                    itemCount: messages.length,
                    separatorBuilder: (_, __) => SizedBox(height: 5),
                  ),
                ) : _tips(),
                error: (error, __) => Container(child: Text(error.toString()),),
                loading: () => Container(
                  alignment: Alignment.center,
                  child: const SizedBox(
                    height: 32,
                    width: 32,
                    child: CircularProgressIndicator(),
                  ),
                )
              )
            ),
          ],
        ),
      ),
      floatingActionButton: _mode == ChatActionMode.docker ? ChatActions(
        onAct: _onAction
      ) : Container(
        padding: EdgeInsets.only(
          top: 12,
          bottom: MediaQuery.of(context).viewInsets.bottom + 12
        ),
        color: Colors.white,
        child: _mode == ChatActionMode.sona ? ChatInstructionInput(onSubmit: _onSona, autofocus: true,) :  ChatInput(onSubmit: _onMessage, autofocus: true,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _itemBuilder(ImMessage msg) {
    final me = ref.read(asyncMyProfileProvider);
    if (msg.sender.id == me.value!.id) {
      return Container(
        margin: EdgeInsets.only(left: 70, bottom: 12, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(msg.content, style: Theme.of(context).textTheme.bodySmall),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(msg.time.toMessageTime(), style: Theme.of(context).textTheme.bodySmall),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () => _onEditMessage(msg),
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1)
                    ),
                    alignment: Alignment.center,
                    child: Text('\u{270D}'),
                  ),
                ),
                Visibility(
                  visible: !msg.knowledgeAdded,
                  child: GestureDetector(
                    onTap: () => _onAddKnowledge(msg),
                    child: Container(
                      height: 28,
                      width: 28,
                      margin: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1)
                      ),
                      alignment: Alignment.center,
                      child: GradientColoredText(text: 'S', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
                SizedBox(width: 12)
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(right: 70, bottom: 12, left: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(msg.content, style: Theme.of(context).textTheme.bodySmall),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 18),
                GestureDetector(
                  child: Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1)
                    ),
                    alignment: Alignment.center,
                    child: Text('❤️'),
                  ),
                ),
                SizedBox(width: 12),
                Text(msg.time.toMessageTime(), style: Theme.of(context).textTheme.bodySmall),
              ],
            )
          ],
        ),
      );
    }
  }

  final _blueStyle = TextStyle(color: Colors.blue, fontSize: 18);
  Widget _tips() {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.black, width: 2))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('| ㊙️ 这条消息仅您可见', style: TextStyle(color: Colors.grey, fontSize: 14)),
          SizedBox(height: 10),
          Text('您希望怎样开始对话呢？', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => _startUpLine('有趣的开场白'),
            child: Text('有趣的开场白', style: _blueStyle)
          ),
          SizedBox(height: 10),
          GestureDetector(
              onTap: () => _startUpLine('询问我关心的问题'),
              child: Text('我关心的问题', style: _blueStyle)
          ),
          SizedBox(height: 10),
          GestureDetector(
              onTap: () => _startUpLine('尝试投其所好'),
              child: Text('尝试投其所好', style: _blueStyle)
          ),
          SizedBox(height: 10),
          GestureDetector(
              onTap: () => _startUpLine('自由发挥'),
              child: Text('自由发挥', style: _blueStyle)
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  void _onMessage({String? text}) async {
    print(text);
    if (text == null || text.trim().isEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        _mode = ChatActionMode.docker;
      });
      return;
    }

    if (_mode == ChatActionMode.manual) {
      try {
        ref.read(sonaLoadingProvider.notifier).state = true;
        await sendMessage(
            httpClient: ref.read(dioProvider),
            userId: widget.otherSide.id,
            type: CallSonaType.MANUAL,
            content: text,
        );
        setState(() {
          _mode = ChatActionMode.docker;
        });
      } catch(e) {
        //
      } finally {
        ref.read(sonaLoadingProvider.notifier).state = false;
      }
    } else if (_mode == ChatActionMode.sona) {
      try {
        ref.read(sonaLoadingProvider.notifier).state = true;
        await callSona(
            httpClient: ref.read(dioProvider),
            userId: widget.otherSide.id,
            input: text,
            type: CallSonaType.INPUT
        );
        setState(() {
          _mode = ChatActionMode.docker;
        });
      } catch(e) {
        //
      } finally {
        ref.read(sonaLoadingProvider.notifier).state = false;
      }
    }
  }

  void _onSona(String? text) async {
    if (text == null || text.trim().isEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        _mode = ChatActionMode.docker;
      });
      return;
    }

    try {
      ref.read(sonaLoadingProvider.notifier).state = true;
      await callSona(
        httpClient: ref.read(dioProvider),
        userId: widget.otherSide.id,
        input: text,
        type: CallSonaType.INPUT,
        chatStyleId: ref.read(currentChatStyleIdProvider)
      );
      setState(() {
        _mode = ChatActionMode.docker;
      });
    } catch(e) {
      //
    } finally {
      ref.read(sonaLoadingProvider.notifier).state = false;
    }
  }

  void _showInfo() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChatInfoScreen(user: widget.otherSide)));
  }

  FutureOr _onAction(ChatActionMode mode) {
    switch(mode) {
      case ChatActionMode.docker:
      case ChatActionMode.manual:
        Fluttertoast.showToast(msg: 'msg');

        break;
      case ChatActionMode.sona:
        setState(() {
          _mode = mode;
        });
        break;
      case ChatActionMode.suggestion:
        return _onSuggestion();
      case ChatActionMode.hook:
        return _freeChat();
    }
  }

  Future _startUpLine(String input) async {
    callSona(
        httpClient: ref.read(dioProvider),
        userId: widget.otherSide.id,
        type: CallSonaType.PROLOGUE
    );
  }

  Future _freeChat() async {
    ref.read(sonaLoadingProvider.notifier).state = true;
    callSona(
        httpClient: ref.read(dioProvider),
        userId: widget.otherSide.id,
        type: CallSonaType.AUTO
    )
    .catchError((e) {
      throw(e);
    })
    .whenComplete(() {
      ref.read(sonaLoadingProvider.notifier).state = false;
    });
  }

  Future _onSuggestion() async {
    ref.read(sonaLoadingProvider.notifier).state = true;
    final resp = await callSona(
        httpClient: ref.read(dioProvider),
        userId: widget.otherSide.id,
        type: CallSonaType.SUGGEST
    )
    .catchError((e) {
      throw(e);
    })
    .whenComplete(() {
      ref.read(sonaLoadingProvider.notifier).state = false;
    });

    final options = resp.data['options'] as List;
    await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),
      isScrollControlled: true,
      builder: (_) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SonaMessage(content: '\nI\'m the Idea Wizard'),
                  SizedBox(height: 12),
                  ...options.map((m) => Container(
                    margin: EdgeInsets.only(top: 5, left: 64),
                    child: ColoredButton(
                        onTap: () async {
                          Navigator.pop(context);
                          await sendMessage(
                            httpClient: ref.read(dioProvider),
                            userId: widget.otherSide.id,
                            type: CallSonaType.SUGGEST,
                            content: m['message'],
                          );
                        },
                        text: m['short']
                    ),
                  )),
                  SizedBox(height: 30),
                ],
            ),
          ),
        );
      }
    );
  }

  Future _onEditMessage(ImMessage message) async {
    Fluttertoast.showToast(msg: 'todo');
  }

  Future _onAddKnowledge(ImMessage message) async {
    final dio = ref.read(dioProvider);
    final resp = await dio.post('/knowledge', data: {'content': message.content});
    final data = resp.data;
    if (data['code'] == 1 ) {
      message.knowledgeAdded = true;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future _deleteAllMessages() async {
    await deleteAllMessages(httpClient: ref.read(dioProvider), id: widget.otherSide.id);
    var allMsgs = await FirebaseFirestore.instance
        .collection('users')
        .doc(ref.read(asyncMyProfileProvider).value!.id.toString())
        .collection('rooms')
        .doc(widget.otherSide.id.toString())
        .collection('msgs')
        .get();
    allMsgs.docs.forEach((doc) {
      doc.reference.delete();
    });
  }
}



enum ChatActionMode {
  docker,
  manual,
  sona,
  suggestion,
  hook
}
class InAppPurchasePage extends ConsumerStatefulWidget {
  const InAppPurchasePage({super.key});

  @override
  ConsumerState<InAppPurchasePage> createState() => _InAppPurchasePageState();
}
final bool _kAutoConsume = Platform.isIOS || true;

const String _kConsumableId = 'consumable';
const String _kUpgradeId = 'upgrade';
const String _kSilverSubscriptionId = 'subscription_silver';
const String _kGoldSubscriptionId = 'subscription_gold';
const String _sona_test_1 = 'sona_test_1';
const String annually = '1_annually';
const String month = '1_month';
const String quarter = '1_quarter';
const String biannually = '1_biannually';

const List<String> _kProductIds = <String>[
  // _kConsumableId,
  // _kUpgradeId,
  // _kSilverSubscriptionId,
  // _kGoldSubscriptionId,
  // _sona_test_1,
  month,
  quarter,
  biannually,
  annually,
];
class _InAppPurchasePageState extends ConsumerState<InAppPurchasePage> {

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  List<String> _consumables = <String>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          _listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          _subscription.cancel();
        }, onError: (Object error) {
          // handle error here.
        });
    initStoreInfo();
    super.initState();
  }
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
        _consumables = <String>[];
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
        _consumables = <String>[];
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
        _consumables = <String>[];
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
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> stack = <Widget>[];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: <Widget>[
            _buildConnectionCheckTile(),
            _buildProductList(),
            _buildConsumableBox(),
            _buildRestoreButton(),
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
        appBar: AppBar(
          title: const Text('IAP Example'),
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
    final Widget storeHeader = ListTile(
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
  Card _buildProductList() {
    if (_loading) {
      return const Card(
          child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching products...')));
    }
    if (!_isAvailable) {
      return const Card();
    }
    const ListTile productHeader = ListTile(title: Text('Products for Sale'));
    final List<ListTile> productList = <ListTile>[];
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
        return ListTile(
          title: Text(
            productDetails.title,
          ),
          subtitle: Text(
            productDetails.description,
          ),
          ///
          trailing: previousPurchase != null && Platform.isIOS
              ? IconButton(
               onPressed: () => confirmPriceChange(context),
               icon: const Icon(Icons.upgrade))
              : TextButton(
               style: TextButton.styleFrom(
               backgroundColor: Colors.green[800],
               foregroundColor: Colors.white,
               ),
            onPressed: () {
              late PurchaseParam purchaseParam;

              if (Platform.isAndroid) {
                // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
                // verify the latest status of you your subscription by using server side receipt validation
                // and update the UI accordingly. The subscription purchase status shown
                // inside the app may not be accurate.
                final GooglePlayPurchaseDetails? oldSubscription =
                _getOldSubscription(productDetails, purchases);

                purchaseParam = GooglePlayPurchaseParam(
                    productDetails: productDetails,
                    changeSubscriptionParam: (oldSubscription != null)
                        ? ChangeSubscriptionParam(
                      oldPurchaseDetails: oldSubscription,
                      prorationMode:
                      ProrationMode.immediateWithTimeProration,
                    )
                        : null);
              } else {
                purchaseParam = PurchaseParam(
                  productDetails: productDetails,
                );
              }

              if (productDetails.id == _kConsumableId) {
                _inAppPurchase.buyConsumable(
                    purchaseParam: purchaseParam,
                    autoConsume: _kAutoConsume);
              } else {
                _inAppPurchase.buyNonConsumable(
                    purchaseParam: purchaseParam);
              }
            },
              child: Text(productDetails.price),
          ),
        );
      },
    ));

    return Card(
        child: Column(
            children: <Widget>[productHeader, const Divider()] + productList));
  }

  Card _buildConsumableBox() {
    if (_loading) {
      return const Card(
          child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching consumables...')));
    }
    if (!_isAvailable || _notFoundIds.contains(_kConsumableId)) {
      return const Card();
    }
    const ListTile consumableHeader =
    ListTile(title: Text('Purchased consumables'));
    final List<Widget> tokens = _consumables.map((String id) {
      return GridTile(
        child: IconButton(
          icon: const Icon(
            Icons.stars,
            size: 42.0,
            color: Colors.orange,
          ),
          splashColor: Colors.yellowAccent,
          onPressed: () => consume(id),
        ),
      );
    }).toList();
    return Card(
        child: Column(children: <Widget>[
          consumableHeader,
          const Divider(),
          GridView.count(
            crossAxisCount: 5,
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: tokens,
          )
        ]));
  }

  Widget _buildRestoreButton() {
    if (_loading) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () => _inAppPurchase.restorePurchases(),
            child: const Text('Restore purchases'),
          ),
        ],
      ),
    );
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID!);
      final List<String> consumables = await ConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async{
    final response=await ref.read(dioProvider).post('/callback/google-pay',data: {
      "packageName":"com.planetwalk.sona",
      "productId":purchaseDetails.productID,
      "purchaseToken":purchaseDetails.verificationData.serverVerificationData
    });
    print(response);
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            unawaited(deliverProduct(purchaseDetails));
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }
        if (Platform.isAndroid) {
          if (!_kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            final InAppPurchaseAndroidPlatformAddition androidAddition =
            _inAppPurchase.getPlatformAddition<
                InAppPurchaseAndroidPlatformAddition>();
            await androidAddition.consumePurchase(purchaseDetails);
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

  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    GooglePlayPurchaseDetails? oldSubscription;
    if (productDetails.id == _kSilverSubscriptionId &&
        purchases[_kGoldSubscriptionId] != null) {
      oldSubscription = purchases[_kGoldSubscriptionId]! as GooglePlayPurchaseDetails;
    } else if (productDetails.id == _kGoldSubscriptionId &&
        purchases[_kSilverSubscriptionId] != null) {
      oldSubscription =
      purchases[_kSilverSubscriptionId]! as GooglePlayPurchaseDetails;
    }
    return oldSubscription;
  }
}
