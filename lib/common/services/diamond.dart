import 'package:dio/dio.dart';
import 'package:sona/utils/global/global.dart';

/// 钻石服务类
class DiamondService {
  /// 获取用户钻石余额
  static Future<Response> getBalance() async {
    return dio.post('/diamond/balance');
  }

  /// 钻石购买 (App Store/Google Play支付成功后调用)
  static Future<Response> purchase({
    required String productId,
    required String orderId,
    required String platform,
    required String receipt,
  }) async {
    return dio.post(
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
  static Future<Response> consume({
    required int diamondCount,
    required String remark,
  }) async {
    return dio.post(
      '/diamond/consume',
      data: {'diamondCount': diamondCount, 'remark': remark},
    );
  }

  /// 获取钻石交易记录
  static Future<Response> getTransactions({
    int page = 1,
    int pageSize = 10,
  }) async {
    return dio.post(
      '/diamond/transactions',
      data: {'page': page, 'pageSize': pageSize},
    );
  }

  /// 检查钻石余额是否充足
  static Future<Response> checkBalance({required int requiredDiamonds}) async {
    return dio.post(
      '/diamond/check-balance',
      data: {'requiredDiamonds': requiredDiamonds},
    );
  }
}

/// 钻石商品配置
class DiamondProduct {
  final String productId;
  final String name;
  final int diamondCount;
  final double price;
  final String currency;
  final String description;

  const DiamondProduct({
    required this.productId,
    required this.name,
    required this.diamondCount,
    required this.price,
    required this.currency,
    required this.description,
  });

  /// 钻石商品列表 (根据后端配置)
  static List<DiamondProduct> getProducts() {
    return [
      const DiamondProduct(
        productId: 'diamond_200',
        name: '钻石礼包',
        diamondCount: 200,
        price: 0.49,
        currency: 'USD',
        description: '200钻石',
      ),
      const DiamondProduct(
        productId: 'diamond_500',
        name: '钻石宝箱',
        diamondCount: 500,
        price: 0.99,
        currency: 'USD',
        description: '500钻石',
      ),
      const DiamondProduct(
        productId: 'diamond_1200',
        name: '钻石豪礼',
        diamondCount: 1200,
        price: 1.99,
        currency: 'USD',
        description: '1200钻石',
      ),
      const DiamondProduct(
        productId: 'diamond_3000',
        name: '钻石大礼包',
        diamondCount: 3000,
        price: 3.99,
        currency: 'USD',
        description: '3000钻石',
      ),
      const DiamondProduct(
        productId: 'diamond_8000',
        name: '钻石至尊礼包',
        diamondCount: 8000,
        price: 7.99,
        currency: 'USD',
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
