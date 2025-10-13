import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sona/core/match/util/http_util.dart';

/// 钻石服务类
class DiamondService {
  /// 获取用户钻石余额
  static Future<HttpResult> getBalance() async {
    return post('/diamond/balance');
  }

  /// 钻石购买 (App Store/Google Play支付成功后调用)
  static Future<HttpResult> purchase({
    required String productId,
    required String orderId,
    required String platform,
    required String receipt,
  }) async {
    return post(
      '/diamond/purchase',
      data: {
        'productId': productId,
        'orderId': orderId,
        'platform': platform,
        'receipt': receipt,
      },
    );
  }

  /// 钻石消费
  static Future<HttpResult> consume({
    required int diamondCount,
    required String remark,
  }) async {
    return post(
      '/diamond/consume',
      data: {'diamondCount': diamondCount, 'remark': remark},
    );
  }

  /// 获取钻石交易记录
  static Future<HttpResult> getTransactions({
    int page = 1,
    int pageSize = 10,
  }) async {
    return post(
      '/diamond/transactions',
      data: {'page': page, 'pageSize': pageSize},
    );
  }

  /// 检查钻石余额是否充足
  static Future<HttpResult> checkBalance(
      {required int requiredDiamonds}) async {
    return post(
      '/diamond/check-balance',
      data: {'requiredDiamonds': requiredDiamonds},
    );
  }

  /// 从IAP系统查询钻石商品列表
  static Future<List<DiamondProduct>> getProductsFromIAP() async {
    // 定义商品ID列表 (可以从后端动态获取)
    const productIds = <String>{
      'diamond_200',
      'diamond_500',
      'diamond_1200',
      'diamond_3000',
      'diamond_8000',
    };

    // 查询商品详情
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(productIds);

    if (response.error != null) {
      throw Exception('Failed to query products: ${response.error}');
    }

    // 转换为DiamondProduct列表
    final products = <DiamondProduct>[];
    for (final productDetail in response.productDetails) {
      // 从商品ID解析钻石数量 (diamond_200 -> 200)
      final diamondCount = int.tryParse(
            productDetail.id.replaceFirst('diamond_', ''),
          ) ??
          0;

      products.add(DiamondProduct(
        currencySymbol: productDetail.currencySymbol,
        productId: productDetail.id,
        name: productDetail.title,
        diamondCount: diamondCount,
        price: productDetail.price,
        currency: productDetail.currencyCode,
        description: productDetail.description,
      ));
    }

    // 按钻石数量排序
    products.sort((a, b) => a.diamondCount.compareTo(b.diamondCount));

    return products;
  }
}

/// 钻石商品配置
class DiamondProduct {
  final String productId;
  final String name;
  final int diamondCount;
  final String price;
  final String currency;
  final String currencySymbol;
  final String description;

  const DiamondProduct({
    required this.productId,
    required this.name,
    required this.diamondCount,
    required this.price,
    required this.currency,
    required this.currencySymbol,
    required this.description,
  });

  /// 钻石商品列表 (从IAP系统查询)
  /// 注意: 此方法是同步的，为了兼容现有代码
  /// 建议在UI层使用 getProductsFromIAP() 异步方法
  static List<DiamondProduct> getProducts() {
    // 返回硬编码的商品作为fallback
    // 实际使用时应该调用 getProductsFromIAP()
    return [
      const DiamondProduct(
        productId: 'diamond_200',
        name: '钻石礼包',
        diamondCount: 200,
        price: '0.49',
        currency: 'USD',
        currencySymbol: '\$',
        description: '200钻石',
      ),
      const DiamondProduct(
        productId: 'diamond_500',
        name: '钻石宝箱',
        diamondCount: 500,
        price: '0.99',
        currency: 'USD',
        currencySymbol: '\$',
        description: '500钻石',
      ),
      const DiamondProduct(
        productId: 'diamond_1200',
        name: '钻石豪礼',
        diamondCount: 1200,
        price: '1.99',
        currency: 'USD',
        currencySymbol: '\$',
        description: '1200钻石',
      ),
      const DiamondProduct(
        productId: 'diamond_3000',
        name: '钻石大礼包',
        diamondCount: 3000,
        price: '3.99',
        currency: 'USD',
        currencySymbol: '\$',
        description: '3000钻石',
      ),
      const DiamondProduct(
        productId: 'diamond_8000',
        name: '钻石至尊礼包',
        diamondCount: 8000,
        price: '7.99',
        currency: 'USD',
        currencySymbol: '\$',
        description: '8000钻石',
      ),
    ];
  }

  static DiamondProduct? findByProductId(String productId) {
    return getProducts()
        .where((product) => product.productId == productId)
        .firstOrNull;
  }
}

/// 钻石余额信息
class DiamondBalance {
  final int totalDiamonds;
  final int validDiamonds;

  const DiamondBalance({
    required this.totalDiamonds,
    required this.validDiamonds,
  });

  factory DiamondBalance.fromJson(Map<String, dynamic> json) {
    return DiamondBalance(
      totalDiamonds: json['totalDiamonds'] ?? 0,
      validDiamonds: json['validDiamonds'] ?? 0,
    );
  }
}

/// 钻石交易记录
class DiamondTransaction {
  final int id;
  final int userId;
  final String transactionType;
  final int diamondCount;
  final int balanceBefore;
  final int balanceAfter;
  final String? productId;
  final String? orderId;
  final String? platform;
  final String? remark;
  final DateTime createDate;

  const DiamondTransaction({
    required this.id,
    required this.userId,
    required this.transactionType,
    required this.diamondCount,
    required this.balanceBefore,
    required this.balanceAfter,
    this.productId,
    this.orderId,
    this.platform,
    this.remark,
    required this.createDate,
  });

  factory DiamondTransaction.fromJson(Map<String, dynamic> json) {
    return DiamondTransaction(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      transactionType: json['transactionType'] ?? '',
      diamondCount: json['diamondCount'] ?? 0,
      balanceBefore: json['balanceBefore'] ?? 0,
      balanceAfter: json['balanceAfter'] ?? 0,
      productId: json['productId'],
      orderId: json['orderId'],
      platform: json['platform'],
      remark: json['remark'],
      createDate: DateTime.tryParse(json['createDate'] ?? '') ?? DateTime.now(),
    );
  }
}
