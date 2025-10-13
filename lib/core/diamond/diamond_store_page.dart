import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:sona/core/diamond/services/diamond.dart';
import 'package:sona/core/diamond/providers/diamond_provider.dart';
import 'package:sona/generated/l10n.dart';
import 'package:sona/utils/global/global.dart';

class DiamondStorePage extends ConsumerStatefulWidget {
  const DiamondStorePage({super.key});

  @override
  ConsumerState createState() => _DiamondStorePageState();
}

class _DiamondStorePageState extends ConsumerState<DiamondStorePage> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  bool _purchasePending = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _subscription = InAppPurchase.instance.purchaseStream.listen(
      _listenToPurchaseUpdated,
      onDone: () => _subscription.cancel(),
      onError: (Object error) => _handleError(error),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  /// 监听到的服务端配置的产品
  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    // 遍历购买列表
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
          // 已购买
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            // 恢复购买
            purchaseDetails.status == PurchaseStatus.restored) {
          try {
            final resp = await _verifyPurchase(purchaseDetails);
            if (resp.statusCode == 0) {
              await deliverProduct(purchaseDetails);
            } else {
              EasyLoading.showToast('Failed to verify the purchase.');
            }
          } catch (e) {
            EasyLoading.showToast('Failed to verify the purchase.');
          } finally {
            setState(() {
              _purchasePending = false;
            });
          }
        }
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  }

  Future<Response> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    /// 获取包名通过PackageInfo
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;

    /**
     * 钻石商品购买
     */
    // DIAMOND_PURCHASE,

    /**
     * 苹果钻石购买校验
     */
    // DIAMOND_PURCHASE_APPLE
    ///
    Map<String, dynamic> map = {};
    if (Platform.isAndroid) {
      map = {
        "packageName": packageName,
        "productId": purchaseDetails.productID,
        "purchaseToken":
            purchaseDetails.verificationData.serverVerificationData,
        "serviceType": "DIAMOND_PURCHASE" // 钻石是消耗品，不是订阅
      };
    } else if (Platform.isIOS) {
      map = {
        "packageName": packageName,
        "productId": purchaseDetails.productID,
        "purchaseToken":
            purchaseDetails.verificationData.serverVerificationData,
        "serviceType": "DIAMOND_PURCHASE_APPLE"
      };
    }

    return dio.post('/callback/google-pay', data: map);
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    // 购买验证成功后，服务器会自动发放钻石
    // 我们只需要刷新客户端的钻石余额即可
    EasyLoading.showSuccess(S.current.buttonDone);
    ref.invalidate(diamondBalanceProvider);
  }

  ///设置挂起状态的UI
  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  ///
  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  void _handleError(Object error) {
    setState(() {
      _purchasePending = false;
    });
    EasyLoading.showError('${S.current.purchaseFailed}: $error');
  }

  Future<void> _initiatePurchase(DiamondProduct product) async {
    if (_purchasePending) {
      EasyLoading.showInfo(S.current.purchasePending);
      return;
    }

    try {
      EasyLoading.show(status: S.current.loading);

      // 查询商品详情
      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails({product.productId});

      if (response.error != null) {
        throw Exception(response.error!.message);
      }

      if (response.productDetails.isEmpty) {
        throw Exception(S.current.productNotFound);
      }

      final ProductDetails productDetails = response.productDetails.first;

      // 发起购买
      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: productDetails,
      );

      await InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      EasyLoading.showError('${S.current.purchaseFailed}: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    final diamondBalance = ref.watch(diamondBalanceProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          S.current.diamondStore,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // 钻石余额显示 - 现代化设计
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.white24, Colors.white12],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white30, width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.diamond, size: 18, color: Colors.white),
                const SizedBox(width: 6),
                diamondBalance.when(
                  data: (balance) => Text(
                    '${balance.validDiamonds}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  loading: () => const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  error: (error, stack) => const Text(
                    '0',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6366F1), // 紫色
              Color(0xFF8B5CF6), // 紫色渐变
              Color(0xFFEC4899), // 粉色
              Color(0xFFF472B6), // 浅粉色
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // 商品网格
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: Consumer(
                  builder: (context, ref, child) {
                    final productsAsync = ref.watch(diamondProductsProvider);
                    return productsAsync.when(
                      loading: () => const SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      error: (error, stack) => SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 48,
                                  color: Colors.red.shade400,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  S.of(context).purchaseFailed,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red.shade600,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                  onPressed: () {
                                    ref.invalidate(diamondProductsProvider);
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      data: (products) {
                        if (products.isEmpty) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(40),
                                child: Text(
                                  S.of(context).productNotFound,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }

                        return SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.9,
                          ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final product = products[index];
                            return _DiamondProductCard(
                              product: product,
                              onPurchase: () => _initiatePurchase(product),
                              isPending: _purchasePending,
                            );
                          }, childCount: products.length),
                        );
                      },
                    );
                  },
                ),
              ),

              // 底部间距
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

/// 钻石商品卡片组件
class _DiamondProductCard extends StatelessWidget {
  final DiamondProduct product;
  final VoidCallback onPurchase;
  final bool isPending;

  const _DiamondProductCard({
    required this.product,
    required this.onPurchase,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isPending ? null : onPurchase,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 钻石数量 - 突出显示
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.white24, Colors.white12],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.diamond, size: 20, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        '${product.diamondCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // 价格
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${product.price}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 购买按钮
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: isPending
                        ? null
                        : const LinearGradient(
                            colors: [Colors.white24, Colors.white12],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: isPending ? null : onPurchase,
                      borderRadius: BorderRadius.circular(20),
                      child: Center(
                        child: isPending
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                S.current.buttonPurchase,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
