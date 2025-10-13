import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:intl/intl.dart';
import 'package:sona/core/diamond/services/diamond.dart';

/// 钻石商品ID列表
const diamondProductIds = <String>{
  'diamond_200',
  'diamond_500',
  'diamond_1200',
  'diamond_3000',
  'diamond_8000',
};

/// 钻石商品管理器
class AsyncDiamondProductsNotifier extends AsyncNotifier<List<DiamondProduct>> {
  @override
  Future<List<DiamondProduct>> build() async {
    // iOS平台设置代理
    if (Platform.isIOS) {
      final iosPlatformAddition = InAppPurchase.instance
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();

      ///设置代理
      await iosPlatformAddition.setDelegate(IOSPaymentQueueDelegate());
    }

    // 查询钻石商品详情
    final resp = await InAppPurchase.instance.queryProductDetails(
      diamondProductIds,
    );

    if (resp.error != null) {
      throw Exception('Failed to load diamond products: ${resp.error}');
    }

    if (resp.productDetails.isEmpty)
      throw Exception('No diamond products found');

    // 转换为DiamondProduct列表
    final products = <DiamondProduct>[];
    for (final productDetail in resp.productDetails) {
      // 从商品ID解析钻石数量 (diamond_200 -> 200)
      final diamondCount =
          int.tryParse(productDetail.id.replaceFirst('diamond_', '')) ?? 0;

      products.add(
        DiamondProduct(
          currencySymbol: productDetail.currencySymbol,
          productId: productDetail.id,
          name: productDetail.title,
          diamondCount: diamondCount,
          price: productDetail.price,
          currency: productDetail.currencyCode,
          description: productDetail.description,
        ),
      );
    }

    // 按钻石数量排序
    products.sort((a, b) => a.diamondCount.compareTo(b.diamondCount));

    return products;
  }
}

/// iOS支付队列代理
class IOSPaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
    SKPaymentTransactionWrapper transaction,
    SKStorefrontWrapper storefront,
  ) {
    return false;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}

/// 钻石商品列表提供者
final diamondProductsProvider =
    AsyncNotifierProvider<AsyncDiamondProductsNotifier, List<DiamondProduct>>(
  () => AsyncDiamondProductsNotifier(),
);

/// 钻石余额提供者
final diamondBalanceProvider = FutureProvider<DiamondBalance>((ref) async {
  final response = await DiamondService.getBalance();

  if (response.isSuccess) {
    return DiamondBalance.fromJson(response.data);
  } else {
    throw Exception(response.data['msg'] ?? '获取钻石余额失败');
  }
});

/// 钻石交易记录提供者
final diamondTransactionsProvider =
    FutureProvider.family<List<DiamondTransaction>, ({int page, int pageSize})>(
  (ref, params) async {
    final response = await DiamondService.getTransactions(
      page: params.page,
      pageSize: params.pageSize,
    );

    if (response.statusCode == 200) {
      final list = response.data['data'] as List<dynamic>? ?? [];
      return list.map((item) => DiamondTransaction.fromJson(item)).toList();
    } else {
      throw Exception(response.data['msg'] ?? '获取交易记录失败');
    }
  },
);

/// 检查钻石余额是否充足提供者
final checkDiamondBalanceProvider = FutureProvider.family<bool, int>((
  ref,
  requiredDiamonds,
) async {
  final response = await DiamondService.checkBalance(
    requiredDiamonds: requiredDiamonds,
  );

  if (response.statusCode == 200) {
    return response.data['data'] as bool? ?? false;
  } else {
    throw Exception(response.data['msg'] ?? '检查钻石余额失败');
  }
});
