import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sona/core/diamond/services/diamond.dart';
import 'package:sona/core/diamond/providers/diamond_provider.dart';
import 'package:sona/generated/l10n.dart';

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

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      _handlePurchaseUpdate(purchaseDetails);
    }
  }

  void _handlePurchaseUpdate(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.pending) {
      setState(() => _purchasePending = true);
      return;
    }

    if (purchaseDetails.status == PurchaseStatus.error) {
      setState(() => _purchasePending = false);
      _handleError(purchaseDetails.error!);
      return;
    }

    if (purchaseDetails.status == PurchaseStatus.purchased ||
        purchaseDetails.status == PurchaseStatus.restored) {
      setState(() => _purchasePending = false);

      // 验证收据并发放钻石
      await _verifyAndGrantDiamonds(purchaseDetails);

      // 完成交易
      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> _verifyAndGrantDiamonds(PurchaseDetails purchaseDetails) async {
    try {
      EasyLoading.show(status: S.current.loading);

      // 获取收据
      String? receipt;
      String platform;

      if (Platform.isIOS) {
        final receiptData =
            purchaseDetails.verificationData.serverVerificationData;
        receipt = receiptData;
        platform = 'apple';
      } else if (Platform.isAndroid) {
        final receiptData =
            purchaseDetails.verificationData.serverVerificationData;
        receipt = receiptData;
        platform = 'google';
      } else {
        throw Exception(S.current.unsupportedPlatform);
      }

      // 调用后端验证收据
      final response = await DiamondService.purchase(
        productId: purchaseDetails.productID,
        orderId: purchaseDetails.purchaseID ?? '',
        platform: platform,
        receipt: receipt,
      );

      if (response.isSuccess) {
        EasyLoading.showSuccess(S.current.buttonDone);
        // 刷新钻石余额
        ref.invalidate(diamondBalanceProvider);
      } else {
        throw Exception(response.data['msg'] ?? S.current.purchaseFailed);
      }
    } catch (e) {
      EasyLoading.showError('${S.current.purchaseFailed}: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void _handleError(Object error) {
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
              border: Border.all(
                color: Colors.white30,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.diamond,
                  size: 18,
                  color: Colors.white,
                ),
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
              // 顶部间距
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),

              // 商品网格
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = DiamondProduct.getProducts()[index];
                      return _DiamondProductCard(
                        product: product,
                        onPurchase: () => _initiatePurchase(product),
                        isPending: _purchasePending,
                      );
                    },
                    childCount: DiamondProduct.getProducts().length,
                  ),
                ),
              ),

              // 底部间距
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
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
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      const Icon(
                        Icons.diamond,
                        size: 20,
                        color: Colors.white,
                      ),
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

                // 商品名称
                Text(
                  product.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // 商品描述
                Text(
                  product.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // 价格
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '\$${product.price}',
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
